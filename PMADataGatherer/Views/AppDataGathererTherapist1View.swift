//
//  AppDataGathererTherapist1View.swift
//  PMADataGatherer
//
//  Created by Daryl Cox on 12/26/2024.
//  Copyright © JustMacApps 2023-2025. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct AppDataGathererTherapist1View: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "AppDataGathererTherapist1View"
        static let sClsVers      = "v1.0501"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2025. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }
    
    // App Data field(s):

//  @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode

    enum FocusedFields
    {
       case therapistTID
    }
    
    @FocusState private var focusedField:FocusedFields?

    @State      private var sTherapistTID:String                                   = ""
    @State      private var sTherapistName:String                                  = ""

    @State      private var cAppLocationViewLogPFDataButtonPresses:Int             = 0
    @State      private var cAppDataGathererTherapist1ViewRefreshButtonPresses:Int = 0

    @State      private var isAppLogPFDataViewModal:Bool                           = false
    @State      private var isAppRunTherapistLocateByTidShowing:Bool               = false
    @State      private var isAppTherapistDetailsByTidShowing:Bool                 = false

                        var jmAppDelegateVisitor:JmAppDelegateVisitor              = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    @ObservedObject     var jmAppParseCoreManager:JmAppParseCoreManager            = JmAppParseCoreManager.ClassSingleton.appParseCodeManager
                        var jmAppParseCoreBkgdDataRepo:JmAppParseCoreBkgdDataRepo  = JmAppParseCoreBkgdDataRepo.ClassSingleton.appParseCodeBkgdDataRepo
    
    init()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Exit...

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of init().

    private func xcgLogMsg(_ sMessage:String)
    {

        if (self.jmAppDelegateVisitor.bAppDelegateVisitorLogFilespecIsUsable == true)
        {
        
            self.jmAppDelegateVisitor.xcgLogMsg(sMessage)
        
        }
        else
        {
        
            print("\(sMessage)")
        
        }

        // Exit:

        return

    }   // End of private func xcgLogMsg().

    var body: some View
    {
        
        let _ = xcgLogMsg("\(ClassInfo.sClsDisp):body(some View) \(ClassInfo.sClsCopyRight)...")
        
        NavigationStack
        {

            VStack
            {

                HStack(alignment:.center)
                {

                    if (AppGlobalInfo.bPerformAppDevTesting == true)
                    {

                        Button
                        {

                            self.cAppLocationViewLogPFDataButtonPresses += 1

                            let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):AppLocationView.Button(Xcode).'Log PFData'.#(\(self.cAppLocationViewLogPFDataButtonPresses)) pressed...")

                            self.isAppLogPFDataViewModal.toggle()

                        //  self.detailPFCscDataItems()

                        }
                        label:
                        {

                            VStack(alignment:.center)
                            {

                                Label("", systemImage: "doc.text.magnifyingglass")
                                    .help(Text("Log PFXxxDataItem(s)..."))
                                    .imageScale(.small)

                                Text("Log PFData")
                                    .font(.caption2)

                            }

                        }
                    #if os(macOS)
                        .sheet(isPresented:$isAppLogPFDataViewModal, content:
                            {

                                AppLogPFDataView()

                            }
                        )
                    #endif
                    #if os(iOS)
                        .fullScreenCover(isPresented:$isAppLogPFDataViewModal)
                        {

                            AppLogPFDataView()

                        }
                    #endif
                        .padding()
                    #if os(macOS)
                        .buttonStyle(.borderedProminent)
                    //  .background(???.isPressed ? .blue : .gray)
                        .cornerRadius(10)
                        .foregroundColor(Color.primary)
                    #endif

                    }

                    Spacer()

                    Button
                    {

                        self.cAppDataGathererTherapist1ViewRefreshButtonPresses += 1

                        let _ = self.xcgLogMsg("...\(ClassInfo.sClsDisp)AppDataGathererTherapist1View.Button(Xcode).'Refresh'.#(\(self.cAppDataGathererTherapist1ViewRefreshButtonPresses))...")

                    }
                    label:
                    {

                        VStack(alignment:.center)
                        {

                            Label("", systemImage: "arrow.clockwise")
                                .help(Text("'Refresh' App Data Gatherer Therapist by TID Screen..."))
                                .imageScale(.large)

                            Text("Refresh - #(\(self.cAppDataGathererTherapist1ViewRefreshButtonPresses))...")
                                .font(.caption)

                        }

                    }
                #if os(macOS)
                    .buttonStyle(.borderedProminent)
                    .padding()
                //  .background(???.isPressed ? .blue : .gray)
                    .cornerRadius(10)
                    .foregroundColor(Color.primary)
                #endif

                    Spacer()

                    Button
                    {

                        let _ = xcgLogMsg("\(ClassInfo.sClsDisp):AppDataGathererTherapist1View.Button(Xcode).'Dismiss' pressed...")

                        self.presentationMode.wrappedValue.dismiss()

                    //  dismiss()

                    }
                    label:
                    {

                        VStack(alignment:.center)
                        {

                            Label("", systemImage: "xmark.circle")
                                .help(Text("Dismiss this Screen"))
                                .imageScale(.large)

                            Text("Dismiss")
                                .font(.caption)

                        }

                    }
                #if os(macOS)
                    .buttonStyle(.borderedProminent)
                    .padding()
                //  .background(???.isPressed ? .blue : .gray)
                    .cornerRadius(10)
                    .foregroundColor(Color.primary)
                #endif
                    .padding()

                }

                Text("")

                Text(" - - - - - - - - - - - - - - - - - - - - ")
                    .frame(maxWidth:.infinity, alignment:.center)

                Text("DATA Gatherer - Therapist by TID")
                    .bold()
                    .frame(maxWidth:.infinity, alignment:.center)

                Text(" - - - - - - - - - - - - - - - - - - - - ")
                    .frame(maxWidth:.infinity, alignment:.center)

                Spacer()

                HStack()
                {

                    Text("=> Enter the Therapists' TID: ")
                        .foregroundColor(.red)

                    TextField("Therapist TID...", text:$sTherapistTID)
                    #if os(iOS)
                        .keyboardType(.numberPad)
                    #endif
                        .onSubmit
                        {
                            self.sTherapistName = self.locateAppTherapistNamebyTid(sTherapistTID:sTherapistTID)
                            focusedField        = .therapistTID
                        }
                        .onReceive(Just(sTherapistTID))
                        { newValue in
                            let filteredValue = newValue.filter { "0123456789".contains($0) }
                            if (filteredValue != newValue)
                            {
                                self.sTherapistTID = filteredValue
                            }
                        }
                        .focused($focusedField, equals:.therapistTID)
                        .onAppear
                        {
                            self.sTherapistName = ""
                            focusedField        = .therapistTID
                        }

                }

                HStack()
                {

                    Text("===> Therapists' Name: ")

                    Text("\(self.sTherapistName)")
                        .italic()

                    Spacer()

                    if (self.sTherapistTID.count    > 0 &&
                        (self.sTherapistName.count  > 0 &&
                         self.sTherapistName       != "-N/A-"))
                    {

                        Button
                        {

                            let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp)AppDataGathererTherapist1View.Button(Xcode).'Therapist Detail(s) by TID'...")

                            self.isAppTherapistDetailsByTidShowing.toggle()

                        }
                        label:
                        {

                            VStack(alignment:.center)
                            {

                                Label("", systemImage: "doc.questionmark")
                                    .help(Text("Show Therapist Detail(s) by TID..."))
                                    .imageScale(.medium)

                                HStack(alignment:.center)
                                {

                                    Spacer()

                                    Text("Therapist Details...")
                                        .font(.caption2)

                                    Spacer()

                                }

                            }

                        }
                    #if os(macOS)
                        .sheet(isPresented:$isAppTherapistDetailsByTidShowing, content:
                        {

                            AppDataGathererTherapist1DetailsView(sTherapistTID:$sTherapistTID)

                        })
                    #endif
                    #if os(iOS)
                        .fullScreenCover(isPresented:$isAppTherapistDetailsByTidShowing)
                        {

                            AppDataGathererTherapist1DetailsView(sTherapistTID:$sTherapistTID)

                        }
                    #endif
                    #if os(macOS)
                        .buttonStyle(.borderedProminent)
                        .padding()
                    //  .background(???.isPressed ? .blue : .gray)
                        .cornerRadius(10)
                        .foregroundColor(Color.primary)
                    #endif
                        .padding()
                    
                    }
                    
                }

                Spacer()

                HStack
                {

                    Button
                    {

                        let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp)AppDataGathererTherapist1View.Button(Xcode).'Locate the Therapist by TID'...")

                        self.sTherapistName = self.locateAppTherapistNamebyTid(sTherapistTID:sTherapistTID)

                        self.isAppRunTherapistLocateByTidShowing.toggle()

                    }
                    label:
                    {

                        VStack(alignment:.center)
                        {

                            Label("", systemImage: "figure.run.circle")
                                .help(Text("Locate the Therapist by TID..."))
                                .imageScale(.large)

                            HStack(alignment:.center)
                            {

                                Spacer()

                                Text("=> Locate the Therapist by TID...")
                                    .bold()
                                    .font(.caption)
                                    .foregroundColor(.red)

                                Spacer()

                            }

                        }

                    }
                //  .alert("TID #(\(sTherapistTID)) is Therapist 'named' [\(sTherapistName)]...", 
                //         isPresented:$isAppRunTherapistLocateByTidShowing)
                //  {
                //      Button("Ok", role:.cancel)
                //      {
                //          let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp) User pressed 'Ok' to 'locate' the Therapist by TID...")
                //      }
                //  }
                #if os(macOS)
                    .buttonStyle(.borderedProminent)
                    .padding()
                //  .background(???.isPressed ? .blue : .gray)
                    .cornerRadius(10)
                    .foregroundColor(Color.primary)
                #endif
                    .padding()

                }

                Spacer()

            }

            Spacer()

        }
        .padding()
        
    }
    
    private func locateAppTherapistNamebyTid(sTherapistTID:String = "")->String
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'sTherapistTID' is [\(sTherapistTID)]...")

        // Locate the Therapist 'name' by TID...

        var sTherapistName:String = self.jmAppParseCoreBkgdDataRepo.convertTidToTherapistName(sPFTherapistParseTID:sTherapistTID)

        if (sTherapistName.count < 1)
        {
        
            sTherapistName = "-N/A-"
        
        }

        // Exit...

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'sTherapistName' is [\(sTherapistName)] - 'sTherapistTID' is [\(sTherapistTID)]...")
  
        return sTherapistName
  
    }   // End of private func locateAppTherapistNamebyTid(sTherapistTID:String)->String.

}   // End of struct AppDataGathererTherapist1View(View).

#Preview 
{
    
    AppDataGathererTherapist1View()
    
}

