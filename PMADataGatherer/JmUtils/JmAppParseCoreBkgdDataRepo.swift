//
//  JmAppParseCoreBkgdDataRepo.swift
//  JmUtils_Library
//
//  Created by Daryl Cox on 01/16/2025.
//  Copyright © JustMacApps 2023-2025. All rights reserved.
//

import Foundation
import SwiftData
import ParseCore

// Implementation class to handle access to the ParseCore 'background' Data (repo).

//@MainActor
public class JmAppParseCoreBkgdDataRepo: NSObject
{

    struct ClassInfo
    {

        static let sClsId        = "JmAppParseCoreBkgdDataRepo"
        static let sClsVers      = "v1.0605"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2025. All Rights Reserved."
        static let bClsTrace     = false
        static let bClsFileLog   = false

    }   // End of struct ClassInfo.

    // Class 'singleton' instance:

    struct ClassSingleton
    {

        static var appParseCodeBkgdDataRepo:JmAppParseCoreBkgdDataRepo = JmAppParseCoreBkgdDataRepo()

    }

    // App Data field(s):

    var parseConfig:ParseClientConfiguration?                                = nil       

    var dictPFAdminsDataItems:[String:ParsePFAdminsDataItem]                 = [String:ParsePFAdminsDataItem]()
                                                                               // [String:ParsePFAdminsDataItem]
                                                                               // Key:PFAdminsParseTID(String)

    var bHasDictTherapistFileItemsBeenDisplayed:Bool                         = false
    var dictPFTherapistFileItems:[Int:ParsePFTherapistFileItem]              = [Int:ParsePFTherapistFileItem]()
                                                                               // [Int:ParsePFTherapistFileItem]
                                                                               // Key:Tid(Int) -> TherapistID (Int)

    var dictTherapistTidXref:[String:String]                                 = [String:String]()
                                                                               // [String:String]
                                                                               // Key:Tid(String)                       -> TherapistName (String)
                                                                               // Key:TherapistName(String)             -> Tid (String)
                                                                               // Key:TherapistName(String)<lowercased> -> Tid (String)

    var bNeedFirstPassSchedPatientLocations:Bool                             = true
    var bHasDictSchedPatientLocItemsBeenDisplayed:Bool                       = false
    var dictSchedPatientLocItems:[String:[ScheduledPatientLocationItem]]     = [String:[ScheduledPatientLocationItem]]()
                                                                               // [String:[ScheduledPatientLocationItem]]
                                                                               // Key:sPFTherapistParseTID(String)

    var listPFCscDataItems:[ParsePFCscDataItem]                              = [ParsePFCscDataItem]()
    var listPFCscNameItems:[String]                                          = [String]()

    var jmAppDelegateVisitor:JmAppDelegateVisitor?                           = nil
                                                                               // 'jmAppDelegateVisitor' MUST remain declared this way
                                                                               // as having it reference the 'shared' instance of 
                                                                               // JmAppDelegateVisitor causes a circular reference
                                                                               // between the 'init()' methods of the 2 classes...
    var jmAppSwiftDataManager:JmAppSwiftDataManager                          = JmAppSwiftDataManager.ClassSingleton.appSwiftDataManager
    var jmAppParseCoreManager:JmAppParseCoreManager                          = JmAppParseCoreManager.ClassSingleton.appParseCodeManager

    // App <global> Message(s) 'stack' cached before XCGLogger is available:

    var  listPreXCGLoggerMessages:[String]                                   = [String]()

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
        asToString.append("'parseConfig': [\(String(describing: self.parseConfig))]")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'dictPFAdminsDataItems': [\(String(describing: self.dictPFAdminsDataItems))]")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'bHasDictTherapistFileItemsBeenDisplayed': [\(String(describing: self.bHasDictTherapistFileItemsBeenDisplayed))]")
        asToString.append("'dictPFTherapistFileItems': [\(String(describing: self.dictPFTherapistFileItems))]")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'bNeedFirstPassSchedPatientLocations': [\(String(describing: self.bNeedFirstPassSchedPatientLocations))]")
        asToString.append("'bHasDictSchedPatientLocItemsBeenDisplayed': [\(String(describing: self.bHasDictSchedPatientLocItemsBeenDisplayed))]")
        asToString.append("'dictSchedPatientLocItems': [\(String(describing: self.dictSchedPatientLocItems))]")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'listPFCscDataItems': [\(String(describing: self.listPFCscDataItems))] <WorkRoute items>")
        asToString.append("'listPFCscNameItems': [\(String(describing: self.listPFCscNameItems))] <WorkRoute names>")
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
            self.xcgLogMsg("\(sCurrMethodDisp) <<< === Spooling the JmAppDelegateVisitor.XCGLogger 'pre' Message(s) from JmAppParseCoreBkgdDataRepo === >>>")

            let sPreXCGLoggerMessages:String = self.listPreXCGLoggerMessages.joined(separator: "\n")

            self.xcgLogMsg(sPreXCGLoggerMessages)

            self.xcgLogMsg("\(sCurrMethodDisp) <<< === Spooled  the JmAppDelegateVisitor.XCGLogger 'pre' Message(s) from JmAppParseCoreBkgdDataRepo === >>>")
            self.xcgLogMsg("")

        }

        // Finish any 'initialization' work:

        self.xcgLogMsg("\(sCurrMethodDisp) ParseCoreBkgdDataRepo Invoking 'self.runPostInitializationTasks()'...")
    
        self.runPostInitializationTasks()

        self.xcgLogMsg("\(sCurrMethodDisp) ParseCoreBkgdDataRepo Invoked  'self.runPostInitializationTasks()'...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'self.jmAppDelegateVisitor' is [\(String(describing: self.jmAppDelegateVisitor))]...")
    
        return

    } // End of public func setJmAppDelegateVisitorInstance().

    private func runPostInitializationTasks()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'self' is [\(self)]...")

        // Finish performing any setup with the ParseCore 'background' Data repo...
        // --------------------------------------------------------------------------------------------------
        // ParseCore doc: -> https://docs.parseplatform.org/ios/guide/
        //
        //     let parseConfig = ParseClientConfiguration {
        //                                                 $0.applicationId = "parseAppId"
        //                                                 $0.clientKey     = "parseClientKey"
        //                                                 $0.server        = "parseServerUrlString"
        //                                                }
        //     Parse.initialize(with: parseConfig)
        // --------------------------------------------------------------------------------------------------

        self.xcgLogMsg("\(sCurrMethodDisp) Creating the ParseCore (Client) 'configuration'...")

        self.parseConfig = ParseClientConfiguration
                               {
                                   $0.applicationId = "VDN7Gs0vvYMg5yokvC4I7Nh521hbm9NF2jluCgW3"
                                   $0.clientKey     = "txwqvA4yxFiShXAiVyY3tMNG00vKpiW6UmdugVnI"
                                   $0.server        = "https://pg-app-1ye5iesplk164f4dsvq8gtaddgv1xc.scalabl.cloud/1/"
                               }

        self.xcgLogMsg("\(sCurrMethodDisp) Passing the ParseCore (Client) 'configuration' on to ParseCore...")

        Parse.initialize(with:self.parseConfig!)

        self.xcgLogMsg("\(sCurrMethodDisp) Passed  the ParseCore (Client) 'configuration' on to ParseCore...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of private func runPostInitializationTasks().

    public func getJmAppParsePFQueryForAdmins()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // If we already have a dictionary of PFAdmins item(s), then display them and skip the PFQuery...

        if (self.dictPFAdminsDataItems.count > 0)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) The (existing) dictionary of 'parsePFAdminsDataItem' item(s) has #(\(self.dictPFAdminsDataItems.count)) object(s) - skipping the PFQuery...")
            self.xcgLogMsg("\(sCurrMethodDisp) Displaying the (existing) dictionary of 'parsePFAdminsDataItem' item(s)...")

            for (_, parsePFAdminsDataItem) in self.dictPFAdminsDataItems
            {

                parsePFAdminsDataItem.displayParsePFAdminsDataItemToLog()

            }

        //  self.xcgLogMsg("\(sCurrMethodDisp) Copying the item(s) from the dictionary of 'parsePFAdminsDataItem' to SwiftData...")
        //
        //  self.copyJmAppParsePFAdminsToSwiftData()

            // ----------------------------------------------------------------------------------------------
            // var dictPFAdminsDataItems:[String:ParsePFAdminsDataItem] = [:]
            //                                                            // [String:ParsePFAdminsDataItem]
            //                                                            // Key:PFAdminsParseTID(String)
            // ----------------------------------------------------------------------------------------------
          
            // If we have a different # of item(s) then the ParseCoreManager does, then deep copy and update it...
          
            if (self.jmAppParseCoreManager.dictPFAdminsDataItems.count  < 1 ||
                self.jmAppParseCoreManager.dictPFAdminsDataItems.count != self.dictPFAdminsDataItems.count)
            {

                let _ = self.deepCopyDictPFAdminsDataItems()
            
        //      self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy'ing the dictionary 'dictPFAdminsDataItems' of (\(self.dictPFAdminsDataItems.count)) 'parsePFAdminsDataItem' item(s)...")
        //
        //      var cDeepCopyPFAdminsDataItems:Int                               = 0 
        //      var dictDeepCopyPFAdminsDataItems:[String:ParsePFAdminsDataItem] = [String:ParsePFAdminsDataItem]()
        //
        //      for (_, parsePFAdminsDataItem) in self.dictPFAdminsDataItems
        //      {
        //
        //          cDeepCopyPFAdminsDataItems                    += 1
        //          let newPFAdminsDataItem:ParsePFAdminsDataItem  = ParsePFAdminsDataItem(pfAdminsDataItem:parsePFAdminsDataItem)
        //
        //          let sPFAdminsParseTID:String = parsePFAdminsDataItem.sPFAdminsParseTID
        //
        //          if (sPFAdminsParseTID.count  < 1 ||
        //              sPFAdminsParseTID       == "-N/A-")
        //          {
        //
        //              self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' Skipping object #(\(cDeepCopyPFAdminsDataItems)) 'parsePFAdminsDataItem' - the 'tid' field is nil or '-N/A-' - Warning!")
        //
        //              continue
        //
        //          }
        //
        //          dictDeepCopyPFAdminsDataItems[sPFAdminsParseTID] = newPFAdminsDataItem
        //
        //          self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' Added object #(\(cDeepCopyPFAdminsDataItems)) 'newPFAdminsDataItem' keyed by 'sPFAdminsParseTID' of [\(sPFAdminsParseTID)] to the 'deep copy' dictionary of item(s)...")
        //
        //      }
        //
        //      if (dictDeepCopyPFAdminsDataItems.count > 0)
        //      {
        //      
        //          DispatchQueue.main.async
        //          {
        //
        //              self.jmAppParseCoreManager.dictPFAdminsDataItems = dictDeepCopyPFAdminsDataItems
        //
        //              self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' replaced #(\(dictDeepCopyPFAdminsDataItems.count)) item(s) in the ParseCoreManager 'dictPFAdminsDataItems'...")
        //
        //          }
        //      
        //      }
            
            }

            // Exit:

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

            return

        }

        // Issue a PFQuery for the 'Admins' class...

        self.xcgLogMsg("\(sCurrMethodDisp) Calling PFQuery to construct an instance for the 'Admins' class...")

        let pfQueryAdmins:PFQuery = PFQuery(className:"Admins")

        self.xcgLogMsg("\(sCurrMethodDisp) Called  PFQuery to construct an instance for the 'Admins' class...")

        // Set the query parameter(s) and issue the 'find' then (possibly) iterate the result(s)...

        self.xcgLogMsg("\(sCurrMethodDisp) Returned query of 'pfQueryAdmins' is [\(String(describing: pfQueryAdmins))]...")

        do
        {
            
            pfQueryAdmins.whereKeyExists("tid")
            pfQueryAdmins.whereKeyExists("password")
            
            pfQueryAdmins.limit = 1000
            
            let listPFAdminsObjects:[PFObject]? = try pfQueryAdmins.findObjects()
            
            if (listPFAdminsObjects != nil &&
                listPFAdminsObjects!.count > 0)
            {
                
            //  DispatchQueue.main.async
            //  {

                    self.xcgLogMsg("\(sCurrMethodDisp) Parse - query of 'pfQueryAdmins' returned a count of #(\(listPFAdminsObjects!.count)) PFObject(s)...")
                    self.xcgLogMsg("\(sCurrMethodDisp) Enumerating the result(s) of query of 'pfQueryAdmins'...")

                    var cPFAdminsObjects:Int   = 0
                    self.dictPFAdminsDataItems = [:]

                    for pfAdminsObject in listPFAdminsObjects!
                    {

                        cPFAdminsObjects += 1

                        let parsePFAdminsDataItem:ParsePFAdminsDataItem = ParsePFAdminsDataItem()

                        parsePFAdminsDataItem.constructParsePFAdminsDataItemFromPFObject(idPFAdminsObject:cPFAdminsObjects, pfAdminsObject:pfAdminsObject)

                        let sPFAdminsParseTID:String = parsePFAdminsDataItem.sPFAdminsParseTID

                        if (sPFAdminsParseTID.count  < 1 ||
                            sPFAdminsParseTID       == "-N/A-")
                        {

                            self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cPFAdminsObjects)) 'parsePFAdminsDataItem' - the 'tid' field is nil or '-N/A-' - Warning!")

                            continue

                        }

                        self.dictPFAdminsDataItems[sPFAdminsParseTID] = parsePFAdminsDataItem

                        self.xcgLogMsg("\(sCurrMethodDisp) Added object #(\(cPFAdminsObjects)) 'parsePFAdminsDataItem' keyed by 'sPFAdminsParseTID' of [\(sPFAdminsParseTID)] to the dictionary of item(s)...")

                    }
                    
                    if (self.dictPFAdminsDataItems.count > 0)
                    {

                        self.xcgLogMsg("\(sCurrMethodDisp) Adding the 'TherapistFile' query data to the dictionary of 'parsePFAdminsDataItem' item(s)...")

                        self.getJmAppParsePFQueryForTherapistFileToAddToAdmins()
                        self.displayDictPFAdminsDataItems()

                    //  self.xcgLogMsg("\(sCurrMethodDisp) Displaying the dictionary of 'parsePFAdminsDataItem' item(s)...")
                    //
                    //  for (_, parsePFAdminsDataItem) in self.dictPFAdminsDataItems
                    //  {
                    //
                    //      parsePFAdminsDataItem.displayParsePFAdminsDataItemToLog()
                    //
                    //  }

                        // Copy back to self.dictPFAdminsDataItems[] and to SwiftData...

                        self.xcgLogMsg("\(sCurrMethodDisp) Copying the item(s) from the dictionary of 'parsePFAdminsDataItem' to SwiftData...")

                        self.copyJmAppParsePFAdminsToSwiftData()

                    }

            //  }

            }
            
        }
        catch
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Parse - failed execute the query 'pfQueryAdmins' - Details: \(error) - Error!")
            
        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
    
        return

    } // End of public func getJmAppParsePFQueryForAdmins().

    public func getJmAppParsePFQueryForTherapistFileToAddToAdmins()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Issue a PFQuery for the 'TherapistFile' class...

        self.xcgLogMsg("\(sCurrMethodDisp) Calling PFQuery to construct an instance for the 'TherapistFile' class...")

        let pfQueryTherapist:PFQuery = PFQuery(className:"TherapistFile")

        self.xcgLogMsg("\(sCurrMethodDisp) Called  PFQuery to construct an instance for the 'TherapistFile' class...")

        // Set the query parameter(s) and issue the 'find' then (possibly) iterate the result(s)...

        self.xcgLogMsg("\(sCurrMethodDisp) Returned query of 'pfQueryTherapist' is [\(String(describing: pfQueryTherapist))]...")

        do
        {
            
            pfQueryTherapist.whereKeyExists("ID")
            pfQueryTherapist.whereKeyExists("name")

            pfQueryTherapist.whereKey("notActive", equalTo:false)
            
            pfQueryTherapist.limit = 1000
            
            let listPFTherapistObjects:[PFObject]? = try pfQueryTherapist.findObjects()
            
            if (listPFTherapistObjects        != nil &&
                listPFTherapistObjects!.count  > 0)
            {
                
                self.xcgLogMsg("\(sCurrMethodDisp) Parse - query of 'pfQueryTherapist' returned a count of #(\(listPFTherapistObjects!.count)) PFObject(s)...")
                self.xcgLogMsg("\(sCurrMethodDisp) Enumerating the result(s) of query of 'pfQueryTherapist'...")
                self.xcgLogMsg("\(sCurrMethodDisp) The 'tracking' location(s) list with #(\(self.listPFCscNameItems.count)) item(s) is [\(self.listPFCscNameItems)])...")

                var cPFTherapistObjects:Int   = 0

                for pfTherapistObject in listPFTherapistObjects!
                {

                    cPFTherapistObjects += 1

                    let sPFTherapistParseTID:String = String(describing: (pfTherapistObject.object(forKey:"ID")  ?? "-N/A-"))

                    if (sPFTherapistParseTID.count  < 1 ||
                        sPFTherapistParseTID       == "-N/A-")
                    {

                        self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cPFTherapistObjects)) 'pfTherapistObject' - the 'tid' field is nil or '-N/A-' - Warning!")

                        continue

                    }


                    let iPFTherapistParseTID:Int = Int(sPFTherapistParseTID) ?? -1

                    if (iPFTherapistParseTID < 0)
                    {

                        self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cPFTherapistObjects)) 'pfTherapistObject' - the 'tid' field (Int) is less than 0 - Warning!")

                        continue

                    }

                    let sPFTherapistParseName:String = String(describing: (pfTherapistObject.object(forKey:"name") ?? "-N/A-"))

                    if (sPFTherapistParseName.count  < 1 ||
                        sPFTherapistParseName       == "-N/A-")
                    {

                        self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cPFTherapistObjects)) 'pfTherapistObject' - the 'name' field is nil or '-N/A-' - Warning!")

                        continue

                    }

                //  DispatchQueue.main.async
                //  {
                    
                        // Build the Tid/TherapistName Xref dictionary...

                        let sPFTherapistParseNameLower:String = sPFTherapistParseName.lowercased()

                        self.dictTherapistTidXref[sPFTherapistParseTID]       = sPFTherapistParseName
                        self.dictTherapistTidXref[sPFTherapistParseName]      = sPFTherapistParseTID
                        self.dictTherapistTidXref[sPFTherapistParseNameLower] = sPFTherapistParseTID

                        // Track the Therapist in the dictionary of TherapistFile item(s)...

                        let pfTherapistFileItem:ParsePFTherapistFileItem      = ParsePFTherapistFileItem()

                        pfTherapistFileItem.constructParsePFTherapistFileItemFromPFObject(pfTherapistFileObject:pfTherapistObject)

                        self.dictPFTherapistFileItems[iPFTherapistParseTID]   = pfTherapistFileItem

                        self.xcgLogMsg("\(sCurrMethodDisp) Added an Item keyed by 'iPFTherapistParseTID' of [\(iPFTherapistParseTID)] added an Item 'pfTherapistFileItem' of [\(pfTherapistFileItem.toString())] to the dictionary of 'dictPFTherapistFileItems' item(s)...")

                        // Track the Therapist in the dictionary of Scheduled Patient 'location' item(s)...

                        if (self.dictSchedPatientLocItems[sPFTherapistParseTID] == nil)
                        {
                    
                            let scheduledPatientLocationItem:ScheduledPatientLocationItem =
                                    ScheduledPatientLocationItem(pfTherapistFileItem:pfTherapistObject)
                    
                            var listScheduledPatientLocationItems:[ScheduledPatientLocationItem] = [ScheduledPatientLocationItem]()
                    
                            listScheduledPatientLocationItems.append(scheduledPatientLocationItem)
                    
                            self.dictSchedPatientLocItems[sPFTherapistParseTID] = listScheduledPatientLocationItems
                    
                            self.xcgLogMsg("\(sCurrMethodDisp) Added an initial Item 'listScheduledPatientLocationItems' of [\(listScheduledPatientLocationItems)] (in a List) to the dictionary of 'dictSchedPatientLocItems' item(s) keyed by 'sPFTherapistParseTID' of [\(sPFTherapistParseTID)] as a 'placeholder'...")
                    
                        }
                        else
                        {
                    
                            self.xcgLogMsg("\(sCurrMethodDisp) Skipped adding an initial Item 'ScheduledPatientLocationItem' (in a List) to the dictionary of 'dictSchedPatientLocItems' item(s) - key 'sPFTherapistParseTID' of [\(sPFTherapistParseTID)] already exists...")
                    
                        }
                    
                //  }

                    // Track the Therapist 'name' in the PFAdminsDataItem(s) dictionary...
                
                    if let parsePFAdminsDataItem:ParsePFAdminsDataItem = self.dictPFAdminsDataItems[sPFTherapistParseTID]
                    {

                        parsePFAdminsDataItem.sPFAdminsParseName = sPFTherapistParseName

                        self.xcgLogMsg("\(sCurrMethodDisp) Using object #(\(cPFTherapistObjects)) 'pfTherapistObject' - to set the 'name' field of [\(sPFTherapistParseName)] in the dictionary of 'parsePFAdminsDataItem' item(s)...")

                    }
                    else
                    {

                        self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cPFTherapistObjects)) 'pfTherapistObject' - the 'tid' field of [\(sPFTherapistParseTID)] is NOT in the dictionary of 'parsePFAdminsDataItem' item(s)...")

                        continue

                    }

                }
                
            }
            else
            {

                self.xcgLogMsg("\(sCurrMethodDisp) Parse - query of 'pfQueryTherapist' returned a count of #(\(listPFTherapistObjects!.count)) PFObject(s) - Error!")

            }
            
        }
        catch
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Parse - failed execute the query 'pfQueryAdmins' - Details: \(error) - Error!")
            
        }

        // If we created item(s) in the 'dictSchedPatientLocItems' and we haven't displayed them, then display them...

        if (bHasDictSchedPatientLocItemsBeenDisplayed == false)
        {

            bHasDictSchedPatientLocItemsBeenDisplayed = true

            self.displayDictSchedPatientLocItems()

        //  if (self.dictSchedPatientLocItems.count > 0)
        //  {
        //
        //      self.xcgLogMsg("\(sCurrMethodDisp) Displaying the dictionary of #(\(self.dictSchedPatientLocItems.count)) 'dictSchedPatientLocItems' item(s)...")
        //
        //      let cPFTherapistTotalTIDs:Int = self.dictSchedPatientLocItems.count
        //      var cPFTherapistParseTIDs:Int = 0
        //
        //      for (sPFTherapistParseTID, listScheduledPatientLocationItems) in self.dictSchedPatientLocItems
        //      {
        //
        //          cPFTherapistParseTIDs += 1
        //
        //          if (sPFTherapistParseTID.count  < 1 ||
        //              sPFTherapistParseTID       == "-N/A-")
        //          {
        //
        //              self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cPFTherapistParseTIDs)) 'sPFTherapistParseTID' - the 'tid' field is nil or '-N/A-' - Warning!")
        //
        //              continue
        //
        //          }
        //
        //          if (listScheduledPatientLocationItems.count < 1)
        //          {
        //
        //              self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cPFTherapistParseTIDs)) 'sPFTherapistParseTID' of [\(sPFTherapistParseTID)] - the 'listScheduledPatientLocationItems' field is nil or the count is less than 1 - Warning!")
        //
        //              continue
        //
        //          }
        //
        //          var cScheduledPatientLocationItems:Int = 0
        //
        //          for scheduledPatientLocationItem in listScheduledPatientLocationItems
        //          {
        //
        //              cScheduledPatientLocationItems += 1
        //
        //              self.xcgLogMsg("\(sCurrMethodDisp) Of #(\(cPFTherapistTotalTIDs)) TIDs - For TID [\(sPFTherapistParseTID)] - Displaying 'scheduledPatientLocationItem' item #(\(cPFTherapistParseTIDs).\(cScheduledPatientLocationItems)):")
        //
        //              scheduledPatientLocationItem.displayScheduledPatientLocationItemToLog()
        //
        //          }
        //
        //      }
        //
        //  }
        //  else
        //  {
        //
        //      self.xcgLogMsg("\(sCurrMethodDisp) Unable to display the dictionary of 'dictSchedPatientLocItems' item(s) - item(s) count is less than 1 - Warning!")
        //
        //  }

        }

        // If we created item(s) in the 'dictPFTherapistFileItems' and we haven't displayed them, then display them...

        if (bHasDictTherapistFileItemsBeenDisplayed == false)
        {

            bHasDictTherapistFileItemsBeenDisplayed = true

            self.displayDictPFTherapistFileItems()

        //  if (self.dictPFTherapistFileItems.count > 0)
        //  {
        //
        //      self.xcgLogMsg("\(sCurrMethodDisp) Displaying the dictionary of #(\(self.dictPFTherapistFileItems.count)) 'dictPFTherapistFileItems' item(s)...")
        //
        //      var cPFTherapistParseTIDs:Int = 0
        //
        //      for (iPFTherapistParseTID, pfTherapistFileItem) in self.dictPFTherapistFileItems
        //      {
        //
        //          cPFTherapistParseTIDs += 1
        //
        //          if (iPFTherapistParseTID < 0)
        //          {
        //
        //              self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cPFTherapistParseTIDs)) 'iPFTherapistParseTID' - the 'tid' field is less than 0 - Warning!")
        //
        //              continue
        //
        //          }
        //
        //          self.xcgLogMsg("\(sCurrMethodDisp) For TID [\(iPFTherapistParseTID)] - Displaying 'pfTherapistFileItem' item #(\(cPFTherapistParseTIDs)):")
        //
        //          pfTherapistFileItem.displayParsePFTherapistFileItemToLog()
        //
        //      }
        //
        //  }
        //  else
        //  {
        //
        //      self.xcgLogMsg("\(sCurrMethodDisp) Unable to display the dictionary of 'dictPFTherapistFileItems' item(s) - item(s) count is less than 1 - Warning!")
        //
        //  }

        }

        // ----------------------------------------------------------------------------------------------------------------------
        //  var dictTherapistTidXref:[String:String] = [String:String]()
        //                                             // [String:String]
        //                                             // Key:Tid(String)                       -> TherapistName (String)
        //                                             // Key:TherapistName(String)             -> Tid (String)
        //                                             // Key:TherapistName(String)<lowercased> -> Tid (String)
        // ----------------------------------------------------------------------------------------------------------------------

        if (self.dictTherapistTidXref.count > 0)
        {

            // If we have a different # of item(s) then the ParseCoreManager does, then deep copy and update it...

            if (self.jmAppParseCoreManager.dictTherapistTidXref.count  < 1 ||
                self.jmAppParseCoreManager.dictTherapistTidXref.count != self.dictTherapistTidXref.count)
            {

                let _ = self.deepCopyDictTherapistTidXref()
            
            //  self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy'ing the dictionary 'dictTherapistTidXref' of (\(self.dictTherapistTidXref.count)) 'string' item(s)...")
            //
            //  var cDeepCopyTherapistTidXrefItems:Int                = 0 
            //  var dictDeepCopyTherapistTidXrefItems:[String:String] = [String:String]()
            //
            //  for (sTherapistTidXrefKey, sTherapistTidXrefValue) in self.dictTherapistTidXref
            //  {
            //
            //      cDeepCopyTherapistTidXrefItems       += 1
            //      let sNewTherapistTidXrefKey:String    = sTherapistTidXrefKey
            //      let sNewTherapistTidXrefValue:String  = sTherapistTidXrefValue
            //
            //      if (sNewTherapistTidXrefKey.count < 1)
            //      {
            //
            //          self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' Skipping object #(\(cDeepCopyTherapistTidXrefItems)) - the 'key' field is nil - Warning!")
            //
            //          continue
            //
            //      }
            //
            //      dictDeepCopyTherapistTidXrefItems[sNewTherapistTidXrefKey] = sNewTherapistTidXrefValue
            //
            //      self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' Added referance #(\(cDeepCopyTherapistTidXrefItems)) keyed by 'sNewTherapistTidXrefKey' of [\(sNewTherapistTidXrefKey)] to the 'deep copy' dictionary of item(s)...")
            //
            //  }
            //
            //  if (dictDeepCopyTherapistTidXrefItems.count > 0)
            //  {
            //  
            //      DispatchQueue.main.async
            //      {
            //
            //          self.jmAppParseCoreManager.dictTherapistTidXref = dictDeepCopyTherapistTidXrefItems
            //
            //          self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' replaced #(\(dictDeepCopyTherapistTidXrefItems.count)) item(s) in the ParseCoreManager 'dictTherapistTidXref'...")
            //
            //      }
            //  
            //  }
            
            }

        }

        // ----------------------------------------------------------------------------------------------------------------------
        //  var dictPFTherapistFileItems:[Int:ParsePFTherapistFileItem] = [Int:ParsePFTherapistFileItem]()
        //                                                                // [Int:ParsePFTherapistFileItem]
        //                                                                // Key:Tid(Int) -> TherapistID (Int)
        // ----------------------------------------------------------------------------------------------------------------------

        if (self.dictPFTherapistFileItems.count > 0)
        {

            // If we have a different # of item(s) then the ParseCoreManager does, then deep copy and update it...

            if (self.jmAppParseCoreManager.dictPFTherapistFileItems.count  < 1 ||
                self.jmAppParseCoreManager.dictPFTherapistFileItems.count != self.dictPFTherapistFileItems.count)
            {

                let _ = self.deepCopyDictPFTherapistFileItems()
            
            //  self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy'ing the dictionary 'dictPFTherapistFileItems' of (\(self.dictPFTherapistFileItems.count)) 'pfTherapistFileItem' item(s)...")
            //
            //  var cDeepCopyPFTherapistFileItems:Int                               = 0 
            //  var dictDeepCopyPFTherapistFileItems:[Int:ParsePFTherapistFileItem] = [Int:ParsePFTherapistFileItem]()
            //
            //  for (iPFTherapistFileTID, pfTherapistFileItem) in self.dictPFTherapistFileItems
            //  {
            //
            //      cDeepCopyPFTherapistFileItems                            += 1
            //      let iNewPFTherapistFileTID:Int                            = iPFTherapistFileTID
            //      let newPFTherapistFileItem:ParsePFTherapistFileItem       = ParsePFTherapistFileItem(pfTherapistFileItem:pfTherapistFileItem)
            //      dictDeepCopyPFTherapistFileItems[iNewPFTherapistFileTID]  = newPFTherapistFileItem
            //
            //      self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' Added object #(\(cDeepCopyPFTherapistFileItems)) 'newPFTherapistFileItem' keyed by 'iNewPFTherapistFileTID' of (\(iNewPFTherapistFileTID)) to the 'deep copy' dictionary of item(s)...")
            //
            //  }
            //
            //  if (dictDeepCopyPFTherapistFileItems.count > 0)
            //  {
            //  
            //      DispatchQueue.main.async
            //      {
            //
            //          self.jmAppParseCoreManager.dictPFTherapistFileItems = dictDeepCopyPFTherapistFileItems
            //
            //          self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' replaced #(\(dictDeepCopyPFTherapistFileItems.count)) item(s) in the ParseCoreManager 'dictPFTherapistFileItems'...")
            //
            //      }
            //  
            //  }
            
            }

        }

        // ----------------------------------------------------------------------------------------------------------------------
        //  var dictSchedPatientLocItems:[String:[ScheduledPatientLocationItem]] = [String:[ScheduledPatientLocationItem]]()
        //                                                                         // [String:[ScheduledPatientLocationItem]]
        //                                                                         // Key:sPFTherapistParseTID(String)
        // ----------------------------------------------------------------------------------------------------------------------

        if (self.dictSchedPatientLocItems.count > 0)
        {

            // If we have a different # of item(s) then the ParseCoreManager does, then deep copy and update it...

            if (self.jmAppParseCoreManager.dictSchedPatientLocItems.count  < 1 ||
                self.jmAppParseCoreManager.dictSchedPatientLocItems.count != self.dictSchedPatientLocItems.count)
            {

                let _ = self.deepCopyDictSchedPatientLocItems()
            
            //  self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy'ing the dictionary 'dictSchedPatientLocItems' of (\(self.dictSchedPatientLocItems.count)) ['scheduledPatientLocationItem'] item(s)...")
            //
            //  var cDeepCopySchedPatientLocItems:Int                                                 = 0 
            //  var dictDeepCopyScheduledPatientLocationItems:[String:[ScheduledPatientLocationItem]] = [String:[ScheduledPatientLocationItem]]()
            //
            //  for (sPFTherapistTID, listScheduledPatientLocationItems) in self.dictSchedPatientLocItems
            //  {
            //
            //      cDeepCopySchedPatientLocItems += 1
            //      let sNewPFTherapistTID:String  = sPFTherapistTID
            //
            //      if (sNewPFTherapistTID.count < 1)
            //      {
            //
            //          self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' Skipping object #(\(cDeepCopySchedPatientLocItems)) - the 'sNewPFTherapistTID' <key> field is nil - Warning!")
            //
            //          continue
            //
            //      }
            //
            //      self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy'ing the list of (\(listScheduledPatientLocationItems.count)) 'listScheduledPatientLocationItems' item(s)...")
            //
            //      var listNewScheduledPatientLocationItems:[ScheduledPatientLocationItem] = [ScheduledPatientLocationItem]()
            //
            //      for scheduledPatientLocationItem in listScheduledPatientLocationItems
            //      {
            //
            //          let newScheduledPatientLocationItem:ScheduledPatientLocationItem = ScheduledPatientLocationItem(scheduledPatientLocationItem:scheduledPatientLocationItem)
            //
            //          listNewScheduledPatientLocationItems.append(newScheduledPatientLocationItem)
            //
            //      }
            //
            //      dictDeepCopyScheduledPatientLocationItems[sNewPFTherapistTID] = listNewScheduledPatientLocationItems
            //
            //      self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' Added list #(\(cDeepCopySchedPatientLocItems)) of (\(listScheduledPatientLocationItems.count)) 'listNewScheduledPatientLocationItems' keyed by 'sNewPFTherapistTID' of [\(sNewPFTherapistTID)] to the 'deep copy' dictionary of item(s)...")
            //
            //  }
            //
            //  if (dictDeepCopyScheduledPatientLocationItems.count > 0)
            //  {
            //  
            //      DispatchQueue.main.async
            //      {
            //
            //          self.jmAppParseCoreManager.dictSchedPatientLocItems = dictDeepCopyScheduledPatientLocationItems
            //
            //          self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' replaced #(\(dictDeepCopyScheduledPatientLocationItems.count)) item(s) in the ParseCoreManager 'dictSchedPatientLocItems'...")
            //
            //      }
            //  
            //  }
            
            }

        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
    
        return

    } // End of public func getJmAppParsePFQueryForTherapistFileToAddToAdmins().

    public func getJmAppParsePFQueryForCSC()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Issue a PFQuery for the 'CSC' class...

        self.xcgLogMsg("\(sCurrMethodDisp) Calling PFQuery to construct an instance for the 'CSC' class...")

        let pfQueryCSC:PFQuery = PFQuery(className:"CSC")

        self.xcgLogMsg("\(sCurrMethodDisp) Called  PFQuery to construct an instance for the 'CSC' class...")

        // Set the query parameter(s) and issue the 'find' then (possibly) iterate the result(s)...

        self.xcgLogMsg("\(sCurrMethodDisp) Returned query of 'pfQueryCSC' is [\(String(describing: pfQueryCSC))]...")

        do
        {
            
            pfQueryCSC.whereKeyExists("name")
            pfQueryCSC.whereKeyExists("lastLocDate")
            pfQueryCSC.whereKeyExists("lastLocTime")
            pfQueryCSC.whereKeyExists("latitude")
            pfQueryCSC.whereKeyExists("longitude")
            
            pfQueryCSC.whereKey("updatedAt", greaterThan:(Calendar.current.date(byAdding: .day, value: -1, to: .now)!))
            
            pfQueryCSC.addDescendingOrder("updatedAt")
            
            pfQueryCSC.limit = 1000
            
            let listPFCscObjects:[PFObject]? = try pfQueryCSC.findObjects()
            
            if (listPFCscObjects != nil &&
                listPFCscObjects!.count > 0)
            {

                self.xcgLogMsg("\(sCurrMethodDisp) Parse - query of 'pfQueryCSC' returned a count of #(\(listPFCscObjects!.count)) PFObject(s)...")
                self.xcgLogMsg("\(sCurrMethodDisp) Enumerating the result(s) of query of 'pfQueryCSC'...")

                var cPFCscObjects:Int = 0
                
            //  self.listPFCscDataItems = []
            //  self.listPFCscNameItems = []

                var dictPFCscDataItems:[String:ParsePFCscDataItem] = [String:ParsePFCscDataItem]()
                                                                     // [String:[ParsePFCscDataItem]]

                for currentPFCscDataItem:ParsePFCscDataItem in self.listPFCscDataItems
                {

                    if (currentPFCscDataItem.sPFCscParseName.count < 1)
                    {
                    
                        continue
                    
                    }

                    dictPFCscDataItems[currentPFCscDataItem.sPFCscParseName] = currentPFCscDataItem

                }

                for pfCscObject in listPFCscObjects!
                {

                    cPFCscObjects += 1

                    let parsePFCscDataItem:ParsePFCscDataItem = ParsePFCscDataItem()

                    parsePFCscDataItem.constructParsePFCscDataItemFromPFObject(idPFCscObject:cPFCscObjects, pfCscObject:pfCscObject)

                    let sPFCscParseName:String = parsePFCscDataItem.sPFCscParseName

                    parsePFCscDataItem.sPFTherapistParseTID = self.convertTherapistNameToTid(sPFTherapistParseName:sPFCscParseName)

                    if (dictPFCscDataItems.keys.contains(sPFCscParseName) == true)
                    {
                    
                        let currentPFCscDataItem:ParsePFCscDataItem = dictPFCscDataItems[sPFCscParseName]!

                        currentPFCscDataItem.overlayPFCscDataItemWithAnotherPFCscDataItem(pfCscDataItem:currentPFCscDataItem)

                        // NO update to 'listPFCscDataItems' - the object is the same in the list as the dictionary...
                        
                        self.xcgLogMsg("\(sCurrMethodDisp) <PFQuery> Updated object #(\(cPFCscObjects)) 'parsePFCscDataItem' for key 'sPFCscParseName' of [\(sPFCscParseName)] to the tracking dictionary (automatic update in the list)...")
                    
                    }
                    else
                    {
                    
                        dictPFCscDataItems[sPFCscParseName] = parsePFCscDataItem

                        self.listPFCscDataItems.append(parsePFCscDataItem)
                        self.listPFCscNameItems.append(sPFCscParseName)

                        // Dictionary and BOTH List(s) are updated as this is a 'new' Item...
                        
                        self.xcgLogMsg("\(sCurrMethodDisp) <PFQuery> Added object #(\(cPFCscObjects)) 'parsePFCscDataItem' for key 'sPFCscParseName' of [\(sPFCscParseName)] to the tracking dictionary and both lists of name(s)/item(s)...")
                    
                    }

                //  self.listPFCscNameItems.append(parsePFCscDataItem.sPFCscParseName)
                //  self.listPFCscDataItems.append(parsePFCscDataItem)
                //
                //  self.xcgLogMsg("\(sCurrMethodDisp) Added object #(\(cPFCscObjects)) 'parsePFCscDataItem' to the list of name(s)/item(s)...")

                }

                if (dictPFCscDataItems.count > 0)
                {
                
                    self.xcgLogMsg("\(sCurrMethodDisp) <PFQuery> 'tracking' - Displaying the <internal/local> dictionary 'dictPFCscDataItems' of (\(dictPFCscDataItems.count))) item(s)...")

                    var cDictPFCscDataItems:Int = 0

                    for (sPFCscParseName, currentPFCscDataItem) in dictPFCscDataItems
                    {

                        cDictPFCscDataItems += 1

                        if (sPFCscParseName.count  < 1)
                        {

                            self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cDictPFCscDataItems)) 'sPFCscParseName' - the 'name' field is 'empty' - Warning!")

                            continue

                        }

                        currentPFCscDataItem.displayParsePFCscDataItemToLog()

                    }
                
                }
                else
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) <PFQuery> 'tracking' - Unable to display the <internal/local> dictionary 'dictPFCscDataItems' of (\(dictPFCscDataItems.count))) item(s) - Warning!")

                }

                // Gather the PFQueries to construct the new ScheduledPatientLocationItem(s) in the background
                // (ONLY on the 1st call to this function - after that this fires from a View on a Timer)

                if (self.bNeedFirstPassSchedPatientLocations == true)
                {
                    
                    self.bNeedFirstPassSchedPatientLocations = false

                    self.xcgLogMsg("\(sCurrMethodDisp) <1st Run> Calling 'self.gatherJmAppParsePFQueriesForScheduledLocationsInBackground()' to gather 'scheduled' Patient location data...")

                    self.gatherJmAppParsePFQueriesForScheduledLocationsInBackground()

                    self.xcgLogMsg("\(sCurrMethodDisp) <1st Run> Called  'self.gatherJmAppParsePFQueriesForScheduledLocationsInBackground()' to gather 'scheduled' Patient location data...")

                }

                // After a 6/10th of a second delay (for location information gathering), display the list of item(s)...

                DispatchQueue.main.asyncAfter(deadline:(.now() + 0.6))
                {

                    self.displayListPFCscDataItems()

                //  self.xcgLogMsg("\(sCurrMethodDisp) Displaying the list of 'parsePFCscDataItem' item(s)...")
                //
                //  for parsePFCscDataItem in self.listPFCscDataItems
                //  {
                //
                //      parsePFCscDataItem.displayParsePFCscDataItemToLog()
                //
                //  }

                }
                
            }
            else
            {

                self.xcgLogMsg("\(sCurrMethodDisp) Parse - query of 'pfQueryCSC' returned an 'empty' or nil list of PFObject(s)...")

            }
            
        }
        catch
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Parse - failed execute the query 'pfQueryCSC' - Details: \(error) - Error!")
            
        }

        // ----------------------------------------------------------------------------------------------------------------------
        //  var listPFCscDataItems:[ParsePFCscDataItem] = []
        // ----------------------------------------------------------------------------------------------------------------------

        if (self.listPFCscDataItems.count > 0)
        {

            // If we have a different # of item(s) then the ParseCoreManager does, then deep copy and update it...

            if (self.jmAppParseCoreManager.listPFCscDataItems.count  < 1 ||
                self.jmAppParseCoreManager.listPFCscDataItems.count != self.listPFCscDataItems.count)
            {

                let _ = self.deepCopyListPFCscDataItems()
            
            //  self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy'ing the list 'listPFCscDataItems' of (\(self.listPFCscDataItems.count)) ['pfCscDataItem'] item(s)...")
            //
            //  var cDeepCopyPFCscDataItems:Int                     = 0 
            //  var listDeepCopyPFCscDataItems:[ParsePFCscDataItem] = [ParsePFCscDataItem]()
            //
            //  for pfCscDataItem in self.listPFCscDataItems
            //  {
            //
            //      cDeepCopyPFCscDataItems                 += 1
            //      let newPFCscDataItem:ParsePFCscDataItem  = ParsePFCscDataItem(pfCscDataItem:pfCscDataItem)
            //
            //      listDeepCopyPFCscDataItems.append(newPFCscDataItem)
            //
            //      self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' Added object #(\(cDeepCopyPFCscDataItems)) 'newPFCscDataItem' of [\(newPFCscDataItem)] to the 'deep copy' list of item(s)...")
            //
            //  }
            //
            //  if (listDeepCopyPFCscDataItems.count > 0)
            //  {
            //  
            //      DispatchQueue.main.async
            //      {
            //
            //          self.jmAppParseCoreManager.listPFCscDataItems = listDeepCopyPFCscDataItems
            //
            //          self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' replaced #(\(listDeepCopyPFCscDataItems.count)) item(s) in the ParseCoreManager 'listPFCscDataItems'...")
            //
            //          // Kick the 'cPFCscObjectsRefresh' count to force any SwiftUI display(s) to refresh...
            //      
            //          self.jmAppParseCoreManager.cPFCscObjects         = listDeepCopyPFCscDataItems.count
            //          self.jmAppParseCoreManager.cPFCscObjectsRefresh += 1
            //      
            //      }
            //  
            //  }
            
            }

        }

        // ----------------------------------------------------------------------------------------------------------------------
        //  var listPFCscNameItems:[String] = []
        // ----------------------------------------------------------------------------------------------------------------------

        if (self.listPFCscNameItems.count > 0)
        {

            // If we have a different # of item(s) then the ParseCoreManager does, then deep copy and update it...

            if (self.jmAppParseCoreManager.listPFCscNameItems.count  < 1 ||
                self.jmAppParseCoreManager.listPFCscNameItems.count != self.listPFCscNameItems.count)
            {

                let _ = self.deepCopyListPFCscNameItems()
            
            //  self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy'ing the list 'listPFCscNameItems' of (\(self.listPFCscNameItems.count)) [String] item(s)...")
            //
            //  var cDeepCopyPFCscNameItems:Int         = 0 
            //  var listDeepCopyPFCscNameItems:[String] = [String]()
            //
            //  for sPFCscParseName in self.listPFCscNameItems
            //  {
            //
            //      cDeepCopyPFCscNameItems      += 1
            //      let sNewPFCscNameItem:String  = sPFCscParseName
            //
            //      listDeepCopyPFCscNameItems.append(sNewPFCscNameItem)
            //
            //      self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' Added object #(\(cDeepCopyPFCscNameItems)) 'sNewPFCscNameItem' of [\(sNewPFCscNameItem)] to the 'deep copy' list of item(s)...")
            //
            //  }
            //
            //  if (listDeepCopyPFCscNameItems.count > 0)
            //  {
            //  
            //      DispatchQueue.main.async
            //      {
            //
            //          self.jmAppParseCoreManager.listPFCscNameItems = listDeepCopyPFCscNameItems
            //
            //          self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' replaced #(\(listDeepCopyPFCscNameItems.count)) item(s) in the ParseCoreManager 'listPFCscNameItems'...")
            //
            //      }
            //  
            //  }
            
            }

        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
    
        return

    } // End of public func getJmAppParsePFQueryForCSC().

    public func copyJmAppParsePFAdminsToSwiftData()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Copy (if any) PFQuery 'Admins' to SwiftData...

        if (self.dictPFAdminsDataItems.count > 0)
        {

            if (self.jmAppSwiftDataManager.modelContext != nil)
            {

            //  let pfAdminsSwiftDataItemsDescriptor = FetchDescriptor<PFAdminsSwiftDataItem>()

                DispatchQueue.main.async
                {

                    do
                    {

                    //  let pfAdminsSwiftDataItems:[PFAdminsSwiftDataItem] = try self.jmAppSwiftDataManager.modelContext!.fetch(pfAdminsSwiftDataItemsDescriptor)
                    //  let cPFAdminsSwiftDataItems:Int                    = pfAdminsSwiftDataItems.count
                    //
                    //  if (cPFAdminsSwiftDataItems > 0)
                        if (self.jmAppSwiftDataManager.pfAdminsSwiftDataItems.count > 0)
                        {

                            self.xcgLogMsg("\(sCurrMethodDisp) Deleting ALL #(\(self.jmAppSwiftDataManager.pfAdminsSwiftDataItems.count)) existing SwiftData PFQuery 'Admins' item(s)...")

                            try self.jmAppSwiftDataManager.modelContext!.delete(model:PFAdminsSwiftDataItem.self)

                            self.xcgLogMsg("\(sCurrMethodDisp) Deleted  ALL #(\(self.jmAppSwiftDataManager.pfAdminsSwiftDataItems.count)) existing SwiftData PFQuery 'Admins' item(s)...")

                        }
                        else
                        {

                            self.xcgLogMsg("\(sCurrMethodDisp) Skipping the deletion of ALL existing SwiftData PFQuery 'Admins' item(s) - there are NO existing item(s)...")

                        }

                    } 
                    catch
                    {

                        self.xcgLogMsg("\(sCurrMethodDisp) Failed to delete ALL SwiftData PFQuery 'Admins' items() - Details: \(error) - Error!")

                    }

                    self.xcgLogMsg("\(sCurrMethodDisp) Copying (\(self.dictPFAdminsDataItems.count)) PFQuery 'Admins' item(s) to SwiftData...")

                    var cPFAdminsDataItemsAdded:Int = 0

                    for (_, parsePFAdminsDataItem) in self.dictPFAdminsDataItems
                    {

                        let newPFAdminsSwiftDataItem = PFAdminsSwiftDataItem(timestamp:   Date(),
                                                                             sCreatedBy:  "\(ClassInfo.sClsDisp)",
                                                                             pfAdminsItem:parsePFAdminsDataItem)

                    //  self.jmAppSwiftDataManager.modelContext!.insert(newPFAdminsSwiftDataItem)
                        self.jmAppSwiftDataManager.addAppSwiftDataItem(pfAdminsSwiftDataItem:newPFAdminsSwiftDataItem, 
                                                                       bShowDetailAfterAdd:  false)

                        self.xcgLogMsg("\(sCurrMethodDisp) Added 'newPFAdminsSwiftDataItem' of [\(String(describing: newPFAdminsSwiftDataItem.toString()))] to the SwiftDataManager...")

                        cPFAdminsDataItemsAdded += 1

                    }

                    self.xcgLogMsg("\(sCurrMethodDisp) Added #(\(cPFAdminsDataItemsAdded)) PFQuery 'Admins' item(s) to SwiftData from #(\(self.dictPFAdminsDataItems.count)) available item(s)...")

                    self.xcgLogMsg("\(sCurrMethodDisp) Invoking 'self.jmAppSwiftDataManager.detailAppSwiftDataToLog()'...")

                    self.jmAppSwiftDataManager.detailAppSwiftDataToLog()

                    self.xcgLogMsg("\(sCurrMethodDisp) Invoked  'self.jmAppSwiftDataManager.detailAppSwiftDataToLog()'...")

                }

            }
            else
            {

                self.xcgLogMsg("\(sCurrMethodDisp) Copy failed - 'self.jmAppSwiftDataManager?.modelContent' is nil - NO 'target' to copy (\(self.dictPFAdminsDataItems.count)) item(s) too - Warning!")

            }

        }
        else
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Copy failed - 'self.dictPFAdminsDataItems' has NO PFQuery 'Admins' item(s) - Warning!")
            
        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
    
        return

    } // End of public func copyJmAppParsePFAdminsToSwiftData().

    public func gatherJmAppParsePFQueriesForScheduledLocationsInBackground()
    {

        let sCurrMethod:String = #function;
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
  
        let dispatchGroup = DispatchGroup()

        do
        {

            dispatchGroup.enter()

            let dispatchQueue = DispatchQueue(label: "GatherAppPFQueriesInBackground", qos: .userInitiated)

            dispatchQueue.async
            {

                self.xcgLogMsg("\(sCurrMethodDisp) Invoking background PFQueries method(s)...");

                self.xcgLogMsg("\(sCurrMethodDisp) Calling PFQuery to construct an instance for the 'PatientCalDay' class...")

                self.gatherJmAppParsePFQueriesForPatientCalDayInBackground()

                self.xcgLogMsg("\(sCurrMethodDisp) Called  PFQuery to construct an instance for the 'PatientCalDay' class...")

                self.xcgLogMsg("\(sCurrMethodDisp) Calling PFQuery to construct an instance for the 'BackupVisit' class...")

                self.gatherJmAppParsePFQueriesForBackupVisitInBackground()

                self.xcgLogMsg("\(sCurrMethodDisp) Called  PFQuery to construct an instance for the 'BackupVisit' class...")

                self.xcgLogMsg("\(sCurrMethodDisp) Invoked  background PFQueries method(s)...");

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

            }

            dispatchGroup.leave()

        }

        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return

    } // End of public func gatherJmAppParsePFQueriesForScheduledLocationsInBackground().
    
    public func gatherJmAppParsePFQueriesForPatientCalDayInBackground()
    {

        let sCurrMethod:String = #function;
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
  
        // Issue a PFQueries to pull Therapist data from PatientCalDay for the current day...

        let dtFormatterDate:DateFormatter = DateFormatter()

        dtFormatterDate.locale     = Locale(identifier: "en_US")
        dtFormatterDate.timeZone   = TimeZone.current
        dtFormatterDate.dateFormat = "yyyy-MM-dd"

        let dateForCurrentQuery:Date = Date.now
        let sCurrentQueryDate:String = dtFormatterDate.string(from:dateForCurrentQuery)

        self.xcgLogMsg("\(sCurrMethodDisp) 'sCurrentQueryDate' is [\(String(describing: sCurrentQueryDate))] <formatted>...")

        // If we have item(s) in the 'dictSchedPatientLocItems' dictionary, then repopulate them with PatientCalDay information...

        if (self.dictSchedPatientLocItems.count > 0)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Enumerating the dictionary of #(\(self.dictSchedPatientLocItems.count)) 'dictSchedPatientLocItems' item(s) to gather 'PatientCalDay' information...")

            let cPFTherapistTotalTIDs:Int = self.dictSchedPatientLocItems.count
            var cPFTherapistParseTIDs:Int = 0

            for (sPFTherapistParseTID, listOfOldScheduledPatientLocationItems) in self.dictSchedPatientLocItems
            {

                cPFTherapistParseTIDs += 1

                if (sPFTherapistParseTID.count  < 1 ||
                    sPFTherapistParseTID       == "-N/A-")
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cPFTherapistParseTIDs)) 'sPFTherapistParseTID' - the 'tid' field is nil or '-N/A-' - Warning!")

                    continue

                }

                if (listOfOldScheduledPatientLocationItems.count < 1)
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cPFTherapistTotalTIDs)) 'sPFTherapistParseTID' of [\(sPFTherapistParseTID)] - the 'listOfOldScheduledPatientLocationItems' field is nil or the count is less than 1 - Warning!")

                    continue

                }

                // 'listOfOldScheduledPatientLocationItems' has at least 1 item (added as a 'placeholder' when the 'dictSchedPatientLocItems' was built.
                // Grab the 1st item in the list to use as a 'template' object and then clear the list (to be rebuilt)...

                let scheduledPatientLocationItemTemplate:ScheduledPatientLocationItem = listOfOldScheduledPatientLocationItems[0]
                var listScheduledPatientLocationItems:[ScheduledPatientLocationItem]  = [ScheduledPatientLocationItem]()

                // Issue a PFQuery for the 'PatientCalDay' class...

                self.xcgLogMsg("\(sCurrMethodDisp) Calling PFQuery to construct an instance for the 'PatientCalDay' class...")

                let pfQueryPatientCalDay:PFQuery = PFQuery(className:"PatientCalDay")

                self.xcgLogMsg("\(sCurrMethodDisp) Called  PFQuery to construct an instance for the 'PatientCalDay' class...")

                // Set the query parameter(s) and issue the 'find' then (possibly) iterate the result(s)...

                self.xcgLogMsg("\(sCurrMethodDisp) Returned query of 'pfQueryPatientCalDay' is [\(String(describing: pfQueryPatientCalDay))]...")

                do
                {

                //  "class" : "select * from PatientCalDay where tid = 261 and VDate = \"2024-12-03\";",

                    pfQueryPatientCalDay.whereKeyExists("pid")
                    pfQueryPatientCalDay.whereKeyExists("startTime")

                //  pfQueryPatientCalDay.whereKey("tid",   equalTo:sPFTherapistParseTID)
                    pfQueryPatientCalDay.whereKey("tid",   equalTo:Int(sPFTherapistParseTID) as Any)
                    pfQueryPatientCalDay.whereKey("VDate", equalTo:sCurrentQueryDate)

                //  pfQueryPatientCalDay.addAscendingOrder("startTime")

                    pfQueryPatientCalDay.limit = 1000

                    let listPFPatientCalDayObjects:[PFObject]? = try pfQueryPatientCalDay.findObjects()

                    if (listPFPatientCalDayObjects != nil &&
                        listPFPatientCalDayObjects!.count > 0)
                    {

                        self.xcgLogMsg("\(sCurrMethodDisp) Parse - query of 'pfQueryPatientCalDay' returned a count of #(\(listPFPatientCalDayObjects!.count)) PFObject(s)...")
                        self.xcgLogMsg("\(sCurrMethodDisp) Enumerating the result(s) of query of 'pfQueryPatientCalDay'...")

                        var cPFPatientCalDayObjects:Int = 0

                        for pfPatientCalDayObject in listPFPatientCalDayObjects!
                        {

                            cPFPatientCalDayObjects += 1

                            let scheduledPatientLocationItem:ScheduledPatientLocationItem =
                                    ScheduledPatientLocationItem(scheduledPatientLocationItem:scheduledPatientLocationItemTemplate)

                            scheduledPatientLocationItem.updateScheduledPatientLocationItemFromPFPatientCalDay(pfPatientCalDayItem:pfPatientCalDayObject)

                            listScheduledPatientLocationItems.append(scheduledPatientLocationItem)

                            self.xcgLogMsg("\(sCurrMethodDisp) Added an updated Item #(\(cPFPatientCalDayObjects)) 'scheduledPatientLocationItem' of [\(scheduledPatientLocationItem)] to the list 'listScheduledPatientLocationItems' for 'sPFTherapistParseTID' of [\(sPFTherapistParseTID)]...")

                        }

                        if (cPFPatientCalDayObjects > 0)
                        {

                            if (cPFPatientCalDayObjects > 1)
                            {

                                self.xcgLogMsg("\(sCurrMethodDisp) Sorting #(\(cPFPatientCalDayObjects)) Item(s) in the 'listScheduledPatientLocationItems' of [\(listScheduledPatientLocationItems)] for 'sPFTherapistParseTID' of [\(sPFTherapistParseTID)]...")

                                listScheduledPatientLocationItems.sort
                                { (scheduledPatientLocationItem1, scheduledPatientLocationItem2) in

                                //  Compare for Sort: '<' sorts 'ascending' and '>' sorts 'descending'...

                                //  let bIsItem1GreaterThanItem2:Bool = (scheduledPatientLocationItem1.iVDateStartTime24h > scheduledPatientLocationItem2.iVDateStartTime24h)
                                    let bIsItem1GreaterThanItem2:Bool = (scheduledPatientLocationItem1.iVDateStartTime24h < scheduledPatientLocationItem2.iVDateStartTime24h)

                                //  self.xcgLogMsg("\(sCurrMethodDisp) Sort <OP> Returning 'bIsItem1GreaterThanItem2' of [\(bIsItem1GreaterThanItem2)] because 'scheduledPatientLocationItem1.iVDateStartTime24h' is [\(scheduledPatientLocationItem1.iVDateStartTime24h)] and is less than 'scheduledPatientLocationItem2.iVDateStartTime24h' is [\(scheduledPatientLocationItem2.iVDateStartTime24h)] for 'sPFTherapistParseTID' of [\(sPFTherapistParseTID)]...")

                                    return bIsItem1GreaterThanItem2

                                }

                                self.xcgLogMsg("\(sCurrMethodDisp) Sorted  #(\(cPFPatientCalDayObjects)) Item(s) in the 'listScheduledPatientLocationItems' of [\(listScheduledPatientLocationItems)] for 'sPFTherapistParseTID' of [\(sPFTherapistParseTID)]...")

                            }
                        
                        //  DispatchQueue.main.async
                        //  {

                                self.dictSchedPatientLocItems[sPFTherapistParseTID] = listScheduledPatientLocationItems

                                self.xcgLogMsg("\(sCurrMethodDisp) Added #(\(cPFPatientCalDayObjects)) updated Item(s) to the 'listScheduledPatientLocationItems' of [\(listScheduledPatientLocationItems)] to the dictionary of 'dictSchedPatientLocItems' item(s) keyed by 'sPFTherapistParseTID' of [\(sPFTherapistParseTID)]...")

                        //  }
                        
                        }

                    }
                    else
                    {

                        self.xcgLogMsg("\(sCurrMethodDisp) Parse - query of 'pfQueryPatientCalDay' returned an 'empty' or nil list of PFObject(s)...")

                    }

                }
                catch
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) Parse - failed execute the query 'pfQueryPatientCalDay' - Details: \(error) - Error!")

                }

            }

        }
        else
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Unable to enumerate the dictionary of 'dictSchedPatientLocItems' item(s) - item(s) count is less than 1 - Warning!")

        }

        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return

    } // End of public func gatherJmAppParsePFQueriesForPatientCalDayInBackground().
    
    public func gatherJmAppParsePFQueriesForBackupVisitInBackground()
    {

        let sCurrMethod:String = #function;
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
  
        // Issue a PFQueries to pull Patient (Visit) data from BackupVisit for the last 30 day(s)...
        //     :: From PFQuery Class: 'BackupVisit' ::
        //
        //     [Query::{ "pid"            : NumberLong(13556), 
        //               "billable"       : NumberLong(1), 
        //               "isTelepractice" : { "$ne" : NumberLong(1) },
        //               "VDate"          : { "$gt" : "2024-11-10" } }]  // Yields all visit(s) in last 30 day(s) or such...
        //     [Sort::{"VDate": -1}]                                     // Yields visit(s) newest to oldest (1st one is newest)...

        let dtFormatterDate:DateFormatter = DateFormatter()

        dtFormatterDate.locale     = Locale(identifier: "en_US")
        dtFormatterDate.timeZone   = TimeZone.current
        dtFormatterDate.dateFormat = "yyyy-MM-dd"

        let dateForCurrentQuery:Date = Calendar.current.date(byAdding: .day, value: -30, to: .now)!
        let sCurrentQueryDate:String = dtFormatterDate.string(from:dateForCurrentQuery)

        self.xcgLogMsg("\(sCurrMethodDisp) 'sCurrentQueryDate' is [\(String(describing: sCurrentQueryDate))] <formatted>...")

        // If we have item(s) in the 'dictSchedPatientLocItems' dictionary, then repopulate them with BackupVisit information...

        if (self.dictSchedPatientLocItems.count > 0)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Enumerating the dictionary of #(\(self.dictSchedPatientLocItems.count)) 'dictSchedPatientLocItems' item(s) to gather 'BackupVisit' information...")

            let cPFTherapistTotalTIDs:Int = self.dictSchedPatientLocItems.count
            var cPFTherapistParseTIDs:Int = 0

            for (sPFTherapistParseTID, listOfScheduledPatientLocationItems) in self.dictSchedPatientLocItems
            {

                cPFTherapistParseTIDs += 1

                if (sPFTherapistParseTID.count  < 1 ||
                    sPFTherapistParseTID       == "-N/A-")
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cPFTherapistParseTIDs)) 'sPFTherapistParseTID' - the 'tid' field is nil or '-N/A-' - Warning!")

                    continue

                }

                if (listOfScheduledPatientLocationItems.count < 1)
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cPFTherapistTotalTIDs)) 'sPFTherapistParseTID' of [\(sPFTherapistParseTID)] - the 'listOfScheduledPatientLocationItems' field is nil or the count is less than 1 - Warning!")

                    continue

                }

                var cPFPatientParsePIDs:Int = 0 

                for scheduledPatientLocationItem in listOfScheduledPatientLocationItems
                {

                    cPFPatientParsePIDs += 1 

                    if (scheduledPatientLocationItem.iPid < 1)
                    {
                    
                        self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cPFPatientParsePIDs)) for 'sPFTherapistParseTID' of [\(sPFTherapistParseTID)] - the patient 'pid' field ('iPid') is < 1 - Warning!")

                        continue
                    
                    }
                    
                    // Issue a PFQuery for the 'BackupVisit' class...

                    self.xcgLogMsg("\(sCurrMethodDisp) Calling PFQuery to construct an instance for the 'BackupVisit' class...")

                    let pfQueryBackupVisit:PFQuery = PFQuery(className:"BackupVisit")

                    self.xcgLogMsg("\(sCurrMethodDisp) Called  PFQuery to construct an instance for the 'BackupVisit' class...")

                    // Set the query parameter(s) and issue the 'find' then (possibly) iterate the result(s)...

                    self.xcgLogMsg("\(sCurrMethodDisp) Returned query of 'pfQueryBackupVisit' is [\(String(describing: pfQueryBackupVisit))]...")

                    do
                    {

                    //  :: From PFQuery Class: 'BackupVisit' ::
                    //
                    //  [Query::{ "pid"            : NumberLong(13556), 
                    //            "billable"       : NumberLong(1), 
                    //            "isTelepractice" : { "$ne" : NumberLong(1) },
                    //            "VDate"          : { "$gt" : "2024-11-10" } }]  // Yields all visit(s) in last 30 day(s) or such...
                    //  [Sort::{"VDate": -1}]                                     // Yields visit(s) newest to oldest (1st one is newest)...

                        self.xcgLogMsg("\(sCurrMethodDisp) Searching for 'pfQueryBackupVisit' Item(s) keyed by 'sPFTherapistParseTID' of [\(sPFTherapistParseTID)] for PID (\(scheduledPatientLocationItem.iPid))...")

                        pfQueryBackupVisit.whereKeyExists("lat")
                        pfQueryBackupVisit.whereKeyExists("long")

                        pfQueryBackupVisit.whereKey("pid",            equalTo:scheduledPatientLocationItem.iPid)
                        pfQueryBackupVisit.whereKey("billable",       equalTo:1)
                        pfQueryBackupVisit.whereKey("isTelepractice", notEqualTo:1)
                        pfQueryBackupVisit.whereKey("VDate",          greaterThan:sCurrentQueryDate)

                        pfQueryBackupVisit.addDescendingOrder("VDate")
                    //  pfQueryBackupVisit.addAscendingOrder("startTime")

                        pfQueryBackupVisit.limit = 1000

                        let listPFBackupVisitObjects:[PFObject]? = try pfQueryBackupVisit.findObjects()

                        if (listPFBackupVisitObjects != nil &&
                            listPFBackupVisitObjects!.count > 0)
                        {

                            self.xcgLogMsg("\(sCurrMethodDisp) Parse - query of 'pfQueryBackupVisit' returned a count of #(\(listPFBackupVisitObjects!.count)) PFObject(s)...")
                            self.xcgLogMsg("\(sCurrMethodDisp) Using the 1st returned 'pfQueryBackupVisit' item...")
                            self.xcgLogMsg("\(sCurrMethodDisp) The entire returned #(\(listPFBackupVisitObjects!.count)) 'pfQueryBackupVisit' item(s) are [\(listPFBackupVisitObjects!)]...")

                            // ------------------------------------------------------------------------------------------------
                            //  >>> Template 1st entry, then search for new Template
                            //  >>>     (if item(s) are available and address == ""),
                            //  >>> to re-Template an item that is address != ""; and posted = 1;...
                            // ------------------------------------------------------------------------------------------------

                            var pfQueryBackupVisitTemplate = listPFBackupVisitObjects![0]

                            if (listPFBackupVisitObjects!.count > 1 &&
                                String(describing: (pfQueryBackupVisitTemplate.object(forKey:"address"))) == "")
                            {

                                for pfBackupVisit in listPFBackupVisitObjects!
                                {

                                    if (String(describing: (pfBackupVisit.object(forKey:"address"))) != "" &&
                                        String(describing: (pfBackupVisit.object(forKey:"posted")))  == "1")
                                    {

                                        pfQueryBackupVisitTemplate = pfBackupVisit
                                        
                                        break;
                                    
                                    }

                                }

                            }

                            scheduledPatientLocationItem.updateScheduledPatientLocationItemFromPFBackupVisit(pfBackupVisit:pfQueryBackupVisitTemplate)

                            if (scheduledPatientLocationItem.sLastVDateAddress == "")
                            {

                                self.xcgLogMsg("\(sCurrMethodDisp) Updating 'scheduledPatientLocationItem' by calling 'updateGeocoderLocation()' for Latitude/Longitude of [\(scheduledPatientLocationItem.sLastVDateLatitude)/\(scheduledPatientLocationItem.sLastVDateLongitude)]...")

                                if (self.jmAppDelegateVisitor!.jmAppCLModelObservable2 != nil)
                                {
                                
                                    let clModelObservable2:CoreLocationModelObservable2 = self.jmAppDelegateVisitor!.jmAppCLModelObservable2!

                                    let _ = clModelObservable2.updateGeocoderLocations(requestID: 1, 
                                                                                       latitude:  Double(scheduledPatientLocationItem.sLastVDateLatitude)!,
                                                                                       longitude: Double(scheduledPatientLocationItem.sLastVDateLongitude)!, 
                                                                                       withCompletionHandler:
                                                                                           { (requestID:Int, dictCurrentLocation:[String:Any]) in

                                                                                               let sStreetAddress:String = String(describing: (dictCurrentLocation["sCurrentLocationName"]       ?? ""))
                                                                                               let sCity:String          = String(describing: (dictCurrentLocation["sCurrentCity"]               ?? ""))
                                                                                               let sState:String         = String(describing: (dictCurrentLocation["sCurrentAdministrativeArea"] ?? ""))
                                                                                               let sZipCode:String       = String(describing: (dictCurrentLocation["sCurrentPostalCode"]         ?? ""))

                                                                                               scheduledPatientLocationItem.sLastVDateAddress = "\(sStreetAddress), \(sCity), \(sState), \(sZipCode)"

                                                                                               self.xcgLogMsg("\(sCurrMethodDisp) Updated 'scheduledPatientLocationItem' for an address of [\(scheduledPatientLocationItem.sLastVDateAddress)] for Latitude/Longitude of [\(scheduledPatientLocationItem.sLastVDateLatitude)/\(scheduledPatientLocationItem.sLastVDateLongitude)]...")

                                                                                           }
                                                                                      )
                                
                                }

                            }

                            self.xcgLogMsg("\(sCurrMethodDisp) Updated an Item 'scheduledPatientLocationItem' of [\(scheduledPatientLocationItem)] (in a List) to the dictionary of 'dictSchedPatientLocItems' item(s) keyed by 'sPFTherapistParseTID' of [\(sPFTherapistParseTID)] for PID (\(scheduledPatientLocationItem.iPid))...")

                        }
                        else
                        {

                            self.xcgLogMsg("\(sCurrMethodDisp) Parse - query of 'pfQueryBackupVisit' returned an 'empty' or nil list of PFObject(s)...")

                        }

                    }
                    catch
                    {

                        self.xcgLogMsg("\(sCurrMethodDisp) Parse - failed execute the query 'pfQueryBackupVisit' - Details: \(error) - Error!")

                    }

                }

            }

        }
        else
        {

            self.xcgLogMsg("\(sCurrMethodDisp) Unable to enumerate the dictionary of 'dictSchedPatientLocItems' item(s) - item(s) count is less than 1 - Warning!")

        }

        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return

    } // End of public func gatherJmAppParsePFQueriesForBackupVisitInBackground().
    
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
    
    public func deepCopyDictPFAdminsDataItems()->Int
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Deep copy the dictionary 'dictPFAdminsDataItems' from here to the 'jmAppParseCoreManager'...

        self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy'ing the dictionary 'dictPFAdminsDataItems' of (\(self.dictPFAdminsDataItems.count)) 'parsePFAdminsDataItem' item(s)...")

        var cDeepCopyPFAdminsDataItems:Int                               = 0 
        var dictDeepCopyPFAdminsDataItems:[String:ParsePFAdminsDataItem] = [String:ParsePFAdminsDataItem]()

        for (_, parsePFAdminsDataItem) in self.dictPFAdminsDataItems
        {

            cDeepCopyPFAdminsDataItems                    += 1
            let newPFAdminsDataItem:ParsePFAdminsDataItem  = ParsePFAdminsDataItem(pfAdminsDataItem:parsePFAdminsDataItem)

            let sPFAdminsParseTID:String = parsePFAdminsDataItem.sPFAdminsParseTID

            if (sPFAdminsParseTID.count  < 1 ||
                sPFAdminsParseTID       == "-N/A-")
            {

                self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' Skipping object #(\(cDeepCopyPFAdminsDataItems)) 'parsePFAdminsDataItem' - the 'tid' field is nil or '-N/A-' - Warning!")

                continue

            }

            dictDeepCopyPFAdminsDataItems[sPFAdminsParseTID] = newPFAdminsDataItem

            self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' Added object #(\(cDeepCopyPFAdminsDataItems)) 'newPFAdminsDataItem' keyed by 'sPFAdminsParseTID' of [\(sPFAdminsParseTID)] to the 'deep copy' dictionary of item(s)...")

        }

        DispatchQueue.main.async
        {

            self.jmAppParseCoreManager.dictPFAdminsDataItems = dictDeepCopyPFAdminsDataItems

            if (dictDeepCopyPFAdminsDataItems.count > 0)
            {

                self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' replaced #(\(dictDeepCopyPFAdminsDataItems.count)) item(s) in the ParseCoreManager 'dictPFAdminsDataItems'...")

            }
            else
            {

                self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' replaced the ParseCoreManager 'dictPFAdminsDataItems' with an 'empty' dictionary - NO item(s) were available...")

            }

        }
        
        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'dictDeepCopyPFAdminsDataItems.count' is (\(dictDeepCopyPFAdminsDataItems.count))...")
  
        return dictDeepCopyPFAdminsDataItems.count

    } // End of func deepCopyDictPFAdminsDataItems()->Int.
    
    public func deepCopyDictTherapistTidXref()->Int
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Deep copy the dictionary 'dictTherapistTidXref' from here to the 'jmAppParseCoreManager'...

        self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy'ing the dictionary 'dictTherapistTidXref' of (\(self.dictTherapistTidXref.count)) 'string' item(s)...")

        var cDeepCopyTherapistTidXrefItems:Int                = 0 
        var dictDeepCopyTherapistTidXrefItems:[String:String] = [String:String]()

        for (sTherapistTidXrefKey, sTherapistTidXrefValue) in self.dictTherapistTidXref
        {

            cDeepCopyTherapistTidXrefItems       += 1
            let sNewTherapistTidXrefKey:String    = sTherapistTidXrefKey
            let sNewTherapistTidXrefValue:String  = sTherapistTidXrefValue

            if (sNewTherapistTidXrefKey.count < 1)
            {

                self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' Skipping object #(\(cDeepCopyTherapistTidXrefItems)) - the 'key' field is nil - Warning!")

                continue

            }

            dictDeepCopyTherapistTidXrefItems[sNewTherapistTidXrefKey] = sNewTherapistTidXrefValue

            self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' Added referance #(\(cDeepCopyTherapistTidXrefItems)) keyed by 'sNewTherapistTidXrefKey' of [\(sNewTherapistTidXrefKey)] to the 'deep copy' dictionary of item(s)...")

        }

        DispatchQueue.main.async
        {

            self.jmAppParseCoreManager.dictTherapistTidXref = dictDeepCopyTherapistTidXrefItems

            if (dictDeepCopyTherapistTidXrefItems.count > 0)
            {

                self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' replaced #(\(dictDeepCopyTherapistTidXrefItems.count)) item(s) in the ParseCoreManager 'dictTherapistTidXref'...")

            }
            else
            {

                self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' replaced the ParseCoreManager 'dictTherapistTidXref' with an 'empty' dictionary - NO item(s) were available...")

            }

        }

        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'dictDeepCopyTherapistTidXrefItems.count' is (\(dictDeepCopyTherapistTidXrefItems.count))...")
  
        return dictDeepCopyTherapistTidXrefItems.count

    } // End of func deepCopyDictTherapistTidXref()->Int.
    
    public func deepCopyDictPFTherapistFileItems()->Int
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Deep copy the dictionary 'dictPFTherapistFileItems' from here to the 'jmAppParseCoreManager'...
        
        self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy'ing the dictionary 'dictPFTherapistFileItems' of (\(self.dictPFTherapistFileItems.count)) 'pfTherapistFileItem' item(s)...")

        var cDeepCopyPFTherapistFileItems:Int                               = 0 
        var dictDeepCopyPFTherapistFileItems:[Int:ParsePFTherapistFileItem] = [Int:ParsePFTherapistFileItem]()

        for (iPFTherapistFileTID, pfTherapistFileItem) in self.dictPFTherapistFileItems
        {

            cDeepCopyPFTherapistFileItems                            += 1
            let iNewPFTherapistFileTID:Int                            = iPFTherapistFileTID
            let newPFTherapistFileItem:ParsePFTherapistFileItem       = ParsePFTherapistFileItem(pfTherapistFileItem:pfTherapistFileItem)
            dictDeepCopyPFTherapistFileItems[iNewPFTherapistFileTID]  = newPFTherapistFileItem

            self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' Added object #(\(cDeepCopyPFTherapistFileItems)) 'newPFTherapistFileItem' keyed by 'iNewPFTherapistFileTID' of (\(iNewPFTherapistFileTID)) to the 'deep copy' dictionary of item(s)...")

        }

        DispatchQueue.main.async
        {

            self.jmAppParseCoreManager.dictPFTherapistFileItems = dictDeepCopyPFTherapistFileItems

            if (dictDeepCopyPFTherapistFileItems.count > 0)
            {

                self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' replaced #(\(dictDeepCopyPFTherapistFileItems.count)) item(s) in the ParseCoreManager 'dictPFTherapistFileItems'...")

            }
            else
            {

                self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' replaced the ParseCoreManager 'dictPFTherapistFileItems' with an 'empty' dictionary - NO item(s) were available...")

            }

        }

        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'dictDeepCopyPFTherapistFileItems.count' is (\(dictDeepCopyPFTherapistFileItems.count))...")
  
        return dictDeepCopyPFTherapistFileItems.count

    } // End of func deepCopyDictPFTherapistFileItems()->Int.
    
    public func deepCopyDictSchedPatientLocItems()->Int
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Deep copy the dictionary 'dictSchedPatientLocItems' from here to the 'jmAppParseCoreManager'...

        self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy'ing the dictionary 'dictSchedPatientLocItems' of (\(self.dictSchedPatientLocItems.count)) ['scheduledPatientLocationItem'] item(s)...")

        var cDeepCopySchedPatientLocItems:Int                                                 = 0 
        var dictDeepCopyScheduledPatientLocationItems:[String:[ScheduledPatientLocationItem]] = [String:[ScheduledPatientLocationItem]]()

        for (sPFTherapistTID, listScheduledPatientLocationItems) in self.dictSchedPatientLocItems
        {

            cDeepCopySchedPatientLocItems += 1
            let sNewPFTherapistTID:String  = sPFTherapistTID

            if (sNewPFTherapistTID.count < 1)
            {

                self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' Skipping object #(\(cDeepCopySchedPatientLocItems)) - the 'sNewPFTherapistTID' <key> field is nil - Warning!")

                continue

            }

            self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy'ing the list of (\(listScheduledPatientLocationItems.count)) 'listScheduledPatientLocationItems' item(s)...")

            var listNewScheduledPatientLocationItems:[ScheduledPatientLocationItem] = [ScheduledPatientLocationItem]()

            for scheduledPatientLocationItem in listScheduledPatientLocationItems
            {

                let newScheduledPatientLocationItem:ScheduledPatientLocationItem = ScheduledPatientLocationItem(scheduledPatientLocationItem:scheduledPatientLocationItem)

                listNewScheduledPatientLocationItems.append(newScheduledPatientLocationItem)

            }

            dictDeepCopyScheduledPatientLocationItems[sNewPFTherapistTID] = listNewScheduledPatientLocationItems

            self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' Added list #(\(cDeepCopySchedPatientLocItems)) of (\(listScheduledPatientLocationItems.count)) 'listNewScheduledPatientLocationItems' keyed by 'sNewPFTherapistTID' of [\(sNewPFTherapistTID)] to the 'deep copy' dictionary of item(s)...")

        }

        DispatchQueue.main.async
        {

            self.jmAppParseCoreManager.dictSchedPatientLocItems = dictDeepCopyScheduledPatientLocationItems

            if (dictDeepCopyScheduledPatientLocationItems.count > 0)
            {

                self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' replaced #(\(dictDeepCopyScheduledPatientLocationItems.count)) item(s) in the ParseCoreManager 'dictSchedPatientLocItems'...")

            }
            else
            {

                self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' replaced the ParseCoreManager 'dictSchedPatientLocItems' with an 'empty' dictionary - NO item(s) were available...")

            }

        }

        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'dictDeepCopyScheduledPatientLocationItems.count' is (\(dictDeepCopyScheduledPatientLocationItems.count))...")
  
        return dictDeepCopyScheduledPatientLocationItems.count

    } // End of func deepCopyDictSchedPatientLocItems()->Int.
    
    public func deepCopyListPFCscDataItems()->Int
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Deep copy the list 'listPFCscDataItems' from here to the 'jmAppParseCoreManager'...

        self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy'ing the list 'listPFCscDataItems' of (\(self.listPFCscDataItems.count)) ['pfCscDataItem'] item(s)...")

        var cDeepCopyPFCscDataItems:Int                     = 0 
        var listDeepCopyPFCscDataItems:[ParsePFCscDataItem] = [ParsePFCscDataItem]()

        for pfCscDataItem in self.listPFCscDataItems
        {

            cDeepCopyPFCscDataItems                 += 1
            let newPFCscDataItem:ParsePFCscDataItem  = ParsePFCscDataItem(pfCscDataItem:pfCscDataItem)

            listDeepCopyPFCscDataItems.append(newPFCscDataItem)

            self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' Added object #(\(cDeepCopyPFCscDataItems)) 'newPFCscDataItem' of [\(newPFCscDataItem)] to the 'deep copy' list of item(s)...")

        }

        DispatchQueue.main.async
        {

            self.jmAppParseCoreManager.listPFCscDataItems = listDeepCopyPFCscDataItems

            if (listDeepCopyPFCscDataItems.count > 0)
            {

                self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' replaced #(\(listDeepCopyPFCscDataItems.count)) item(s) in the ParseCoreManager 'listPFCscDataItems'...")

            }
            else
            {

                self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' replaced the ParseCoreManager 'listPFCscDataItems' with an 'empty' list - NO item(s) were available...")

            }

            // Kick the 'cPFCscObjectsRefresh' count to force any SwiftUI display(s) to refresh...

            self.jmAppParseCoreManager.cPFCscObjects         = listDeepCopyPFCscDataItems.count
            self.jmAppParseCoreManager.cPFCscObjectsRefresh += 1

        }

        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'listDeepCopyPFCscDataItems.count' is (\(listDeepCopyPFCscDataItems.count))...")
  
        return listDeepCopyPFCscDataItems.count

    } // End of func deepCopyListPFCscDataItems()->Int.
    
    public func deepCopyListPFCscNameItems()->Int
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Deep copy the list 'listPFCscNameItems' from here to the 'jmAppParseCoreManager'...

        self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy'ing the list 'listPFCscNameItems' of (\(self.listPFCscNameItems.count)) [String] item(s)...")

        var cDeepCopyPFCscNameItems:Int         = 0 
        var listDeepCopyPFCscNameItems:[String] = [String]()

        for sPFCscParseName in self.listPFCscNameItems
        {

            cDeepCopyPFCscNameItems      += 1
            let sNewPFCscNameItem:String  = sPFCscParseName

            listDeepCopyPFCscNameItems.append(sNewPFCscNameItem)

            self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' Added object #(\(cDeepCopyPFCscNameItems)) 'sNewPFCscNameItem' of [\(sNewPFCscNameItem)] to the 'deep copy' list of item(s)...")

        }

        DispatchQueue.main.async
        {

            self.jmAppParseCoreManager.listPFCscNameItems = listDeepCopyPFCscNameItems

            if (listDeepCopyPFCscNameItems.count > 0)
            {

                self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' replaced #(\(listDeepCopyPFCscNameItems.count)) item(s) in the ParseCoreManager 'listPFCscNameItems'...")

            }
            else
            {

                self.xcgLogMsg("\(sCurrMethodDisp) 'deep copy' replaced the ParseCoreManager 'listPFCscNameItems' with an 'empty' list - NO item(s) were available...")

            }

        }

        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'listDeepCopyPFCscNameItems.count' is (\(listDeepCopyPFCscNameItems.count))...")
  
        return listDeepCopyPFCscNameItems.count

    } // End of func deepCopyListPFCscNameItems()->Int.
    
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

            for parsePFCscDataItem in self.listPFCscDataItems
            {

                parsePFCscDataItem.displayParsePFCscDataItemToLog()

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
    
}   // End of public class JmAppParseCoreBkgdDataRepo.

