/***********************************************************************
* Copyright(C) 2020 - LBS - (Single person developer.)                 *
* Tue Mar 24 17:56:37 CET 2020                                         *
* Autor: Leonid Burmistrov                                             *
***********************************************************************/

//my
#include "libpushVectorInRoot.h"

//root
#include "TROOT.h"
#include "TStyle.h"
#include "TString.h"
#include "TH1D.h"
#include "TH2D.h"
#include "TFile.h"
#include "TRandom3.h"
#include "TGraph.h"
#include "TCanvas.h"
#include "TMultiGraph.h"
#include "TGaxis.h"

//C, C++
#include <iostream>
#include <stdlib.h>
#include <assert.h>
#include <fstream>
#include <iomanip>
#include <time.h>

using namespace std;

int main(int argc, char *argv[]){
  if(argc == 4 && atoi(argv[1])==0){
    TString rootFileIn = argv[2];
    TString vecNamesFile = argv[3];
    Int_t saveKey = 1;
    Double_t timeAxisLabelOffset = 0.02;
    std::vector<TGraph*> gr_v = getGraphsVector (rootFileIn, vecNamesFile, saveKey);
    TGraph *gr_one_vs_time = new TGraph();
    TGraph *gr_one_vs_time_norm = new TGraph();
    gr_one_vs_time->SetTitle("gr_one_vs_time");
    gr_one_vs_time->SetName("gr_one_vs_time");
    gr_one_vs_time_norm->SetTitle("gr_one_vs_time_norm");
    gr_one_vs_time_norm->SetName("gr_one_vs_time_norm");
    Double_t x, y, val, norm, tmin, tmax, tlast;
    gr_v.at(0)->GetPoint(0,x,tmin);
    gr_v.at(0)->GetPoint((gr_v.at(0)->GetN()-1),x,tmax);
    norm = gr_v.at(0)->GetN()/((tmax - tmin)/3600.0);
    for(Int_t i = 0;i<gr_v.at(0)->GetN();i++){
      //cout<<x<<endl;
      gr_one_vs_time->SetPoint(i,y,1);
      val = 0;
      if(i>0){
	gr_v.at(0)->GetPoint(i,x,y);
	gr_v.at(0)->GetPoint((i-1),x,tlast);
	val = norm/((y - tlast)/3600.0);
      }
      gr_v.at(0)->GetPoint(i,x,y);
      //cout<<val<<endl;
      gr_one_vs_time_norm->SetPoint(i,y,val);
    }
    //
    Double_t y_min = 0;
    Double_t y_max = 2.0;
    ////
    TCanvas *c1 = new TCanvas("c1","c1",10,10,1200,800);
    gStyle->SetPalette(1);
    gStyle->SetFrameBorderMode(0);
    gROOT->ForceStyle();
    gStyle->SetStatColor(kWhite);
    c1->SetRightMargin(0.12);
    c1->SetLeftMargin(0.12);
    c1->SetTopMargin(0.1);
    c1->SetBottomMargin(0.15);
    c1->SetGrid();
    //
    gr_one_vs_time->SetLineColor(kRed);
    gr_one_vs_time->SetMarkerColor(kRed);
    gr_one_vs_time->SetMarkerStyle(20);
    gr_one_vs_time->SetLineStyle(kSolid);
    gr_one_vs_time->SetMinimum(y_min);
    gr_one_vs_time->SetMaximum(y_max);
    //
    gr_one_vs_time_norm->SetLineColor(kRed);
    gr_one_vs_time_norm->SetMarkerColor(kRed);
    gr_one_vs_time_norm->SetMarkerStyle(20);
    gr_one_vs_time_norm->SetLineStyle(kSolid);
    gr_one_vs_time_norm->SetMinimum(y_min);
    gr_one_vs_time_norm->SetMaximum(y_max);
    //
    TMultiGraph *mg = new TMultiGraph();
    TString mgTitle = "Studying time";
    TString mgName = "mg";
    //mg->Add(gr_v.at(0));
    //mg->Add(gr_one_vs_time);
    mg->Add(gr_one_vs_time_norm);
    mg->SetTitle(mgTitle.Data());
    mg->SetName(mgName.Data());
    //mg->SetMaximum(y_max);
    //mg->SetMinimum(y_min);
    mg->Draw("AP");
    mg->GetXaxis()->SetTimeDisplay(1);
    mg->GetXaxis()->SetTimeFormat("#splitline{%m/%d}{%H:%M}%F1970-01-01 00:00:00");
    mg->GetXaxis()->SetLabelOffset(timeAxisLabelOffset);
    mg->GetXaxis()->SetLabelSize(0.025);
    mg->GetYaxis()->SetTitle("");
    //
    TString pdfOutFile = rootFileIn;
    pdfOutFile += ".pdf";
    c1->SaveAs(pdfOutFile.Data());
  }
  else{
    cout<<" --> ERROR in input arguments "<<endl
	<<" runID [1] = 0 (execution ID number)"<<endl
      	<<"       [2] - rootFileIn"<<endl
	<<"       [3] - vecNamesFile"<<endl;
  }
  return 0;
}
