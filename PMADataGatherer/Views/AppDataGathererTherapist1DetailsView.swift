//
//  AppDataGathererTherapist1DetailsView.swift
//  PMADataGatherer
//
//  Created by Daryl Cox on 12/26/2024.
//  Copyright © JustMacApps 2023-2025. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct AppDataGathererTherapist1DetailsView: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "AppDataGathererTherapist1DetailsView"
        static let sClsVers      = "v1.0308"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2025. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }
    
    // App Data field(s):

//  @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode

    @Binding     private var sTherapistTID:String

    @State       private var sTherapistName:String                         = ""
    @State       private var pfTherapistFileItem:ParsePFTherapistFileItem? = nil

                         var jmAppDelegateVisitor:JmAppDelegateVisitor     = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    
    init(sTherapistTID:Binding<String>)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        // Handle the 'sTherapistTID' parameter...

        _sTherapistTID = sTherapistTID

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

                        let _ = xcgLogMsg("\(ClassInfo.sClsDisp):AppDataGathererTherapist1DetailsView.Button(Xcode).'Dismiss' pressed...")

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
                    .padding()

                }

                Text("")

                Text(" - - - - - - - - - - - - - - - - - - - - ")
                    .frame(maxWidth:.infinity, alignment:.center)

                Text("DATA Gatherer - Therapist Details by TID")
                    .bold()
                    .frame(maxWidth:.infinity, alignment:.center)

                Text(" - - - - - - - - - - - - - - - - - - - - ")
                    .frame(maxWidth:.infinity, alignment:.center)

                Text("")

                HStack()
                {

                    Text(":: Therapists' TID: ")
                        .onAppear
                        {

                            self.sTherapistName = self.locateAppTherapistNamebyTid(sTherapistTID:self.sTherapistTID)

                        }

                    Text("\(self.sTherapistTID)")
                        .italic()

                    Spacer()

                }

                HStack()
                {

                    Text("Therapists' Name: ")

                    Text("\(self.sTherapistName)")
                        .italic()

                    Spacer()

                }

            if (self.pfTherapistFileItem != nil)
            {
            
                ScrollView(.vertical)
                {

                    Grid(alignment:.leadingFirstTextBaseline, horizontalSpacing:5, verticalSpacing: 3)
                    {

                        // Column Headings:

                        Divider() 

                        GridRow 
                        {

                            Text("Item")
                                .bold()
                                .underline()
                            Text("Value")
                                .bold()
                                .underline()

                        }
                        .font(.caption) 

                        Divider() 

                        // Item Rows:

                        GridRow(alignment:.bottom)
                        {

                            Text("Therapists' Phone #")
                            Text("\(self.pfTherapistFileItem!.sPFTherapistFilePhone)")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Therapists' Email")
                            Text("\(self.pfTherapistFileItem!.sPFTherapistFileEmail)")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Therapists' Username")
                            Text("\(self.pfTherapistFileItem!.sPFTherapistFileUsername)")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Therapists' Password")
                            Text("\(self.pfTherapistFileItem!.sPFTherapistFilePassword)")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Therapists' HOME Location")
                            Text("\(self.pfTherapistFileItem!.sPFTherapistFileHomeLoc)")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Therapists' Address")
                            Text("\(self.pfTherapistFileItem!.sHomeLocLocationName), \(self.pfTherapistFileItem!.sHomeLocCity) \(self.pfTherapistFileItem!.sHomeLocPostalCode)")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Therapists' License #")
                            Text(verbatim:"\(self.pfTherapistFileItem!.iPFTherapistFileLicenseNumber)")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Therapists' NOT Active?")
                            Text("\(self.pfTherapistFileItem!.bPFTherapistFileNotActive)")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Therapists' is OFFICE?")
                            Text("\(self.pfTherapistFileItem!.bPFTherapistFileOffice)")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Therapists' is Supervisor?")
                            Text("\(self.pfTherapistFileItem!.bPFTherapistFileIsSupervisor)")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Therapists' has Assistant(s)?")
                            Text("\(self.pfTherapistFileItem!.bPFTherapistFileHaveAssistants)")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Therapists' TYPE")
                            Text(verbatim:"\(self.pfTherapistFileItem!.iPFTherapistFileType)")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Therapists' Supervisor TID #")
                            Text(verbatim:"\(self.pfTherapistFileItem!.iPFTherapistFileSuperID)")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Therapists' Mentor TID #")
                            Text(verbatim:"\(self.pfTherapistFileItem!.iPFTherapistFileMentorID)")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Therapists' LAST Sync")
                            Text("\(self.pfTherapistFileItem!.sPFTherapistFileLastSync)")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Therapists' iPad Update #")
                            Text(verbatim:"\(self.pfTherapistFileItem!.iPFTherapistFileIpadUpdate)")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Therapists' iPhone Update #")
                            Text(verbatim:"\(self.pfTherapistFileItem!.iPFTherapistFileIphoneUpdate)")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Therapists' Start Week")
                            Text("\(self.pfTherapistFileItem!.sPFTherapistFileStartWeek)")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Therapists' Start Invoice")
                            Text("\(self.pfTherapistFileItem!.sPFTherapistFileWeekStartInvoice)")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Therapists' # of EXPECTED Week Visit(s)")
                            Text(verbatim:"\(self.pfTherapistFileItem!.iPFTherapistFileExpectedWeekVisits)")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Therapists' # of LATE Week Visit(s)")
                            Text(verbatim:"\(self.pfTherapistFileItem!.iPFTherapistFileLateWeekVisits)")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Therapists' # of Previous Week VOID(s)")
                            Text(verbatim:"\(self.pfTherapistFileItem!.iPFTherapistFilePreviousWeekVoids2)")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Therapists' Makeups Allowed?")
                            Text("\(self.pfTherapistFileItem!.bPFTherapistFileMakeupsAllowed)")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Therapists' Over 50 Allowed?")
                            Text("\(self.pfTherapistFileItem!.bPFTherapistFileOver50Allowed)")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Therapists' Final Sync Ratios")
                            Text("\(self.pfTherapistFileItem!.listPFTherapistFileFinalSyncRatios)")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Therapists' Week Patient(s) 'missing' visit(s)")
                            Text("\(self.pfTherapistFileItem!.listPFTherapistFileWeekPtMissingVisits)")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Therapists' PID(s) for Friday")
                            Text("\(self.pfTherapistFileItem!.listPFTherapistFilePidsForFriday)")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Therapists' Parent ID(s)")
                            Text("\(self.pfTherapistFileItem!.listPFTherapistFileParentIDs)")

                        }
                        .font(.caption2) 

                        Divider() 

                    }

                }

            }
            else
            {

                Divider() 

                // Item Rows:

                GridRow(alignment:.bottom)
                {

                    Text("<<< NO Data >>>")
                    Text("Therapist TID #(\(self.sTherapistTID))")
                        .italic()

                }
                .font(.caption2) 

                Divider() 

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

        var sTherapistName:String = ""

        if (self.jmAppDelegateVisitor.jmAppParseCoreManager != nil)
        {
        
            sTherapistName = self.jmAppDelegateVisitor.jmAppParseCoreManager!.convertTidToTherapistName(sPFTherapistParseTID:sTherapistTID)

            let iTherapistTID:Int = Int(sTherapistTID)!

            self.pfTherapistFileItem = self.jmAppDelegateVisitor.jmAppParseCoreManager!.dictPFTherapistFileItems[iTherapistTID]
        
        }

        if (sTherapistName.count < 1)
        {
        
            sTherapistName = "-N/A-"
        
        }

        // Exit...

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'sTherapistName' is [\(sTherapistName)] - 'sTherapistTID' is [\(sTherapistTID)]...")
  
        return sTherapistName
  
    }   // End of private func locateAppTherapistNamebyTid(sTherapistTID:String)->String.

}   // End of struct AppDataGathererTherapist1DetailsView(View).
