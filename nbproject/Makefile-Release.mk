#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Environment
MKDIR=mkdir
CP=cp
GREP=grep
NM=nm
CCADMIN=CCadmin
RANLIB=ranlib
CC=gcc
CCC=g++
CXX=g++
FC=gfortran
AS=as

# Macros
CND_PLATFORM=GNU-Linux
CND_DLIB_EXT=so
CND_CONF=Release
CND_DISTDIR=dist
CND_BUILDDIR=build

# Include project Makefile
include Makefile

# Object Directory
OBJECTDIR=${CND_BUILDDIR}/${CND_CONF}/${CND_PLATFORM}

# Object Files
OBJECTFILES= \
	${OBJECTDIR}/BowVector.o \
	${OBJECTDIR}/Column.o \
	${OBJECTDIR}/FBrief.o \
	${OBJECTDIR}/FORB.o \
	${OBJECTDIR}/FSurf64.o \
	${OBJECTDIR}/FeatureVector.o \
	${OBJECTDIR}/QueryResults.o \
	${OBJECTDIR}/ScoringObject.o \
	${OBJECTDIR}/main.o


# C Compiler Flags
CFLAGS=

# CC Compiler Flags
CCFLAGS=-std=c++11
CXXFLAGS=-std=c++11

# Fortran Compiler Flags
FFLAGS=

# Assembler Flags
ASFLAGS=

# Link Libraries and Options
LDLIBSOPTIONS=-L../../SDKs/opencv-2.4.13/build/lib -L../../SDKs/DLib-1.0/build -L../../SDKs/jdk1.8.0_92/lib

# Build Targets
.build-conf: ${BUILD_SUBPROJECTS}
	"${MAKE}"  -f nbproject/Makefile-${CND_CONF}.mk ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/libVocTreePgLib.${CND_DLIB_EXT}

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/libVocTreePgLib.${CND_DLIB_EXT}: ${OBJECTFILES}
	${MKDIR} -p ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}
	g++ -shared -o ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/libVocTreePgLib.${CND_DLIB_EXT} ${OBJECTFILES} ${LDLIBSOPTIONS} -lpqxx -lpq -lopencv_core -lopencv_contrib -lopencv_features2d -lopencv_flann -lopencv_highgui -lopencv_objdetect -lopencv_video -lopencv_legacy -lopencv_calib3d -lopencv_imgproc -lopencv_ml -lopencv_nonfree -shared -fPIC

${OBJECTDIR}/BowVector.o: BowVector.cpp 
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I../../SDKs/DLib-1.0/include/DUtils -I../../SDKs/DLib-1.0/include/DUtilsCV -I../../SDKs/DLib-1.0/include/DVision -I../../SDKs/opencv-2.4.13/include/opencv -I../../SDKs/opencv-2.4.13/include/opencv2 -I../../SDKs/jdk1.8.0_92/include -I../../SDKs/jdk1.8.0_92/include/linux -std=c++11 -fPIC  -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/BowVector.o BowVector.cpp

${OBJECTDIR}/Column.o: Column.cpp 
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I../../SDKs/DLib-1.0/include/DUtils -I../../SDKs/DLib-1.0/include/DUtilsCV -I../../SDKs/DLib-1.0/include/DVision -I../../SDKs/opencv-2.4.13/include/opencv -I../../SDKs/opencv-2.4.13/include/opencv2 -I../../SDKs/jdk1.8.0_92/include -I../../SDKs/jdk1.8.0_92/include/linux -std=c++11 -fPIC  -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Column.o Column.cpp

${OBJECTDIR}/FBrief.o: FBrief.cpp 
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I../../SDKs/DLib-1.0/include/DUtils -I../../SDKs/DLib-1.0/include/DUtilsCV -I../../SDKs/DLib-1.0/include/DVision -I../../SDKs/opencv-2.4.13/include/opencv -I../../SDKs/opencv-2.4.13/include/opencv2 -I../../SDKs/jdk1.8.0_92/include -I../../SDKs/jdk1.8.0_92/include/linux -std=c++11 -fPIC  -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/FBrief.o FBrief.cpp

${OBJECTDIR}/FORB.o: FORB.cpp 
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I../../SDKs/DLib-1.0/include/DUtils -I../../SDKs/DLib-1.0/include/DUtilsCV -I../../SDKs/DLib-1.0/include/DVision -I../../SDKs/opencv-2.4.13/include/opencv -I../../SDKs/opencv-2.4.13/include/opencv2 -I../../SDKs/jdk1.8.0_92/include -I../../SDKs/jdk1.8.0_92/include/linux -std=c++11 -fPIC  -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/FORB.o FORB.cpp

${OBJECTDIR}/FSurf64.o: FSurf64.cpp 
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I../../SDKs/DLib-1.0/include/DUtils -I../../SDKs/DLib-1.0/include/DUtilsCV -I../../SDKs/DLib-1.0/include/DVision -I../../SDKs/opencv-2.4.13/include/opencv -I../../SDKs/opencv-2.4.13/include/opencv2 -I../../SDKs/jdk1.8.0_92/include -I../../SDKs/jdk1.8.0_92/include/linux -std=c++11 -fPIC  -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/FSurf64.o FSurf64.cpp

${OBJECTDIR}/FeatureVector.o: FeatureVector.cpp 
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I../../SDKs/DLib-1.0/include/DUtils -I../../SDKs/DLib-1.0/include/DUtilsCV -I../../SDKs/DLib-1.0/include/DVision -I../../SDKs/opencv-2.4.13/include/opencv -I../../SDKs/opencv-2.4.13/include/opencv2 -I../../SDKs/jdk1.8.0_92/include -I../../SDKs/jdk1.8.0_92/include/linux -std=c++11 -fPIC  -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/FeatureVector.o FeatureVector.cpp

${OBJECTDIR}/QueryResults.o: QueryResults.cpp 
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I../../SDKs/DLib-1.0/include/DUtils -I../../SDKs/DLib-1.0/include/DUtilsCV -I../../SDKs/DLib-1.0/include/DVision -I../../SDKs/opencv-2.4.13/include/opencv -I../../SDKs/opencv-2.4.13/include/opencv2 -I../../SDKs/jdk1.8.0_92/include -I../../SDKs/jdk1.8.0_92/include/linux -std=c++11 -fPIC  -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/QueryResults.o QueryResults.cpp

${OBJECTDIR}/ScoringObject.o: ScoringObject.cpp 
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I../../SDKs/DLib-1.0/include/DUtils -I../../SDKs/DLib-1.0/include/DUtilsCV -I../../SDKs/DLib-1.0/include/DVision -I../../SDKs/opencv-2.4.13/include/opencv -I../../SDKs/opencv-2.4.13/include/opencv2 -I../../SDKs/jdk1.8.0_92/include -I../../SDKs/jdk1.8.0_92/include/linux -std=c++11 -fPIC  -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/ScoringObject.o ScoringObject.cpp

${OBJECTDIR}/main.o: main.cpp 
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -I../../SDKs/DLib-1.0/include/DUtils -I../../SDKs/DLib-1.0/include/DUtilsCV -I../../SDKs/DLib-1.0/include/DVision -I../../SDKs/opencv-2.4.13/include/opencv -I../../SDKs/opencv-2.4.13/include/opencv2 -I../../SDKs/jdk1.8.0_92/include -I../../SDKs/jdk1.8.0_92/include/linux -std=c++11 -fPIC  -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/main.o main.cpp

# Subprojects
.build-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r ${CND_BUILDDIR}/${CND_CONF}
	${RM} ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/libVocTreePgLib.${CND_DLIB_EXT}

# Subprojects
.clean-subprojects:

# Enable dependency checking
.dep.inc: .depcheck-impl

include .dep.inc
