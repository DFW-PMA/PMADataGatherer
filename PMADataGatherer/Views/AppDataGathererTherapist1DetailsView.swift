//
//  AppDataGathererTherapist1DetailsView.swift
//  PMADataGatherer
//
//  Created by Daryl Cox on 11/18/2024.
//  Copyright © JustMacApps 2023-2024. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct AppDataGathererTherapist1DetailsView: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "AppDataGathererTherapist1DetailsView"
        static let sClsVers      = "v1.0104"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2024. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }
    
    // App Data field(s):

//  @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode

    @Binding     private var sTherapistTID:String
    @State       private var sTherapistName:String                     = ""

                         var jmAppDelegateVisitor:JmAppDelegateVisitor = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    
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

                Text("DATA Gatherer - Therapist Details by TID #1")
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

                    Text(":: Therapists' Name: ")

                    Text("\(self.sTherapistName)")
                        .italic()

                    Spacer()

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
