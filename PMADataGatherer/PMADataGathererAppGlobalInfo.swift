//
//  PMADataGathererAppGlobalInfo.swift
//  PMADataGatherer
//
//  Created by Daryl Cox on 07/25/2024.
//  Copyright © JustMacApps 2023-2025. All rights reserved.
//

import SwiftUI

#if os(macOS)
import IOKit
#endif

#if os(iOS)
import UIKit
#endif

public class AppGlobalInfo: NSObject
{
    
    struct ClassSingleton
    {

        static 
        var appGlobalInfo:AppGlobalInfo                                  = AppGlobalInfo()

    }

    static let sGlobalInfoAppId:String                                   = "PMADataGatherer"
    static let sGlobalInfoAppVers:String                                 = "v1.2803"
    static let sGlobalInfoAppDisp:String                                 = sGlobalInfoAppId+".("+sGlobalInfoAppVers+"): "
    static let sGlobalInfoAppCopyRight:String                            = "Copyright (C) JustMacApps 2023-2025. All Rights Reserved."
    static let sGlobalInfoAppLogFilespec:String                          = "PMADataGatherer.log"
    static let sGlobalInfoAppLastGoodLogFilespec:String                  = "PMADataGatherer.last_good.log"
    static let sGlobalInfoAppLastCrashLogFilespec:String                 = "PMADataGatherer.crashed_last.log"
    static let sGlobalInfoAppCrashMarkerFilespec:String                  = "PMADataGatherer.crash_marker.txt"

    static let bUseApplicationShortTitle:Bool                            = true
    static let sApplicationTitle:String                                  = sGlobalInfoAppId
    static let sApplicationShortTitle:String                             = "PMADataGatherer"

#if os(macOS)

    static let sHelpBasicFileExt:String                                  = "html"        // 'help' File extension: "md", "html", or "txt"

#elseif os(iOS)

    static let sHelpBasicFileExt:String                                  = "md"          // 'help' File extension: "md", "html", or "txt"

#endif

    // Various 'app' component options:
    
    static let bInstantiateAppSwiftDataManager:Bool                      = true
    static let bPerformAppObjCSwiftBridgeTest:Bool                       = true
    static let bInstantiateAppMetricKitManager:Bool                      = true
    static let bAppMetricKitManagerSendDiagnostics:Bool                  = false
    static let bAppMetricKitManagerSendMetrics:Bool                      = true
    static let bInstantiateAppUserNotificationsManager:Bool              = true
    static let bIssueTestAppUserNotifications:Bool                       = false
    static let bIssueShortAppUserNotifications:Bool                      = true
    static let bInstantiateAppParseCoreManager:Bool                      = true
    static let bInstantiateAppCoreLocationSupport:Bool                   = true
    static let bPerformAppCoreLocationTesting:Bool                       = true
    static let bInstantiateAppMenuBarStatusBar:Bool                      = false
    static let bPerformAppDevTesting:Bool                                = true
    static let bEnableAppReleaseDownloads:Bool                           = true
    static let bInstantiateAppNWSWeatherModelObservable:Bool             = false
    static let bTestStringManipulations:Bool                             = true
    static let sAppUploadNotifyFrom:String                               = "dcox@justmacapps.net"

    // Various 'device' information:

           var sGlobalDeviceType:String                                  = "-unknown-"   // Values: "Mac", "iPad", "iPhone, "AppleWatch"
           var bGlobalDeviceIsMac:Bool                                   = false
           var bGlobalDeviceIsIPad:Bool                                  = false
           var bGlobalDeviceIsIPhone:Bool                                = false
           var bGlobalDeviceIsAppleWatch:Bool                            = false
           var bGlobalDeviceIsXcodeSimulator:Bool                        = false

           var sGlobalDeviceName:String                                  = "-unknown-"
           var sGlobalDeviceSystemName:String                            = "-unknown-"
           var sGlobalDeviceSystemVersion:String                         = "-unknown-"
           var sGlobalDeviceModel:String                                 = "-unknown-"
           var sGlobalDeviceLocalizedModel:String                        = "-unknown-"

       #if os(iOS)

           var idiomGlobalDeviceUserInterfaceIdiom:UIUserInterfaceIdiom? = nil
           var iGlobalDeviceUserInterfaceIdiom:Int                       = 0
           var uuidGlobalDeviceIdForVendor:UUID?                         = nil
           var fGlobalDeviceCurrentBatteryLevel:Float                    = 1.0

       #endif

           var fGlobalDeviceScreenSizeWidth:Float                        = 0.0
           var fGlobalDeviceScreenSizeHeight:Float                       = 0.0
           var iGlobalDeviceScreenSizeScale:Int                          = 0

       #if os(iOS)

           var sGlobalDeviceOrientation:String                           = "unknown"
                                                                           // Values: "unknown", "portrait", "portraitUpsideDown",
                                                                           //         "landscapeLeft", "landscapeRight",
                                                                           //         "faceUp", and "faceDown"...
           var bGlobalDeviceOrientationIsPortrait:Bool                   = false
           var bGlobalDeviceOrientationIsLandscape:Bool                  = false
           var bGlobalDeviceOrientationIsFlat:Bool                       = false
           var bGlobalDeviceOrientationIsInvalid:Bool                    = false

       #endif

    // Various 'app' information:

           var sAppCategory:String                                       = "-unknown-"
           var sAppDisplayName:String                                    = "-unknown-"
           var sAppBundleIdentifier:String                               = "-unknown-"
           var sAppVersionAndBuildNumber:String                          = "-unknown-"
           var sAppCopyright:String                                      = "-unknown-"

    // Various 'app' Internal 'tracing' (selective) flag(s):

           var bEnableAppInternalSelectiveTracing:Bool                   = true
           var iPreXCGLoggerMessageLimit:Int                             = 10000

    // App 'delegate' Visitor:

           var jmAppDelegateVisitor:JmAppDelegateVisitor?                = nil
                                                                           // 'jmAppDelegateVisitor' MUST remain declared this way
                                                                           // as having it reference the 'shared' instance of 
                                                                           // JmAppDelegateVisitor causes a circular reference
                                                                           // between the 'init()' methods of the 2 classes...

    // App <global> Message(s) 'stack' cached before XCGLogger is available:

           var listPreXCGLoggerMessages:[String]                         = [String]()

    // Private 'init()' to make this class a 'singleton':

    private override init()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(AppGlobalInfo.sGlobalInfoAppDisp)'"+sCurrMethod+"':"

        super.init()

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

    #if os(macOS)

        self.sGlobalDeviceType             = "Mac"   // Values: "Mac", "iPad", "iPhone, "AppleWatch"
        self.bGlobalDeviceIsMac            = true
        self.bGlobalDeviceIsIPad           = false
        self.bGlobalDeviceIsIPhone         = false
        self.bGlobalDeviceIsAppleWatch     = false
        self.bGlobalDeviceIsXcodeSimulator = false

        let osVersion:OperatingSystemVersion 
                                           = ProcessInfo.processInfo.operatingSystemVersion 

        self.sGlobalDeviceName             = ProcessInfo.processInfo.hostName
        self.sGlobalDeviceSystemName       = "MacOS v\(osVersion.majorVersion).\(osVersion.minorVersion).\(osVersion.patchVersion)"
        self.sGlobalDeviceSystemVersion    = ProcessInfo.processInfo.operatingSystemVersionString
        self.sGlobalDeviceModel            = "-unknown-"
        self.sGlobalDeviceLocalizedModel   = "-unknown-"

        let ioServiceExpertDevice          = IOServiceGetMatchingService(kIOMainPortDefault, IOServiceMatching("IOPlatformExpertDevice"))
        var sModelIdentifier:String?       = nil

        if let ioModelData:Data = IORegistryEntryCreateCFProperty(ioServiceExpertDevice, ("model" as CFString), kCFAllocatorDefault, 0).takeRetainedValue() as? Data
        {

            if let ioModelIdentifierCString = String(data:ioModelData, encoding:.utf8)?.cString(using:.utf8) 
            {

                sModelIdentifier = String(cString:ioModelIdentifierCString)

            }

        }

        IOObjectRelease(ioServiceExpertDevice)

        self.sGlobalDeviceModel            = sModelIdentifier ?? "-unknown-"
        self.sGlobalDeviceLocalizedModel   = sModelIdentifier ?? "-unknown-"

        if let screenSize = NSScreen.main?.frame as CGRect?
        {

            self.fGlobalDeviceScreenSizeWidth   = Float(screenSize.width)
            self.fGlobalDeviceScreenSizeHeight  = Float(screenSize.height)
            self.iGlobalDeviceScreenSizeScale   = 1

        }

    #elseif os(iOS)

        // Get various 'device' setting(s):
        // (Alternate test: if UIDevice.current.userInterfaceIdiom == .pad { ... } ).

        if UIDevice.current.localizedModel == "Mac" 
        {

            self.sGlobalDeviceType         = "Mac"
            self.bGlobalDeviceIsMac        = true

        } 
        else if UIDevice.current.localizedModel == "iPad" 
        {

            self.sGlobalDeviceType         = "iPad"
            self.bGlobalDeviceIsIPad       = true

        }
        else if UIDevice.current.localizedModel == "iPhone" 
        {

            self.sGlobalDeviceType         = "iPhone"
            self.bGlobalDeviceIsIPhone     = true

        }
        else if UIDevice.current.localizedModel == "AppleWatch" 
        {

            self.sGlobalDeviceType         = "AppleWatch"
            self.bGlobalDeviceIsAppleWatch = true

        }

        self.sGlobalDeviceName                   = UIDevice.current.name
        self.sGlobalDeviceSystemName             = UIDevice.current.systemName
        self.sGlobalDeviceSystemVersion          = UIDevice.current.systemVersion
        self.sGlobalDeviceModel                  = UIDevice.current.model
        self.sGlobalDeviceLocalizedModel         = UIDevice.current.localizedModel

        self.idiomGlobalDeviceUserInterfaceIdiom = UIDevice.current.userInterfaceIdiom
        self.iGlobalDeviceUserInterfaceIdiom     = ((idiomGlobalDeviceUserInterfaceIdiom?.rawValue ?? 0) as Int)
        self.uuidGlobalDeviceIdForVendor         = UIDevice.current.identifierForVendor
        self.fGlobalDeviceCurrentBatteryLevel    = UIDevice.current.batteryLevel

        if let screenSize = UIScreen.main.bounds as CGRect?
        {

            self.fGlobalDeviceScreenSizeWidth    = Float(screenSize.width)
            self.fGlobalDeviceScreenSizeHeight   = Float(screenSize.height)
            self.iGlobalDeviceScreenSizeScale    = Int(UIScreen.main.scale)

        }

    #endif

    #if targetEnvironment(simulator)

        self.self.bGlobalDeviceIsXcodeSimulator = true

    #endif

        self.sAppCategory                  = JmXcodeBuildSettings.jmAppCategory   
        self.sAppDisplayName               = JmXcodeBuildSettings.jmAppDisplayName
        self.sAppBundleIdentifier          = JmXcodeBuildSettings.jmAppBundleIdentifier
        self.sAppVersionAndBuildNumber     = JmXcodeBuildSettings.jmAppVersionAndBuildNumber
        self.sAppCopyright                 = JmXcodeBuildSettings.jmAppCopyright      

        self.updateUIDeviceOrientation()

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of private override init().

    private func xcgLogMsg(_ sMessage:String)
    {

        if (self.jmAppDelegateVisitor != nil)
        {

            if (self.jmAppDelegateVisitor!.bAppDelegateVisitorLogFilespecIsUsable == true)
            {

                self.jmAppDelegateVisitor!.xcgLogMsg(sMessage)

            }
            else
            {

                print("\(sMessage)")

                self.listPreXCGLoggerMessages.append(sMessage)

            }

        }
        else
        {

            print("\(sMessage)")

            self.listPreXCGLoggerMessages.append(sMessage)

        }

        // Exit:

        return

    }   // End of private func xcgLogMsg().

    public func setJmAppDelegateVisitorInstance(jmAppDelegateVisitor:JmAppDelegateVisitor)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(AppGlobalInfo.sGlobalInfoAppDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - supplied parameter 'jmAppDelegateVisitor' is [\(jmAppDelegateVisitor)]...")

        // Set the AppDelegateVisitor instance...

        self.jmAppDelegateVisitor = jmAppDelegateVisitor

        // Spool <any> pre-XDGLogger (via the AppDelegateVisitor) message(s) into the Log...

        if (self.listPreXCGLoggerMessages.count > 0)
        {

            self.xcgLogMsg("")
            self.xcgLogMsg("\(sCurrMethodDisp) <<< === Spooling the JmAppDelegateVisitor.XCGLogger 'pre' Message(s) === >>>")

            let sPreXCGLoggerMessages:String = self.listPreXCGLoggerMessages.joined(separator: "\n")

            self.xcgLogMsg(sPreXCGLoggerMessages)

            self.xcgLogMsg("\(sCurrMethodDisp) <<< === Spooled  the JmAppDelegateVisitor.XCGLogger 'pre' Message(s) === >>>")
            self.xcgLogMsg("")

        }

        // Finish any 'initialization' work:

        self.xcgLogMsg("\(sCurrMethodDisp) AppGlobalInfo Invoking 'self.runPostInitializationTasks()'...")
    
        self.runPostInitializationTasks()

        self.xcgLogMsg("\(sCurrMethodDisp) AppGlobalInfo Invoked  'self.runPostInitializationTasks()'...")
    
        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'self.jmAppDelegateVisitor' is [\(String(describing: self.jmAppDelegateVisitor))]...")
    
        return

    } // End of public func setJmAppDelegateVisitorInstance().

    private func runPostInitializationTasks()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(AppGlobalInfo.sGlobalInfoAppDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'self' is [\(self)]...")

        // Run 'post' Initialization task(s)...

        self.updateUIDeviceOrientation()
        self.displayUIDeviceInformation()

        // If we're flaggedto 'test' String manipulation(s), then do so...

        if (AppGlobalInfo.bTestStringManipulations == true)
        {
        
            let listCharactersToRemove:[StringCleaning] = [
                                                           StringCleaning.removeAll,
                                                           StringCleaning.removeControl,
                                                           StringCleaning.removeDecomposables,
                                                           StringCleaning.removeIllegal,
                                                           StringCleaning.removeNewlines,
                                                           StringCleaning.removeNonBase,
                                                           StringCleaning.removePunctuation,
                                                           StringCleaning.removeSymbols,
                                                           StringCleaning.removeWhitespaces,
                                                           StringCleaning.removeWhitespacesAndNewlines,
                                                          ]

            self.xcgLogMsg("------------------------------------------------------------")
            self.xcgLogMsg("'listCharactersToRemove' is [\(listCharactersToRemove)]...")

            self.xcgLogMsg("------------------------------------------------------------")

            let sTest4:String  = "<LastName>, FirstName MiddleName, Jr. \r\n"
            let sTest5:String  = sTest4.removeUnwantedCharacters(charsetToRemove:listCharactersToRemove, bResultIsLowerCased:false)
            let sTest6:String  = sTest4.removeUnwantedCharacters(charsetToRemove:listCharactersToRemove, bResultIsLowerCased:true)
            let sTest7:String  = sTest4.removeUnwantedCharacters(charsetToRemove:listCharactersToRemove, sJoinCharacters:",", bResultIsLowerCased:true)
            let sTest8:String  = sTest4.removeUnwantedCharacters(charsetToRemove:listCharactersToRemove, sExtraCharacters:"<>amp", bResultIsLowerCased:true)
            let sTest9:String  = sTest4.removeUnwantedCharacters(charsetToRemove:listCharactersToRemove, sExtraCharacters:"<>amp", bResultIsLowerCased:false)
            let sTest10:String = sTest4.removeUnwantedCharacters(charsetToRemove:[StringCleaning.removeAll], bResultIsLowerCased:true)
            let sTest11:String = sTest4.removeUnwantedCharacters(charsetToRemove:[StringCleaning.removeNone], bResultIsLowerCased:false)
            let sTest12:String = sTest4.removeUnwantedCharacters(charsetToRemove:[StringCleaning.removeNone], bResultIsLowerCased:true)

            self.xcgLogMsg("------------------------------------------------------------")
            self.xcgLogMsg("'sTest4'  is [\(sTest4)]...")
            self.xcgLogMsg("'sTest5'  is [\(sTest5)]  -> 'sTest4' cleaned (case-sensitive)...")
            self.xcgLogMsg("'sTest6'  is [\(sTest6)]  -> 'sTest4' cleaned (lowercased)...")
            self.xcgLogMsg("'sTest7'  is [\(sTest7)]  -> 'sTest4' cleaned (lowercased separated by ',')...")
            self.xcgLogMsg("'sTest8'  is [\(sTest8)]  -> 'sTest4' cleaned (lowercased without '<>amp')...")
            self.xcgLogMsg("'sTest9'  is [\(sTest9)]  -> 'sTest4' cleaned (case-sensitive without '<>amp')...")
            self.xcgLogMsg("'sTest10' is [\(sTest10)] -> 'sTest4' cleaned (.removeAll, lowercased)...")
            self.xcgLogMsg("'sTest11' is [\(sTest11)] -> 'sTest4' cleaned (.removeNone, case-sensitive)...")
            self.xcgLogMsg("'sTest12' is [\(sTest12)] -> 'sTest4' cleaned (.removeNone, lowercased)...")
            self.xcgLogMsg("------------------------------------------------------------")
        
        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of private func runPostInitializationTasks().

    // Method(s) to 'update' and 'display' Device setting(s):

    public func updateUIDeviceOrientation()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(AppGlobalInfo.sGlobalInfoAppDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

    #if os(iOS)

        // Update the 'device' orientation:

        self.sGlobalDeviceOrientation            = "unknown"
        self.bGlobalDeviceOrientationIsPortrait  = false
        self.bGlobalDeviceOrientationIsLandscape = false
        self.bGlobalDeviceOrientationIsFlat      = false
        self.bGlobalDeviceOrientationIsInvalid   = false

        switch(UIDevice.current.orientation)
        {
            case UIDeviceOrientation.portrait:
                self.sGlobalDeviceOrientation            = "portrait"
                self.bGlobalDeviceOrientationIsPortrait  = true
            case UIDeviceOrientation.portraitUpsideDown:
                self.sGlobalDeviceOrientation            = "portraitUpsideDown"
                self.bGlobalDeviceOrientationIsPortrait  = true
            case UIDeviceOrientation.landscapeLeft:
                self.sGlobalDeviceOrientation            = "landscapeLeft"
                self.bGlobalDeviceOrientationIsLandscape = true
            case UIDeviceOrientation.landscapeRight:
                self.sGlobalDeviceOrientation            = "landscapeLeft"
                self.bGlobalDeviceOrientationIsLandscape = true
            case UIDeviceOrientation.faceUp:
                self.sGlobalDeviceOrientation            = "faceUp"
                self.bGlobalDeviceOrientationIsFlat      = true
            case UIDeviceOrientation.faceDown:
                self.sGlobalDeviceOrientation            = "faceDown"
                self.bGlobalDeviceOrientationIsFlat      = true
            case UIDeviceOrientation.unknown:
                self.sGlobalDeviceOrientation            = "unknown"
                self.bGlobalDeviceOrientationIsInvalid   = true
            default:
                self.sGlobalDeviceOrientation            = "unknown"
                self.bGlobalDeviceOrientationIsInvalid   = true
        }

    #endif

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of public func updateUIDeviceOrientation().

    public func displayUIDeviceInformation()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(AppGlobalInfo.sGlobalInfoAppDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Display the various AppGlobalInfo 'settings'...

        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.self' is [\(String(describing: self))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sGlobalInfoAppId' is [\(String(describing: AppGlobalInfo.sGlobalInfoAppId))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sGlobalInfoAppVers' is [\(String(describing: AppGlobalInfo.sGlobalInfoAppVers))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sGlobalInfoAppDisp' is [\(String(describing: AppGlobalInfo.sGlobalInfoAppDisp))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sGlobalInfoAppCopyRight' is [\(String(describing: AppGlobalInfo.sGlobalInfoAppCopyRight))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sGlobalInfoAppLogFilespec' is [\(String(describing: AppGlobalInfo.sGlobalInfoAppLogFilespec))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sGlobalInfoAppLastGoodLogFilespec' is [\(String(describing: AppGlobalInfo.sGlobalInfoAppLastGoodLogFilespec))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sGlobalInfoAppLastCrashLogFilespec' is [\(String(describing: AppGlobalInfo.sGlobalInfoAppLastCrashLogFilespec))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sGlobalInfoAppCrashMarkerFilespec' is [\(String(describing: AppGlobalInfo.sGlobalInfoAppCrashMarkerFilespec))]...")
                                                                                                                                                                       
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.bUseApplicationShortTitle' is [\(String(describing: AppGlobalInfo.bUseApplicationShortTitle))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sApplicationTitle' is [\(String(describing: AppGlobalInfo.sApplicationTitle))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sApplicationShortTitle' is [\(String(describing: AppGlobalInfo.sApplicationShortTitle))]...")
                                                                                                                                                                       
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sHelpBasicFileExt' is [\(String(describing: AppGlobalInfo.sHelpBasicFileExt))]...")
                                                                                                                                                                       
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.bInstantiateAppSwiftDataManager' is [\(String(describing: AppGlobalInfo.bInstantiateAppSwiftDataManager))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.bPerformAppObjCSwiftBridgeTest' is [\(String(describing: AppGlobalInfo.bPerformAppObjCSwiftBridgeTest))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.bInstantiateAppMetricKitManager' is [\(String(describing: AppGlobalInfo.bInstantiateAppMetricKitManager))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.bAppMetricKitManagerSendDiagnostics' is [\(String(describing: AppGlobalInfo.bAppMetricKitManagerSendDiagnostics))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.bAppMetricKitManagerSendMetrics' is [\(String(describing: AppGlobalInfo.bAppMetricKitManagerSendMetrics))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.bInstantiateAppUserNotificationsManager' is [\(String(describing: AppGlobalInfo.bInstantiateAppUserNotificationsManager))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.bIssueTestAppUserNotifications' is [\(String(describing: AppGlobalInfo.bIssueTestAppUserNotifications))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.bIssueShortAppUserNotifications' is [\(String(describing: AppGlobalInfo.bIssueShortAppUserNotifications))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.bInstantiateAppParseCoreManager' is [\(String(describing: AppGlobalInfo.bInstantiateAppParseCoreManager))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.bInstantiateAppCoreLocationSupport' is [\(String(describing: AppGlobalInfo.bInstantiateAppCoreLocationSupport))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.bPerformAppCoreLocationTesting' is [\(String(describing: AppGlobalInfo.bPerformAppCoreLocationTesting))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.bInstantiateAppMenuBarStatusBar' is [\(String(describing: AppGlobalInfo.bInstantiateAppMenuBarStatusBar))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.bPerformAppDevTesting' is [\(String(describing: AppGlobalInfo.bPerformAppDevTesting))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.bEnableAppReleaseDownloads' is [\(String(describing: AppGlobalInfo.bEnableAppReleaseDownloads))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.bInstantiateAppNWSWeatherModelObservable' is [\(String(describing: AppGlobalInfo.bInstantiateAppNWSWeatherModelObservable))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.bTestStringManipulations' is [\(String(describing: AppGlobalInfo.bTestStringManipulations))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sAppUploadNotifyFrom' is [\(String(describing: AppGlobalInfo.sAppUploadNotifyFrom))]...")

        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sGlobalDeviceType' is [\(String(describing: self.sGlobalDeviceType))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.bGlobalDeviceIsMac' is [\(String(describing: self.bGlobalDeviceIsMac))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.bGlobalDeviceIsIPad' is [\(String(describing: self.bGlobalDeviceIsIPad))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.bGlobalDeviceIsIPhone' is [\(String(describing: self.bGlobalDeviceIsIPhone))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.bGlobalDeviceIsAppleWatch' is [\(String(describing: self.bGlobalDeviceIsAppleWatch))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.bGlobalDeviceIsXcodeSimulator' is [\(String(describing: self.bGlobalDeviceIsXcodeSimulator))]...")
        
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sGlobalDeviceName' is [\(String(describing: self.sGlobalDeviceName))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sGlobalDeviceSystemName' is [\(String(describing: self.sGlobalDeviceSystemName))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sGlobalDeviceSystemVersion' is [\(String(describing: self.sGlobalDeviceSystemVersion))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sGlobalDeviceModel' is [\(String(describing: self.sGlobalDeviceModel))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sGlobalDeviceLocalizedModel' is [\(String(describing: self.sGlobalDeviceLocalizedModel))]...")
        
    #if os(iOS)

        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.idiomGlobalDeviceUserInterfaceIdiom' is [\(String(describing: self.idiomGlobalDeviceUserInterfaceIdiom))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.iGlobalDeviceUserInterfaceIdiom' is [\(String(describing: self.iGlobalDeviceUserInterfaceIdiom))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.uuidGlobalDeviceIdForVendor' is [\(String(describing: self.uuidGlobalDeviceIdForVendor))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.fGlobalDeviceCurrentBatteryLevel' is [\(String(describing: self.fGlobalDeviceCurrentBatteryLevel))]...")

    #endif
        
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.fGlobalDeviceScreenSizeWidth' is [\(String(describing: self.fGlobalDeviceScreenSizeWidth))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.fGlobalDeviceScreenSizeHeight' is [\(String(describing: self.fGlobalDeviceScreenSizeHeight))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.iGlobalDeviceScreenSizeScale' is [\(String(describing: self.iGlobalDeviceScreenSizeScale))]...")

    #if os(iOS)

        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sGlobalDeviceOrientation' is [\(String(describing: self.sGlobalDeviceOrientation))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.bGlobalDeviceOrientationIsPortrait' is [\(String(describing: self.bGlobalDeviceOrientationIsPortrait))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.bGlobalDeviceOrientationIsLandscape' is [\(String(describing: self.bGlobalDeviceOrientationIsLandscape))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.bGlobalDeviceOrientationIsFlat' is [\(String(describing: self.bGlobalDeviceOrientationIsFlat))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.bGlobalDeviceOrientationIsInvalid' is [\(String(describing: self.bGlobalDeviceOrientationIsInvalid))]...")

    #endif

        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sAppCategory' is [\(String(describing: self.sAppCategory))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sAppDisplayName' is [\(String(describing: self.sAppDisplayName))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sAppBundleIdentifier' is [\(String(describing: self.sAppBundleIdentifier))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sAppVersionAndBuildNumber' is [\(String(describing: self.sAppVersionAndBuildNumber))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.sAppCopyright' is [\(String(describing: self.sAppCopyright))]...")

        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.bEnableAppInternalSelectiveTracing' is [\(String(describing: self.bEnableAppInternalSelectiveTracing))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.iPreXCGLoggerMessageLimit' is [\(String(describing: self.iPreXCGLoggerMessageLimit))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'AppGlobalInfo.listPreXCGLoggerMessages' has (\(self.listPreXCGLoggerMessages.count)) message(s)...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of public func displayUIDeviceInformation().

}   // End of public class AppGlobalInfo(NSObject).

