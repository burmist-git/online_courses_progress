#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2020 - LBS - (Single person developer.)                 #
# Tue Mar 24 11:56:17 CET 2020                                         #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# File description:                                                    #
#                                                                      #
# Input paramete:                                                      #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

LC_TIME=en_US.UTF-8
LANG=en_US.UTF-8

source /home/burmist/root_v6.14.00/root-6.14.00-install/bin/thisroot.sh

function push_sh {
    vecparID=0
    $sourceHome/push 0 $outRootFile $vecparID 1 $1
}

function plot_sh {
    $sourceHome/plot 0 $inRootFile $vecNamesFile
    evince $inRootFile'.pdf' &
}

function printHelp {
    echo " --> ERROR in input arguments "
    echo " [0] -push_ml_nj01   : To push "
    echo " [1]                 : unixtime "
    echo " [0] -plot_ml_nj01   : to plot "
    echo " [0] -push_pyml_jp01 : To push "
    echo " [1]                 : unixtime "
    echo " [0] -plot_pyml_jp01 : to plot "
    echo " [0] -push_s2ds_tut  : To push "
    echo " [1]                 : unixtime "
    echo " [0] -plot_s2ds_tut  : to plot "
    echo " [0] -h              : print help"
}

sourceHome=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
dataFolder=$sourceHome'/data/'
outRootFile_ml_nj01=$dataFolder'online_courses_progress_time_ml_nj01.root'
outRootFile_pyml_jp01=$dataFolder'online_courses_progress_time_pyml_jp01.root'
outRootFile_s2ds_tut=$dataFolder'online_courses_progress_time_s2ds_tut.root'
vecNamesFile=$sourceHome'/vectorOfinDataValuesNames.dat'

mkdir -p $dataFolder

if [ $# -eq 0 ]; then    
    printHelp
else
    if [ "$1" = "-push_ml_nj01" ]; then
	if [ $# -eq 2 ]; then
	    ut=$2
	    outRootFile=$outRootFile_ml_nj01
	    push_sh $ut
	else
            printHelp
        fi
    elif [ "$1" = "-plot_ml_nj01" ]; then
	inRootFile=$outRootFile_ml_nj01
	plot_sh
    elif [ "$1" = "-push_pyml_jp01" ]; then
	if [ $# -eq 2 ]; then
	    ut=$2
	    outRootFile=$outRootFile_pyml_jp01
	    push_sh $ut
	else
            printHelp
        fi
    elif [ "$1" = "-plot_pyml_jp01" ]; then
	inRootFile=$outRootFile_pyml_jp01
	plot_sh
    elif [ "$1" = "-push_s2ds_tut" ]; then
	if [ $# -eq 2 ]; then
	    ut=$2
	    outRootFile=$outRootFile_s2ds_tut
	    push_sh $ut
	else
            printHelp
        fi
    elif [ "$1" = "-plot_s2ds_tut" ]; then
	inRootFile=$outRootFile_s2ds_tut
	plot_sh
    elif [ "$1" = "-h" ]; then
        printHelp
    else
        printHelp
    fi
fi
#espeak "I have done"
