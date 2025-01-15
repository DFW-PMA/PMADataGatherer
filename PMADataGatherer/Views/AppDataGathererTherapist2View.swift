//
//  AppDataGathererTherapist2View.swift
//  PMADataGatherer
//
//  Created by Daryl Cox on 12/26/2024.
//  Copyright © JustMacApps 2023-2025. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct AppDataGathererTherapist2View: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "AppDataGathererTherapist2View"
        static let sClsVers      = "v1.0305"
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
       case therapistName
    }
    
    @FocusState  private var focusedField:FocusedFields?

    @State       private var sTherapistTID:String                                   = ""
    @State       private var sTherapistName:String                                  = ""

//  @StateObject         var jmAppParseCoreManager:JmAppParseCoreManager
    
    @State       private var cAppDataGathererTherapist2ViewRefreshButtonPresses:Int = 0

    @State       private var isAppRunTherapistLocateByTNameShowing:Bool             = false
    @State       private var isAppTherapistDetailsByTNameShowing:Bool               = false

                         var jmAppDelegateVisitor:JmAppDelegateVisitor              = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    @ObservedObject      var jmAppParseCoreManager:JmAppParseCoreManager            = JmAppParseCoreManager.ClassSingleton.appParseCodeManager
    
//  init(jmAppParseCoreManager:JmAppParseCoreManager)
    init()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
    //  // Handle the 'jmAppParseCoreManager' parameter...
    //
    //  self._jmAppParseCoreManager = StateObject(wrappedValue: jmAppParseCoreManager)

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

                        self.cAppDataGathererTherapist2ViewRefreshButtonPresses += 1

                        let _ = self.xcgLogMsg("...\(ClassInfo.sClsDisp)AppDataGathererTherapist2View.Button(Xcode).'Refresh'.#(\(self.cAppDataGathererTherapist2ViewRefreshButtonPresses))...")

                    }
                    label:
                    {

                        VStack(alignment:.center)
                        {

                            Label("", systemImage: "arrow.clockwise")
                                .help(Text("'Refresh' App Data Gatherer Therapist by tName Screen..."))
                                .imageScale(.large)

                            Text("Refresh - #(\(self.cAppDataGathererTherapist2ViewRefreshButtonPresses))...")
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

                        let _ = xcgLogMsg("\(ClassInfo.sClsDisp):AppDataGathererTherapist2View.Button(Xcode).'Dismiss' pressed...")

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

                Text("DATA Gatherer - Therapist by tName")
                    .bold()
                    .frame(maxWidth:.infinity, alignment:.center)

                Text(" - - - - - - - - - - - - - - - - - - - - ")
                    .frame(maxWidth:.infinity, alignment:.center)

                Spacer()

                HStack()
                {

                    Text("===> Therapists' TID: ")

                    Text("\(sTherapistTID)")
                        .onChange(of:self.sTherapistName)
                        {
                            let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp).onChange #1 - 'self.sTherapistName' is [\(self.sTherapistName)] - clearing the 'sTherapistTID' field...")

                            self.sTherapistTID = ""
                        }

                    if (self.sTherapistTID.count    > 0 &&
                        (self.sTherapistName.count  > 0 &&
                         self.sTherapistName       != "-N/A-"))
                    {

                        Button
                        {

                            let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp)AppDataGathererTherapist2View.Button(Xcode).'Therapist Detail(s) by tName'...")

                            self.isAppTherapistDetailsByTNameShowing.toggle()

                        }
                        label:
                        {

                            VStack(alignment:.center)
                            {

                                Label("", systemImage: "doc.questionmark")
                                    .help(Text("Show Therapist Detail(s) by tName..."))
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
                        .sheet(isPresented:$isAppTherapistDetailsByTNameShowing, content:
                        {

                            AppDataGathererTherapist1DetailsView(sTherapistTID:$sTherapistTID)

                        })
                    #endif
                    #if os(iOS)
                        .fullScreenCover(isPresented:$isAppTherapistDetailsByTNameShowing)
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
                    else
                    {

                        Spacer()

                    }

                }

                HStack()
                {

                    Text("=> Enter the Therapists' Name: ")
                        .foregroundColor(.red)

                    TextField("Therapist tName...", text:$sTherapistName)
                        .italic()
                        .focused($focusedField, equals:.therapistName)
                        .onSubmit
                        {
                            self.sTherapistTID  = self.locateAppTherapistNameByTName(sTherapistName:sTherapistName)
                            focusedField        = .therapistName
                        }
                        .onAppear
                        {
                            self.sTherapistName = ""
                            self.sTherapistTID  = ""
                            focusedField        = .therapistName
                        }

                    Spacer()
                    
                }

                Text("")

                HStack
                {

                    Button
                    {

                        let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp)AppDataGathererTherapist2View.Button(Xcode).'Locate the Therapist by tName'...")

                        self.sTherapistTID = self.locateAppTherapistNameByTName(sTherapistName:sTherapistName)

                        self.isAppRunTherapistLocateByTNameShowing.toggle()

                    }
                    label:
                    {

                        VStack(alignment:.center)
                        {

                            Label("", systemImage: "figure.run.circle")
                                .help(Text("Locate the Therapist by tName..."))
                                .imageScale(.large)

                            HStack(alignment:.center)
                            {

                                Spacer()

                                Text("=> Locate the Therapist by tName...")
                                    .bold()
                                    .font(.caption)
                                    .foregroundColor(.red)

                                Spacer()

                            }

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

                Spacer()

            }

            Spacer()

        }
        .padding()
        
    }
    
    private func locateAppTherapistNameByTName(sTherapistName:String = "")->String
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'sTherapistName' is [\(sTherapistName)]...")

        // Locate the Therapist TID by 'name'...

        var sTherapistTID:String = self.jmAppParseCoreManager.convertTherapistNameToTid(sPFTherapistParseName:sTherapistName)

        if (sTherapistTID.count < 1)
        {
        
            sTherapistTID = "-1"
        
        }

        // Exit...

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'sTherapistName' is [\(sTherapistName)] - 'sTherapistTID' is [\(sTherapistTID)]...")
  
        return sTherapistTID
  
    }   // End of private func locateAppTherapistNameByTName(sTherapistName:String)->String.

}   // End of struct AppDataGathererTherapist2View(View).

#Preview 
{
    
    AppDataGathererTherapist2View()
    
}

