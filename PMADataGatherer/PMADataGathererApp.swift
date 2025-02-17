//
//  PMADataGathererApp.swift
//  PMADataGatherer
//
//  Created by Daryl Cox on 07/19/2024.
//  Copyright © JustMacApps 2023-2025. All rights reserved.
//

import Foundation
import SwiftUI
import SwiftData

@main
struct PMADataGathererApp: App 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "PMADataGathererApp"
        static let sClsVers      = "v1.2001"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2025. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    // AppDelegate:
    //     (NOTE: This causes the AppDelegate class to instantiate
    //            - use this ONLY once in an App or it will cause multiple instantiation(s) of AppDelegate...

#if os(macOS)

    @NSApplicationDelegateAdaptor(PMADataGathererNSAppDelegate.self)
    var appDelegate

#elseif os(iOS)

    @UIApplicationDelegateAdaptor(PMADataGathererUIAppDelegate.self)
    var appDelegate

#endif

    // App Data field(s):

    let sAppBundlePath:String                                       = Bundle.main.bundlePath

                    var jmAppDelegateVisitor:JmAppDelegateVisitor   = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    @ObservedObject var jmAppParseCoreManager:JmAppParseCoreManager = JmAppParseCoreManager.ClassSingleton.appParseCodeManager
    
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

    var body: some Scene 
    {
        
        let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):body(some Scene) - 'sAppBundlePath' is [\(sAppBundlePath)]...")
        
        WindowGroup
        {
            
            AppAuthenticateView()
                .navigationTitle(AppGlobalInfo.sGlobalInfoAppId)
                .onOpenURL(perform:
                            { url in
                    
                    self.xcgLogMsg("\(ClassInfo.sClsDisp):AuthenticateView.onOpenURL() performed for the URL of [\(url)]...")
                    
                })
            
        }
        .handlesExternalEvents(matching: [])
#if os(macOS)
        .commands
        {
            
            AppInfoCommands()
            
            HelpCommands()
            
        }
#endif
        
#if os(macOS)
        Settings
        {
            
            SettingsSingleView()
            
        }
#endif
        
#if os(macOS)
        // This is the Window to diaplay the AppWorkRouteView...this works from MacOS...
        
        Window("AppWorkRoute", id:"AppWorkRouteView")
        {
            
            AppWorkRouteView()
            
        }
        
        // This is the Window to diaplay the AppWorkRouteMapView...this works from MacOS...
        
        WindowGroup("AppWorkRouteMap", id:"AppWorkRouteMapView", for: UUID.self)
        { $uuid in
            
            AppWorkRouteMapView(parsePFCscDataItem:jmAppParseCoreManager.locatePFCscDataItemByID(id:uuid ?? UUID()))
            
        }

        // This is the Window to diaplay the AppTidScheduleView...this works from MacOS...

        Window("AppTidSchedule", id:"AppTidScheduleView")
        {

            AppTidScheduleView(listScheduledPatientLocationItems: [])

        }

        // This is the Window to diaplay the AppWorkRouteView...this works from MacOS...

        Window("AppDataGatherer", id:"AppDataGathererView")
        {

            AppDataGathererView()

        }

    #endif
        
    }
    
}   // End of struct PMADataGathererApp(App). 

