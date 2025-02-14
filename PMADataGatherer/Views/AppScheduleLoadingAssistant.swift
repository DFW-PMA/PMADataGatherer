//
//  AppScheduleLoadingAssistant.swift
//  PMADataGatherer
//
//  Created by JustMacApps.net on 02/14/2025.
//  Copyright © 2023-2025 JustMacApps. All rights reserved.
//

import Foundation
import SwiftUI

//public class AppScheduleLoadingAssistant: NSObject, ObservableObject
public class AppScheduleLoadingAssistant: NSObject
{
    
    struct ClassInfo
    {
        
        static let sClsId          = "AppScheduleLoadingAssistant"
        static let sClsVers        = "v1.0108"
        static let sClsDisp        = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight   = "Copyright (C) JustMacApps 2023-2025. All Rights Reserved."
        static let bClsTrace       = true
        static let bClsFileLog     = true
        
    }

    struct ClassSingleton
    {
        static 
        var appScheduleLoadingAssistant:AppScheduleLoadingAssistant           = AppScheduleLoadingAssistant()
    }

    // App Data field(s):

//  @Published      var bScheduledPatientLocationItemsAreAvaiable:Bool        = false
                    var bScheduledPatientLocationItemsAreAvaiable:Bool        = false
//  {
//      didSet
//      {
//          objectWillChange.send()
//      }
//  }

//  @Published      var sScheduledPatientLocationItemsTID:String              = ""
                    var sScheduledPatientLocationItemsTID:String              = ""
//  {
//      didSet
//      {
//          objectWillChange.send()
//      }
//  }

//  @Published      var listScheduledPatientLocationItems:[ScheduledPatientLocationItem]
                    var listScheduledPatientLocationItems:[ScheduledPatientLocationItem]
                                                                              = [ScheduledPatientLocationItem]()
//  {
//      didSet
//      {
//          objectWillChange.send()
//      }
//  }

                    var jmAppDelegateVisitor:JmAppDelegateVisitor             = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    @ObservedObject var jmAppParseCoreManager:JmAppParseCoreManager           = JmAppParseCoreManager.ClassSingleton.appParseCodeManager
                    var jmAppParseCoreBkgdDataRepo:JmAppParseCoreBkgdDataRepo = JmAppParseCoreBkgdDataRepo.ClassSingleton.appParseCodeBkgdDataRepo

    private override init()
    {

    //  let sCurrMethod:String = #function
    //  let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        super.init()

    //  self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Exit...

    //  self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of private override init().

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

    public func toString()->String
    {

        var asToString:[String] = Array()

        asToString.append("[")
        asToString.append("[")
        asToString.append("'sClsId': [\(ClassInfo.sClsId)],")
        asToString.append("'sClsVers': [\(ClassInfo.sClsVers)],")
        asToString.append("'sClsDisp': [\(ClassInfo.sClsDisp)],")
        asToString.append("'sClsCopyRight': [\(ClassInfo.sClsCopyRight)],")
        asToString.append("'bClsTrace': [\(ClassInfo.bClsTrace)],")
        asToString.append("'bClsFileLog': [\(ClassInfo.bClsFileLog)],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'bScheduledPatientLocationItemsAreAvaiable': [\(String(describing: self.bScheduledPatientLocationItemsAreAvaiable))],")
        asToString.append("'sScheduledPatientLocationItemsTID': [\(String(describing: self.sScheduledPatientLocationItemsTID))],")
        asToString.append("'listScheduledPatientLocationItems': [\(String(describing: self.listScheduledPatientLocationItems))],")
        asToString.append("],")
        asToString.append("]")

        let sContents:String = "{"+(asToString.joined(separator: ""))+"}"

        return sContents

    }   // End of public func toString().

    public func clearScheduledPatientLocationItems()
    {
  
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Clear the ScheduledPatientLocationItems field(s)...

        self.bScheduledPatientLocationItemsAreAvaiable = false
        self.sScheduledPatientLocationItemsTID         = ""
        self.listScheduledPatientLocationItems         = [ScheduledPatientLocationItem]()
        
        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'self.bScheduledPatientLocationItemsAreAvaiable' is [\(self.bScheduledPatientLocationItemsAreAvaiable)] - 'self.sScheduledPatientLocationItemsTID' is [\(self.sScheduledPatientLocationItemsTID)] - 'self.listScheduledPatientLocationItems' has #(\(self.listScheduledPatientLocationItems.count)) item(s)...")
  
        return
  
    }   // End of public func clearScheduledPatientLocationItems().

    func getScheduledPatientLocationItemsForTid(sPFTherapistTID:String = "")->[ScheduledPatientLocationItem]
    {
  
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'sPFTherapistTID' is [\(sPFTherapistTID)]...")

        // If we have ScheduledPatientLocation item(s) and the TIDs match, then just return...

        if (self.listScheduledPatientLocationItems.count  > 0 &&
            self.sScheduledPatientLocationItemsTID       == sPFTherapistTID)
        {
        
            self.bScheduledPatientLocationItemsAreAvaiable = true

            // Exit...

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'self.bScheduledPatientLocationItemsAreAvaiable' is [\(self.bScheduledPatientLocationItemsAreAvaiable)] - 'self.sScheduledPatientLocationItemsTID' is [\(self.sScheduledPatientLocationItemsTID)] - 'self.listScheduledPatientLocationItems' has #(\(self.listScheduledPatientLocationItems.count)) item(s)...")

            return self.listScheduledPatientLocationItems

        }

        // Use the TherapistName in the PFCscDataItem to lookup any ScheduledPatientLocationItem(s)...

        self.sScheduledPatientLocationItemsTID = ""
        self.listScheduledPatientLocationItems = [ScheduledPatientLocationItem]()

        if (sPFTherapistTID.count > 0)
        {

            if (self.jmAppParseCoreManager.dictSchedPatientLocItems.count > 0)
            {

                self.listScheduledPatientLocationItems = self.jmAppParseCoreManager.dictSchedPatientLocItems[sPFTherapistTID] ?? []

            }

        }

        if (self.listScheduledPatientLocationItems.count > 0)
        {
        
            self.sScheduledPatientLocationItemsTID         = sPFTherapistTID
            self.bScheduledPatientLocationItemsAreAvaiable = true
        
        }
        else
        {
        
            self.sScheduledPatientLocationItemsTID         = ""
            self.bScheduledPatientLocationItemsAreAvaiable = false
        
        }
        
        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'self.bScheduledPatientLocationItemsAreAvaiable' is [\(self.bScheduledPatientLocationItemsAreAvaiable)] - 'self.sScheduledPatientLocationItemsTID' is [\(self.sScheduledPatientLocationItemsTID)] - 'self.listScheduledPatientLocationItems' has #(\(self.listScheduledPatientLocationItems.count)) item(s)...")
  
        return self.listScheduledPatientLocationItems
  
    }   // End of func getScheduledPatientLocationItemsForTid(sPFTherapistTID:String = "")->[ScheduledPatientLocationItem].

}   // End of public class AppScheduleLoadingAssistant.

