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
        static let sClsVers      = "v1.2803"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2025. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

//  @Environment(\.modelContext) var modelContext
    @Environment(\.openWindow)   var openWindow
    @Environment(\.openURL)      var openURL

    // App Data field(s):

    @Binding       var isUserLoggedIn:Bool 
    @Binding       var sLoginUsername:String
    @Binding       var sLoginPassword:String

#if os(iOS)

//  @State private var cAppViewSuspendButtonPresses:Int          = 0
    @State private var cAppViewSettingsButtonPresses:Int         = 0
    
//  @State private var isAppSuspendShowing:Bool                  = false
    @State private var isAppSettingsModal:Bool                   = false

//         private var bIsAppUploadUsingLongMsg:Bool             = true
//
//  @State private var isAppExecutionCurrentShowing:Bool         = false
//         private var sAppExecutionCurrentButtonText:String     = "Share the current App Log with Developers..."
//         private var sAppExecutionCurrentAlertText:String      = "Do you want to 'send' the current App LOG data to the Developers?"
//
//         private var bWasAppLogFilePresentAtStartup:Bool       = false
//         private var bDidAppCrash:Bool                         = false
//         private var sAppExecutionPreviousTypeText:String      = "-N/A-"
//         private var sAppExecutionPreviousButtonText:String    = "App::-N/A-"
//         private var sAppExecutionPreviousAlertText:String     = "Do you want to 'send' the App LOG data?"
//         private var sAppExecutionPreviousLogToUpload:String   = ""
//  @State private var isAppExecutionPreviousShowing:Bool        = false

#endif
    
    @State private var cContentViewRefreshButtonPresses:Int      = 0
    @State private var cContentViewAppDataButtonPresses:Int      = 0
    @State private var cContentViewAppLocationButtonPresses:Int  = 0

    @State private var isAppDataViewModal:Bool                   = false
    @State private var isAppLocationViewModal:Bool               = false

    @State private var shouldContentViewChange:Bool              = false
    @State private var shouldContentViewShowAlert:Bool           = false

//                 var jmAppParseCoreManager:JmAppParseCoreManager
    
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

    //  // Get some 'internal' Dev Detail(s)...
    //
    //  bWasAppLogFilePresentAtStartup = checkIfAppLogWasPresent()
    //  bDidAppCrash                   = checkIfAppDidCrash()
    //
    //  if (bDidAppCrash == false)
    //  {
    //
    //      sAppExecutionPreviousTypeText    = "Success"
    //      sAppExecutionPreviousButtonText  = "Share the App 'success' Log with Developers..."
    //      sAppExecutionPreviousAlertText   = "Do you want to 'send' the App execution 'success' LOG data to the Developers?"
    //      sAppExecutionPreviousLogToUpload = AppGlobalInfo.sGlobalInfoAppLastGoodLogFilespec
    //
    //  }
    //  else
    //  {
    //
    //      sAppExecutionPreviousTypeText    = "Crash"
    //      sAppExecutionPreviousButtonText  = "Share the App CRASH Log with Developers..."
    //      sAppExecutionPreviousAlertText   = "Do you want to 'send' the App execution 'crash' LOG data to the Developers?"
    //      sAppExecutionPreviousLogToUpload = AppGlobalInfo.sGlobalInfoAppLastCrashLogFilespec
    //
    //  }

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

            //  Button
            //  {
            //  
            //      self.cAppViewSuspendButtonPresses += 1
            //  
            //      let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp)ContentView.Button(Xcode).'Quit'.#(\(self.cAppViewSuspendButtonPresses))...")
            //  
            //      self.isAppSuspendShowing.toggle()
            //  
            //  }
            //  label:
            //  {
            //  
            //      VStack(alignment:.center)
            //      {
            //  
            //          Label("", systemImage: "xmark.circle")
            //              .help(Text("Suspend this App"))
            //              .imageScale(.large)
            //  
            //          Text("Suspend App")
            //              .font(.caption)
            //  
            //      }
            //  
            //  }
            //  .alert("Are you sure you want to 'suspend' this App?", isPresented:$isAppSuspendShowing)
            //  {
            //      Button("Cancel", role:.cancel)
            //      {
            //          let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp) User pressed 'Cancel' to 'suspend' the App - resuming...")
            //      }
            //      Button("Ok", role:.destructive)
            //      {
            //          let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp) User pressed 'Ok' to 'suspend' the App - suspending...")
            //  
            //          UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
            //      }
            //  }
            //  
            //  Spacer()
            //  
            //  if (bWasAppLogFilePresentAtStartup == true)
            //  {
            //  
            //      Button
            //      {
            //  
            //          let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp)ContentView.Button(Xcode).'\(sAppExecutionPreviousButtonText)'...")
            //  
            //          self.isAppExecutionPreviousShowing.toggle()
            //  
            //      }
            //      label:
            //      {
            //          
            //          VStack(alignment:.center)
            //          {
            //              
            //              Label("", systemImage: "arrow.up.message")
            //                  .help(Text("'Send' \(sAppExecutionPreviousTypeText) App LOG"))
            //                  .imageScale(.large)
            //              
            //              Text("\(sAppExecutionPreviousTypeText) LOG")
            //                  .font(.caption)
            //              
            //          }
            //          
            //      }
            //      .alert(sAppExecutionPreviousAlertText, isPresented:$isAppExecutionPreviousShowing)
            //      {
            //          Button("Cancel", role:.cancel)
            //          {
            //              let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp) User pressed 'Cancel' to 'send' the \(sAppExecutionPreviousTypeText) App LOG - resuming...")
            //          }
            //          Button("Ok", role:.destructive)
            //          {
            //              let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp) User pressed 'Ok' to 'send' the \(sAppExecutionPreviousTypeText) App LOG - sending...")
            //  
            //              self.uploadPreviousAppLogToDevs()
            //          }
            //      }
            //  
            //  }
            //  
            //  Spacer()
            //  
            //  if (jmAppDelegateVisitor.bAppDelegateVisitorLogFilespecIsUsable == true)
            //  {
            //  
            //      Button
            //      {
            //  
            //          let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp)ContentView.Button(Xcode).'\(sAppExecutionCurrentButtonText)'...")
            //  
            //          self.isAppExecutionCurrentShowing.toggle()
            //  
            //      }
            //      label:
            //      {
            //          
            //          VStack(alignment:.center)
            //          {
            //              
            //              Label("", systemImage: "arrow.up.message")
            //                  .help(Text("'Send' current App LOG"))
            //                  .imageScale(.large)
            //              
            //              Text("Current LOG")
            //                  .font(.caption)
            //              
            //          }
            //          
            //      }
            //      .alert(sAppExecutionCurrentAlertText, isPresented:$isAppExecutionCurrentShowing)
            //      {
            //          Button("Cancel", role:.cancel)
            //          {
            //              let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp) User pressed 'Cancel' to 'send' the current App LOG - resuming...")
            //          }
            //          Button("Ok", role:.destructive)
            //          {
            //              let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp) User pressed 'Ok' to 'send' the current App LOG - sending...")
            //  
            //              self.uploadCurrentAppLogToDevs()
            //          }
            //      }
            //  
            //      Spacer()
            //  
            //  }

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

//  func checkIfAppLogWasPresent() -> Bool
//  {
//
//      let sCurrMethod:String = #function
//      let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
//      
//      self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
//
//      self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppDelegateVisitor' is [\(String(describing: jmAppDelegateVisitor))] - details are [\(jmAppDelegateVisitor.toString())]...")
//
//      let bWasAppLogPresentAtStart:Bool = jmAppDelegateVisitor.bWasAppLogFilePresentAtStartup
//      
//      // Exit...
//
//      self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'bWasAppLogPresentAtStart' is [\(String(describing: bWasAppLogPresentAtStart))]...")
//
//      return bWasAppLogPresentAtStart
//
//  }   // End of checkIfAppLogWasPresent().
//
//  func checkIfAppDidCrash() -> Bool
//  {
//
//      let sCurrMethod:String = #function
//      let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
//      
//      self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
//
//      self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppDelegateVisitor' is [\(String(describing: jmAppDelegateVisitor))] - details are [\(jmAppDelegateVisitor.toString())]...")
//
//      let bDidAppCrashOnLastRun:Bool = jmAppDelegateVisitor.bWasAppCrashFilePresentAtStartup
//
//      self.xcgLogMsg("\(sCurrMethodDisp) 'bDidAppCrashOnLastRun' is [\(String(describing: bDidAppCrashOnLastRun))]...")
//      
//      // Exit...
//
//      self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'bDidAppCrashOnLastRun' is [\(String(describing: bDidAppCrashOnLastRun))]...")
//
//      return bDidAppCrashOnLastRun
//
//  }   // End of checkIfAppDidCrash().
//
//  func uploadCurrentAppLogToDevs()
//  {
//
//      let sCurrMethod:String = #function
//      let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
//      
//      self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
//
//      // Prepare specifics to 'upload' the AppLog file...
//
//      var urlAppDelegateVisitorLogFilepath:URL?     = nil
//      var urlAppDelegateVisitorLogFilespec:URL?     = nil
//      var sAppDelegateVisitorLogFilespec:String!    = nil
//      var sAppDelegateVisitorLogFilepath:String!    = nil
//      var sAppDelegateVisitorLogFilenameExt:String! = nil
//
//      do 
//      {
//
//          urlAppDelegateVisitorLogFilepath  = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask ,appropriateFor: nil, create: true)
//          urlAppDelegateVisitorLogFilespec  = urlAppDelegateVisitorLogFilepath?.appendingPathComponent(AppGlobalInfo.sGlobalInfoAppLogFilespec)
//          sAppDelegateVisitorLogFilespec    = urlAppDelegateVisitorLogFilespec?.path
//          sAppDelegateVisitorLogFilepath    = urlAppDelegateVisitorLogFilepath?.path
//          sAppDelegateVisitorLogFilenameExt = urlAppDelegateVisitorLogFilespec?.lastPathComponent
//
//          self.xcgLogMsg("[\(sCurrMethodDisp)] 'sAppDelegateVisitorLogFilespec'    (computed) is [\(String(describing: sAppDelegateVisitorLogFilespec))]...")
//          self.xcgLogMsg("[\(sCurrMethodDisp)] 'sAppDelegateVisitorLogFilepath'    (resolved #2) is [\(String(describing: sAppDelegateVisitorLogFilepath))]...")
//          self.xcgLogMsg("[\(sCurrMethodDisp)] 'sAppDelegateVisitorLogFilenameExt' (computed) is [\(String(describing: sAppDelegateVisitorLogFilenameExt))]...")
//
//      }
//      catch
//      {
//
//          self.xcgLogMsg("[\(sCurrMethodDisp)] Failed to 'stat' item(s) in the 'path' of [.documentDirectory] - Error: \(error)...")
//
//      }
//
//      // Create the AppLog's 'multipartRequestInfo' object (but WITHOUT any Data (yet))...
//
//      let multipartRequestInfo:MultipartRequestInfo = MultipartRequestInfo()
//
//      multipartRequestInfo.bAppZipSourceToUpload    = false
//      multipartRequestInfo.sAppUploadURL            = ""          // "" takes the Upload URL 'default'...
//      multipartRequestInfo.sAppUploadNotifyTo       = ""          // This is email notification - "" defaults to all Dev(s)...
//      multipartRequestInfo.sAppUploadNotifyCc       = ""          // This is email notification - "" defaults to 'none'...
//      multipartRequestInfo.sAppSourceFilespec       = sAppDelegateVisitorLogFilespec
//      multipartRequestInfo.sAppSourceFilename       = sAppDelegateVisitorLogFilenameExt
//      multipartRequestInfo.sAppZipFilename          = sAppDelegateVisitorLogFilenameExt
//      multipartRequestInfo.sAppSaveAsFilename       = sAppDelegateVisitorLogFilenameExt
//      multipartRequestInfo.sAppFileMimeType         = "text/plain"
//
//      // Create the AppLog's 'multipartRequestInfo.dataAppFile' object...
//
//      multipartRequestInfo.dataAppFile              = FileManager.default.contents(atPath: sAppDelegateVisitorLogFilespec)
//
//      self.xcgLogMsg("\(sCurrMethodDisp) The 'upload' is using 'multipartRequestInfo' of [\(String(describing: multipartRequestInfo.toString()))]...")
//
//      // Send the AppLog as an 'upload' to the Server...
//
//      let multipartRequestDriver:MultipartRequestDriver = MultipartRequestDriver(bGenerateResponseLongMsg:self.bIsAppUploadUsingLongMsg)
//
//      self.xcgLogMsg("\(sCurrMethodDisp) Calling 'multipartRequestDriver.executeMultipartRequest(multipartRequestInfo:)'...")
//
//      multipartRequestDriver.executeMultipartRequest(multipartRequestInfo:multipartRequestInfo)
//      
//      self.xcgLogMsg("\(sCurrMethodDisp) Called  'multipartRequestDriver.executeMultipartRequest(multipartRequestInfo:)'...")
//
//      // Exit...
//
//      self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
//
//      return
//
//  }   // End of uploadCurrentAppLogToDevs().
//
//  func uploadPreviousAppLogToDevs()
//  {
//
//      let sCurrMethod:String = #function
//      let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
//      
//      self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
//
//      // Prepare specifics to 'upload' the AppLog file...
//
//      var urlAppDelegateVisitorLogFilepath:URL?     = nil
//      var urlAppDelegateVisitorLogFilespec:URL?     = nil
//      var sAppDelegateVisitorLogFilespec:String!    = nil
//      var sAppDelegateVisitorLogFilepath:String!    = nil
//      var sAppDelegateVisitorLogFilenameExt:String! = nil
//
//      do 
//      {
//
//          urlAppDelegateVisitorLogFilepath  = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask ,appropriateFor: nil, create: true)
//          urlAppDelegateVisitorLogFilespec  = urlAppDelegateVisitorLogFilepath?.appendingPathComponent(sAppExecutionPreviousLogToUpload)
//          sAppDelegateVisitorLogFilespec    = urlAppDelegateVisitorLogFilespec?.path
//          sAppDelegateVisitorLogFilepath    = urlAppDelegateVisitorLogFilepath?.path
//          sAppDelegateVisitorLogFilenameExt = urlAppDelegateVisitorLogFilespec?.lastPathComponent
//
//          self.xcgLogMsg("[\(sCurrMethodDisp)] 'sAppDelegateVisitorLogFilespec'    (computed) is [\(String(describing: sAppDelegateVisitorLogFilespec))]...")
//          self.xcgLogMsg("[\(sCurrMethodDisp)] 'sAppDelegateVisitorLogFilepath'    (resolved #2) is [\(String(describing: sAppDelegateVisitorLogFilepath))]...")
//          self.xcgLogMsg("[\(sCurrMethodDisp)] 'sAppDelegateVisitorLogFilenameExt' (computed) is [\(String(describing: sAppDelegateVisitorLogFilenameExt))]...")
//
//      }
//      catch
//      {
//
//          self.xcgLogMsg("[\(sCurrMethodDisp)] Failed to 'stat' item(s) in the 'path' of [.documentDirectory] - Error: \(error)...")
//
//      }
//
//      // Create the AppLog's 'multipartRequestInfo' object (but WITHOUT any Data (yet))...
//
//      let multipartRequestInfo:MultipartRequestInfo = MultipartRequestInfo()
//
//      multipartRequestInfo.bAppZipSourceToUpload    = false
//      multipartRequestInfo.sAppUploadURL            = ""          // "" takes the Upload URL 'default'...
//      multipartRequestInfo.sAppUploadNotifyTo       = ""          // This is email notification - "" defaults to all Dev(s)...
//      multipartRequestInfo.sAppUploadNotifyCc       = ""          // This is email notification - "" defaults to 'none'...
//      multipartRequestInfo.sAppSourceFilespec       = sAppDelegateVisitorLogFilespec
//      multipartRequestInfo.sAppSourceFilename       = sAppDelegateVisitorLogFilenameExt
//      multipartRequestInfo.sAppZipFilename          = sAppDelegateVisitorLogFilenameExt
//      multipartRequestInfo.sAppSaveAsFilename       = sAppDelegateVisitorLogFilenameExt
//      multipartRequestInfo.sAppFileMimeType         = "text/plain"
//
//      // Create the AppLog's 'multipartRequestInfo.dataAppFile' object...
//
//      multipartRequestInfo.dataAppFile              = FileManager.default.contents(atPath: sAppDelegateVisitorLogFilespec)
//
//      self.xcgLogMsg("\(sCurrMethodDisp) The 'upload' is using 'multipartRequestInfo' of [\(String(describing: multipartRequestInfo.toString()))]...")
//
//      // Send the AppLog as an 'upload' to the Server...
//
//      let multipartRequestDriver:MultipartRequestDriver = MultipartRequestDriver(bGenerateResponseLongMsg:self.bIsAppUploadUsingLongMsg)
//
//      self.xcgLogMsg("\(sCurrMethodDisp) Calling 'multipartRequestDriver.executeMultipartRequest(multipartRequestInfo:)'...")
//
//      multipartRequestDriver.executeMultipartRequest(multipartRequestInfo:multipartRequestInfo)
//      
//      self.xcgLogMsg("\(sCurrMethodDisp) Called  'multipartRequestDriver.executeMultipartRequest(multipartRequestInfo:)'...")
//
//      // Exit...
//
//      self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
//
//      return
//
//  }   // End of uploadPreviousAppLogToDevs().

//  func getAppParseCoreManagerInstance()->JmAppParseCoreManager
//  {
//
//      let sCurrMethod:String = #function
//      let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
//      
//      self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
//
//      self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppDelegateVisitor' is [\(String(describing: jmAppDelegateVisitor))] - details are [\(jmAppDelegateVisitor.toString())]...")
//
//      let jmAppParseCoreManager:JmAppParseCoreManager = jmAppDelegateVisitor.jmAppParseCoreManager ?? JmAppParseCoreManager()
//
//      // Exit...
//
//      self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'jmAppDelegateVisitor.jmAppParseCoreManager?' is [\(String(describing: jmAppDelegateVisitor.jmAppParseCoreManager))]...")
//
//      return jmAppParseCoreManager
//
//  }   // End of getAppParseCoreManagerInstance()->jmAppParseCoreManager.

}   // End of struct ContentView(View).

