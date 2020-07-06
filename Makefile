########################################################################
#                                                                      #
# Copyright(C) 2020 - LBS - (Single person developer.)                 #
# Mon May 11 01:29:49 CEST 2020                                        #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# Script description:                                                  #
#                                                                      #
# Input paramete:                                                      #
#                                                                      #
# This software is provided "as is" without any warranty.              #
########################################################################

MakefileFullPath = $(abspath $(lastword $(MAKEFILE_LIST)))
MakefileDirFullPath = $(shell dirname $(MakefileFullPath))
LIB_push_vector_in_root=$(MakefileDirFullPath)/push_vector_in_root/install/libpushVectorInRoot.so
INC_push_vector_in_root += -I$(MakefileDirFullPath)/push_vector_in_root/install/

ROOTCFLAGS  = $(shell $(ROOTSYS)/bin/root-config --cflags)
ROOTLIBS    = $(shell $(ROOTSYS)/bin/root-config --libs)
ROOTGLIBS   = $(shell $(ROOTSYS)/bin/root-config --glibs)
ROOTLDFLAGS = $(shell $(ROOTSYS)/bin/root-config --ldflags)

CXX  = g++
CXX += -I./
CXX += $(INC_push_vector_in_root)

CXXFLAGS  = -g -Wall -fPIC -Wno-deprecated
CXXFLAGS += $(ROOTCFLAGS)
CXXFLAGS += $(ROOTLIBS)
CXXFLAGS += $(ROOTGLIBS)
CXXFLAGS += $(ROOTLDFLAGS)
CXXFLAGS += $(LIB_push_vector_in_root)

.PHONY: all printmakeinfo clean 

#----------------------------------------------------#

all: push plot

printmakeinfo:
	$(info CXX                 = "$(CXX)")
	$(info CXXFLAGS            = "$(CXXFLAGS)")
	$(info MakefileFullPath    = "$(MakefileFullPath)")
	$(info MakefileDirFullPath = "$(MakefileDirFullPath)")

push: push.cc
	$(CXX) -o $@ $< $(CXXFLAGS)

plot: plot.cc
	$(CXX) -o $@ $< $(CXXFLAGS)

clean:
	rm -f *~
	rm -f .*~
	rm -f push
	rm -f plot
