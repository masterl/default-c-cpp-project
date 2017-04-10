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

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#	Compilation flags
#--------------------------------------------------------------------------
#PGFLAG = -lpq
#ALLBOOSTFLAGS = -lboost_locale -lpthread -lboost_thread -lboost_filesystem -lboost_system -lboost_regex -lboost_serialization -lboost_random
#ALLENDFLAGS = -lssl -lcrypto -lz -ldl -lmhash -lcurl
#GOOGLETESTFLAGS = -lgmock_main -lgmock -lgtest
#STACKTRACEFLAGS = -rdynamic
#PTHREADFLAG = -lpthread

INCLUSIONFLAGS := -I./vendor

GENERALSTARTFLAGS := -Wall -std=c++14

ALLCOMPFLAGS := $(GENERALSTARTFLAGS) $(INCLUSIONFLAGS)

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
	ALLCOMPFLAGS += -I.
	UNPROCESSEDDIRLIST += $(TESTSDIR)
endif

_ALLSRCDIRLIST := $(call get_processed_directories_trees_list,$(UNPROCESSEDDIRLIST))

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#	Object directories
#--------------------------------------------------------------------------
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
# Object files list
#--------------------------------------------------------------------------
ALLOBJS := $(call get_objects_from_sources_list,$(ALLSRCFILES))

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Executable definitions
#--------------------------------------------------------------------------
EXEC := exec
TESTEXEC := test

BINDIR := bin

export CC
export ALLCOMPFLAGS
export OBJDIR
export ALLOBJS

all:
	@echo -e '\n'
	@echo -e '==================== ERROR ===================='
	@echo -e ' --------------------------------------------  '
	@echo    " |        There's no default rule!           | "
	@echo -e ' --------------------------------------------  '
	@echo -e '   Choose an option:\n'
	@echo -e '\texec\t    [compiles main executable]'
	@echo -e '\tclean\t\t    [erases all files]'
	@echo -e '===============================================\n\n'

exec: rmexec allobjs FORCE | $(BINDIR)
	$(CC) $(ALLOBJS) $(ALLCOMPFLAGS) -o $(BINDIR)/$(EXEC) $(LINKFLAGS)
	@echo -e '=----------------------------------------------------='
	@echo -e '=           executable generated/updated             ='
	@echo -e '=           Executable: $(BINDIR)/$(EXEC)  \t\t     ='
	@echo -e '=----------------------------------------------------=\n\n'

test: compiletest
	@echo -e 'Executing tests...\n'
	@set -e;./$(BINDIR)/$(TESTEXEC)

compiletest: rmtest allobjs FORCE | $(BINDIR)
	$(CC) $(ALLOBJS) $(ALLCOMPFLAGS) -o $(BINDIR)/$(TESTEXEC) $(LINKFLAGS)
	@echo -e '=----------------------------------------------------='
	@echo -e '=           TESTS generated/updated                  ='
	@echo -e '=           Executable: $(BINDIR)/$(TESTEXEC)  \t\t     ='
	@echo -e '=----------------------------------------------------=\n\n'

allobjs: objdirs
	@set -e; $(MAKE) --no-print-directory -f makeobjs.mk allobjs

objdirs: | $(OBJDIRLIST)
	@echo -e '------------------------------------------------------'
	@echo -e '\tObjects directories created/checked!\n'

$(OBJDIRLIST) $(BINDIR):
	mkdir $@

clean: rmobjs rmexec FORCE
	rm -rf $(BINDIR)
	@echo -e '------------------------------------------------------'
	@echo -e '\tAll files removed!\n\n'

rmexec:
	rm -f $(BINDIR)/$(EXEC)
	@echo -e '------------------------------------------------------'
	@echo -e '\tExecutables removed!'

rmtest:
	rm -f $(BINDIR)/$(TESTEXEC)
	@echo -e '------------------------------------------------------'
	@echo -e '\tTest executable removed!'

rmobjs: FORCE
	$(foreach dir, $(OBJDIRLIST) tests/$(OBJDIR), $(call execute-command, rm -rf $(dir) ) )

FORCE:

#  ===========================
#  ||    MAKEFILE >END<      ||
#  ===========================
