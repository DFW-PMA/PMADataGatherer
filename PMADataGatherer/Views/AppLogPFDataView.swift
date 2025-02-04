//
//  AppLogPFDataView.swift
//  PMADataGatherer
//
//  Created by Daryl Cox on 02/04/2025.
//  Copyright © JustMacApps 2023-2025. All rights reserved.
//

import Foundation
import SwiftUI

struct AppLogPFDataView: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "AppLogPFDataView"
        static let sClsVers      = "v1.0109"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2025. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }
    
    // App Data field(s):

//  @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    @State private  var cAppLogPFDataViewRefreshButtonPresses:Int             = 0
    @State private  var cAppLogPFDataViewPFCscButtonPresses:Int               = 0
    @State private  var cAppLogPFDataViewPFTherapistButtonPresses:Int         = 0
    @State private  var cAppLogPFDataViewTherapistXrefButtonPresses:Int       = 0
    @State private  var cAppLogPFDataViewSchedPatLocButtonPresses:Int         = 0

                    var jmAppDelegateVisitor:JmAppDelegateVisitor             = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    @ObservedObject var jmAppParseCoreManager:JmAppParseCoreManager           = JmAppParseCoreManager.ClassSingleton.appParseCodeManager
                    var jmAppParseCoreBkgdDataRepo:JmAppParseCoreBkgdDataRepo = JmAppParseCoreBkgdDataRepo.ClassSingleton.appParseCodeBkgdDataRepo
    
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

                    Spacer()

                    Button
                    {

                        self.cAppLogPFDataViewRefreshButtonPresses += 1

                        let _ = self.xcgLogMsg("...\(ClassInfo.sClsDisp)AppLogPFDataView.Button(Xcode).'Refresh'.#(\(self.cAppLogPFDataViewRefreshButtonPresses))...")

                    }
                    label:
                    {

                        VStack(alignment:.center)
                        {

                            Label("", systemImage: "arrow.clockwise")
                                .help(Text("'Refresh' App Log PFData Screen..."))
                                .imageScale(.large)

                            Text("Refresh - #(\(self.cAppLogPFDataViewRefreshButtonPresses))...")
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

                        let _ = xcgLogMsg("\(ClassInfo.sClsDisp):AppLogPFDataView.Button(Xcode).'Dismiss' pressed...")

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

            //  ScrollView(.vertical)
            //  {

                List
                {

                    HStack(alignment:.center)
                    {

                        Spacer()

                        Button
                        {

                            self.cAppLogPFDataViewPFCscButtonPresses += 1

                            let _ = self.xcgLogMsg("...\(ClassInfo.sClsDisp)AppLogPFDataView.Button(Xcode).'App Log PFData for PFCsc'.#(\(self.cAppLogPFDataViewPFCscButtonPresses))...")

                            self.detailPFCscDataItems()

                        }
                        label:
                        {

                            VStack(alignment:.center)
                            {

                                Label("", systemImage: "arrow.down.square")
                                    .help(Text("Log PFData for PFCsc..."))
                                    .imageScale(.large)

                                Text("Log PFData (PFCsc) - #(\(self.cAppLogPFDataViewPFCscButtonPresses))...")
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

                    }

                    HStack(alignment:.center)
                    {

                        Spacer()

                        Button
                        {

                            self.cAppLogPFDataViewPFTherapistButtonPresses += 1

                            let _ = self.xcgLogMsg("...\(ClassInfo.sClsDisp)AppLogPFDataView.Button(Xcode).'App Log PFData for PFTherapist'.#(\(self.cAppLogPFDataViewPFTherapistButtonPresses))...")

                            self.detailTherapistNamesList()

                        }
                        label:
                        {

                            VStack(alignment:.center)
                            {

                                Label("", systemImage: "arrow.down.square")
                                    .help(Text("Log PFData for PFTherapist..."))
                                    .imageScale(.large)

                                Text("Log PFData (PFTherapist) - #(\(self.cAppLogPFDataViewPFTherapistButtonPresses))...")
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

                    }

                    HStack(alignment:.center)
                    {

                        Spacer()

                        Button
                        {

                            self.cAppLogPFDataViewTherapistXrefButtonPresses += 1

                            let _ = self.xcgLogMsg("...\(ClassInfo.sClsDisp)AppLogPFDataView.Button(Xcode).'App Log Dictionary for TherapistXref'.#(\(self.cAppLogPFDataViewTherapistXrefButtonPresses))...")

                            self.detailTherapistXrefDict()

                        }
                        label:
                        {

                            VStack(alignment:.center)
                            {

                                Label("", systemImage: "arrow.down.square")
                                    .help(Text("Log Dictionary for TherapistXref..."))
                                    .imageScale(.large)

                                Text("Log Dictionary (TherapistXref) - #(\(self.cAppLogPFDataViewTherapistXrefButtonPresses))...")
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

                    }

                    HStack(alignment:.center)
                    {

                        Spacer()

                        Button
                        {

                            self.cAppLogPFDataViewSchedPatLocButtonPresses += 1

                            let _ = self.xcgLogMsg("...\(ClassInfo.sClsDisp)AppLogPFDataView.Button(Xcode).'App Log PFData for SchedPatLoc'.#(\(self.cAppLogPFDataViewSchedPatLocButtonPresses))...")

                            self.detailDictSchedPatientLocItems()

                        }
                        label:
                        {

                            VStack(alignment:.center)
                            {

                                Label("", systemImage: "arrow.down.square")
                                    .help(Text("Log PFData for SchedPatLoc..."))
                                    .imageScale(.large)

                                Text("Log PFData (SchedPatLoc) - #(\(self.cAppLogPFDataViewSchedPatLocButtonPresses))...")
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

                    }

                }

            //  }

            }

        }
        .padding()
        
    }
    
    private func detailPFCscDataItems()
    {
    
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
    
        // Log BOTH of the ParseCoreManager and ParseCoreBkgdDataRepo PFCscDataItem(s)...
    
        self.xcgLogMsg("\(sCurrMethodDisp) Displaying 'jmAppParseCoreManager' #(\(self.jmAppParseCoreManager.listPFCscDataItems.count)) PFCscDataItem(s)...")
    
        self.jmAppParseCoreManager.displayListPFCscDataItems()
    
        self.xcgLogMsg("\(sCurrMethodDisp) Displaying 'jmAppParseCoreBkgdDataRepo' #(\(self.jmAppParseCoreBkgdDataRepo.listPFCscDataItems.count)) PFCscDataItem(s)...")
    
        self.jmAppParseCoreBkgdDataRepo.displayListPFCscDataItems()
    
        // Exit...
    
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
    
        return
    
    }   // End of private func detailPFCscDataItems()

    private func detailTherapistNamesList()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
    
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
    
        // Detail all Therapist 'name(s)' in the dictionary...
    
        if (self.jmAppParseCoreManager.dictPFTherapistFileItems.count < 1)
        {
        
            self.xcgLogMsg("\(sCurrMethodDisp) Intermediate #1 - 'self.jmAppParseCoreManager.dictPFTherapistFileItems' is an empty 'dictionary' - unable to detail the item(s) - Warning!")
            
            // Exit:
    
            self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
    
            return
        
        }
    
        self.xcgLogMsg("\(sCurrMethodDisp) Intermediate #2 - 'self.jmAppParseCoreManager.dictPFTherapistFileItems' contains (\(self.jmAppParseCoreManager.dictPFTherapistFileItems.count)) item(s)...")
    
        var cTherapistNames:Int = 0
        
        for (iPFTherapistParseTID, pfTherapistFileItem) in self.jmAppParseCoreManager.dictPFTherapistFileItems
        {
    
            if (iPFTherapistParseTID < 0)
            {
    
                self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cTherapistNames)) 'iPFTherapistParseTID' - the 'tid' field is less than 0 - Warning!")
    
                continue
    
            }
    
            cTherapistNames += 1
            
            let sTherapistTName:String = pfTherapistFileItem.sPFTherapistFileName
    
            self.xcgLogMsg("\(sCurrMethodDisp) #(\(cTherapistNames)): 'iPFTherapistParseTID' is (\(iPFTherapistParseTID)) - 'sTherapistTName' is [\(sTherapistTName)] - 'pfTherapistFileItem' is [\(pfTherapistFileItem)]...")
    
        }
    
        self.xcgLogMsg("\(sCurrMethodDisp) Intermediate #3 - detailed (\(cTherapistNames)) names(s) in a dictionary of (\(self.jmAppParseCoreManager.dictPFTherapistFileItems.count)) item(s)...")
    
        // Exit:
    
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
    
        return
    
    }   // End of private func detailTherapistNamesList().

    private func detailTherapistXrefDict()
    {
    
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
    
        // Log BOTH of the ParseCoreManager and ParseCoreBkgdDataRepo 'dictTherapistTidXref(s)'...
    
        self.xcgLogMsg("\(sCurrMethodDisp) Displaying 'jmAppParseCoreManager' #(\(self.jmAppParseCoreManager.dictTherapistTidXref.count)) 'dictTherapistTidXref(s)'...")
    
        self.jmAppParseCoreManager.displayDictTherapistTidXfef()
    
        self.xcgLogMsg("\(sCurrMethodDisp) Displaying 'jmAppParseCoreBkgdDataRepo' #(\(self.jmAppParseCoreBkgdDataRepo.dictTherapistTidXref.count)) 'dictTherapistTidXref(s)'...")
    
        self.jmAppParseCoreBkgdDataRepo.displayDictTherapistTidXfef()
    
        // Exit...
    
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
    
        return
    
    }   // End of private func detailTherapistXrefDict()

    private func detailDictSchedPatientLocItems()
    {
    
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
    
        // Log BOTH of the ParseCoreManager and ParseCoreBkgdDataRepo PFCscDataItem(s)...
    
        self.xcgLogMsg("\(sCurrMethodDisp) Displaying 'jmAppParseCoreManager' #(\(self.jmAppParseCoreManager.dictSchedPatientLocItems.count)) dictionary of ScheduledPatientLocationItem(s)...")
    
        self.jmAppParseCoreManager.displayDictSchedPatientLocItems()
    
        self.xcgLogMsg("\(sCurrMethodDisp) Displaying 'jmAppParseCoreBkgdDataRepo' #(\(self.jmAppParseCoreBkgdDataRepo.dictSchedPatientLocItems.count)) dictionary of ScheduledPatientLocationItem(s)")
    
        self.jmAppParseCoreBkgdDataRepo.displayDictSchedPatientLocItems()
    
        // Exit...
    
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
    
        return
    
    }   // End of private func detailDictSchedPatientLocItems()

}   // End of struct AppLogPFDataView(View).

#Preview 
{
    
    AppLogPFDataView()
    
}

