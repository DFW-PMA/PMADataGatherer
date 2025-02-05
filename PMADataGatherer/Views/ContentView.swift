//
//  ContentView.swift
//  PMADataGatherer
//
//  Created by Daryl Cox on 07/19/2024.
//  Copyright © JustMacApps 2023-2025. All rights reserved.
//

import Foundation
import SwiftUI
import SwiftData

struct ContentView: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "ContentView"
        static let sClsVers      = "v1.2901"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2025. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    @Environment(\.openWindow)   var openWindow
    @Environment(\.openURL)      var openURL

    // App Data field(s):

    @Binding       var isUserLoggedIn:Bool 
    @Binding       var sLoginUsername:String
    @Binding       var sLoginPassword:String

#if os(iOS)

    @State private var cAppViewSettingsButtonPresses:Int         = 0
    
    @State private var isAppSettingsModal:Bool                   = false

#endif
    
    @State private var cContentViewRefreshButtonPresses:Int      = 0
    @State private var cContentViewAppDataButtonPresses:Int      = 0
    @State private var cContentViewAppLocationButtonPresses:Int  = 0

    @State private var isAppDataViewModal:Bool                   = false
    @State private var isAppLocationViewModal:Bool               = false

    @State private var shouldContentViewChange:Bool              = false
    @State private var shouldContentViewShowAlert:Bool           = false

                   var jmAppDelegateVisitor:JmAppDelegateVisitor = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    
    init(isUserLoggedIn: Binding<Bool>, sLoginUsername: Binding<String>, sLoginPassword: Binding<String>)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        // Handle inbound parameter(s) before any 'self.' references...

        _isUserLoggedIn = isUserLoggedIn
        _sLoginUsername = sLoginUsername
        _sLoginPassword = sLoginPassword

        // Continue with 'init()'...
        
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

        let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):body(some Scene) \(JmXcodeBuildSettings.jmAppVersionAndBuildNumber)...")
        
        VStack 
        {
            
        #if os(iOS)

            HStack
            {

                Spacer()

                Button
                {

                    self.cContentViewRefreshButtonPresses += 1

                    let _ = self.xcgLogMsg("...\(ClassInfo.sClsDisp)ContentView.Button(Xcode).'Refresh'.#(\(self.cContentViewRefreshButtonPresses))...")

                }
                label:
                {

                    VStack(alignment:.center)
                    {

                        Label("", systemImage: "arrow.clockwise")
                            .help(Text("'Refresh' App Screen..."))
                            .imageScale(.large)

                        Text("Refresh Screen - #(\(self.cContentViewRefreshButtonPresses))...")
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

                    self.cAppViewSettingsButtonPresses += 1

                    let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp)ContentView.Button(Xcode).'Settings'.#(\(self.cAppViewSettingsButtonPresses))...")

                    self.isAppSettingsModal.toggle()

                }
                label:
                {

                    VStack(alignment:.center)
                    {

                        Label("", systemImage: "gearshape")
                            .help(Text("App Settings"))
                            .imageScale(.large)

                        Text("Settings")
                            .font(.caption)

                    }

                }
            #if os(macOS)
                .sheet(isPresented:$isAppSettingsModal, content:
                    {

                        SettingsSingleView()

                    }
                )
            #elseif os(iOS)
                .fullScreenCover(isPresented:$isAppSettingsModal)
                {

                    SettingsSingleView()

                }
            #endif
                .padding()

            }

        #endif
            
            Spacer(minLength:10)

        if #available(iOS 17.0, *)
        {

            Image(ImageResource(name: "Gfx/AppIcon", bundle: Bundle.main))
                .resizable()
                .scaledToFit()
                .containerRelativeFrame(.horizontal)
                    { size, axis in
                        size * 0.15
                    }

        }
        else
        {

            Image(ImageResource(name: "Gfx/AppIcon", bundle: Bundle.main))
                .resizable()
                .scaledToFit()
                .frame(width:75, height: 75, alignment:.center)

        }
            
            Spacer(minLength: 10)
            
            Text("--- [\(AppGlobalInfo.sGlobalInfoAppId)] ---")
                .onReceive(jmAppDelegateVisitor.$isAppDelegateVisitorShowingAlert,
                    perform:
                    { bShow in
                        if (bShow == true)
                        {
                            let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp).onReceive #1 - Received a 'show' Alert...")
                            shouldContentViewShowAlert                            = true
                            jmAppDelegateVisitor.isAppDelegateVisitorShowingAlert = false
                        }
                    })
                .alert("\(jmAppDelegateVisitor.sAppDelegateVisitorGlobalAlertMessage ?? "")", isPresented:$shouldContentViewShowAlert)
                {

                    Button("\(jmAppDelegateVisitor.sAppDelegateVisitorGlobalAlertButtonText ?? "")", role:.cancel) { }

                }
            
            Spacer()
            
            Text("\(JmXcodeBuildSettings.jmAppVersionAndBuildNumber)")     // <=== Version...
                .italic()
                .onReceive(jmAppDelegateVisitor.$appDelegateVisitorSwiftViewsShouldChange,
                    perform:
                    { bChange in
                        if (bChange == true)
                        {
                            let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp).onReceive #2 - Received a 'view(s)' SHOULD Change...")

                            shouldContentViewChange = true

                            jmAppDelegateVisitor.resetAppDelegateVisitorSignalSwiftViewsShouldChange()
                        }
                    })

            Spacer(minLength: 4)

            Text("\(JmXcodeBuildSettings.jmAppCopyright)")
                .italic()
            
            Spacer()

            HStack(alignment:.center)
            {

                Spacer()

                Button
                {

                    self.cContentViewAppDataButtonPresses += 1

                    let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):ContentView.Button(Xcode).'App Data...'.#(\(self.cContentViewAppDataButtonPresses))...")

                    self.isAppDataViewModal.toggle()

                #if os(macOS)
              
                    // Using -> @Environment(\.openWindow)var openWindow and 'openWindow(id:"...")' on MacOS...
                    openWindow(id:"AppDataGathererView")
              
                #endif

            //  #if os(macOS)
            //
            //      // Using -> @Environment(\.openWindow)var openWindow and 'openWindow(id:"...")' on MacOS...
            //      openWindow(id:"AppLocationView", value:self.getAppParseCoreManagerInstance())
            //
            //      //  ERROR: Instance method 'callAsFunction(id:value:)' requires that 'JmAppParseCoreManager' conform to 'Encodable'
            //      //  ERROR: Instance method 'callAsFunction(id:value:)' requires that 'JmAppParseCoreManager' conform to 'Decodable'
            //
            //  #endif
            
                }
                label:
                {

                    VStack(alignment:.center)
                    {

                        Label("", systemImage: "swiftdata")
                            .help(Text("App Data Gatherer"))
                            .imageScale(.large)

                        Text("Data")
                            .font(.caption)

                    }

                }
        //  #if os(macOS)
        //      .sheet(isPresented:$isAppDataViewModal, content:
        //          {
        //
        //              AppDataGathererView()
        //
        //          }
        //      )
        //  #endif
            #if os(iOS)
                .fullScreenCover(isPresented:$isAppDataViewModal)
                {

                    AppDataGathererView()

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
                
                    let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):ContentView.Button(Xcode).'Logout' pressed...")

                    self.sLoginPassword = ""
                    
                    self.isUserLoggedIn.toggle()
                
                }
                label:
                {

                    VStack(alignment:.center)
                    {

                        Label("", systemImage: "person.badge.key")
                            .help(Text("App 'logout'"))
                            .imageScale(.large)

                        Text("Logout")
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
            
            Spacer()
            
        }
        .padding()
        
    }

}   // End of struct ContentView(View).

