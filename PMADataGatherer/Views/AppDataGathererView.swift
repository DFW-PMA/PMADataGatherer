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
        static let sClsVers      = "v1.0801"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2025. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }
    
    // App Data field(s):

//  @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    
//  @StateObject    var jmAppParseCoreManager:JmAppParseCoreManager
    
    @State private  var cAppLocationViewLogPFDataButtonPresses:Int     = 0
    @State private  var cAppDataGathererViewRefreshButtonPresses:Int   = 0
    @State private  var cContentViewAppLocationButtonPresses:Int       = 0
    @State private  var cAppDataGathererViewTherapistButtonPresses:Int = 0
    @State private  var cAppDataGathererViewPatientButtonPresses:Int   = 0

    @State private  var isAppLogPFDataViewModal:Bool                   = false
    @State private  var isAppLocationViewModal:Bool                    = false
    @State private  var isAppDataTherapist1ViewModal:Bool              = false
    @State private  var isAppDataTherapist2ViewModal:Bool              = false
    @State private  var isAppDataTherapist3ViewModal:Bool              = false
    @State private  var isAppDataPatient1ViewModal:Bool                = false
    @State private  var isAppDataPatient2ViewModal:Bool                = false
    @State private  var isAppDataPatient3ViewModal:Bool                = false

                    var jmAppDelegateVisitor:JmAppDelegateVisitor      = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    @ObservedObject var jmAppParseCoreManager:JmAppParseCoreManager    = JmAppParseCoreManager.ClassSingleton.appParseCodeManager
    
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

                        self.cContentViewAppLocationButtonPresses += 1

                        let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):ContentView.Button(Xcode).'App Location'.#(\(self.cContentViewAppLocationButtonPresses))...")

                        self.isAppLocationViewModal.toggle()

                //  #if os(macOS)
                //
                //      // Using -> @Environment(\.openWindow)var openWindow and 'openWindow(id:"...")' on MacOS...
                //      openWindow(id:"AppLocationView", value:self.getAppParseCoreManagerInstance())
                //
                //      //  ERROR: Instance method 'callAsFunction(id:value:)' requires that 'JmAppParseCoreManager' conform to 'Encodable'
                //      //  ERROR: Instance method 'callAsFunction(id:value:)' requires that 'JmAppParseCoreManager' conform to 'Decodable'
                //
                //  #endif
                //
                    }
                    label:
                    {

                        VStack(alignment:.center)
                        {

                            Label("", systemImage: "location.viewfinder")
                                .help(Text("App Location Information"))
                                .imageScale(.large)

                            Text("Location")
                                .font(.caption)

                        }

                    }
                #if os(macOS)
                    .sheet(isPresented:$isAppLocationViewModal, content:
                        {

                            AppLocationView()

                        }
                    )
                #endif
                #if os(iOS)
                    .fullScreenCover(isPresented:$isAppLocationViewModal)
                    {

                        AppLocationView()

                    }
                #endif
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

                    //  HStack(alignment:.center)
                    //  {
                    //
                    //      Spacer()
                    //
                    //      Button
                    //      {
                    //
                    //          self.cAppDataGathererViewTherapistButtonPresses += 1
                    //
                    //          let _ = self.xcgLogMsg("...\(ClassInfo.sClsDisp)AppDataGathererView.Button(Xcode).'Therapist Gatherer by TID'.#(\(self.cAppDataGathererViewTherapistButtonPresses))...")
                    //
                    //          self.isAppDataTherapist1ViewModal.toggle()
                    //
                    //      }
                    //      label:
                    //      {
                    //
                    //          VStack(alignment:.center)
                    //          {
                    //
                    //              Label("", systemImage: "bed.double")
                    //                  .help(Text("Therapist Data Gatherer #1 by TID Screen..."))
                    //                  .imageScale(.medium)
                    //
                    //              Text("Therapist - Data Gatherer by TID - #(\(self.cAppDataGathererViewTherapistButtonPresses))...")
                    //                  .font(.caption2)
                    //
                    //          }
                    //
                    //      }
                    //  #if os(macOS)
                    //      .sheet(isPresented:$isAppDataTherapist1ViewModal, content:
                    //          {
                    //
                    //              AppDataGathererTherapist1View()
                    //
                    //          }
                    //      )
                    //  #endif
                    //  #if os(iOS)
                    //      .fullScreenCover(isPresented:$isAppDataTherapist1ViewModal)
                    //      {
                    //
                    //          AppDataGathererTherapist1View()
                    //
                    //      }
                    //  #endif
                    //  #if os(macOS)
                    //      .buttonStyle(.borderedProminent)
                    //      .padding()
                    //  //  .background(???.isPressed ? .blue : .gray)
                    //      .cornerRadius(10)
                    //      .foregroundColor(Color.primary)
                    //  #endif
                    //
                    //      Spacer()
                    //
                    //  }
                    //
                    //  HStack(alignment:.center)
                    //  {
                    //
                    //      Spacer()
                    //
                    //      Button
                    //      {
                    //
                    //          self.cAppDataGathererViewTherapistButtonPresses += 1
                    //
                    //          let _ = self.xcgLogMsg("...\(ClassInfo.sClsDisp)AppDataGathererView.Button(Xcode).'Therapist Gatherer by tName'.#(\(self.cAppDataGathererViewTherapistButtonPresses))...")
                    //
                    //          self.isAppDataTherapist2ViewModal.toggle()
                    //
                    //      }
                    //      label:
                    //      {
                    //
                    //          VStack(alignment:.center)
                    //          {
                    //
                    //              Label("", systemImage: "bed.double")
                    //                  .help(Text("Therapist Data Gatherer #2 by tName Screen..."))
                    //                  .imageScale(.medium)
                    //
                    //              Text("Therapist - Data Gatherer by tName - #(\(self.cAppDataGathererViewTherapistButtonPresses))...")
                    //                  .font(.caption2)
                    //
                    //          }
                    //
                    //      }
                    //  #if os(macOS)
                    //      .sheet(isPresented:$isAppDataTherapist2ViewModal, content:
                    //          {
                    //
                    //              AppDataGathererTherapist2View()
                    //
                    //          }
                    //      )
                    //  #endif
                    //  #if os(iOS)
                    //      .fullScreenCover(isPresented:$isAppDataTherapist2ViewModal)
                    //      {
                    //
                    //          AppDataGathererTherapist2View()
                    //
                    //      }
                    //  #endif
                    //  #if os(macOS)
                    //      .buttonStyle(.borderedProminent)
                    //      .padding()
                    //  //  .background(???.isPressed ? .blue : .gray)
                    //      .cornerRadius(10)
                    //      .foregroundColor(Color.primary)
                    //  #endif
                    //
                    //      Spacer()
                    //
                    //  }

                        HStack(alignment:.center)
                        {

                            Spacer()

                            Button
                            {

                                self.cAppDataGathererViewTherapistButtonPresses += 1

                                let _ = self.xcgLogMsg("...\(ClassInfo.sClsDisp)AppDataGathererView.Button(Xcode).'Therapist Gatherer by TID or tName'.#(\(self.cAppDataGathererViewTherapistButtonPresses))...")

                                self.isAppDataTherapist3ViewModal.toggle()

                            }
                            label:
                            {

                                VStack(alignment:.center)
                                {

                                    Label("", systemImage: "bed.double")
                                        .help(Text("Therapist Data Gatherer #3 by TID or tName Screen..."))
                                        .imageScale(.medium)

                                    Text("Therapist - Data Gatherer by TID or tName - #(\(self.cAppDataGathererViewTherapistButtonPresses))...")
                                        .font(.caption2)

                                }

                            }
                        #if os(macOS)
                            .sheet(isPresented:$isAppDataTherapist3ViewModal, content:
                                {

                                    AppDataGathererTherapist3View()

                                }
                            )
                        #endif
                        #if os(iOS)
                            .fullScreenCover(isPresented:$isAppDataTherapist3ViewModal)
                            {

                                AppDataGathererTherapist3View()

                            }
                        #endif
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
                    header:
                    {

                        Text("Therapist(s)")
                            .bold()
                            .italic()
                            .underline()
                            .font(.caption)

                    }

                    Section
                    {

                    //  HStack(alignment:.center)
                    //  {
                    //
                    //      Spacer()
                    //
                    //      Button
                    //      {
                    //
                    //          self.cAppDataGathererViewPatientButtonPresses += 1
                    //
                    //          let _ = self.xcgLogMsg("...\(ClassInfo.sClsDisp)AppDataGathererView.Button(Xcode).'Patient Gatherer by PID'.#(\(self.cAppDataGathererViewPatientButtonPresses))...")
                    //
                    //          self.isAppDataPatient1ViewModal.toggle()
                    //
                    //      }
                    //      label:
                    //      {
                    //
                    //          VStack(alignment:.center)
                    //          {
                    //
                    //              Label("", systemImage: "person.text.rectangle")
                    //                  .help(Text("Patient Data Gatherer #1 by PID Screen..."))
                    //                  .imageScale(.medium)
                    //
                    //              Text("Patient - Data Gatherer by PID - #(\(self.cAppDataGathererViewPatientButtonPresses))...")
                    //                  .font(.caption2)
                    //
                    //          }
                    //
                    //      }
                    //  #if os(macOS)
                    //      .sheet(isPresented:$isAppDataPatient1ViewModal, content:
                    //          {
                    //
                    //              AppDataGathererPatient1View()
                    //
                    //          }
                    //      )
                    //  #endif
                    //  #if os(iOS)
                    //      .fullScreenCover(isPresented:$isAppDataPatient1ViewModal)
                    //      {
                    //
                    //          AppDataGathererPatient1View()
                    //
                    //      }
                    //  #endif
                    //  #if os(macOS)
                    //      .buttonStyle(.borderedProminent)
                    //      .padding()
                    //  //  .background(???.isPressed ? .blue : .gray)
                    //      .cornerRadius(10)
                    //      .foregroundColor(Color.primary)
                    //  #endif
                    //
                    //      Spacer()
                    //
                    //  }
                    //
                    //  HStack(alignment:.center)
                    //  {
                    //
                    //      Spacer()
                    //
                    //      Button
                    //      {
                    //
                    //          self.cAppDataGathererViewPatientButtonPresses += 1
                    //
                    //          let _ = self.xcgLogMsg("...\(ClassInfo.sClsDisp)AppDataGathererView.Button(Xcode).'Patient Gatherer by Name'.#(\(self.cAppDataGathererViewPatientButtonPresses))...")
                    //
                    //          self.isAppDataPatient2ViewModal.toggle()
                    //
                    //      }
                    //      label:
                    //      {
                    //
                    //          VStack(alignment:.center)
                    //          {
                    //
                    //              Label("", systemImage: "person.text.rectangle")
                    //                  .help(Text("Patient Data Gatherer #2 by Name Screen..."))
                    //                  .imageScale(.medium)
                    //
                    //              Text("Patient - Data Gatherer by Name - #(\(self.cAppDataGathererViewPatientButtonPresses))...")
                    //                  .font(.caption2)
                    //
                    //          }
                    //
                    //      }
                    //  #if os(macOS)
                    //      .sheet(isPresented:$isAppDataPatient2ViewModal, content:
                    //          {
                    //
                    //              AppDataGathererPatient2View()
                    //
                    //          }
                    //      )
                    //  #endif
                    //  #if os(iOS)
                    //      .fullScreenCover(isPresented:$isAppDataPatient2ViewModal)
                    //      {
                    //
                    //          AppDataGathererPatient2View()
                    //
                    //      }
                    //  #endif
                    //  #if os(macOS)
                    //      .buttonStyle(.borderedProminent)
                    //      .padding()
                    //  //  .background(???.isPressed ? .blue : .gray)
                    //      .cornerRadius(10)
                    //      .foregroundColor(Color.primary)
                    //  #endif
                    //
                    //      Spacer()
                    //
                    //  }

                        HStack(alignment:.center)
                        {

                            Spacer()

                            Button
                            {

                                self.cAppDataGathererViewPatientButtonPresses += 1

                                let _ = self.xcgLogMsg("...\(ClassInfo.sClsDisp)AppDataGathererView.Button(Xcode).'Patient Gatherer by PID or Name'.#(\(self.cAppDataGathererViewPatientButtonPresses))...")

                                self.isAppDataPatient3ViewModal.toggle()

                            }
                            label:
                            {

                                VStack(alignment:.center)
                                {

                                    Label("", systemImage: "person.text.rectangle")
                                        .help(Text("Patient Data Gatherer #3 by PID or Name Screen..."))
                                        .imageScale(.medium)

                                    Text("Patient - Data Gatherer by PID or Name - #(\(self.cAppDataGathererViewPatientButtonPresses))...")
                                        .font(.caption2)

                                }

                            }
                        #if os(macOS)
                            .sheet(isPresented:$isAppDataPatient3ViewModal, content:
                                {

                                    AppDataGathererPatient3View()

                                }
                            )
                        #endif
                        #if os(iOS)
                            .fullScreenCover(isPresented:$isAppDataPatient3ViewModal)
                            {

                                AppDataGathererPatient3View()

                            }
                        #endif
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
                    header:
                    {

                        Text("Patient(s)")
                            .bold()
                            .italic()
                            .underline()
                            .font(.caption)

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
                                .font(.caption)
                            Text(" => DATA Gatherer #3...")
                                .font(.caption)

                            Spacer()

                        }

                    }
                    header:
                    {

                        Text("Schedule(s)")
                            .bold()
                            .italic()
                            .underline()
                            .font(.caption)

                    }

                }

            //  }

            }

            Text("")            
                .hidden()
                .onAppear(
                    perform:
                    {
                        // Finish App 'initialization'...

                        let _ = self.finishAppInitialization()
                    })

        }
        .padding()
        
    }
    
    private func finishAppInitialization()
    {

        let sCurrMethod:String = #function;
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Finish the App 'initialization'...
  
        self.xcgLogMsg("\(ClassInfo.sClsDisp) Invoking the 'jmAppDelegateVisitor.checkAppDelegateVisitorTraceLogFileForSize()'...")

        self.jmAppDelegateVisitor.checkAppDelegateVisitorTraceLogFileForSize()

        self.xcgLogMsg("\(ClassInfo.sClsDisp) Invoked  the 'jmAppDelegateVisitor.checkAppDelegateVisitorTraceLogFileForSize()'...")

        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return

    } // End of private func finishAppInitialization().
    
}   // End of struct AppDataGathererView(View).

#Preview 
{
    
    AppDataGathererView()
    
}

