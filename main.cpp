#if __GNUC__ >= 4
#define DLL_PUBLIC __attribute__ ((visibility("default")))
#define DLL_LOCAL  __attribute__ ((visibility("hidden")))
#else

JNIEXPORT void JNICALL
    Java_HelloWorld_displayHelloWorld(JNIEnv *, jobject);

#define DLL_PUBLIC
#define DLL_LOCAL
#endif

#include <jni.h>
#include <stdio.h>

#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <sys/types.h>
#include <dirent.h>

// DBoW2
#include "DBoW2.h" // defines Surf64Vocabulary and Surf64Database

#include "DUtils.h"
#include "DUtilsCV.h" // defines macros CVXX
#include "DVision.h"

#include "pqxx/connection"
#include "pqxx/transaction"

// OpenCV
#include <opencv/cv.h>
#include <opencv/highgui.h>
#if CV24
#include <opencv2/nonfree/features2d.hpp>
#endif

using namespace DBoW2;
using namespace DUtils;
using namespace std;
using namespace pqxx;


static connection *pg_conn;
static Surf64Database *db;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

void changeStructure(const vector<float> &plain, vector<vector<float> > &out,
  int L)
{
  out.resize(plain.size() / L);

  unsigned int j = 0;
  for(unsigned int i = 0; i < plain.size(); i += L, ++j)
  {
    out[j].resize(L);
    std::copy(plain.begin() + i, plain.begin() + i + L, out[j].begin());
  }
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

void getFeature(vector<vector<vector<float> > > &features, string &imageDir,
        bool EXTENDED_SURF = false)
{
    cv::SURF surf(400, 4, 2, EXTENDED_SURF);
    vector<cv::KeyPoint> keypoints;
    vector<float> descriptors;
    cv::Mat image = cv::imread(imageDir, 0);
    cv::Mat mask;
    surf(image, mask, keypoints, descriptors);
    features.push_back(vector<vector<float> >());
    changeStructure(descriptors, features.back(), surf.descriptorSize());
}

void getFeature(vector<vector<vector<float> > > &features, cv::Mat qImage,
        bool EXTENDED_SURF = false)
{
    cv::SURF surf(400, 4, 2, EXTENDED_SURF);
    vector<cv::KeyPoint> keypoints;
    vector<float> descriptors;
    cv::Mat mask;
    surf(qImage, mask, keypoints, descriptors);
    features.push_back(vector<vector<float> >());
    changeStructure(descriptors, features.back(), surf.descriptorSize());
}

void getFeatures(vector<vector<vector<float> > > &features, string &imageDir, 
        int NIMAGES, bool EXTENDED_SURF = false)
{
    cv::SURF surf(400, 4, 2, EXTENDED_SURF);
    
    features.clear();
    features.reserve(NIMAGES);

    DIR *dir = opendir(imageDir.c_str());
    if(dir)
    {
        struct dirent *ent;
        while((ent = readdir(dir)) != NULL)
        {
            char *dname = ent->d_name;
            string path = imageDir + "/";
            path = path + dname;
            if (sizeof(dname) > 2 && dname[0] != '.')
            {
                cout << "Extracting SURF features of " << dname << endl;
                getFeature(features, path);
            }
        }
    }
    
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -



extern "C" JNIEXPORT void JNICALL 
Java_org_ash_VocPgWrapper_loadFeaturesToDB(JNIEnv *env, jobject obj,
jstring imageDir, jstring newRecordName, int NIMAGES, 
        bool EXTENDED_SURF = false)
{
    if (!db) {
        cout << "Opened database not found" << endl;
        return;
    }
    
    const char *nImageDir = env->GetStringUTFChars(imageDir, 0);
    const char *nNewRecordName = env->GetStringUTFChars(newRecordName, 0);
    
    cv::SURF surf(400, 4, 2, EXTENDED_SURF);
    vector<vector<vector<float> > > features;
    features.clear();
    features.reserve(NIMAGES);

    DIR *dir = opendir(nImageDir);
    if(dir)
    {
        struct dirent *ent;
        while((ent = readdir(dir)) != NULL)
        {
            char *dname = ent->d_name;
            string path = string(nImageDir) + "/";
            path = path + dname;
            if (sizeof(dname) > 2 && dname[0] != '.')
            {
                cout << "Processsing image " << dname << endl;
                getFeature(features, path);
                db->add(features.back(), dname);
            }
        }
    }
    if (pg_conn) {
        db->saveToPG(*pg_conn, (string)nNewRecordName);
    } else {
        cerr << "Cannot save database object into PG database: connection is null" << endl;
    }
    
    env->ReleaseStringUTFChars(imageDir, nImageDir);
    env->ReleaseStringUTFChars(newRecordName, nNewRecordName);
}

extern "C" JNIEXPORT jstring JNICALL 
Java_org_ash_VocPgWrapper_query(JNIEnv *env, jobject obj, long matImageAddr) 
{
    if (!db) {
        cerr << "Databse isn't loaded yet. use openDB() first." << endl;
        return nullptr;
    }
    try {
        cv::Mat *image = (cv::Mat*)matImageAddr;
        work w(*pg_conn, "queryingByImage");
        vector<vector<vector<float> > > features;
        getFeature(features, *image);

        QueryResults qr;
        db->query(features[0], qr); 
        delete image;
        return env->NewStringUTF((qr.begin().base()->image_name).c_str());
    } catch (const pqxx_exception &e) {
        cerr << "Eror whyle querying by image: " << e.base().what() << endl;
    }
    return nullptr;
}

extern "C" JNIEXPORT jboolean JNICALL  
Java_org_ash_VocPgWrapper_connectToDb(JNIEnv *env, jobject obj, jstring conn_string) 
{
    try {
        const char *nConn_string = env->GetStringUTFChars(conn_string, 0);
        pg_conn = new connection((string)nConn_string);
        env->ReleaseStringUTFChars(conn_string, nConn_string);
        return true;
    } catch (const pqxx_exception &e) {
        cerr << "Connection error:" << e.base().what() << endl;
    }
    return false;
}

extern "C" JNIEXPORT jboolean JNICALL 
Java_org_ash_VocPgWrapper_openDB(JNIEnv *env, jobject, 
        jstring vocTreeName, jstring dbRecordName)
{
    if (!pg_conn) {
        cerr << "Connection is null. Use connectToDb() first." << endl;
        return false;
    }
    try {
        const char *nVocTreeName = env->GetStringUTFChars(vocTreeName, 0);
        const char *nRecordName = env->GetStringUTFChars(dbRecordName, 0);
        db = new Surf64Database(*pg_conn, (string)nVocTreeName, (string)nRecordName);
        env->ReleaseStringUTFChars(vocTreeName, nVocTreeName);
        env->ReleaseStringUTFChars(dbRecordName, nRecordName);
        return true;
    } catch (const pqxx_exception &e) {
        cerr << "Can't load dbObject: " << e.base().what() << endl; 
    }
    return false;
}

extern "C" JNIEXPORT void JNICALL 
Java_org_ash_VocPgWrapper_disconnect(JNIEnv *env, jobject obj) 
{
    if (pg_conn) {
        pg_conn->disconnect();
    }
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
