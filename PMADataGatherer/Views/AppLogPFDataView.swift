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
        static let sClsVers      = "v1.0205"
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
    @State private  var cAppLogPFDataViewPFTherapistNamesButtonPresses:Int    = 0
    @State private  var cAppLogPFDataViewPFTherapistFileButtonPresses:Int     = 0
    @State private  var cAppLogPFDataViewTherapistXrefButtonPresses:Int       = 0
    @State private  var cAppLogPFDataViewPFPatientNamesButtonPresses:Int      = 0
    @State private  var cAppLogPFDataViewPFPatientFileButtonPresses:Int       = 0
    @State private  var cAppLogPFDataViewPFPatientXrefButtonPresses:Int       = 0
    @State private  var cAppLogPFDataViewPatientXrefButtonPresses:Int         = 0
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
                                    .imageScale(.medium)

                                Text("Log PFData (PFCsc) - #(\(self.cAppLogPFDataViewPFCscButtonPresses))...")
                                    .font(.caption2)

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

                            self.cAppLogPFDataViewPFTherapistNamesButtonPresses += 1

                            let _ = self.xcgLogMsg("...\(ClassInfo.sClsDisp)AppLogPFDataView.Button(Xcode).'App Log PFData for PFTherapist (Names)'.#(\(self.cAppLogPFDataViewPFTherapistNamesButtonPresses))...")

                            self.detailTherapistNamesList()

                        }
                        label:
                        {

                            VStack(alignment:.center)
                            {

                                Label("", systemImage: "arrow.down.square")
                                    .help(Text("Log PFData for PFTherapist (Names)..."))
                                    .imageScale(.medium)

                                Text("Log PFData (PFTherapist) Names - #(\(self.cAppLogPFDataViewPFTherapistNamesButtonPresses))...")
                                    .font(.caption2)

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

                            self.cAppLogPFDataViewPFTherapistFileButtonPresses += 1

                            let _ = self.xcgLogMsg("...\(ClassInfo.sClsDisp)AppLogPFDataView.Button(Xcode).'App Log PFData for PFTherapistFile'.#(\(self.cAppLogPFDataViewPFTherapistFileButtonPresses))...")

                            self.detailTherapistFileItems()

                        }
                        label:
                        {

                            VStack(alignment:.center)
                            {

                                Label("", systemImage: "arrow.down.square")
                                    .help(Text("Log PFData for PFTherapistFile..."))
                                    .imageScale(.medium)

                                Text("Log PFData (PFTherapistFile) - #(\(self.cAppLogPFDataViewPFTherapistFileButtonPresses))...")
                                    .font(.caption2)

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
                                    .imageScale(.medium)

                                Text("Log Dictionary (TherapistXref) - #(\(self.cAppLogPFDataViewTherapistXrefButtonPresses))...")
                                    .font(.caption2)

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

                            self.cAppLogPFDataViewPFPatientNamesButtonPresses += 1

                            let _ = self.xcgLogMsg("...\(ClassInfo.sClsDisp)AppLogPFDataView.Button(Xcode).'App Log PFData for PFPatient (Names)'.#(\(self.cAppLogPFDataViewPFPatientNamesButtonPresses))...")

                            self.detailPatientNamesList()

                        }
                        label:
                        {

                            VStack(alignment:.center)
                            {

                                Label("", systemImage: "arrow.down.square")
                                    .help(Text("Log PFData for PFPatient (Names)..."))
                                    .imageScale(.medium)

                                Text("Log PFData (PFPatient) Names - #(\(self.cAppLogPFDataViewPFPatientNamesButtonPresses))...")
                                    .font(.caption2)

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

                            self.cAppLogPFDataViewPFPatientFileButtonPresses += 1

                            let _ = self.xcgLogMsg("...\(ClassInfo.sClsDisp)AppLogPFDataView.Button(Xcode).'App Log PFData for PFPatientFile'.#(\(self.cAppLogPFDataViewPFPatientFileButtonPresses))...")

                            self.detailPatientFileItems()

                        }
                        label:
                        {

                            VStack(alignment:.center)
                            {

                                Label("", systemImage: "arrow.down.square")
                                    .help(Text("Log PFData for PFPatientFile..."))
                                    .imageScale(.medium)

                                Text("Log PFData (PFPatientFile) - #(\(self.cAppLogPFDataViewPFPatientFileButtonPresses))...")
                                    .font(.caption2)

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

                            self.cAppLogPFDataViewPatientXrefButtonPresses += 1

                            let _ = self.xcgLogMsg("...\(ClassInfo.sClsDisp)AppLogPFDataView.Button(Xcode).'App Log Dictionary for PatientXref'.#(\(self.cAppLogPFDataViewPatientXrefButtonPresses))...")

                            self.detailPatientXrefDict()

                        }
                        label:
                        {

                            VStack(alignment:.center)
                            {

                                Label("", systemImage: "arrow.down.square")
                                    .help(Text("Log Dictionary for PatientXref..."))
                                    .imageScale(.medium)

                                Text("Log Dictionary (PatientXref) - #(\(self.cAppLogPFDataViewPatientXrefButtonPresses))...")
                                    .font(.caption2)

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
                                    .imageScale(.medium)

                                Text("Log PFData (SchedPatLoc) - #(\(self.cAppLogPFDataViewSchedPatLocButtonPresses))...")
                                    .font(.caption2)

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

    private func detailTherapistFileItems()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Detail all TherapistFile 'item(s)' in the JmAppParseCoreManger of the JmAppDelegateVisitor...

        if (self.jmAppDelegateVisitor.jmAppParseCoreManager != nil)
        {

            if (self.jmAppDelegateVisitor.jmAppParseCoreManager!.dictPFTherapistFileItems.count > 0)
            {

                self.xcgLogMsg("\(sCurrMethodDisp) Displaying the 'jmAppParseCoreManager' dictionary of #(\(self.jmAppDelegateVisitor.jmAppParseCoreManager!.dictPFTherapistFileItems.count)) 'dictPFTherapistFileItems' item(s)...")

                var cPFTherapistParseTIDs:Int = 0

                for (iPFTherapistParseTID, pfTherapistFileItem) in self.jmAppDelegateVisitor.jmAppParseCoreManager!.dictPFTherapistFileItems
                {

                    cPFTherapistParseTIDs += 1

                    if (iPFTherapistParseTID < 0)
                    {

                        self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppParseCoreManager' Skipping object #(\(cPFTherapistParseTIDs)) 'iPFTherapistParseTID' - the 'tid' field is less than 0 - Warning!")

                        continue

                    }

                    self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppParseCoreManager' For TID [\(iPFTherapistParseTID)] - Displaying 'pfTherapistFileItem' item #(\(cPFTherapistParseTIDs)):")

                    pfTherapistFileItem.displayParsePFTherapistFileItemToLog()

                }

            }
            else
            {

                self.xcgLogMsg("\(sCurrMethodDisp) Unable to display the 'jmAppParseCoreManager' dictionary of 'dictPFTherapistFileItems' item(s) - item(s) count is less than 1 - Warning!")

            }

        }
        else
        {

            self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppParseCoreManager' is nil - unable to get the dictionary 'dictPFTherapistFileItems' - Error!")

        }

        // Detail all TherapistFile 'item(s)' in the JmAppParseCoreBkgdDataRepo of the JmAppDelegateVisitor...

        if (self.jmAppParseCoreBkgdDataRepo.dictPFTherapistFileItems.count > 0)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Displaying the 'jmAppParseCoreBkgdDataRepo' dictionary of #(\(self.jmAppParseCoreBkgdDataRepo.dictPFTherapistFileItems.count)) 'dictPFTherapistFileItems' item(s)...")

            var cPFTherapistParseTIDs:Int = 0

            for (iPFTherapistParseTID, pfTherapistFileItem) in self.jmAppParseCoreBkgdDataRepo.dictPFTherapistFileItems
            {

                cPFTherapistParseTIDs += 1

                if (iPFTherapistParseTID < 0)
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppParseCoreBkgdDataRepo' Skipping object #(\(cPFTherapistParseTIDs)) 'iPFTherapistParseTID' - the 'tid' field is less than 0 - Warning!")

                    continue

                }

                self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppParseCoreBkgdDataRepo' For TID [\(iPFTherapistParseTID)] - Displaying 'pfTherapistFileItem' item #(\(cPFTherapistParseTIDs)):")

                pfTherapistFileItem.displayParsePFTherapistFileItemToLog()

            }

        }
        else
        {

            self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppParseCoreBkgdDataRepo' Unable to display the dictionary of 'dictPFTherapistFileItems' item(s) - item(s) count is less than 1 - Warning!")

        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of private func detailTherapistFileItems().

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

    private func detailPatientNamesList()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
    
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
    
        // Detail all Patient 'name(s)' in the dictionary...
    
        if (self.jmAppParseCoreManager.dictPFPatientFileItems.count < 1)
        {
        
            self.xcgLogMsg("\(sCurrMethodDisp) Intermediate #1 - 'self.jmAppParseCoreManager.dictPFPatientFileItems' is an empty 'dictionary' - unable to detail the item(s) - Warning!")
            
            // Exit:
    
            self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
    
            return
        
        }
    
        self.xcgLogMsg("\(sCurrMethodDisp) Intermediate #2 - 'self.jmAppParseCoreManager.dictPFPatientFileItems' contains (\(self.jmAppParseCoreManager.dictPFPatientFileItems.count)) item(s)...")
    
        var cPatientNames:Int = 0
        
        for (iPFPatientParseTID, pfPatientFileItem) in self.jmAppParseCoreManager.dictPFPatientFileItems
        {
    
            if (iPFPatientParseTID < 0)
            {
    
                self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cPatientNames)) 'iPFPatientParseTID' - the 'tid' field is less than 0 - Warning!")
    
                continue
    
            }
    
            cPatientNames += 1
            
            let sPatientTName:String = pfPatientFileItem.sPFPatientFileName
    
            self.xcgLogMsg("\(sCurrMethodDisp) #(\(cPatientNames)): 'iPFPatientParseTID' is (\(iPFPatientParseTID)) - 'sPatientTName' is [\(sPatientTName)] - 'pfPatientFileItem' is [\(pfPatientFileItem)]...")
    
        }
    
        self.xcgLogMsg("\(sCurrMethodDisp) Intermediate #3 - detailed (\(cPatientNames)) names(s) in a dictionary of (\(self.jmAppParseCoreManager.dictPFPatientFileItems.count)) item(s)...")
    
        // Exit:
    
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
    
        return
    
    }   // End of private func detailPatientNamesList().

    private func detailPatientFileItems()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Detail all PatientFile 'item(s)' in the JmAppParseCoreManger of the JmAppDelegateVisitor...

        if (self.jmAppDelegateVisitor.jmAppParseCoreManager != nil)
        {

            if (self.jmAppDelegateVisitor.jmAppParseCoreManager!.dictPFPatientFileItems.count > 0)
            {

                self.xcgLogMsg("\(sCurrMethodDisp) Displaying the 'jmAppParseCoreManager' dictionary of #(\(self.jmAppDelegateVisitor.jmAppParseCoreManager!.dictPFPatientFileItems.count)) 'dictPFPatientFileItems' item(s)...")

                var cPFPatientParsePIDs:Int = 0

                for (iPFPatientParsePID, pfPatientFileItem) in self.jmAppDelegateVisitor.jmAppParseCoreManager!.dictPFPatientFileItems
                {

                    cPFPatientParsePIDs += 1

                    if (iPFPatientParsePID < 0)
                    {

                        self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppParseCoreManager' Skipping object #(\(cPFPatientParsePIDs)) 'iPFPatientParsePID' - the 'pid' field is less than 0 - Warning!")

                        continue

                    }

                    self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppParseCoreManager' For PID [\(iPFPatientParsePID)] - Displaying 'pfPatientFileItem' item #(\(cPFPatientParsePIDs)):")

                    pfPatientFileItem.displayParsePFPatientFileItemToLog()

                }

            }
            else
            {

                self.xcgLogMsg("\(sCurrMethodDisp) Unable to display the 'jmAppParseCoreManager' dictionary of 'dictPFPatientFileItems' item(s) - item(s) count is less than 1 - Warning!")

            }

        }
        else
        {

            self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppParseCoreManager' is nil - unable to get the dictionary 'dictPFPatientFileItems' - Error!")

        }

        // Detail all PatientFile 'item(s)' in the JmAppParseCoreBkgdDataRepo of the JmAppDelegateVisitor...

        if (self.jmAppParseCoreBkgdDataRepo.dictPFPatientFileItems.count > 0)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Displaying the 'jmAppParseCoreBkgdDataRepo' dictionary of #(\(self.jmAppParseCoreBkgdDataRepo.dictPFPatientFileItems.count)) 'dictPFPatientFileItems' item(s)...")

            var cPFPatientParsePIDs:Int = 0

            for (iPFPatientParsePID, pfPatientFileItem) in self.jmAppParseCoreBkgdDataRepo.dictPFPatientFileItems
            {

                cPFPatientParsePIDs += 1

                if (iPFPatientParsePID < 0)
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppParseCoreBkgdDataRepo' Skipping object #(\(cPFPatientParsePIDs)) 'iPFPatientParsePID' - the 'pid' field is less than 0 - Warning!")

                    continue

                }

                self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppParseCoreBkgdDataRepo' For PID [\(iPFPatientParsePID)] - Displaying 'pfPatientFileItem' item #(\(cPFPatientParsePIDs)):")

                pfPatientFileItem.displayParsePFPatientFileItemToLog()

            }

        }
        else
        {

            self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppParseCoreBkgdDataRepo' Unable to display the dictionary of 'dictPFPatientFileItems' item(s) - item(s) count is less than 1 - Warning!")

        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of private func detailPatientFileItems().

    private func detailPatientXrefDict()
    {
    
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
    
        // Log BOTH of the ParseCoreManager and ParseCoreBkgdDataRepo 'dictPatientTidXref(s)'...
    
        self.xcgLogMsg("\(sCurrMethodDisp) Displaying 'jmAppParseCoreManager' #(\(self.jmAppParseCoreManager.dictPatientPidXref.count)) 'dictPatientTidXref(s)'...")
    
        self.jmAppParseCoreManager.displayDictPatientPidXfef()
    
        self.xcgLogMsg("\(sCurrMethodDisp) Displaying 'jmAppParseCoreBkgdDataRepo' #(\(self.jmAppParseCoreBkgdDataRepo.dictPatientPidXref.count)) 'dictPatientPidXref(s)'...")
    
        self.jmAppParseCoreBkgdDataRepo.displayDictPatientPidXfef()
    
        // Exit...
    
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
    
        return
    
    }   // End of private func detailPatientXrefDict()

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

