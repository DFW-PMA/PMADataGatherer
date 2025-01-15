//
//  AppDataGathererView.swift
//  PMADataGatherer
//
//  Created by Daryl Cox on 12/26/2024.
//  Copyright © JustMacApps 2023-2025. All rights reserved.
//

import Foundation
import SwiftUI

struct AppDataGathererView: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "AppDataGathererView"
        static let sClsVers      = "v1.0401"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2025. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }
    
    // App Data field(s):

//  @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject   var jmAppParseCoreManager:JmAppParseCoreManager
    
    @State private var cAppDataGathererViewRefreshButtonPresses:Int   = 0
    @State private var cAppDataGathererViewTherapistButtonPresses:Int = 0

    @State private var isAppDataTherapist1ViewModal:Bool              = false
    @State private var isAppDataTherapist2ViewModal:Bool              = false

                   var jmAppDelegateVisitor:JmAppDelegateVisitor      = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    
    init(jmAppParseCoreManager:JmAppParseCoreManager)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        // Handle the 'jmAppParseCoreManager' parameter...

        self._jmAppParseCoreManager = StateObject(wrappedValue: jmAppParseCoreManager)

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

                        self.cAppDataGathererViewRefreshButtonPresses += 1

                        let _ = self.xcgLogMsg("...\(ClassInfo.sClsDisp)AppDataGathererView.Button(Xcode).'Refresh'.#(\(self.cAppDataGathererViewRefreshButtonPresses))...")

                    }
                    label:
                    {

                        VStack(alignment:.center)
                        {

                            Label("", systemImage: "arrow.clockwise")
                                .help(Text("'Refresh' App Data Gatherer Screen..."))
                                .imageScale(.large)

                            Text("Refresh - #(\(self.cAppDataGathererViewRefreshButtonPresses))...")
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

                        let _ = xcgLogMsg("\(ClassInfo.sClsDisp):AppDataGathererView.Button(Xcode).'Dismiss' pressed...")

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

                    Section
                    {

                        HStack(alignment:.center)
                        {

                            Spacer()

                            Button
                            {

                                self.cAppDataGathererViewTherapistButtonPresses += 1

                                let _ = self.xcgLogMsg("...\(ClassInfo.sClsDisp)AppDataGathererView.Button(Xcode).'Therapist Gatherer by TID'.#(\(self.cAppDataGathererViewTherapistButtonPresses))...")

                                self.isAppDataTherapist1ViewModal.toggle()

                            }
                            label:
                            {

                                VStack(alignment:.center)
                                {

                                    Label("", systemImage: "bed.double")
                                        .help(Text("Therapist Data Gatherer #1 by TID Screen..."))
                                        .imageScale(.large)

                                    Text("Therapist - Data Gatherer by TID - #(\(self.cAppDataGathererViewTherapistButtonPresses))...")
                                        .font(.caption)

                                }

                            }
                        #if os(macOS)
                            .sheet(isPresented:$isAppDataTherapist1ViewModal, content:
                                {

                                    AppDataGathererTherapist1View(jmAppParseCoreManager:jmAppParseCoreManager)

                                }
                            )
                        #endif
                        #if os(iOS)
                            .fullScreenCover(isPresented:$isAppDataTherapist1ViewModal)
                            {

                                AppDataGathererTherapist1View(jmAppParseCoreManager:jmAppParseCoreManager)

                            }
                        #endif

                            Spacer()

                        }

                        HStack(alignment:.center)
                        {

                            Spacer()

                            Button
                            {

                                self.cAppDataGathererViewTherapistButtonPresses += 1

                                let _ = self.xcgLogMsg("...\(ClassInfo.sClsDisp)AppDataGathererView.Button(Xcode).'Therapist Gatherer by tName'.#(\(self.cAppDataGathererViewTherapistButtonPresses))...")

                                self.isAppDataTherapist2ViewModal.toggle()

                            }
                            label:
                            {

                                VStack(alignment:.center)
                                {

                                    Label("", systemImage: "bed.double")
                                        .help(Text("Therapist Data Gatherer #2 by tName Screen..."))
                                        .imageScale(.large)

                                    Text("Therapist - Data Gatherer by tName - #(\(self.cAppDataGathererViewTherapistButtonPresses))...")
                                        .font(.caption)

                                }

                            }
                        #if os(macOS)
                            .sheet(isPresented:$isAppDataTherapist2ViewModal, content:
                                {

                                    AppDataGathererTherapist2View(jmAppParseCoreManager:jmAppParseCoreManager)

                                }
                            )
                        #endif
                        #if os(iOS)
                            .fullScreenCover(isPresented:$isAppDataTherapist2ViewModal)
                            {

                                AppDataGathererTherapist2View(jmAppParseCoreManager:jmAppParseCoreManager)

                            }
                        #endif

                            Spacer()

                        }

                    }
                    header:
                    {

                        Text("Therapist(s)")
                            .bold()
                            .italic()
                            .underline()

                    }

                    Section
                    {

                        HStack(alignment:.center)
                        {

                            Spacer()

                            Text("<under-construction>")
                                .bold()
                                .italic()
                                .underline()
                            Text(" => DATA Gatherer #2...")

                            Spacer()

                        }

                    }
                    header:
                    {

                        Text("Patient(s)")
                            .bold()
                            .italic()
                            .underline()

                    }

                    Section
                    {

                        HStack(alignment:.center)
                        {

                            Spacer()

                            Text("<under-construction>")
                                .bold()
                                .italic()
                                .underline()
                            Text(" => DATA Gatherer #3...")

                            Spacer()

                        }

                    }
                    header:
                    {

                        Text("Other")
                            .bold()
                            .italic()
                            .underline()

                    }

                }

            //  }

            }

        }
        .padding()
        
    }
    
}   // End of struct AppDataGathererView(View).

#Preview 
{
    
    AppDataGathererView(jmAppParseCoreManager:JmAppParseCoreManager())
    
}

