//
//  JmAppParseCoreManager.swift
//  JmUtils_Library
//
//  Created by Daryl Cox on 11/04/2024.
//  Copyright © JustMacApps 2023-2025. All rights reserved.
//

import Foundation
import ParseCore
import SwiftData

// Implementation class to handle access to the ParseCore framework.

//@MainActor
public class JmAppParseCoreManager: NSObject, ObservableObject
{

    struct ClassInfo
    {

        static let sClsId        = "JmAppParseCoreManager"
        static let sClsVers      = "v1.3001"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2025. All Rights Reserved."
        static let bClsTrace     = false
        static let bClsFileLog   = false

    }   // End of struct ClassInfo.

    // Class 'singleton' instance:

    struct ClassSingleton
    {

        static var appParseCodeManager:JmAppParseCoreManager                             = JmAppParseCoreManager()

    }

    // App Data field(s):

                    let timerPublisherTherapistLocations                                 = Timer.publish(every: (3 * 60), on: .main, in: .common).autoconnect()
                                                                                           // TIMER to update Therapist location(s):
                                                                                           // Note: implement .onReceive() on a field within the displaying 'View'...
                                                                                           // 
                                                                                           // @ObservedObject var jmAppParseCoreManager:JmAppParseCoreManager
                                                                                           // ...
                                                                                           // .onReceive(jmAppParseCoreManager.timerPublisherTherapistLocations,
                                                                                           //     perform:
                                                                                           //     { dtObserved in
                                                                                           //         ...
                                                                                           //     })

                    let timerPublisherScheduleLocations                                  = Timer.publish(every: (25 * 60), on: .main, in: .common).autoconnect()
                                                                                           // TIMER to update (Patient) Schedule(d) location(s):
                                                                                           // Note: implement .onReceive() on a field within the displaying 'View'...
                                                                                           // 
                                                                                           // @ObservedObject var jmAppParseCoreManager:JmAppParseCoreManager
                                                                                           // ...
                                                                                           // .onReceive(jmAppParseCoreManager.timerPublisherScheduleLocations,
                                                                                           //     perform:
                                                                                           //     { dtObserved in
                                                                                           //         ...
                                                                                           //     })

    @Published      var cPFCscObjectsRefresh:Int                                         = 0
    {
        didSet
        {
            objectWillChange.send()
        }
    }
    @Published      var cPFCscObjects:Int                                                = 0
                    var listPFCscNameItems:[String]                                      = [String]()
    @Published      var listPFCscDataItems:[ParsePFCscDataItem]                          = [ParsePFCscDataItem]()
    {
        didSet
        {
            objectWillChange.send()
        }
    }
                                                                                           // Key:PFAdminsParseTID(String)
    @Published      var dictPFAdminsDataItems:[String:ParsePFAdminsDataItem]             = [String:ParsePFAdminsDataItem]()
    {
        didSet
        {
            objectWillChange.send()
        }
    }

                                                                                           // [String:String]
                                                                                           // Key:Tid(String)                       -> TherapistName (String)
                                                                                           // Key:TherapistName(String)             -> Tid (String)
                                                                                           // Key:TherapistName(String)<lowercased> -> Tid (String)
    @Published      var dictTherapistTidXref:[String:String]                             = [String:String]()
    {
        didSet
        {
            objectWillChange.send()
        }
    }

                                                                                           // [String:[ScheduledPatientLocationItem]]
                                                                                           // Key:sPFTherapistParseTID(String)
    @Published      var dictSchedPatientLocItems:[String:[ScheduledPatientLocationItem]] = [String:[ScheduledPatientLocationItem]]()
    {
        didSet
        {
            objectWillChange.send()
        }
    }

       private      var bHasDictSchedPatientLocItemsBeenDisplayed:Bool                   = false

                                                                                           // [Int:ParsePFTherapistFileItem]
                                                                                           // Key:Tid(Int) -> TherapistID (Int)
    @Published      var dictPFTherapistFileItems:[Int:ParsePFTherapistFileItem]          = [Int:ParsePFTherapistFileItem]()
    {
        didSet
        {
            objectWillChange.send()
        }
    }

       private      var bHasDictTherapistFileItemsBeenDisplayed:Bool                     = false

                    var jmAppDelegateVisitor:JmAppDelegateVisitor?                       = nil
                                                                                           // 'jmAppDelegateVisitor' MUST remain declared this way
                                                                                           // as having it reference the 'shared' instance of 
                                                                                           // JmAppDelegateVisitor causes a circular reference
                                                                                           // between the 'init()' methods of the 2 classes...
    @ObservedObject var jmAppSwiftDataManager:JmAppSwiftDataManager                      = JmAppSwiftDataManager.ClassSingleton.appSwiftDataManager

    // App <global> Message(s) 'stack' cached before XCGLogger is available:

                    var  listPreXCGLoggerMessages:[String]                               = [String]()

    // ------------------------------------------------------------------------------------------------------
    //
    //  Item(s) that would need separate 'tracking' instance from a background thread to the 'main':
    //
    //      self.dictPFAdminsDataItems[]                 -> Admin(s) that can 'log-in'...
    //      self.dictPFTherapistFileItems[]              -> All 'known' Therapist(s)...
    //      self.dictSchedPatientLocItems[]              -> Patient Schedule for the day by Therapist(s)...
    //      self.dictTherapistTidXref[]                  -> Therapist TID/TName cross-reference dictionary...
    //      - - - - -
    //      self.listPFCscDataItems:[ParsePFCscDataItem] -> All 'known' WorkRoute People...
    //      self.listPFCscNameItems:[String]             -> All 'known' WorkRoute People 'name(s)'...
    //
    // ------------------------------------------------------------------------------------------------------

    private override init()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        super.init()

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
        
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

    public func toString() -> String
    {

        var asToString:[String] = Array()

        asToString.append("[")
        asToString.append("[")
        asToString.append("'sClsId': [\(ClassInfo.sClsId)],")
        asToString.append("'sClsVers': [\(ClassInfo.sClsVers)],")
        asToString.append("'sClsDisp': [\(ClassInfo.sClsDisp)],")
        asToString.append("'sClsCopyRight': [\(ClassInfo.sClsCopyRight)],")
        asToString.append("'bClsTrace': [\(ClassInfo.bClsTrace)],")
        asToString.append("'bClsFileLog': [\(ClassInfo.bClsFileLog)]")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'cPFCscObjectsRefresh': (\(String(describing: self.cPFCscObjectsRefresh)))")
        asToString.append("'cPFCscObjects': (\(String(describing: self.cPFCscObjects)))")
        asToString.append("'listPFCscDataItems': [\(String(describing: self.listPFCscDataItems))]")
        asToString.append("'listPFCscNameItems': [\(String(describing: self.listPFCscNameItems))]")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'dictPFAdminsDataItems': [\(String(describing: self.dictPFAdminsDataItems))]")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'dictSchedPatientLocItems': [\(String(describing: self.dictSchedPatientLocItems))]")
        asToString.append("'bHasDictSchedPatientLocItemsBeenDisplayed': [\(String(describing: self.bHasDictSchedPatientLocItemsBeenDisplayed))]")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'dictPFTherapistFileItems': [\(String(describing: self.dictPFTherapistFileItems))]")
        asToString.append("'bHasDictTherapistFileItemsBeenDisplayed': [\(String(describing: self.bHasDictTherapistFileItemsBeenDisplayed))]")
        asToString.append("],")
        asToString.append("]")

        let sContents:String = "{"+(asToString.joined(separator: ""))+"}"

        return sContents

    }   // End of public func toString().

    // (Call-back) Method to set the jmAppDelegateVisitor instance...

    public func setJmAppDelegateVisitorInstance(jmAppDelegateVisitor:JmAppDelegateVisitor)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - supplied parameter 'jmAppDelegateVisitor' is [\(jmAppDelegateVisitor)]...")

        // Set the AppDelegateVisitor instance...

        self.jmAppDelegateVisitor = jmAppDelegateVisitor
    
        // Spool <any> pre-XDGLogger (via the AppDelegateVisitor) message(s) into the Log...

        if (self.listPreXCGLoggerMessages.count > 0)
        {

            self.xcgLogMsg("")
            self.xcgLogMsg("\(sCurrMethodDisp) <<< === Spooling the JmAppDelegateVisitor.XCGLogger 'pre' Message(s) from JmAppParseCoreManager === >>>")

            let sPreXCGLoggerMessages:String = self.listPreXCGLoggerMessages.joined(separator: "\n")

            self.xcgLogMsg(sPreXCGLoggerMessages)

            self.xcgLogMsg("\(sCurrMethodDisp) <<< === Spooled  the JmAppDelegateVisitor.XCGLogger 'pre' Message(s) from JmAppParseCoreManager === >>>")
            self.xcgLogMsg("")

        }

        // Finish any 'initialization' work:

        self.xcgLogMsg("\(sCurrMethodDisp) ParseCoreManager Invoking 'self.runPostInitializationTasks()'...")
    
        self.runPostInitializationTasks()

        self.xcgLogMsg("\(sCurrMethodDisp) ParseCoreManager Invoked  'self.runPostInitializationTasks()'...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'self.jmAppDelegateVisitor' is [\(String(describing: self.jmAppDelegateVisitor))]...")
    
        return

    } // End of public func setJmAppDelegateVisitorInstance().

    private func runPostInitializationTasks()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'self' is [\(self)]...")

        // Finish performing any setup with the ParseCore (Client) framework...

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of private func runPostInitializationTasks().

    public func convertTidToTherapistName(sPFTherapistParseTID:String = "")->String
    {
  
        let sCurrMethod:String = #function;
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
  
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'sPFTherapistParseTID' is [\(sPFTherapistParseTID)]...")
  
        // Lookup and convert the 'sPFTherapistParseTID' to 'sPFTherapistParseName'...
  
        var sPFTherapistParseName:String = ""
  
        if (sPFTherapistParseTID.count      > 0 &&
            self.dictTherapistTidXref.count > 0)
        {
        
            if (self.dictTherapistTidXref[sPFTherapistParseTID] != nil)
            {
  
                sPFTherapistParseName = self.dictTherapistTidXref[sPFTherapistParseTID] ?? ""
  
            }
        
        }
        
        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'sPFTherapistParseName' is [\(sPFTherapistParseName)]...")
  
        return sPFTherapistParseName
  
    } // End of public func convertTidToTherapistName(sPFTherapistParseTID:String)->String.
    
    public func convertTherapistNameToTid(sPFTherapistParseName:String = "")->String
    {
  
        let sCurrMethod:String = #function;
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
  
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'sPFTherapistParseName' is [\(sPFTherapistParseName)]...")
  
        // Lookup and convert the 'sPFTherapistParseName' to 'sPFTherapistParseTID'...
  
        var sPFTherapistParseTID:String = ""
  
        if (sPFTherapistParseName.count     > 0 &&
            self.dictTherapistTidXref.count > 0)
        {
  
            let sPFTherapistParseNameLower:String = sPFTherapistParseName.lowercased()
        
            if (self.dictTherapistTidXref[sPFTherapistParseNameLower] != nil)
            {
  
                sPFTherapistParseTID = self.dictTherapistTidXref[sPFTherapistParseNameLower] ?? ""
  
            }
        
        }
        
        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'sPFTherapistParseTID' is [\(sPFTherapistParseTID)]...")
  
        return sPFTherapistParseTID
  
    } // End of public func convertTherapistNameToTid(sPFTherapistParseName:String)->String.
    
    func locatePFCscDataItemByID(id:UUID)->ParsePFCscDataItem
    {
  
        let sCurrMethod:String = #function;
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
  
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'id' is [\(id)]...")
  
        // Locate a given PFCscDataItem given an 'id' (aka, UUID)...
  
        var pfCscDataItem:ParsePFCscDataItem = ParsePFCscDataItem()
  
        if (self.listPFCscDataItems.count > 1)
        {
        
            for currentPFCscDataItem:ParsePFCscDataItem in self.listPFCscDataItems
            {
  
                if (currentPFCscDataItem.id == id)
                {
                
                    pfCscDataItem = currentPFCscDataItem
                    
                    break
                
                }
  
            }
        
        }
        
        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'pfCscDataItem' is [\(pfCscDataItem)]...")
  
        return pfCscDataItem
  
    } // End of func locatePFCscDataItemByID(id:UUID)->ParsePFCscDataItem.
    
    public func displayDictPFAdminsDataItems()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Display the dictionary of 'dictPFAdminsDataItems'...

        if (self.dictPFAdminsDataItems.count > 0)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Displaying the dictionary of 'parsePFAdminsDataItem' item(s)...")

            for (_, parsePFAdminsDataItem) in self.dictPFAdminsDataItems
            {

                parsePFAdminsDataItem.displayParsePFAdminsDataItemToLog()

            }

        }
        else
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Unable to display the dictionary of 'parsePFAdminsDataItem' item(s) - item(s) count is less than 1 - Warning!")

        }
        
        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return

    } // End of func displayDictPFAdminsDataItems().
    
    public func displayDictPFTherapistFileItems()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Display the dictionary of 'dictPFTherapistFileItems'...

        if (self.dictPFTherapistFileItems.count > 0)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Displaying the dictionary of #(\(self.dictPFTherapistFileItems.count)) 'dictPFTherapistFileItems' item(s)...")

            var cPFTherapistParseTIDs:Int = 0

            for (iPFTherapistParseTID, pfTherapistFileItem) in self.dictPFTherapistFileItems
            {

                cPFTherapistParseTIDs += 1

                if (iPFTherapistParseTID < 0)
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cPFTherapistParseTIDs)) 'iPFTherapistParseTID' - the 'tid' field is less than 0 - Warning!")

                    continue

                }

                self.xcgLogMsg("\(sCurrMethodDisp) For TID [\(iPFTherapistParseTID)] - Displaying 'pfTherapistFileItem' item #(\(cPFTherapistParseTIDs)):")

                pfTherapistFileItem.displayParsePFTherapistFileItemToLog()

            }

        }
        else
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Unable to display the dictionary of 'dictPFTherapistFileItems' item(s) - item(s) count is less than 1 - Warning!")

        }
        
        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return

    } // End of func displayDictPFTherapistFileItems().
    
    public func displayDictSchedPatientLocItems()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Display the dictionary of 'dictSchedPatientLocItems'...

        if (self.dictSchedPatientLocItems.count > 0)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Displaying the dictionary of #(\(self.dictSchedPatientLocItems.count)) 'dictSchedPatientLocItems' item(s)...")

            let cPFTherapistTotalTIDs:Int = self.dictSchedPatientLocItems.count
            var cPFTherapistParseTIDs:Int = 0

            for (sPFTherapistParseTID, listScheduledPatientLocationItems) in self.dictSchedPatientLocItems
            {

                cPFTherapistParseTIDs += 1

                if (sPFTherapistParseTID.count  < 1 ||
                    sPFTherapistParseTID       == "-N/A-")
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cPFTherapistParseTIDs)) 'sPFTherapistParseTID' - the 'tid' field is nil or '-N/A-' - Warning!")

                    continue

                }

                if (listScheduledPatientLocationItems.count < 1)
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cPFTherapistParseTIDs)) 'sPFTherapistParseTID' of [\(sPFTherapistParseTID)] - the 'listScheduledPatientLocationItems' field is nil or the count is less than 1 - Warning!")

                    continue

                }

                var cScheduledPatientLocationItems:Int = 0

                for scheduledPatientLocationItem in listScheduledPatientLocationItems
                {

                    cScheduledPatientLocationItems += 1

                    self.xcgLogMsg("\(sCurrMethodDisp) Of #(\(cPFTherapistTotalTIDs)) TIDs - For TID [\(sPFTherapistParseTID)] - Displaying 'scheduledPatientLocationItem' item #(\(cPFTherapistParseTIDs).\(cScheduledPatientLocationItems)):")

                    scheduledPatientLocationItem.displayScheduledPatientLocationItemToLog()

                }

            }

        }
        else
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Unable to display the dictionary of 'dictSchedPatientLocItems' item(s) - item(s) count is less than 1 - Warning!")

        }
        
        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return

    } // End of func displayDictSchedPatientLocItems().
    
    public func displayListPFCscDataItems()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Display the ...

        if (self.listPFCscDataItems.count > 0)
        {
        
            self.xcgLogMsg("\(sCurrMethodDisp) Displaying the list of 'parsePFCscDataItem' item(s)...")

            var cDictPFCscDataItems:Int = 0

            for parsePFCscDataItem in self.listPFCscDataItems
            {

                cDictPFCscDataItems += 1

                parsePFCscDataItem.displayParsePFCscDataItemToLog(cDisplayItem:cDictPFCscDataItems)

            }
        
        }
        else
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Unable to display the list of 'listPFCscDataItems' item(s) - item(s) count is less than 1 - Warning!")

        }
        
        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return

    } // End of func displayListPFCscDataItems().
    
    public func displayDictTherapistTidXfef()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Display the dictionary 'self.dictTherapistTidXref'...

        if (self.dictTherapistTidXref.count > 0)
        {
        
            self.xcgLogMsg("\(sCurrMethodDisp) Displaying the dictionary of 'dictTherapistTidXref' item(s)...")

            var cTherapistTidXrefItems:Int = 0

            for (sPFTherapistXrefKey, sPFTherapistXrefItem) in self.dictTherapistTidXref
            {

                cTherapistTidXrefItems += 1

                self.xcgLogMsg("\(sCurrMethodDisp) #(\(cTherapistTidXrefItems)): 'sPFTherapistXrefKey' is [\(sPFTherapistXrefKey)] - 'sPFTherapistXrefItem' is [\(sPFTherapistXrefItem)]...")

            }
        
        }
        else
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Unable to display the dictionary of 'dictTherapistTidXref' item(s) - item(s) count is less than 1 - Warning!")

        }
        
        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return

    } // End of func displayDictTherapistTidXfef().
    
}   // End of public class JmAppParseCoreManager.

