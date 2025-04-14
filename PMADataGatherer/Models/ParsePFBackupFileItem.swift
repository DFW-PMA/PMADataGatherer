//
//  ParsePFBackupFileItem.swift
//  PMADataGatherer
//
//  Created by JustMacApps.net on 04/14/2025.
//  Copyright © JustMacApps 2023-2025. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit
import ParseCore

class ParsePFBackupFileItem: NSObject, Identifiable
{

    struct ClassInfo
    {
        
        static let sClsId        = "ParsePFBackupFileItem"
        static let sClsVers      = "v1.0101"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2025. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    // Item Data field(s):
    
    var id                                                  = UUID()

    var pfBackupFileObjectClonedFrom:ParsePFBackupFileItem? = nil 
    var pfBackupFileObjectClonedTo:ParsePFBackupFileItem?   = nil 

    // ------------------------------------------------------------------------------------------
    //  'pfBackupFileObject' is [<CSC: 0x301e16700, objectId: qpp1fxx68P, localId: (null)> 
    //  {
    //      name        = "Office Ernesto";
    //      lastLocDate = "11/14/24";
    //      lastLocTime = "4:15\U202fPM";
    //      latitude    = "32.83285140991211";
    //      longitude   = "-97.071533203125";
    //  }]...
    // ------------------------------------------------------------------------------------------

    var pfBackupFileObject:PFObject?                        = nil

    // ----------------------------------------------------------------------------------------------------------------
    //  TYPE of 'pfBackupFileObject'                 is [PFObject]         - value is [<CSC: 0x302ee1080, objectId: ...
    //  TYPE of 'pfBackupFileObject.parseClassName'  is [String]           - value is [CSC]...
    //  TYPE of 'pfBackupFileObject.objectId'        is [Optional<String>] - value is [Optional("dztxUrBZLr")]...
    //  TYPE of 'pfBackupFileObject.createdAt'       is [Optional<Date>]   - value is [Optional(2024-11-13 17:13:57 +0000)]...
    //  TYPE of 'pfBackupFileObject.updatedAt'       is [Optional<Date>]   - value is [Optional(2024-11-14 22:30:00 +0000)]...
    //  TYPE of 'pfBackupFileObject.acl'             is [Optional<PFACL>]  - value is [nil]...
    //  TYPE of 'pfBackupFileObject.isDataAvailable' is [Bool]             - value is [true]...
    //  TYPE of 'pfBackupFileObject.isDirty'         is [Bool]             - value is [false]...
    //  TYPE of 'pfBackupFileObject.allKeys'         is [Array<String>]    - value is [["lastLocTime", "latitude", ...
    // ----------------------------------------------------------------------------------------------------------------

    // Item 'discrete' field(s):

    var sPFCscParseClassName:String                         = ""
    var sPFCscParseObjectId:String?                         = nil
    var datePFCscParseCreatedAt:Date?                       = nil
    var datePFCscParseUpdatedAt:Date?                       = nil
    var aclPFCscParse:PFACL?                                = nil
    var bPFCscParseIsDataAvailable:Bool                     = false
    var bPFCscParseIdDirty:Bool                             = false
    var sPFCscParseAllKeys:[String]                         = []

    // ----------------------------------------------------------------------------------------------------------------
    //     TYPE of 'pfBackupFileObject[name]'        is [Optional<Any>] - value is [Optional(Mihal Lasky)]...
    //     TYPE of 'pfBackupFileObject[lastLocDate]' is [Optional<Any>] - value is [Optional(11/14/24)]...
    //     TYPE of 'pfBackupFileObject[lastLocTime]' is [Optional<Any>] - value is [Optional(4:30 PM)]...
    //     TYPE of 'pfBackupFileObject[latitude]'    is [Optional<Any>] - value is [Optional(32.77201080322266)]...
    //     TYPE of 'pfBackupFileObject[longitude]'   is [Optional<Any>] - value is [Optional(-96.5831298828125)]...
    // ----------------------------------------------------------------------------------------------------------------

    // Item 'keyed' field(s):

    var sTid:String                                         = "-1" // From 'PFQuery::BackupVisit["tidString"]'
    var iTid:Int                                            = -1   // From 'PFQuery::BackupVisit["tid"]'

    var sPid:String                                         = "-1" // Converted from 'iPid <Int>'...
    var iPid:Int                                            = -1   // From 'PFQuery::PatientCalDay["pid"]' <Int>

    var sLastVDate:String                                   = ""   // From 'PFQuery::BackupVisit["VDate"]'
    var sLastVDateType:String                               = "-1" // From 'PFQuery::BackupVisit["type"]'
    var iLastVDateType:Int                                  = -1   // Converted from 'sLastVDateType <String>'...
    var sLastVDateLatitude:String                           = ""   // From 'PFQuery::BackupVisit["lat"]'
    var sLastVDateLongitude:String                          = ""   // From 'PFQuery::BackupVisit["long"]'
    var sLastVDateAddress:String                            = ""   // From 'PFQuery::BackupVisit["address"]'

    // ----------------------------------------------------------------------------------------------------------------
    //  TYPE of 'pfBackupFileObjectLatitude'     is [Optional<Any>] - value is [Optional(32.77201080322266)]...
    //  TYPE of 'pfBackupFileObjectLongitude'    is [Optional<Any>] - value is [Optional(-96.5831298828125)]...
    //  TYPE of 'spfBackupFileObjectLatitude'    is [String]        - value is [32.77201080322266]...
    //  TYPE of 'spfBackupFileObjectLongitude'   is [String]        - value is [-96.5831298828125]...
    //  TYPE of 'dblpfBackupFileObjectLatitude'  is [Double]        - value is [32.77201080322266]...
    //  TYPE of 'dblpfBackupFileObjectLongitude' is [Double]        - value is [-96.5831298828125]...
    //  TYPE of 'dblConvertedLatitude'           is [Double]        - value is [32.77201080322266]...
    //  TYPE of 'dblConvertedLongitude'          is [Double]        - value is [-96.5831298828125]...
    //  TYPE of 'sCurrentLocationName'           is [String]        - value is [-N/A-]...
    //  TYPE of 'sCurrentCity'                   is [String]        - value is [-N/A-]...
    // ----------------------------------------------------------------------------------------------------------------

    // Item 'calculated'/'converted'/'look-up'/'computed' field(s):

    var pfBackupFileObjectLatitude:Any?                     = nil
    var pfBackupFileObjectLongitude:Any?                    = nil

    var spfBackupFileObjectLatitude:String                  = "0.00000"
    var spfBackupFileObjectLongitude:String                 = "0.00000"

    var dblpfBackupFileObjectLatitude:Double                = 0.00000
    var dblpfBackupFileObjectLongitude:Double               = 0.00000

    var dblConvertedLatitude:Double                         = 0.00000
    var dblConvertedLongitude:Double                        = 0.00000

    // Item address 'lookup' flag(s) and field(s):

    var bCurrentAddessLookupScheduled:Bool                  = false
    var bCurrentAddessLookupComplete:Bool                   = false

    var sCurrentLocationName:String                         = ""
    var sCurrentCity:String                                 = ""
    var sCurrentCountry:String                              = ""
    var sCurrentPostalCode:String                           = ""
    var sCurrentTimeZone:String                             = ""

    // Item coordinate and position 'computed' field(s):

    var clLocationCoordinate2D:CLLocationCoordinate2D
    {

        return CLLocationCoordinate2D(latitude: self.dblConvertedLatitude, 
                                      longitude:self.dblConvertedLongitude)

    }

    var mapCoordinateRegion:MKCoordinateRegion
    {

        return MKCoordinateRegion(center:self.clLocationCoordinate2D,               
                                    span:MKCoordinateSpan(latitudeDelta: 0.05, 
                                                          longitudeDelta:0.05))

    }

    var mapPosition:MapCameraPosition
    {

        return MapCameraPosition.region(self.mapCoordinateRegion)

    }

    // App Data field(s):

    var jmAppDelegateVisitor:JmAppDelegateVisitor           = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    
    override init()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        super.init()

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of override init().

    convenience init(pfBackupFile:ParsePFBackupFileItem)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
  
        self.init()
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter is 'pfCscDataItem' is [\(pfCscDataItem)]...")

        // Finish the 'convenience' setup of field(s)...

        self.init(bDeepCopyIsAnOverlay:false, pfBackupFile:pfBackupFile)

        // Exit:
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return
  
    }   // End of convenience init(pfCscDataItem:ParsePFBackupFileItem).

    convenience init(bDeepCopyIsAnOverlay:Bool, pfBackupFile:ParsePFBackupFileItem)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
  
        self.init()
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter is 'pfBackupFile' is [\(pfBackupFile)]...")

        // Finish the 'convenience' setup of field(s)...

        self.overlayPFBackupFileItemWithAnotherPFBackupFileItem(pfBackupFile:pfBackupFile)

        if (bDeepCopyIsAnOverlay == false)
        {
        
            self.pfBackupFileObjectClonedFrom          = pfBackupFile 
            self.pfBackupFileObjectClonedTo            = self 

        //  pfCscDataItem.pfBackupFileObjectClonedFrom = nil
            pfCscDataItem.pfBackupFileObjectClonedTo   = self
        
        }

        // Check if the 'current' Location data copied was 'blank'...

        if (self.sCurrentLocationName.count < 1 ||
            self.sCurrentCity.count         < 1)
        {
        
            self.xcgLogMsg("\(sCurrMethodDisp) Intermediate <dup copy 'init'> <PFBackupFile> - Copied 'self.sCurrentLocationName' is [\(self.sCurrentLocationName)] and 'self.sCurrentCity' is [\(self.sCurrentCity)] - 1 or both are 'blank' - 'pfCscDataItem.sCurrentLocationName' is [\(pfCscDataItem.sCurrentLocationName)] and 'pfCscDataItem.sCurrentCity' is [\(pfCscDataItem.sCurrentCity)] - Warning!")
        
        }

        // Trace the 'clone' From/To fields in both objects...

        self.xcgLogMsg("\(sCurrMethodDisp) Intermediate <dup copy 'init'> <PFBackupFile> - From/To 'self.pfBackupFileObjectClonedFrom' is [\(String(describing: self.pfBackupFileObjectClonedFrom))] and 'self.pfBackupFileObjectClonedTo' is [\(String(describing: self.pfBackupFileObjectClonedTo))] - 'pfCscDataItem.pfBackupFileObjectClonedFrom' is [\(String(describing: pfCscDataItem.pfBackupFileObjectClonedFrom))] and 'pfCscDataItem.pfBackupFileObjectClonedTo' is [\(String(describing: pfCscDataItem.pfBackupFileObjectClonedTo))]...")

        // Exit:
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return
  
    }   // End of convenience init(bDeepCopyIsAnOverlay:Bool, pfCscDataItem:ParsePFBackupFileItem).

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
        asToString.append("'self': [\(String(describing: self))],")
        asToString.append("'id': [\(String(describing: self.id))],")
        asToString.append("'pfBackupFileObjectClonedFrom': [\(String(describing: self.pfBackupFileObjectClonedFrom))],")
        asToString.append("'pfBackupFileObjectClonedTo': [\(String(describing: self.pfBackupFileObjectClonedTo))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'sPFCscParseClassName': [\(String(describing: self.sPFCscParseClassName))],")
        asToString.append("'sPFCscParseObjectId': [\(String(describing: self.sPFCscParseObjectId))],")
        asToString.append("'datePFCscParseCreatedAt': [\(String(describing: self.datePFCscParseCreatedAt))],")
        asToString.append("'datePFCscParseUpdatedAt': [\(String(describing: self.datePFCscParseUpdatedAt))],")
        asToString.append("'aclPFCscParse': [\(String(describing: self.aclPFCscParse))],")
        asToString.append("'bPFCscParseIsDataAvailable': [\(String(describing: self.bPFCscParseIsDataAvailable))],")
        asToString.append("'bPFCscParseIdDirty': [\(String(describing: self.bPFCscParseIdDirty))],")
        asToString.append("'sPFCscParseAllKeys': [\(String(describing: self.sPFCscParseAllKeys))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'sTid': [\(String(describing: self.sTid))],")
        asToString.append("'iTid': (\(String(describing: self.iTid))),")
        asToString.append("'sPid': [\(String(describing: self.sPid))],")
        asToString.append("'iPid': (\(String(describing: self.iPid))),")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'sLastVDate': [\(String(describing: self.sLastVDate))],")
        asToString.append("'sLastVDateType': [\(String(describing: self.sLastVDateType))],")
        asToString.append("'iLastVDateType': (\(String(describing: self.iLastVDateType))),")
        asToString.append("'sLastVDateLatitude': [\(String(describing: self.sLastVDateLatitude))],")
        asToString.append("'sLastVDateLongitude': [\(String(describing: self.sLastVDateLongitude))],")
        asToString.append("'sLastVDateAddress': [\(String(describing: self.sLastVDateAddress))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'pfBackupFileObjectLatitude': [\(String(describing: self.pfBackupFileObjectLatitude))],")
        asToString.append("'pfBackupFileObjectLongitude': [\(String(describing: self.pfBackupFileObjectLongitude))],")
        asToString.append("'spfBackupFileObjectLatitude': [\(String(describing: self.spfBackupFileObjectLatitude))],")
        asToString.append("'spfBackupFileObjectLongitude': [\(String(describing: self.spfBackupFileObjectLongitude))],")
        asToString.append("'dblpfBackupFileObjectLatitude': [\(String(describing: self.dblpfBackupFileObjectLatitude))],")
        asToString.append("'dblpfBackupFileObjectLongitude': [\(String(describing: self.dblpfBackupFileObjectLongitude))],")
        asToString.append("'dblConvertedLatitude': [\(String(describing: self.dblConvertedLatitude))],")
        asToString.append("'dblConvertedLongitude': [\(String(describing: self.dblConvertedLongitude))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'bCurrentAddessLookupScheduled': [\(String(describing: self.bCurrentAddessLookupScheduled))],")
        asToString.append("'bCurrentAddessLookupComplete': [\(String(describing: self.bCurrentAddessLookupComplete))],")
        asToString.append("'sCurrentLocationName': [\(String(describing: self.sCurrentLocationName))],")
        asToString.append("'sCurrentCity': [\(String(describing: self.sCurrentCity))],")
        asToString.append("'sCurrentCountry': [\(String(describing: self.sCurrentCountry))],")
        asToString.append("'sCurrentPostalCode': [\(String(describing: self.sCurrentPostalCode))],")
        asToString.append("'sCurrentTimeZone': [\(String(describing: self.sCurrentTimeZone))],")
    //  asToString.append("],")
    //  asToString.append("[")
    //  asToString.append("'jmAppDelegateVisitor': [\(self.jmAppDelegateVisitor.toString())]")
        asToString.append("],")
        asToString.append("]")

        let sContents:String = "{"+(asToString.joined(separator: ""))+"}"

        return sContents

    }   // End of public func toString().

    public func displayParsePFBackupFileItemToLog()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Display the various field(s) of this object in the Log...

        self.xcgLogMsg("\(sCurrMethodDisp) 'self'                           is [\(String(describing: self))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'id'                             is [\(String(describing: self.id))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'pfBackupFileObjectClonedFrom'   is [\(String(describing: self.pfBackupFileObjectClonedFrom))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'pfBackupFileObjectClonedTo'     is [\(String(describing: self.pfBackupFileObjectClonedTo))]...")

        self.xcgLogMsg("\(sCurrMethodDisp) 'sPFCscParseClassName'           is [\(String(describing: self.sPFCscParseClassName))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sPFCscParseObjectId'            is [\(String(describing: self.sPFCscParseObjectId))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'datePFCscParseCreatedAt'        is [\(String(describing: self.datePFCscParseCreatedAt))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'datePFCscParseUpdatedAt'        is [\(String(describing: self.datePFCscParseUpdatedAt))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'aclPFCscParse'                  is [\(String(describing: self.aclPFCscParse))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'bPFCscParseIsDataAvailable'     is [\(String(describing: self.bPFCscParseIsDataAvailable))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'bPFCscParseIdDirty'             is [\(String(describing: self.bPFCscParseIdDirty))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sPFCscParseAllKeys'             is [\(String(describing: self.sPFCscParseAllKeys))]...")

        self.xcgLogMsg("\(sCurrMethodDisp) 'sTid'                           is [\(String(describing: self.sTid))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'iTid'                           is (\(String(describing: self.iTid)))...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sPid'                           is [\(String(describing: self.sPid))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'iPid'                           is (\(String(describing: self.iPid)))...")

        self.xcgLogMsg("\(sCurrMethodDisp) 'sLastVDate'                     is [\(String(describing: self.sLastVDate))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sLastVDateType'                 is [\(String(describing: self.sLastVDateType))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'iLastVDateType'                 is (\(String(describing: self.iLastVDateType)))...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sLastVDateLatitude'             is [\(String(describing: self.sLastVDateLatitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sLastVDateLongitude'            is [\(String(describing: self.sLastVDateLongitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sLastVDateAddress'              is [\(String(describing: self.sLastVDateAddress))]...")

        self.xcgLogMsg("\(sCurrMethodDisp) 'pfBackupFileObjectLatitude'     is [\(String(describing: self.pfBackupFileObjectLatitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'pfBackupFileObjectLongitude'    is [\(String(describing: self.pfBackupFileObjectLongitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'spfBackupFileObjectLatitude'    is [\(String(describing: self.spfBackupFileObjectLatitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'spfBackupFileObjectLongitude'   is [\(String(describing: self.spfBackupFileObjectLongitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'dblpfBackupFileObjectLatitude'  is [\(String(describing: self.dblpfBackupFileObjectLatitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'dblpfBackupFileObjectLongitude' is [\(String(describing: self.dblpfBackupFileObjectLongitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'dblConvertedLatitude'           is [\(String(describing: self.dblConvertedLatitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'dblConvertedLongitude'          is [\(String(describing: self.dblConvertedLongitude))]...")

        self.xcgLogMsg("\(sCurrMethodDisp) 'bCurrentAddessLookupScheduled'  is [\(String(describing: self.bCurrentAddessLookupScheduled))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'bCurrentAddessLookupComplete'   is [\(String(describing: self.bCurrentAddessLookupComplete))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sCurrentLocationName'           is [\(String(describing: self.sCurrentLocationName))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sCurrentCity'                   is [\(String(describing: self.sCurrentCity))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sCurrentCountry'                is [\(String(describing: self.sCurrentCountry))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sCurrentPostalCode'             is [\(String(describing: self.sCurrentPostalCode))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sCurrentTimeZone'               is [\(String(describing: self.sCurrentTimeZone))]...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of public func displayParsePFBackupFileItemToLog().

    public func updateScheduledPatientLocationItemFromPFBackupVisit(pfBackupVisit:PFObject)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
  
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter is 'pfBackupVisit.VDate' is [\(String(describing: pfBackupVisit.object(forKey:"VDate")))] <for 'tid' of [\(String(describing: pfBackupVisit.object(forKey:"tid")))]>...")

        // Handle the 'update' (setup) of field(s)...
  
        self.sLastVDate          = String(describing: (pfBackupVisit.object(forKey:"VDate")   ?? ""))
        self.sLastVDateType      = String(describing: (pfBackupVisit.object(forKey:"type")    ?? "-1"))
        self.iLastVDateType      = Int(self.sLastVDateType)!
        self.sLastVDateAddress   = String(describing: (pfBackupVisit.object(forKey:"address") ?? ""))
        self.sLastVDateLatitude  = String(describing: (pfBackupVisit.object(forKey:"lat")     ?? ""))
        self.sLastVDateLongitude = String(describing: (pfBackupVisit.object(forKey:"long")    ?? ""))

        // Exit:
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return
  
    }   // End of public func updateScheduledPatientLocationItemFromPFBackupVisit(pfBackupVisit:PFObject).

    public func updateParsePFBackupFileItemFromPFObject(pfBackupVisit:PFObject)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'self' is [\(String(describing: self))] - parameter 'pfBackupFileObject' is [\(String(describing: pfBackupFileObject))]...")

        // Assign the various field(s) of this object from the supplied PFObject...

        self.sPFCscParseClassName          = pfBackupFileObject.parseClassName
        self.sPFCscParseObjectId           = pfBackupFileObject.objectId  != nil ? pfBackupFileObject.objectId!  : ""
        self.datePFCscParseCreatedAt       = pfBackupFileObject.createdAt != nil ? pfBackupFileObject.createdAt! : nil
        self.datePFCscParseUpdatedAt       = pfBackupFileObject.updatedAt != nil ? pfBackupFileObject.updatedAt! : nil
        self.aclPFCscParse                 = pfBackupFileObject.acl
        self.bPFCscParseIsDataAvailable    = pfBackupFileObject.isDataAvailable
        self.bPFCscParseIdDirty            = pfBackupFileObject.isDirty
        self.sPFCscParseAllKeys            = pfBackupFileObject.allKeys


  
        self.sLastVDate          = String(describing: (pfBackupVisit.object(forKey:"VDate")   ?? ""))
        self.sLastVDateType      = String(describing: (pfBackupVisit.object(forKey:"type")    ?? "-1"))
        self.iLastVDateType      = Int(self.sLastVDateType)!
        self.sLastVDateAddress   = String(describing: (pfBackupVisit.object(forKey:"address") ?? ""))
        self.sLastVDateLatitude  = String(describing: (pfBackupVisit.object(forKey:"lat")     ?? ""))
        self.sLastVDateLongitude = String(describing: (pfBackupVisit.object(forKey:"long")    ?? ""))






        self.sPFCscParseName               = String(describing: pfBackupFileObject.object(forKey:"name")!)
        self.sPFCscParseLastLocDate        = String(describing: (pfBackupFileObject.object(forKey:"lastLocDate") ?? ""))
        self.sPFCscParseLastLocTime        = String(describing: (pfBackupFileObject.object(forKey:"lastLocTime") ?? "")).lowercased()
        self.sPFCscParseLastLatitude       = String(describing: (pfBackupFileObject.object(forKey:"latitude")    ?? ""))
        self.sPFCscParseLastLongitude      = String(describing: (pfBackupFileObject.object(forKey:"longitude")   ?? ""))

        self.pfBackupFileObjectLatitude           = (pfBackupFileObject.object(forKey:"latitude"))  != nil ? pfBackupFileObject.object(forKey:"latitude")  : nil
        self.pfBackupFileObjectLongitude          = (pfBackupFileObject.object(forKey:"longitude")) != nil ? pfBackupFileObject.object(forKey:"longitude") : nil
        self.spfBackupFileObjectLatitude          = String(describing: self.pfBackupFileObjectLatitude!)
        self.spfBackupFileObjectLongitude         = String(describing: self.pfBackupFileObjectLongitude!)
        self.dblpfBackupFileObjectLatitude        = Double(self.spfBackupFileObjectLatitude)  ?? 0.0
        self.dblpfBackupFileObjectLongitude       = Double(self.spfBackupFileObjectLongitude) ?? 0.0
        self.dblConvertedLatitude          = Double(String(describing: pfBackupFileObject.object(forKey:"latitude")!))  ?? 0.0
        self.dblConvertedLongitude         = Double(String(describing: pfBackupFileObject.object(forKey:"longitude")!)) ?? 0.0
        
        self.bCurrentAddessLookupScheduled = false
        self.bCurrentAddessLookupComplete  = false

        self.sCurrentLocationName          = ""
        self.sCurrentCity                  = ""
        self.sCurrentCountry               = ""
        self.sCurrentPostalCode            = ""
        self.sCurrentTimeZone              = ""

        self.resolveLocationAndAddress()

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of public func constructParsePFBackupFileItemFromPFObject(idpfBackupFileObject:Int, pfBackupFileObject:PFObject).

    public func overlayPFCscDataItemWithAnotherPFCscDataItem(pfCscDataItem:ParsePFBackupFileItem)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
  
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'self' is [\(String(describing: self))] - parameter is 'pfCscDataItem' is [\(pfCscDataItem)]...")

        // Finish the 'overlay' update of field(s)...

        self.idpfBackupFileObject                  = pfCscDataItem.idpfBackupFileObject               

    //  'Object' From/To update does NOT occur in an 'overlay'...
    //
    //  if (bDeepCopyIsAnOverlay == false)
    //  {
    //  
    //      self.pfBackupFileObjectClonedFrom          = pfCscDataItem 
    //      self.pfBackupFileObjectClonedTo            = nil 
    //
    //      pfCscDataItem.pfBackupFileObjectClonedFrom = nil
    //      pfCscDataItem.pfBackupFileObjectClonedTo   = self
    //  
    //  }
    //
    //  self.pfBackupFileObjectClonedFrom          = pfCscDataItem 
    //  self.pfBackupFileObjectClonedTo            = nil 
    //
    //  pfCscDataItem.pfBackupFileObjectClonedFrom = nil
    //  pfCscDataItem.pfBackupFileObjectClonedTo   = self

        self.pfBackupFileObject                    = pfCscDataItem.pfBackupFileObject                 
        
        self.sPFCscParseClassName           = pfCscDataItem.sPFCscParseClassName        
        self.sPFCscParseObjectId            = pfCscDataItem.sPFCscParseObjectId         
        self.datePFCscParseCreatedAt        = pfCscDataItem.datePFCscParseCreatedAt     
        self.datePFCscParseUpdatedAt        = pfCscDataItem.datePFCscParseUpdatedAt     
        self.aclPFCscParse                  = pfCscDataItem.aclPFCscParse               
        self.bPFCscParseIsDataAvailable     = pfCscDataItem.bPFCscParseIsDataAvailable  
        self.bPFCscParseIdDirty             = pfCscDataItem.bPFCscParseIdDirty          
        self.sPFCscParseAllKeys             = pfCscDataItem.sPFCscParseAllKeys          
        
        self.sPFCscParseName                = pfCscDataItem.sPFCscParseName             
        self.sPFCscParseLastLocDate         = pfCscDataItem.sPFCscParseLastLocDate      
        self.sPFCscParseLastLocTime         = pfCscDataItem.sPFCscParseLastLocTime      
        self.sPFCscParseLastLatitude        = pfCscDataItem.sPFCscParseLastLatitude     
        self.sPFCscParseLastLongitude       = pfCscDataItem.sPFCscParseLastLongitude    
        
        self.pfBackupFileObjectLatitude            = pfCscDataItem.pfBackupFileObjectLatitude         
        self.pfBackupFileObjectLongitude           = pfCscDataItem.pfBackupFileObjectLongitude        
        self.spfBackupFileObjectLatitude           = pfCscDataItem.spfBackupFileObjectLatitude        
        self.spfBackupFileObjectLongitude          = pfCscDataItem.spfBackupFileObjectLongitude       
        self.dblpfBackupFileObjectLatitude         = pfCscDataItem.dblpfBackupFileObjectLatitude      
        self.dblpfBackupFileObjectLongitude        = pfCscDataItem.dblpfBackupFileObjectLongitude     

        let dblPreviousLatitude:Double      = self.dblConvertedLatitude
        let dblPreviousLongitude:Double     = self.dblConvertedLongitude
        let dblCurrentLatitude:Double       = pfCscDataItem.dblConvertedLatitude
        let dblCurrentLongitude:Double      = pfCscDataItem.dblConvertedLongitude

        self.dblConvertedLatitude           = pfCscDataItem.dblConvertedLatitude        
        self.dblConvertedLongitude          = pfCscDataItem.dblConvertedLongitude       

        self.sPFTherapistParseTID           = pfCscDataItem.sPFTherapistParseTID        

        // If 'self' (current) does NOT have 'important' location data, then copy all of it...

        if (self.sCurrentLocationName.count < 1 ||
            self.sCurrentCity.count         < 1)
        {
        
            self.sCurrentLocationName           = pfCscDataItem.sCurrentLocationName        
            self.sCurrentCity                   = pfCscDataItem.sCurrentCity                
            self.sCurrentCountry                = pfCscDataItem.sCurrentCountry             
            self.sCurrentPostalCode             = pfCscDataItem.sCurrentPostalCode          
            self.sCurrentTimeZone               = pfCscDataItem.sCurrentTimeZone            

            self.bCurrentAddessLookupScheduled  = pfCscDataItem.bCurrentAddessLookupScheduled
            self.bCurrentAddessLookupComplete   = pfCscDataItem.bCurrentAddessLookupComplete
        
        }
        else
        {

            // 'self' (current) has location data, then use latitude/longitude changes to determine the update...

        //  let bLocationLatitudeHasChanged:Bool  = (abs(self.dblConvertedLatitude  - pfCscDataItem.dblConvertedLatitude)  <= .ulpOfOne)
        //  let bLocationLongitudeHasChanged:Bool = (abs(self.dblConvertedLongitude - pfCscDataItem.dblConvertedLongitude) <= .ulpOfOne)

            let bLocationLatitudeHasChanged:Bool  = (abs(dblPreviousLatitude  - dblCurrentLatitude)  > (3 * .ulpOfOne))
            let bLocationLongitudeHasChanged:Bool = (abs(dblPreviousLongitude - dblCurrentLongitude) > (3 * .ulpOfOne))

            if (bLocationLatitudeHasChanged  == true ||
                bLocationLongitudeHasChanged == true)
            {
            
                self.sCurrentLocationName           = pfCscDataItem.sCurrentLocationName        
                self.sCurrentCity                   = pfCscDataItem.sCurrentCity                
                self.sCurrentCountry                = pfCscDataItem.sCurrentCountry             
                self.sCurrentPostalCode             = pfCscDataItem.sCurrentPostalCode          
                self.sCurrentTimeZone               = pfCscDataItem.sCurrentTimeZone            

                self.bCurrentAddessLookupScheduled  = pfCscDataItem.bCurrentAddessLookupScheduled
                self.bCurrentAddessLookupComplete   = pfCscDataItem.bCurrentAddessLookupComplete

                self.xcgLogMsg("\(sCurrMethodDisp) Intermediate <dup 'overlay'> <PFCsc> <location check> - Copied address data since 'bLocationLatitudeHasChanged' is [\(bLocationLatitudeHasChanged)] and/or 'bLocationLongitudeHasChanged' is [\(bLocationLongitudeHasChanged)] <location changed>...")
                self.xcgLogMsg("\(sCurrMethodDisp) Intermediate <dup 'overlay'> <PFCsc> <location check> - Location is [\(dblCurrentLatitude),\(dblCurrentLongitude)] and was [\(dblPreviousLatitude),\(dblPreviousLongitude)]...")

                if (self.sCurrentLocationName.count < 1 ||
                    self.sCurrentCity.count         < 1)
                {
                
                    self.bCurrentAddessLookupScheduled  = false
                    self.bCurrentAddessLookupComplete   = false
                
                }
            
            }
            else
            {
            
                self.xcgLogMsg("\(sCurrMethodDisp) Intermediate <dup 'overlay'> <PFCsc> <location check> - Skipped copying address data since 'bLocationLatitudeHasChanged' is [\(bLocationLatitudeHasChanged)] and 'bLocationLongitudeHasChanged' is [\(bLocationLongitudeHasChanged)] <location has NOT changed>...")
            
            }

        }
        
        // Check if the 'current' Location data copied was 'blank'...

        if (self.sCurrentLocationName.count < 1 ||
            self.sCurrentCity.count         < 1)
        {
        
            self.xcgLogMsg("\(sCurrMethodDisp) Intermediate <dup 'overlay'> <PFCsc> - Copied 'self.sCurrentLocationName' is [\(self.sCurrentLocationName)] and 'self.sCurrentCity' is [\(self.sCurrentCity)] - 1 or both are 'blank' - 'pfCscDataItem.sCurrentLocationName' is [\(pfCscDataItem.sCurrentLocationName)] and 'pfCscDataItem.sCurrentCity' is [\(pfCscDataItem.sCurrentCity)] - Warning!")

            self.resolveLocationAndAddress()

        }

        // Trace the 'clone' From/To fields in both objects...

        self.xcgLogMsg("\(sCurrMethodDisp) Intermediate <dup 'overlay'> <PFCsc> - From/To 'self.pfBackupFileObjectClonedFrom' is [\(String(describing: self.pfBackupFileObjectClonedFrom))] and 'self.pfBackupFileObjectClonedTo' is [\(String(describing: self.pfBackupFileObjectClonedTo))] - 'pfCscDataItem.pfBackupFileObjectClonedFrom' is [\(String(describing: pfCscDataItem.pfBackupFileObjectClonedFrom))] and 'pfCscDataItem.pfBackupFileObjectClonedTo' is [\(String(describing: pfCscDataItem.pfBackupFileObjectClonedTo))]...")

        // Exit:
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return
  
    }   // End of convenience init(pfCscDataItem:ParsePFBackupFileItem).

    public func resolveLocationAndAddress()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        if (self.bCurrentAddessLookupScheduled == true)
        {
        
            self.xcgLogMsg("\(sCurrMethodDisp) Intermediate - bypassing the address 'resolve' - 'self.bCurrentAddessLookupScheduled' is [\(self.bCurrentAddessLookupScheduled)]...")

            // Exit:

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

            return
        
        }

        // Use the Latitude/Longitude values to resolve address...

        if (self.jmAppDelegateVisitor.jmAppCLModelObservable2 != nil)
        {

            let clModelObservable2:CoreLocationModelObservable2 = self.jmAppDelegateVisitor.jmAppCLModelObservable2!

            self.bCurrentAddessLookupScheduled = true
            self.bCurrentAddessLookupComplete  = false
            
        //  let dblDeadlineInterval:Double     = Double((0.5 * Double(self.idpfBackupFileObject)))
        //  let dblDeadlineInterval:Double     = Double((1.2 * Double(self.idpfBackupFileObject)))
        //  let dblDeadlineInterval:Double     = clModelObservable2.requestNextReverseLocationLookupDeadlineInterval()
            let dblDeadlineInterval:Double     = clModelObservable2.requestNextReverseLocationLookupDeadlineInterval(clRevLocType:CLRevLocType.primary)

            DispatchQueue.main.asyncAfter(deadline:(.now() + dblDeadlineInterval))
            {
                self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idpfBackupFileObject)): <closure> Calling 'updateGeocoderLocation()' with 'self' of [\(String(describing: self))] for Latitude/Longitude of [\(self.dblConvertedLatitude)/\(self.dblConvertedLongitude)] for Therapist [\(self.sPFCscParseName)]...")

                let _ = clModelObservable2.updateGeocoderLocations(requestID: self.idpfBackupFileObject, 
                                                                   latitude:  self.dblConvertedLatitude, 
                                                                   longitude: self.dblConvertedLongitude, 
                                                                   withCompletionHandler:
                                                                       { (requestID:Int, dictCurrentLocation:[String:Any]) in
                                                                           self.handleLocationAndAddressClosureEvent(bIsDownstreamObject:false, requestID:requestID, dictCurrentLocation:dictCurrentLocation)
                                                                       }
                                                                  )
            }

        }
        else
        {

            self.bCurrentAddessLookupScheduled = false
            self.bCurrentAddessLookupComplete  = false

            self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idpfBackupFileObject)): CoreLocation (service) is NOT available...")

        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of public func resolveLocationAndAddress().

    public func handleLocationAndAddressClosureEvent(bIsDownstreamObject:Bool = false, requestID:Int, dictCurrentLocation:[String:Any])
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'self' is [\(String(describing: self))] for Therapist [\(self.sPFCscParseName)] - parameter 'bIsDownstreamObject' is [\(bIsDownstreamObject)] - 'requestID' is [\(requestID)] - 'dictCurrentLocation' is [\(String(describing: dictCurrentLocation))]...")

        // Update the address info for BOTH 'self' and (possibly 'from'/'to')...

        if (dictCurrentLocation.count > 0)
        {
        
            self.xcgLogMsg("\(sCurrMethodDisp) #(\(requestID)): <closure> Called  'updateGeocoderLocation()' with 'self' of [\(String(describing: self))] for Latitude/Longitude of [\(self.dblConvertedLatitude)/\(self.dblConvertedLongitude)] for Therapist [\(self.sPFCscParseName)] current 'location' [\(String(describing: dictCurrentLocation))]...")

            self.sCurrentLocationName         = String(describing: (dictCurrentLocation["sCurrentLocationName"] ?? ""))
            self.sCurrentCity                 = String(describing: (dictCurrentLocation["sCurrentCity"]         ?? ""))
            self.sCurrentCountry              = String(describing: (dictCurrentLocation["sCurrentCountry"]      ?? ""))
            self.sCurrentPostalCode           = String(describing: (dictCurrentLocation["sCurrentPostalCode"]   ?? ""))
            self.sCurrentTimeZone             = String(describing: (dictCurrentLocation["tzCurrentTimeZone"]    ?? ""))

            self.bCurrentAddessLookupComplete = true

            if (bIsDownstreamObject == false)
            {
            
                if (self.pfBackupFileObjectClonedFrom != nil &&
                    self.pfBackupFileObjectClonedFrom != self)
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) #(\(requestID)): <closure> Calling 'self.pfBackupFileObjectClonedFrom' of [\(String(describing: self.pfBackupFileObjectClonedFrom))] with 'self' of [\(String(describing: self))] for Therapist [\(self.sPFCscParseName)]...")

                    self.pfBackupFileObjectClonedFrom!.handleLocationAndAddressClosureEvent(bIsDownstreamObject:true, requestID:requestID, dictCurrentLocation:dictCurrentLocation)

                    self.xcgLogMsg("\(sCurrMethodDisp) #(\(requestID)): <closure> Called  'self.pfBackupFileObjectClonedFrom' of [\(String(describing: self.pfBackupFileObjectClonedFrom))] with 'self' of [\(String(describing: self))] for Therapist [\(self.sPFCscParseName)]...")

                }

                if (self.pfBackupFileObjectClonedTo != nil &&
                    self.pfBackupFileObjectClonedTo != self)
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) #(\(requestID)): <closure> Calling 'self.pfBackupFileObjectClonedTo' of [\(String(describing: self.pfBackupFileObjectClonedTo))] with 'self' of [\(String(describing: self))] for Therapist [\(self.sPFCscParseName)]...")

                    self.pfBackupFileObjectClonedTo!.handleLocationAndAddressClosureEvent(bIsDownstreamObject:true, requestID:requestID, dictCurrentLocation:dictCurrentLocation)

                    self.xcgLogMsg("\(sCurrMethodDisp) #(\(requestID)): <closure> Called  'self.pfBackupFileObjectClonedTo' of [\(String(describing: self.pfBackupFileObjectClonedTo))] with 'self' of [\(String(describing: self))] for Therapist [\(self.sPFCscParseName)]...")

                }
            
            }
        
        }
        else
        {

            self.xcgLogMsg("\(sCurrMethodDisp) #(\(requestID)): Dictionary 'dictCurrentLocation' is 'empty' - bypassing update - Warning!")

            self.bCurrentAddessLookupComplete = false

        }

        self.bCurrentAddessLookupScheduled = false

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of public func handleLocationAndAddressClosureEvent(bIsDownstreamObject:Bool, requestID:Int, dictCurrentLocation:[String:Any]).

}   // End of class ParsePFBackupFileItem(NSObject, Identifiable).

