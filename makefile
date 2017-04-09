#   =======================
#  ||    ROOT MAKEFILE    ||
#   =======================
#

include .functions.mk

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#	Compiler:
#--------------------------------------------------------------------------
CC := g++

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#	Directories for linking
#--------------------------------------------------------------------------
# ======== GERAL ========
LIBDIR := -L/usr/lib
# LOCALLIBDIR =  -L/usr/local/lib

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#	Compilation flags
#--------------------------------------------------------------------------
#PGFLAG = -lpq
#ALLBOOSTFLAGS = -lboost_locale -lpthread -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lboost_serialization -lboost_random
#ALLENDFLAGS = -lssl -lcrypto -lz -ldl -lmhash -lcurl
#GOOGLETESTFLAGS = -lgmock_main -lgmock -lgtest
#STACKTRACEFLAGS = -rdynamic
#PTHREADFLAG = -lpthread

GENERALSTARTFLAGS := -Wall -std=c++14

ALLCOMPFLAGS := $(GENERALSTARTFLAGS)

#LINKFLAGS = -lboost_filesystem -lboost_system
ifeq ($(MAKECMDGOALS),test)
	TESTFLAGS :=
endif

LINKFLAGS += $(TESTFLAGS)

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#	Sources directories
#--------------------------------------------------------------------------
# Specify which directory contais the main file
MAINDIR := src
# Name of main file
MAINFILE := main.cpp
# All source directories (except test files directory)
SOURCEDIRS := src utils

UNPROCESSEDDIRLIST := $(SOURCEDIRS)

ifeq ($(MAKECMDGOALS),test)
	TESTSDIR := tests
	UNPROCESSEDDIRLIST += $(TESTSDIR)
endif

_ALLSRCDIRLIST := $(call get_processed_directories_trees_list,$(UNPROCESSEDDIRLIST))

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#	Dependencies and object directories
#--------------------------------------------------------------------------
DEPDIRLIST := $(call get_dependencies_directories,$(_ALLSRCDIRLIST))

#----====----====----====----====----

OBJDIRLIST := $(call get_objects_directories,$(_ALLSRCDIRLIST))

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Sources list
#--------------------------------------------------------------------------
ALLSRCFILES := $(foreach dir,$(_ALLSRCDIRLIST),$(wildcard $(dir)/*.cpp))

# Main file should be removed from list when testing
ifeq ($(MAKECMDGOALS),test)
	ALLSRCFILES := $(filter-out $(MAINDIR)/$(MAINFILE),$(ALLSRCFILES))
endif

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Dependencies Lists
#--------------------------------------------------------------------------
# .o dependencies
ALLDEPS :=	$(call get_dependencies_from_sources_list,$(ALLSRCFILES))

# dependency dependencies so we are able to update dependencies
ALLDEPDEPS :=	$(call get_dependencies_dependency_list,$(ALLDEPS))
