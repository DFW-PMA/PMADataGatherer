//
//  ParsePFPatientFileItem.swift
//  PMADataGatherer
//
//  Created by JustMacApps.net on 01/31/2025.
//  Copyright © JustMacApps 2023-2025. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit
import ParseCore

class ParsePFPatientFileItem: NSObject, Identifiable
{

    struct ClassInfo
    {
        
        static let sClsId        = "ParsePFPatientFileItem"
        static let sClsVers      = "v1.0201"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2025. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    // 'Internal' Trace flag:

    private 
    var bInternalTraceFlag:Bool                                   = false

    // Item Data field(s):
    
    var id                                                        = UUID()
    var idPFPatientFileObject:Int                                 = 0

    var pfPatientFileObjectClonedFrom:ParsePFPatientFileItem?     = nil 
    var pfPatientFileObjectClonedTo:ParsePFPatientFileItem?       = nil 

    // ------------------------------------------------------------------------------------------
    //  'pfPatientFileObject' is [<CSC: 0x301e16700, objectId: qpp1fxx68P, localId: (null)> 
    //  {
    //  }]...
    // ------------------------------------------------------------------------------------------

    var pfPatientFileObject:PFObject?                             = nil

    // ----------------------------------------------------------------------------------------------------------------
    //  TYPE of 'pfPatientFileObject'                 is [PFObject]         - value is [<CSC: 0x302ee1080, objectId: ...
    //  TYPE of 'pfPatientFileObject.parseClassName'  is [String]           - value is [PatientFile]...
    //  TYPE of 'pfPatientFileObject.objectId'        is [Optional<String>] - value is [Optional("dztxUrBZLr")]...
    //  TYPE of 'pfPatientFileObject.createdAt'       is [Optional<Date>]   - value is [Optional(2024-11-13 17:13:57 +0000)]...
    //  TYPE of 'pfPatientFileObject.updatedAt'       is [Optional<Date>]   - value is [Optional(2024-11-14 22:30:00 +0000)]...
    //  TYPE of 'pfPatientFileObject.acl'             is [Optional<PFACL>]  - value is [nil]...
    //  TYPE of 'pfPatientFileObject.isDataAvailable' is [Bool]             - value is [true]...
    //  TYPE of 'pfPatientFileObject.isDirty'         is [Bool]             - value is [false]...
    //  TYPE of 'pfPatientFileObject.allKeys'         is [Array<String>]    - value is [["lastLocTime", "latitude", ...
    // ----------------------------------------------------------------------------------------------------------------

    // Item 'discrete' field(s):

    var sPFPatientFileClassName:String                          = ""
    var sPFPatientFileObjectId:String?                          = nil
    var datePFPatientFileCreatedAt:Date?                        = nil
    var datePFPatientFileUpdatedAt:Date?                        = nil
    var aclPFPatientFile:PFACL?                                 = nil
    var bPFPatientFileIsDataAvailable:Bool                      = false
    var bPFPatientFileIdDirty:Bool                              = false
    var listPFPatientFileAllKeys:[String]                       = []

    // ----------------------------------------------------------------------------------------------------------
    // "ID"           : NumberInt(12524),
    // "name"         : "Zuniga ,Santino Alfredo",
    // "firstName"    : "Santino",
    // "lastName"     : "Alfredo Zuniga",
    // "emerContacts" : ["Ophelia Vargas","mother","","6822469838","","","","","","","",""],
    // "histLoc1"     : [32.80673599243164,-96.68681335449219],
    // ----------------------------------------------------------------------------------------------------------

    // Item 'keyed' field(s):

    var iPFPatientFilePID:Int                                   = -1         // 'pfPatientFileObject[ID]'
    var sPFPatientFileName:String                               = "-N/A-"    // 'pfPatientFileObject[name]' (last, first middle)
    var sPFPatientFileFirstName:String                          = "-N/A-"    // 'pfPatientFileObject[firstName]' (first)
    var sPFPatientFileLastName:String                           = "-N/A-"    // 'pfPatientFileObject[lastName]' (<middle> last)
    var sPFPatientFileEmerContacts:String                       = ""         // 'pfPatientFileObject[emerContacts]' <list>
    var sPFPatientFileHomeLoc:String                            = ""         // 'pfPatientFileObject[histLoc1]' [latitude,longitude]

    // ----------------------------------------------------------------------------------------------------------------
    //  TYPE of 'pfPatientFileObjectLatitude'     is [Optional<Any>] - value is [Optional(32.77201080322266)]...
    //  TYPE of 'pfPatientFileObjectLongitude'    is [Optional<Any>] - value is [Optional(-96.5831298828125)]...
    //  TYPE of 'sPFPatientFileObjectLatitude'    is [String]        - value is [32.77201080322266]...
    //  TYPE of 'sPFPatientFileObjectLongitude'   is [String]        - value is [-96.5831298828125]...
    //  TYPE of 'dblPFPatientFileObjectLatitude'  is [Double]        - value is [32.77201080322266]...
    //  TYPE of 'dblPFPatientFileObjectLongitude' is [Double]        - value is [-96.5831298828125]...
    //  TYPE of 'dblConvertedLatitude'            is [Double]        - value is [32.77201080322266]...
    //  TYPE of 'dblConvertedLongitude'           is [Double]        - value is [-96.5831298828125]...
    //  TYPE of 'sHomeLocLocationName'            is [String]        - value is [-N/A-]...
    //  TYPE of 'sHomeLocCity'                    is [String]        - value is [-N/A-]...
    // ----------------------------------------------------------------------------------------------------------------

    // Item 'calculated'/'converted'/'looked'-up/'computed' field(s):

    var pfPatientFileObjectLatitude:Any?                          = nil
    var pfPatientFileObjectLongitude:Any?                         = nil

    var sPFPatientFileObjectLatitude:String                       = "0.0"
    var sPFPatientFileObjectLongitude:String                      = "0.0"

    var dblPFPatientFileObjectLatitude:Double                     = 0.0
    var dblPFPatientFileObjectLongitude:Double                    = 0.0

    var dblConvertedLatitude:Double                               = 0.0
    var dblConvertedLongitude:Double                              = 0.0

    // Item address 'lookup'/'reverseLocation' (address) field(s):

    var bHomeLocAddessLookupScheduled:Bool                        = false
    var bHomeLocAddessLookupComplete:Bool                         = false

    var sHomeLocLocationName:String                               = ""
    var sHomeLocCity:String                                       = ""
    var sHomeLocCountry:String                                    = ""
    var sHomeLocPostalCode:String                                 = ""
    var sHomeLocTimeZone:String                                   = ""

    var clLocationCoordinate2D:CLLocationCoordinate2D
    {

        return CLLocationCoordinate2D(latitude:self.dblConvertedLatitude, longitude:self.dblConvertedLongitude)

    }

    var mapCoordinateRegion:MKCoordinateRegion
    {

        return MKCoordinateRegion(center:self.clLocationCoordinate2D,               
                                    span:MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta:0.05))

    }

    var mapPosition:MapCameraPosition
    {

        return MapCameraPosition.region(self.mapCoordinateRegion)

    }

    // App Data field(s):

    var jmAppDelegateVisitor:JmAppDelegateVisitor                 = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    
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

    convenience init(pfPatientFileItem:ParsePFPatientFileItem)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
  
        self.init()
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'pfPatientFileItem' is [\(pfPatientFileItem)]...")

        // Finish the 'convenience' setup of field(s)...

        self.init(bDeepCopyIsAnOverlay:false, pfPatientFileItem:pfPatientFileItem)

        // Exit:
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return
  
    }   // End of convenience init(pfPatientFileItem:ParsePFPatientFileItem).

    convenience init(bDeepCopyIsAnOverlay:Bool, pfPatientFileItem:ParsePFPatientFileItem)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
  
        self.init()
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter is 'pfPatientFileItem' is [\(pfPatientFileItem)]...")

        // Finish the 'convenience' setup of field(s)...

        self.overlayPFPatientFileDataItemWithAnotherPFPatientFileDataItem(pfPatientFileItem:pfPatientFileItem)

        if (bDeepCopyIsAnOverlay == false)
        {
        
            self.pfPatientFileObjectClonedFrom              = pfPatientFileItem 
            self.pfPatientFileObjectClonedTo                = self 

        //  pfPatientFileItem.pfPatientFileObjectClonedFrom = nil
            pfPatientFileItem.pfPatientFileObjectClonedTo   = self
        
        }

        // Check if the 'current' Location data copied was 'blank'...

        if (self.sHomeLocLocationName.count < 1 ||
            self.sHomeLocCity.count         < 1)
        {
        
            self.xcgLogMsg("\(sCurrMethodDisp) Intermediate <dup copy 'init'> <PFPatientFile> - Copied 'self.sHomeLocLocationName' is [\(self.sHomeLocLocationName)] and 'self.sHomeLocCity' is [\(self.sHomeLocCity)] - 1 or both are 'blank' - 'pfPatientFileItem.sHomeLocLocationName' is [\(pfPatientFileItem.sHomeLocLocationName)] and 'pfPatientFileItem.sHomeLocCity' is [\(pfPatientFileItem.sHomeLocCity)] - Warning!")
        
        }

        // Trace the 'clone' From/To fields in both objects...

        self.xcgLogMsg("\(sCurrMethodDisp) Intermediate <dup copy 'init'> <PFPatientFile> - From/To 'self.pfPatientFileObjectClonedFrom' is [\(String(describing: self.pfPatientFileObjectClonedFrom))] and 'self.pfPatientFileObjectClonedTo' is [\(String(describing: self.pfPatientFileObjectClonedTo))] - 'pfPatientFileItem.pfPatientFileObjectClonedFrom' is [\(String(describing: pfPatientFileItem.pfPatientFileObjectClonedFrom))] and 'pfPatientFileItem.pfPatientFileObjectClonedTo' is [\(String(describing: pfPatientFileItem.pfPatientFileObjectClonedTo))]...")

        // Exit:
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return
  
    }   // End of convenience init(bDeepCopyIsAnOverlay:Bool, pfPatientFileItem:ParsePFPatientFileItem).

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
        asToString.append("'bInternalTraceFlag': [\(String(describing: self.bInternalTraceFlag))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'id': [\(String(describing: self.id))],")
        asToString.append("'idPFPatientFileObject': [\(String(describing: self.idPFPatientFileObject))],")
        asToString.append("'pfPatientFileObjectClonedFrom': [\(String(describing: self.pfPatientFileObjectClonedFrom))],")
        asToString.append("'pfPatientFileObjectClonedTo': [\(String(describing: self.pfPatientFileObjectClonedTo))],")

        if (pfPatientFileObject == nil)
        {
            asToString.append("'pfPatientFileObject': [-nil-],")
        }
        else
        {
            asToString.append("'pfPatientFileObject': [-available-],")
        }

        asToString.append("],")
        asToString.append("[")
        asToString.append("'sPFPatientFileClassName': [\(String(describing: self.sPFPatientFileClassName))],")
        asToString.append("'sPFPatientFileObjectId': [\(String(describing: self.sPFPatientFileObjectId))],")
        asToString.append("'datePFPatientFileCreatedAt': [\(String(describing: self.datePFPatientFileCreatedAt))],")
        asToString.append("'datePFPatientFileUpdatedAt': [\(String(describing: self.datePFPatientFileUpdatedAt))],")
        asToString.append("'aclPFPatientFile': [\(String(describing: self.aclPFPatientFile))],")
        asToString.append("'bPFPatientFileIsDataAvailable': [\(String(describing: self.bPFPatientFileIsDataAvailable))],")
        asToString.append("'bPFPatientFileIdDirty': [\(String(describing: self.bPFPatientFileIdDirty))],")
        asToString.append("'listPFPatientFileAllKeys': [\(String(describing: self.listPFPatientFileAllKeys))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'iPFPatientFilePID': (\(String(describing: self.iPFPatientFilePID))),")
        asToString.append("'sPFPatientFileName': [\(String(describing: self.sPFPatientFileName))],")
        asToString.append("'sPFPatientFileLastName': [\(String(describing: self.sPFPatientFileLastName))],")
        asToString.append("'sPFPatientFileEmerContacts': [\(String(describing: self.sPFPatientFileEmerContacts))],")
        asToString.append("'sPFPatientFileHomeLoc': [\(String(describing: self.sPFPatientFileHomeLoc))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'pfPatientFileObjectLatitude': [\(String(describing: self.pfPatientFileObjectLatitude))],")
        asToString.append("'pfPatientFileObjectLongitude': [\(String(describing: self.pfPatientFileObjectLongitude))],")
        asToString.append("'sPFPatientFileObjectLatitude': [\(String(describing: self.sPFPatientFileObjectLatitude))],")
        asToString.append("'sPFPatientFileObjectLongitude': [\(String(describing: self.sPFPatientFileObjectLongitude))],")
        asToString.append("'dblPFPatientFileObjectLatitude': [\(String(describing: self.dblPFPatientFileObjectLatitude))],")
        asToString.append("'dblPFPatientFileObjectLongitude': [\(String(describing: self.dblPFPatientFileObjectLongitude))],")
        asToString.append("'dblConvertedLatitude': [\(String(describing: self.dblConvertedLatitude))],")
        asToString.append("'dblConvertedLongitude': [\(String(describing: self.dblConvertedLongitude))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'bHomeLocAddessLookupScheduled': [\(String(describing: self.bHomeLocAddessLookupScheduled))],")
        asToString.append("'bHomeLocAddessLookupComplete': [\(String(describing: self.bHomeLocAddessLookupComplete))],")
        asToString.append("'sHomeLocLocationName': [\(String(describing: self.sHomeLocLocationName))],")
        asToString.append("'sHomeLocCity': [\(String(describing: self.sHomeLocCity))],")
        asToString.append("'sHomeLocCountry': [\(String(describing: self.sHomeLocCountry))],")
        asToString.append("'sHomeLocPostalCode': [\(String(describing: self.sHomeLocPostalCode))],")
        asToString.append("'sHomeLocTimeZone': [\(String(describing: self.sHomeLocTimeZone))],")
    //  asToString.append("],")
    //  asToString.append("[")
    //  asToString.append("'jmAppDelegateVisitor': [\(self.jmAppDelegateVisitor.toString())]")
        asToString.append("],")
        asToString.append("]")

        let sContents:String = "{"+(asToString.joined(separator: ""))+"}"

        return sContents

    }   // End of public func toString().

    public func displayParsePFPatientFileItemToLog()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Display the various field(s) of this object in the Log...

        self.xcgLogMsg("\(sCurrMethodDisp) 'self'                            is [\(String(describing: self))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'bInternalTraceFlag'              is [\(String(describing: self.bInternalTraceFlag))]...")

        self.xcgLogMsg("\(sCurrMethodDisp) 'id'                              is [\(String(describing: self.id))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'idPFPatientFileObject'           is [\(String(describing: self.idPFPatientFileObject))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'pfPatientFileObjectClonedFrom'   is [\(String(describing: self.pfPatientFileObjectClonedFrom))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'pfPatientFileObjectClonedTo'     is [\(String(describing: self.pfPatientFileObjectClonedTo))]...")

    //  self.xcgLogMsg("\(sCurrMethodDisp) 'pfPatientFileObject'             is [\(String(describing: self.pfPatientFileObject))]...")

        if (self.pfPatientFileObject == nil)
        {
            self.xcgLogMsg("\(sCurrMethodDisp) 'pfPatientFileObject'         is [-nil-]...")
        }
        else
        {
            self.xcgLogMsg("\(sCurrMethodDisp) 'pfPatientFileObject'         is [-available-]...")
        }

        self.xcgLogMsg("\(sCurrMethodDisp) 'sPFPatientFileClassName'         is [\(String(describing: self.sPFPatientFileClassName))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sPFPatientFileObjectId'          is [\(String(describing: self.sPFPatientFileObjectId))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'datePFPatientFileCreatedAt'      is [\(String(describing: self.datePFPatientFileCreatedAt))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'datePFPatientFileUpdatedAt'      is [\(String(describing: self.datePFPatientFileUpdatedAt))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'aclPFPatientFile'                is [\(String(describing: self.aclPFPatientFile))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'bPFPatientFileIsDataAvailable'   is [\(String(describing: self.bPFPatientFileIsDataAvailable))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'bPFPatientFileIdDirty'           is [\(String(describing: self.bPFPatientFileIdDirty))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'listPFPatientFileAllKeys'        is [\(String(describing: self.listPFPatientFileAllKeys))]...")

        self.xcgLogMsg("\(sCurrMethodDisp) 'iPFPatientFilePID'               is (\(String(describing: self.iPFPatientFilePID)))...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sPFPatientFileName'              is [\(String(describing: self.sPFPatientFileName))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sPFPatientFileFirstName'         is [\(String(describing: self.sPFPatientFileFirstName))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sPFPatientFileLastName'          is [\(String(describing: self.sPFPatientFileLastName))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sPFPatientFileEmerContacts'      is [\(String(describing: self.sPFPatientFileEmerContacts))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sPFPatientFileHomeLoc'           is [\(String(describing: self.sPFPatientFileHomeLoc))]...")

        self.xcgLogMsg("\(sCurrMethodDisp) 'pfPatientFileObjectLatitude'     is [\(String(describing: self.pfPatientFileObjectLatitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'pfPatientFileObjectLongitude'    is [\(String(describing: self.pfPatientFileObjectLongitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sPFPatientFileObjectLatitude'    is [\(String(describing: self.sPFPatientFileObjectLatitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sPFPatientFileObjectLongitude'   is [\(String(describing: self.sPFPatientFileObjectLongitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'dblPFPatientFileObjectLatitude'  is [\(String(describing: self.dblPFPatientFileObjectLatitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'dblPFPatientFileObjectLongitude' is [\(String(describing: self.dblPFPatientFileObjectLongitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'dblConvertedLatitude'            is [\(String(describing: self.dblConvertedLatitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'dblConvertedLongitude'           is [\(String(describing: self.dblConvertedLongitude))]...")

        self.xcgLogMsg("\(sCurrMethodDisp) 'bHomeLocAddessLookupScheduled'   is [\(String(describing: self.bHomeLocAddessLookupScheduled))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'bHomeLocAddessLookupComplete'    is [\(String(describing: self.bHomeLocAddessLookupComplete))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sHomeLocLocationName'            is [\(String(describing: self.sHomeLocLocationName))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sHomeLocCity'                    is [\(String(describing: self.sHomeLocCity))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sHomeLocCountry'                 is [\(String(describing: self.sHomeLocCountry))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sHomeLocPostalCode'              is [\(String(describing: self.sHomeLocPostalCode))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sHomeLocTimeZone'                is [\(String(describing: self.sHomeLocTimeZone))]...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of public func displayParsePFPatientFileItemToLog().

    public func constructParsePFPatientFileItemFromPFObject(idPFPatientFileObject:Int = 1, pfPatientFileObject:PFObject)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

    //  self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'idPFPatientFileObject' is (\(idPFPatientFileObject)) - 'pfPatientFileObject' is [\(pfPatientFileObject)]...")
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'idPFPatientFileObject' is (\(idPFPatientFileObject)) - 'pfPatientFileObject'...")

        // Assign the various field(s) of this object from the supplied PFObject...

        self.idPFPatientFileObject                = idPFPatientFileObject

        self.pfPatientFileObjectClonedFrom        = nil 
        self.pfPatientFileObjectClonedTo          = nil 

        self.pfPatientFileObject                  = pfPatientFileObject                                                             
        
        self.sPFPatientFileClassName              = pfPatientFileObject.parseClassName
        self.sPFPatientFileObjectId               = pfPatientFileObject.objectId  != nil ? pfPatientFileObject.objectId!  : ""
        self.datePFPatientFileCreatedAt           = pfPatientFileObject.createdAt != nil ? pfPatientFileObject.createdAt! : nil
        self.datePFPatientFileUpdatedAt           = pfPatientFileObject.updatedAt != nil ? pfPatientFileObject.updatedAt! : nil
        self.aclPFPatientFile                     = pfPatientFileObject.acl
        self.bPFPatientFileIsDataAvailable        = pfPatientFileObject.isDataAvailable
        self.bPFPatientFileIdDirty                = pfPatientFileObject.isDirty
        self.listPFPatientFileAllKeys             = pfPatientFileObject.allKeys

        self.iPFPatientFilePID                    = Int(String(describing: (pfPatientFileObject.object(forKey:"ID")       ?? "-1"))) ?? -2
        self.sPFPatientFileName                   = String(describing: (pfPatientFileObject.object(forKey:"name")         ?? ""))
        self.sPFPatientFileFirstName              = String(describing: (pfPatientFileObject.object(forKey:"firstName")    ?? ""))
        self.sPFPatientFileLastName               = String(describing: (pfPatientFileObject.object(forKey:"lastName")     ?? ""))
        self.sPFPatientFileEmerContacts           = String(describing: (pfPatientFileObject.object(forKey:"emerContacts") ?? ""))
        self.sPFPatientFileHomeLoc                = String(describing: (pfPatientFileObject.object(forKey:"histLoc1")     ?? ""))

    //  self.bPFPatientFileNotActive              = Bool(truncating: (Int(String(describing: (pfPatientFileObject.object(forKey:"notActive")    ?? "0")))  ?? 0) as NSNumber)
    //  self.iPFPatientFileSuperID                = Int(String(describing: (pfPatientFileObject.object(forKey:"superID")                        ?? "-1"))) ?? -2

        self.convertPFPatientFileHomeLocToLatitudeLongitude()

        self.bHomeLocAddessLookupScheduled        = false
        self.bHomeLocAddessLookupComplete         = false
      
        self.sHomeLocLocationName                 = ""
        self.sHomeLocCity                         = ""
        self.sHomeLocCountry                      = ""
        self.sHomeLocPostalCode                   = ""
        self.sHomeLocTimeZone                     = ""

        self.resolveLocationAndAddress()
      
        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of public func constructParsePFPatientFileItemFromPFObject(pfPatientFileObject:PFObject).

    private func overlayPFPatientFileDataItemWithAnotherPFPatientFileDataItem(pfPatientFileItem:ParsePFPatientFileItem)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Finish the 'overlay' update of field(s)...

        self.idPFPatientFileObject                = pfPatientFileItem.idPFPatientFileObject

        // 'Object' From/To update does NOT occur in an 'overlay'...

    //  self.pfPatientFileObjectClonedFrom        = nil 
    //  self.pfPatientFileObjectClonedTo          = nil 

        self.pfPatientFileObject                  = pfPatientFileItem.pfPatientFileObject

        self.sPFPatientFileClassName              = pfPatientFileItem.sPFPatientFileClassName
        self.sPFPatientFileObjectId               = pfPatientFileItem.sPFPatientFileObjectId
        self.datePFPatientFileCreatedAt           = pfPatientFileItem.datePFPatientFileCreatedAt
        self.datePFPatientFileUpdatedAt           = pfPatientFileItem.datePFPatientFileUpdatedAt
        self.aclPFPatientFile                     = pfPatientFileItem.aclPFPatientFile
        self.bPFPatientFileIsDataAvailable        = pfPatientFileItem.bPFPatientFileIsDataAvailable
        self.bPFPatientFileIdDirty                = pfPatientFileItem.bPFPatientFileIdDirty
        self.listPFPatientFileAllKeys             = pfPatientFileItem.listPFPatientFileAllKeys
        
        self.iPFPatientFilePID                    = pfPatientFileItem.iPFPatientFilePID
        self.sPFPatientFileName                   = pfPatientFileItem.sPFPatientFileName
        self.sPFPatientFileFirstName              = pfPatientFileItem.sPFPatientFileFirstName
        self.sPFPatientFileLastName               = pfPatientFileItem.sPFPatientFileLastName
        self.sPFPatientFileEmerContacts           = pfPatientFileItem.sPFPatientFileEmerContacts
        self.sPFPatientFileHomeLoc                = pfPatientFileItem.sPFPatientFileHomeLoc
        
        self.pfPatientFileObjectLatitude          = pfPatientFileItem.pfPatientFileObjectLatitude
        self.pfPatientFileObjectLongitude         = pfPatientFileItem.pfPatientFileObjectLongitude
        self.sPFPatientFileObjectLatitude         = pfPatientFileItem.sPFPatientFileObjectLatitude
        self.sPFPatientFileObjectLongitude        = pfPatientFileItem.sPFPatientFileObjectLongitude
        self.dblPFPatientFileObjectLatitude       = pfPatientFileItem.dblPFPatientFileObjectLatitude
        self.dblPFPatientFileObjectLongitude      = pfPatientFileItem.dblPFPatientFileObjectLongitude

        let dblPreviousLatitude:Double            = self.dblConvertedLatitude
        let dblPreviousLongitude:Double           = self.dblConvertedLongitude
        let dblHomeLocLatitude:Double             = pfPatientFileItem.dblConvertedLatitude
        let dblHomeLocLongitude:Double            = pfPatientFileItem.dblConvertedLongitude

        self.dblConvertedLatitude                 = pfPatientFileItem.dblConvertedLatitude
        self.dblConvertedLongitude                = pfPatientFileItem.dblConvertedLongitude
        
        // If 'self' (current) does NOT have 'important' location data, then copy all of it...

        if (self.sHomeLocLocationName.count < 1 ||
            self.sHomeLocCity.count         < 1)
        {
        
            self.sHomeLocLocationName          = pfPatientFileItem.sHomeLocLocationName        
            self.sHomeLocCity                  = pfPatientFileItem.sHomeLocCity                
            self.sHomeLocCountry               = pfPatientFileItem.sHomeLocCountry             
            self.sHomeLocPostalCode            = pfPatientFileItem.sHomeLocPostalCode          
            self.sHomeLocTimeZone              = pfPatientFileItem.sHomeLocTimeZone            

            self.bHomeLocAddessLookupScheduled = pfPatientFileItem.bHomeLocAddessLookupScheduled
            self.bHomeLocAddessLookupComplete  = pfPatientFileItem.bHomeLocAddessLookupComplete
        
        }
        else
        {

            // 'self' (HomeLoc) has location data, then use latitude/longitude changes to determine the update...

            let bLocationLatitudeHasChanged:Bool  = (abs(dblPreviousLatitude  - dblHomeLocLatitude)  > (3 * .ulpOfOne))
            let bLocationLongitudeHasChanged:Bool = (abs(dblPreviousLongitude - dblHomeLocLongitude) > (3 * .ulpOfOne))

            if (bLocationLatitudeHasChanged  == true ||
                bLocationLongitudeHasChanged == true)
            {
            
                self.sHomeLocLocationName          = pfPatientFileItem.sHomeLocLocationName        
                self.sHomeLocCity                  = pfPatientFileItem.sHomeLocCity                
                self.sHomeLocCountry               = pfPatientFileItem.sHomeLocCountry             
                self.sHomeLocPostalCode            = pfPatientFileItem.sHomeLocPostalCode          
                self.sHomeLocTimeZone              = pfPatientFileItem.sHomeLocTimeZone            

                self.bHomeLocAddessLookupScheduled = pfPatientFileItem.bHomeLocAddessLookupScheduled
                self.bHomeLocAddessLookupComplete  = pfPatientFileItem.bHomeLocAddessLookupComplete

                self.xcgLogMsg("\(sCurrMethodDisp) Intermediate <dup 'overlay'> <PFPatientFile> <location check> - Copied address data since 'bLocationLatitudeHasChanged' is [\(bLocationLatitudeHasChanged)] and/or 'bLocationLongitudeHasChanged' is [\(bLocationLongitudeHasChanged)] <location changed>...")
                self.xcgLogMsg("\(sCurrMethodDisp) Intermediate <dup 'overlay'> <PFPatientFile> <location check> - Location is [\(dblHomeLocLatitude),\(dblHomeLocLongitude)] and was [\(dblPreviousLatitude),\(dblPreviousLongitude)]...")

                if (self.sHomeLocLocationName.count < 1 ||
                    self.sHomeLocCity.count         < 1)
                {
                
                    self.bHomeLocAddessLookupScheduled  = false
                    self.bHomeLocAddessLookupComplete   = false
                
                }
            
            }
            else
            {
            
                self.xcgLogMsg("\(sCurrMethodDisp) Intermediate <dup 'overlay'> <PFPatientFile> <location check> - Skipped copying address data since 'bLocationLatitudeHasChanged' is [\(bLocationLatitudeHasChanged)] and 'bLocationLongitudeHasChanged' is [\(bLocationLongitudeHasChanged)] <location has NOT changed>...")
            
            }

        }
        
        // Check if the 'HomeLoc' Location data copied was 'blank'...

        if (self.sHomeLocLocationName.count < 1 ||
            self.sHomeLocCity.count         < 1)
        {
        
            self.xcgLogMsg("\(sCurrMethodDisp) Intermediate <dup 'overlay'> <PFPatientFile> - Copied 'self.sHomeLocLocationName' is [\(self.sHomeLocLocationName)] and 'self.sHomeLocCity' is [\(self.sHomeLocCity)] - 1 or both are 'blank' - 'pfPatientFileItem.sHomeLocLocationName' is [\(pfPatientFileItem.sHomeLocLocationName)] and 'pfPatientFileItem.sHomeLocCity' is [\(pfPatientFileItem.sHomeLocCity)] - Warning!")

            self.resolveLocationAndAddress()

        }

        // Trace the 'clone' From/To fields in both objects...

        self.xcgLogMsg("\(sCurrMethodDisp) Intermediate <dup 'overlay'> <PFPatientFile> - From/To 'self.pfPatientFileObjectClonedFrom' is [\(String(describing: self.pfPatientFileObjectClonedFrom))] and 'self.pfPatientFileObjectClonedTo' is [\(String(describing: self.pfPatientFileObjectClonedTo))] - 'pfPatientFileItem.pfPatientFileObjectClonedFrom' is [\(String(describing: pfPatientFileItem.pfPatientFileObjectClonedFrom))] and 'pfPatientFileItem.pfPatientFileObjectClonedTo' is [\(String(describing: pfPatientFileItem.pfPatientFileObjectClonedTo))]...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of private func overlayPFPatientFileDataItemWithAnotherPFPatientFileDataItem(pfPatientFileItem:ParsePFPatientFileItem)

    private func convertPFPatientFileHomeLocToLatitudeLongitude()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        var asToString:[String] = Array()

        asToString.append("[")

        // Convert the 'HomeLoc' field into Latitude/Longitude...

        asToString.append("\(sCurrMethodDisp) 'self.sPFPatientFileHomeLoc' is [\(self.sPFPatientFileHomeLoc)]...")

        let listHomeLocNoWS:[String]  = self.sPFPatientFileHomeLoc.components(separatedBy:CharacterSet.whitespacesAndNewlines)

        asToString.append("\(sCurrMethodDisp) 'listHomeLocNoWS' is [\(listHomeLocNoWS)]...")

        let sHomeLocNoWS:String = listHomeLocNoWS.joined(separator:"")

        asToString.append("\(sCurrMethodDisp) 'sHomeLocNoWS' is [\(sHomeLocNoWS)]...")

        var csHomeLocDelimiters1:CharacterSet = CharacterSet()

        csHomeLocDelimiters1.insert(charactersIn: "<>")

        let listHomeLocCleaned1:[String] = sHomeLocNoWS.components(separatedBy:csHomeLocDelimiters1)

        asToString.append("\(sCurrMethodDisp) 'listHomeLocCleaned1' is [\(listHomeLocCleaned1)]...")

        let sHomeLocCleaned1:String = listHomeLocCleaned1.joined(separator:"")

        asToString.append("\(sCurrMethodDisp) 'sHomeLocCleaned1' is [\(sHomeLocCleaned1)]...")

        var csHomeLocDelimiters2:CharacterSet = CharacterSet()

        csHomeLocDelimiters2.insert(charactersIn: ",")

        let listHomeLocCleaned2:[String] = sHomeLocCleaned1.components(separatedBy:csHomeLocDelimiters2)

        asToString.append("\(sCurrMethodDisp) 'listHomeLocCleaned2' is [\(listHomeLocCleaned2)]...")

        var csHomeLocDelimiters3:CharacterSet = CharacterSet()

        csHomeLocDelimiters3.insert(charactersIn: ":")

        if (listHomeLocCleaned2.count < 1)
        {
            
            asToString.append("\(sCurrMethodDisp) 'listHomeLocCleaned2' has a count of (\(listHomeLocCleaned2.count)) which is less than 1 - Error!")
            
        }
        else
        {
            
            asToString.append("\(sCurrMethodDisp) 'listHomeLocCleaned2' has a count of (\(listHomeLocCleaned2.count)) which is equal to or greater than 1 - continuing...")
            
            var dictHomeLocCleaned2:[String:String] = [String:String]()
            var cHomeLocWork:Int                    = 0
            
            for sHomeLocWork:String in listHomeLocCleaned2
            {
                
            //  if (sHomeLocWork.count < 1)
            //  {
            //      
            //      continue
            //      
            //  }
                
                cHomeLocWork += 1
                
                asToString.append("\(sCurrMethodDisp) #(\(cHomeLocWork)): 'sHomeLocWork' is [\(sHomeLocWork)]...")
                
            //  let listHomeLocWorkCleaned:[String] = sHomeLocWork.components(separatedBy:csHomeLocDelimiters3)
            //
            //  asToString.append("\(sCurrMethodDisp) #(\(cHomeLocWork)): 'listHomeLocWorkCleaned' is [\(listHomeLocWorkCleaned)]...")

                var sHomeLocKey:String   = ""
                var sHomeLocValue:String = ""
                
                if (cHomeLocWork == 1)
                {
                
                    sHomeLocKey   = "latitude"
                    sHomeLocValue = sHomeLocWork
                
                }
                
                if (cHomeLocWork == 2)
                {
                
                    sHomeLocKey   = "longitude"
                    sHomeLocValue = sHomeLocWork
                
                }
                
                dictHomeLocCleaned2[sHomeLocKey] = sHomeLocValue
                
                asToString.append("\(sCurrMethodDisp) #(\(cHomeLocWork)): Added a key 'sHomeLocKey' of [\(sHomeLocKey)] with a value 'sHomeLocValue' of [\(sHomeLocValue)] to the dictionary 'dictHomeLocCleaned2'...")
                
            }
                 
            asToString.append("\(sCurrMethodDisp) The dictionary 'dictHomeLocCleaned2' is [\(dictHomeLocCleaned2)]...")
            
            let sHomeLocLatitude:String  = dictHomeLocCleaned2["latitude"]  ?? "0.0000"
            let sHomeLocLongitude:String = dictHomeLocCleaned2["longitude"] ?? "0.0000"
            
            asToString.append("\(sCurrMethodDisp) 'sHomeLocLatitude'  is [\(sHomeLocLatitude)]...")
            asToString.append("\(sCurrMethodDisp) 'sHomeLocLongitude' is [\(sHomeLocLongitude)]...")

            self.pfPatientFileObjectLatitude     = sHomeLocLatitude
            self.pfPatientFileObjectLongitude    = sHomeLocLongitude
            self.sPFPatientFileObjectLatitude    = String(describing: pfPatientFileObjectLatitude!)
            self.sPFPatientFileObjectLongitude   = String(describing: pfPatientFileObjectLongitude!)
            self.dblPFPatientFileObjectLatitude  = Double(sPFPatientFileObjectLatitude)        ?? 0.0000
            self.dblPFPatientFileObjectLongitude = Double(sPFPatientFileObjectLongitude)       ?? 0.0000
            self.dblConvertedLatitude            = Double(String(describing: sHomeLocLatitude))  ?? 0.0000
            self.dblConvertedLongitude           = Double(String(describing: sHomeLocLongitude)) ?? 0.0000
            
            asToString.append("\(sCurrMethodDisp) 'pfPatientFileObjectLatitude'     is [\(String(describing: pfPatientFileObjectLatitude))]...")
            asToString.append("\(sCurrMethodDisp) 'pfPatientFileObjectLongitude'    is [\(String(describing: pfPatientFileObjectLongitude))]...")
            asToString.append("\(sCurrMethodDisp) 'sPFPatientFileObjectLatitude'    is [\(sPFPatientFileObjectLatitude)]...")
            asToString.append("\(sCurrMethodDisp) 'sPFPatientFileObjectLongitude'   is [\(sPFPatientFileObjectLongitude)]...")
            asToString.append("\(sCurrMethodDisp) 'dblPFPatientFileObjectLatitude'  is [\(dblPFPatientFileObjectLatitude)]...")
            asToString.append("\(sCurrMethodDisp) 'dblPFPatientFileObjectLongitude' is [\(dblPFPatientFileObjectLongitude)]...")
            asToString.append("\(sCurrMethodDisp) 'dblConvertedLatitude'            is [\(dblConvertedLatitude)]...")
            asToString.append("\(sCurrMethodDisp) 'dblConvertedLongitude'           is [\(dblConvertedLongitude)]...")
            
        }

        // If we have an 'Internal' Trace flag, then output all the captured log messages...

        if (bInternalTraceFlag == true)
        {

            let sContents:String = "{"+(asToString.joined(separator: ""))+"}"

            self.xcgLogMsg("\(sCurrMethodDisp) Accumulated 'sContents' is [\(sContents)]...")

        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of private func convertPFPatientFileHomeLocToLatitudeLongitude().

    public func resolveLocationAndAddress()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

    //  // Check if the Patient is 'NOT Active', if so, bypass address/location resolve...
    //
    //  if (self.bPFPatientFileNotActive == true)
    //  {
    //
    //      self.xcgLogMsg("\(sCurrMethodDisp) Intermediate - bypassing the address 'resolve' - 'self.bPFPatientFileNotActive' is [\(self.bPFPatientFileNotActive)]...")
    //
    //      // Exit:
    //
    //      self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
    //
    //      return
    //  }

        // Check if address 'lookup' has already been scheduled, if so, bypass address/location resolve...

        if (self.bHomeLocAddessLookupScheduled == true)
        {
        
            self.xcgLogMsg("\(sCurrMethodDisp) Intermediate - bypassing the address 'resolve' - 'self.bHomeLocAddessLookupScheduled' is [\(self.bHomeLocAddessLookupScheduled)]...")

            // Exit:

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

            return
        
        }

        // Use the Latitude/Longitude values to resolve address...

        if (self.jmAppDelegateVisitor.jmAppCLModelObservable2 != nil)
        {

            let clModelObservable2:CoreLocationModelObservable2 = self.jmAppDelegateVisitor.jmAppCLModelObservable2!

            self.bHomeLocAddessLookupScheduled = true
            self.bHomeLocAddessLookupComplete  = false
            
            let dblDeadlineInterval:Double     = clModelObservable2.requestNextReverseLocationLookupDeadlineInterval(clRevLocType:CLRevLocType.tertiary)

            DispatchQueue.main.asyncAfter(deadline:(.now() + dblDeadlineInterval))
            {
                self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFPatientFileObject)): <closure> Calling 'updateGeocoderLocation()' with 'self' of [\(String(describing: self))] for Latitude/Longitude of [\(self.dblConvertedLatitude)/\(self.dblConvertedLongitude)] for Therapist [\(self.sPFPatientFileName)]...")

                let _ = clModelObservable2.updateGeocoderLocations(requestID: self.idPFPatientFileObject, 
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

            self.bHomeLocAddessLookupScheduled = false
            self.bHomeLocAddessLookupComplete  = false

            self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idPFPatientFileObject)): CoreLocation (service) is NOT available...")

        }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of public func resolveLocationAndAddress().

    public func handleLocationAndAddressClosureEvent(bIsDownstreamObject:Bool = false, requestID:Int, dictCurrentLocation:[String:Any])
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'self' is [\(String(describing: self))] for Therapist [\(self.idPFPatientFileObject)] - parameter 'bIsDownstreamObject' is [\(bIsDownstreamObject)] - 'requestID' is [\(requestID)] - 'dictCurrentLocation' is [\(String(describing: dictCurrentLocation))]...")

        // Update the address info for BOTH 'self' and (possibly 'from'/'to')...

        if (dictCurrentLocation.count > 0)
        {
        
            self.xcgLogMsg("\(sCurrMethodDisp) #(\(requestID)): <closure> Called  'updateGeocoderLocation()' with 'self' of [\(String(describing: self))] for Latitude/Longitude of [\(self.dblConvertedLatitude)/\(self.dblConvertedLongitude)] for Therapist [\(self.sPFPatientFileName)] current 'location' [\(String(describing: dictCurrentLocation))]...")

            self.sHomeLocLocationName = String(describing: (dictCurrentLocation["sCurrentLocationName"] ?? ""))
            self.sHomeLocCity         = String(describing: (dictCurrentLocation["sCurrentCity"]         ?? ""))
            self.sHomeLocCountry      = String(describing: (dictCurrentLocation["sCurrentCountry"]      ?? ""))
            self.sHomeLocPostalCode   = String(describing: (dictCurrentLocation["sCurrentPostalCode"]   ?? ""))
            self.sHomeLocTimeZone     = String(describing: (dictCurrentLocation["tzCurrentTimeZone"]    ?? ""))

            self.bHomeLocAddessLookupComplete = true

            if (bIsDownstreamObject == false)
            {
            
                if (self.pfPatientFileObjectClonedFrom != nil &&
                    self.pfPatientFileObjectClonedFrom != self)
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) #(\(requestID)): <closure> Calling 'self.pfPatientFileObjectClonedFrom' of [\(String(describing: self.pfPatientFileObjectClonedFrom))] with 'self' of [\(String(describing: self))] for Therapist [\(self.sPFPatientFileName)]...")

                    self.pfPatientFileObjectClonedFrom!.handleLocationAndAddressClosureEvent(bIsDownstreamObject:true, requestID:requestID, dictCurrentLocation:dictCurrentLocation)

                    self.xcgLogMsg("\(sCurrMethodDisp) #(\(requestID)): <closure> Called  'self.pfPatientFileObjectClonedFrom' of [\(String(describing: self.pfPatientFileObjectClonedFrom))] with 'self' of [\(String(describing: self))] for Therapist [\(self.sPFPatientFileName)]...")

                }

                if (self.pfPatientFileObjectClonedTo != nil &&
                    self.pfPatientFileObjectClonedTo != self)
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) #(\(requestID)): <closure> Calling 'self.pfPatientFileObjectClonedTo' of [\(String(describing: self.pfPatientFileObjectClonedTo))] with 'self' of [\(String(describing: self))] for Therapist [\(self.sPFPatientFileName)]...")

                    self.pfPatientFileObjectClonedTo!.handleLocationAndAddressClosureEvent(bIsDownstreamObject:true, requestID:requestID, dictCurrentLocation:dictCurrentLocation)

                    self.xcgLogMsg("\(sCurrMethodDisp) #(\(requestID)): <closure> Called  'self.pfPatientFileObjectClonedTo' of [\(String(describing: self.pfPatientFileObjectClonedTo))] with 'self' of [\(String(describing: self))] for Therapist [\(self.sPFPatientFileName)]...")

                }
            
            }
        
        }
        else
        {

            self.xcgLogMsg("\(sCurrMethodDisp) #(\(requestID)): Dictionary 'dictCurrentLocation' is 'empty' - bypassing update - Warning!")

            self.bHomeLocAddessLookupComplete = false

        }

        self.bHomeLocAddessLookupScheduled = false

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of public func handleLocationAndAddressClosureEvent(bIsDownstreamObject:Bool, requestID:Int, dictCurrentLocation:[String:Any]).

}   // End of class ParsePFPatientFileItem(NSObject, Identifiable).

