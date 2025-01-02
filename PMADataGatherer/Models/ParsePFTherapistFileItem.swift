//
//  ParsePFTherapistFileItem.swift
//  PMADataGatherer
//
//  Created by JustMacApps.net on 12/27/2024.
//  Copyright © JustMacApps 2023-2025. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit
import ParseCore

class ParsePFTherapistFileItem: NSObject, Identifiable
{

    struct ClassInfo
    {
        
        static let sClsId        = "ParsePFTherapistFileItem"
        static let sClsVers      = "v1.0205"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2025. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    // Item Data field(s):
    
    var id                                               = UUID()

    // ------------------------------------------------------------------------------------------
    //  'pfTherapistFileObject' is [<CSC: 0x301e16700, objectId: qpp1fxx68P, localId: (null)> 
    //  {
    //  }]...
    // ------------------------------------------------------------------------------------------

    var pfTherapistFileObject:PFObject?                  = nil

    // ----------------------------------------------------------------------------------------------------------------
    //  TYPE of 'pfTherapistFileObject'                 is [PFObject]         - value is [<CSC: 0x302ee1080, objectId: ...
    //  TYPE of 'pfTherapistFileObject.parseClassName'  is [String]           - value is [TherapistFile]...
    //  TYPE of 'pfTherapistFileObject.objectId'        is [Optional<String>] - value is [Optional("dztxUrBZLr")]...
    //  TYPE of 'pfTherapistFileObject.createdAt'       is [Optional<Date>]   - value is [Optional(2024-11-13 17:13:57 +0000)]...
    //  TYPE of 'pfTherapistFileObject.updatedAt'       is [Optional<Date>]   - value is [Optional(2024-11-14 22:30:00 +0000)]...
    //  TYPE of 'pfTherapistFileObject.acl'             is [Optional<PFACL>]  - value is [nil]...
    //  TYPE of 'pfTherapistFileObject.isDataAvailable' is [Bool]             - value is [true]...
    //  TYPE of 'pfTherapistFileObject.isDirty'         is [Bool]             - value is [false]...
    //  TYPE of 'pfTherapistFileObject.allKeys'         is [Array<String>]    - value is [["lastLocTime", "latitude", ...
    // ----------------------------------------------------------------------------------------------------------------

    // Item 'discrete' field(s):

    var sPFTherapistFileClassName:String                 = ""
    var sPFTherapistFileObjectId:String?                 = nil
    var datePFTherapistFileCreatedAt:Date?               = nil
    var datePFTherapistFileUpdatedAt:Date?               = nil
    var aclPFTherapistFile:PFACL?                        = nil
    var bPFTherapistFileIsDataAvailable:Bool             = false
    var bPFTherapistFileIdDirty:Bool                     = false
    var listPFTherapistFileAllKeys:[String]              = []

    // ----------------------------------------------------------------------------------------------------------
    // "ID"                 : NumberInt(277),
    // "name"               : "My Melissa Horton",
    // "phone"              : "5126099593",
    // "email"              : "horton.utd.slp@gmail.com",
    // "username"           : "MelissaH",
    // "password"           : "Gluumburst712!",
    // "homeLoc"            : [-97.06112670898438,32.79240417480469],
    // "licenseNum"         : NumberInt(0),
    // ----------------------------------------------------------------------------------------------------------

    // Item 'keyed' field(s):

    var iPFTherapistFileTID:Int                          = -1         // 'pfTherapistFileObject[ID]'
    var sPFTherapistFileName:String                      = "-N/A-"    // 'pfTherapistFileObject[name]'
    var sPFTherapistFilePhone:String                     = "-N/A-"    // 'pfTherapistFileObject[phone]'
    var sPFTherapistFileEmail:String                     = "-N/A-"    // 'pfTherapistFileObject[email]'
    var sPFTherapistFileUsername:String                  = "-N/A-"    // 'pfTherapistFileObject[username]'
    var sPFTherapistFilePassword:String                  = "-N/A-"    // 'pfTherapistFileObject[password]'
    var listPFTherapistFileHomeLoc:[String]              = []         // 'pfTherapistFileObject[homeLoc]' [latitude,longitude]
    var iPFTherapistFileLicenseNumber:Int                = -1         // 'pfTherapistFileObject[licenseNum]'

    // ----------------------------------------------------------------------------------------------------------
    // "notActive"          : Bool,
    // "office"             : Bool,
    // "isSupervisor"       : Bool,
    // "haveAssts"          : Bool,
    // "type"               : NumberInt(2),
    // "superID"            : NumberInt(5),
    // "mentorID"           : NumberInt(5), // #9 -> means NOT Assigned...
    // ----------------------------------------------------------------------------------------------------------

    // Item 'keyed' field(s):

    var bPFTherapistFileNotActive:Bool                   = false      // 'pfTherapistFileObject[notActive]'
    var bPFTherapistFileOffice:Bool                      = false      // 'pfTherapistFileObject[office]'
    var bPFTherapistFileIsSupervisor:Bool                = false      // 'pfTherapistFileObject[isSupervisor]'
    var bPFTherapistFileHaveAssistants:Bool              = false      // 'pfTherapistFileObject[haveAssts]'
    var iPFTherapistFileType:Int                         = -1         // 'pfTherapistFileObject[type]'
    var iPFTherapistFileSuperID:Int                      = -1         // 'pfTherapistFileObject[superID]'
    var iPFTherapistFileMentorID:Int                     = -1         // 'pfTherapistFileObject[mentorID]'

    // ----------------------------------------------------------------------------------------------------------
    // "lastSync"           : "Dec 26,2024 at 11:18 AM",
    // "iPadUpdate"         : NumberInt(268),
    // "iPhoneUpdate"       : NumberInt(267),
    // ----------------------------------------------------------------------------------------------------------

    // Item 'keyed' field(s):

    var sPFTherapistFileLastSync:String                  = "-N/A"     // 'pfTherapistFileObject[lastSync]'
    var iPFTherapistFileIpadUpdate:Int                   = -1         // 'pfTherapistFileObject[iPadUpdate]'
    var iPFTherapistFileIphoneUpdate:Int                 = -1         // 'pfTherapistFileObject[iPhoneUpdate]'

    // ----------------------------------------------------------------------------------------------------------
    // "startWk"            : "12/21/24",
    // "wkStartInvoice"     : "12/21/24",
    // "expectedWkVisits"   : NumberInt(0),
    // "lateWkVisits"       : NumberInt(0),
    // "prevWkVoids2"       : null,
    // "makeupsAllowed"     : Bool,
    // "over50Allowed"      : Bool,
    // "finalSyncRatios"    : ["12/20/24, 3:13 PM;On Time: 0 - Late: 0 - Missed Deadline: 3"],
    // "wkPtsMissingVisits" : [...],
    // "pidsForFriday"      : ["13819","13664","13740","13861","13741"],
    // "parentIDs"          : ["Abdulrahman Bashir",NumberInt(1340),"...]
    // ----------------------------------------------------------------------------------------------------------

    // Item 'keyed' field(s):

    var sPFTherapistFileStartWeek:String                 = "-N/A-"    // 'pfTherapistFileObject[startWk]'
    var sPFTherapistFileWeekStartInvoice:String          = "-N/A-"    // 'pfTherapistFileObject[wkStartInvoice]'
    var iPFTherapistFileExpectedWeekVisits:Int           = -1         // 'pfTherapistFileObject[expectedWkVisits]'
    var iPFTherapistFileLateWeekVisits:Int               = -1         // 'pfTherapistFileObject[lateWkVisits]'
    var iPFTherapistFilePreviousWeekVoids2:Int           = -1         // 'pfTherapistFileObject[prevWkVoids2]'
    var bPFTherapistFileMakeupsAllowed:Bool              = false      // 'pfTherapistFileObject[makeupsAllowed]'
    var bPFTherapistFileOver50Allowed:Bool               = false      // 'pfTherapistFileObject[over50Allowed]'

    var listPFTherapistFileFinalSyncRatios:[String]      = []         // 'pfTherapistFileObject[finalSyncRatios]'
    var listPFTherapistFileWeekPtMissingVisits:[String]  = []         // 'pfTherapistFileObject[wkPtsMissingVisits]'
    var listPFTherapistFilePidsForFriday:[String]        = []         // 'pfTherapistFileObject[pidsForFriday]'
    var listPFTherapistFileParentIDs:[String]            = []         // 'pfTherapistFileObject[parentIDs]'

    // ----------------------------------------------------------------------------------------------------------------
    //  TYPE of 'pfTherapistFileObjectLatitude'     is [Optional<Any>] - value is [Optional(32.77201080322266)]...
    //  TYPE of 'pfTherapistFileObjectLongitude'    is [Optional<Any>] - value is [Optional(-96.5831298828125)]...
    //  TYPE of 'sPFTherapistFileObjectLatitude'    is [String]        - value is [32.77201080322266]...
    //  TYPE of 'sPFTherapistFileObjectLongitude'   is [String]        - value is [-96.5831298828125]...
    //  TYPE of 'dblPFTherapistFileObjectLatitude'  is [Double]        - value is [32.77201080322266]...
    //  TYPE of 'dblPFTherapistFileObjectLongitude' is [Double]        - value is [-96.5831298828125]...
    //  TYPE of 'dblConvertedLatitude'              is [Double]        - value is [32.77201080322266]...
    //  TYPE of 'dblConvertedLongitude'             is [Double]        - value is [-96.5831298828125]...
    //  TYPE of 'sCurrentLocationName'              is [String]        - value is [-N/A-]...
    //  TYPE of 'sCurrentCity'                      is [String]        - value is [-N/A-]...
    // ----------------------------------------------------------------------------------------------------------------

    // Item 'calculated'/'converted'/'looked'-up/'computed' field(s):

    var pfTherapistFileObjectLatitude:Any?               = nil
    var pfTherapistFileObjectLongitude:Any?              = nil

    var sPFTherapistFileObjectLatitude:String            = "0.0"
    var sPFTherapistFileObjectLongitude:String           = "0.0"

    var dblPFTherapistFileObjectLatitude:Double          = 0.0
    var dblPFTherapistFileObjectLongitude:Double         = 0.0

    var dblConvertedLatitude:Double                      = 0.0
    var dblConvertedLongitude:Double                     = 0.0

    var sCurrentLocationName:String                      = ""
    var sCurrentCity:String                              = ""
    var sCurrentCountry:String                           = ""
    var sCurrentPostalCode:String                        = ""
    var sCurrentTimeZone:String                          = ""

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

    // Item address 'lookup' completed flag:

    var bCurrentAddessLookupComplete:Bool                = false

    // App Data field(s):

    var jmAppDelegateVisitor:JmAppDelegateVisitor        = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    
    override init()
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        super.init()

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'jmAppDelegateVisitor' is [\(self.jmAppDelegateVisitor)]...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'jmAppDelegateVisitor' is [\(self.jmAppDelegateVisitor)]...")

        return

    }   // End of override init().

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
        asToString.append("'id': [\(String(describing: self.id))],")
        asToString.append("'pfTherapistFileObject': [\(String(describing: self.pfTherapistFileObject))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'sPFTherapistFileClassName': [\(String(describing: self.sPFTherapistFileClassName))],")
        asToString.append("'sPFTherapistFileObjectId': [\(String(describing: self.sPFTherapistFileObjectId))],")
        asToString.append("'datePFTherapistFileCreatedAt': [\(String(describing: self.datePFTherapistFileCreatedAt))],")
        asToString.append("'datePFTherapistFileUpdatedAt': [\(String(describing: self.datePFTherapistFileUpdatedAt))],")
        asToString.append("'aclPFTherapistFile': [\(String(describing: self.aclPFTherapistFile))],")
        asToString.append("'bPFTherapistFileIsDataAvailable': [\(String(describing: self.bPFTherapistFileIsDataAvailable))],")
        asToString.append("'bPFTherapistFileIdDirty': [\(String(describing: self.bPFTherapistFileIdDirty))],")
        asToString.append("'listPFTherapistFileAllKeys': [\(String(describing: self.listPFTherapistFileAllKeys))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'iPFTherapistFileTID': (\(String(describing: self.iPFTherapistFileTID))),")
        asToString.append("'sPFTherapistFileName': [\(String(describing: self.sPFTherapistFileName))],")
        asToString.append("'sPFTherapistFilePhone': [\(String(describing: self.sPFTherapistFilePhone))],")
        asToString.append("'sPFTherapistFileEmail': [\(String(describing: self.sPFTherapistFileEmail))],")
        asToString.append("'sPFTherapistFileUsername': [\(String(describing: self.sPFTherapistFileUsername))],")
        asToString.append("'sPFTherapistFilePassword': [\(String(describing: self.sPFTherapistFilePassword))],")
        asToString.append("'listPFTherapistFileHomeLoc': [\(String(describing: self.listPFTherapistFileHomeLoc))],")
        asToString.append("'iPFTherapistFileLicenseNumber': (\(String(describing: self.iPFTherapistFileLicenseNumber))),")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'bPFTherapistFileNotActive': [\(String(describing: self.bPFTherapistFileNotActive))],")
        asToString.append("'bPFTherapistFileOffice': [\(String(describing: self.bPFTherapistFileOffice))],")
        asToString.append("'bPFTherapistFileIsSupervisor': [\(String(describing: self.bPFTherapistFileIsSupervisor))],")
        asToString.append("'bPFTherapistFileHaveAssistants': [\(String(describing: self.bPFTherapistFileHaveAssistants))],")
        asToString.append("'iPFTherapistFileType': (\(String(describing: self.iPFTherapistFileType))),")
        asToString.append("'iPFTherapistFileSuperID': (\(String(describing: self.iPFTherapistFileSuperID))),")
        asToString.append("'iPFTherapistFileMentorID': (\(String(describing: self.iPFTherapistFileMentorID))),")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'sPFTherapistFileLastSync': [\(String(describing: self.sPFTherapistFileLastSync))],")
        asToString.append("'iPFTherapistFileIpadUpdate': (\(String(describing: self.iPFTherapistFileIpadUpdate))),")
        asToString.append("'iPFTherapistFileIphoneUpdate': (\(String(describing: self.iPFTherapistFileIphoneUpdate))),")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'sPFTherapistFileStartWeek': [\(String(describing: self.sPFTherapistFileStartWeek))],")
        asToString.append("'sPFTherapistFileWeekStartInvoice': [\(String(describing: self.sPFTherapistFileWeekStartInvoice))],")
        asToString.append("'iPFTherapistFileExpectedWeekVisits': (\(String(describing: self.iPFTherapistFileExpectedWeekVisits))),")
        asToString.append("'iPFTherapistFileLateWeekVisits': (\(String(describing: self.iPFTherapistFileLateWeekVisits))),")
        asToString.append("'iPFTherapistFilePreviousWeekVoids2': (\(String(describing: self.iPFTherapistFilePreviousWeekVoids2))),")
        asToString.append("'bPFTherapistFileMakeupsAllowed': [\(String(describing: self.bPFTherapistFileMakeupsAllowed))],")
        asToString.append("'bPFTherapistFileOver50Allowed': [\(String(describing: self.bPFTherapistFileOver50Allowed))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'listPFTherapistFileFinalSyncRatios': [\(String(describing: self.listPFTherapistFileFinalSyncRatios))],")
        asToString.append("'listPFTherapistFileWeekPtMissingVisits': [\(String(describing: self.listPFTherapistFileWeekPtMissingVisits))],")
        asToString.append("'listPFTherapistFilePidsForFriday': [\(String(describing: self.listPFTherapistFilePidsForFriday))],")
        asToString.append("'listPFTherapistFileParentIDs': [\(String(describing: self.listPFTherapistFileParentIDs))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'pfTherapistFileObjectLatitude': [\(String(describing: self.pfTherapistFileObjectLatitude))],")
        asToString.append("'pfTherapistFileObjectLongitude': [\(String(describing: self.pfTherapistFileObjectLongitude))],")
        asToString.append("'sPFTherapistFileObjectLatitude': [\(String(describing: self.sPFTherapistFileObjectLatitude))],")
        asToString.append("'sPFTherapistFileObjectLongitude': [\(String(describing: self.sPFTherapistFileObjectLongitude))],")
        asToString.append("'dblPFTherapistFileObjectLatitude': [\(String(describing: self.dblPFTherapistFileObjectLatitude))],")
        asToString.append("'dblPFTherapistFileObjectLongitude': [\(String(describing: self.dblPFTherapistFileObjectLongitude))],")
        asToString.append("'dblConvertedLatitude': [\(String(describing: self.dblConvertedLatitude))],")
        asToString.append("'dblConvertedLongitude': [\(String(describing: self.dblConvertedLongitude))],")
        asToString.append("'sCurrentLocationName': [\(String(describing: self.sCurrentLocationName))],")
        asToString.append("'sCurrentCity': [\(String(describing: self.sCurrentCity))],")
        asToString.append("'sCurrentCountry': [\(String(describing: self.sCurrentCountry))],")
        asToString.append("'sCurrentPostalCode': [\(String(describing: self.sCurrentPostalCode))],")
        asToString.append("'sCurrentTimeZone': [\(String(describing: self.sCurrentTimeZone))],")
        asToString.append("'bCurrentAddessLookupComplete': [\(String(describing: self.bCurrentAddessLookupComplete))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'jmAppDelegateVisitor': [\(self.jmAppDelegateVisitor.toString())]")
        asToString.append("],")
        asToString.append("]")

        let sContents:String = "{"+(asToString.joined(separator: ""))+"}"

        return sContents

    }   // End of public func toString().

    public func displayParsePFTherapistFileItemToLog()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Display the various field(s) of this object in the Log...

        self.xcgLogMsg("\(sCurrMethodDisp) 'id'                                     is [\(String(describing: self.id))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'pfTherapistFileObject'                  is [\(String(describing: self.pfTherapistFileObject))]...")

        self.xcgLogMsg("\(sCurrMethodDisp) 'sPFTherapistFileClassName'              is [\(String(describing: self.sPFTherapistFileClassName))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sPFTherapistFileObjectId'               is [\(String(describing: self.sPFTherapistFileObjectId))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'datePFTherapistFileCreatedAt'           is [\(String(describing: self.datePFTherapistFileCreatedAt))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'datePFTherapistFileUpdatedAt'           is [\(String(describing: self.datePFTherapistFileUpdatedAt))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'aclPFTherapistFile'                     is [\(String(describing: self.aclPFTherapistFile))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'bPFTherapistFileIsDataAvailable'        is [\(String(describing: self.bPFTherapistFileIsDataAvailable))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'bPFTherapistFileIdDirty'                is [\(String(describing: self.bPFTherapistFileIdDirty))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'listPFTherapistFileAllKeys'             is [\(String(describing: self.listPFTherapistFileAllKeys))]...")

        self.xcgLogMsg("\(sCurrMethodDisp) 'iPFTherapistFileTID'                    is (\(String(describing: self.iPFTherapistFileTID)))...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sPFTherapistFileName'                   is [\(String(describing: self.sPFTherapistFileName))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sPFTherapistFilePhone'                  is [\(String(describing: self.sPFTherapistFilePhone))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sPFTherapistFileEmail'                  is [\(String(describing: self.sPFTherapistFileEmail))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sPFTherapistFileUsername'               is [\(String(describing: self.sPFTherapistFileUsername))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sPFTherapistFilePassword'               is [\(String(describing: self.sPFTherapistFilePassword))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'listPFTherapistFileHomeLoc'             is [\(String(describing: self.listPFTherapistFileHomeLoc))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'iPFTherapistFileLicenseNumber'          is (\(String(describing: self.iPFTherapistFileLicenseNumber)))...")

        self.xcgLogMsg("\(sCurrMethodDisp) 'bPFTherapistFileNotActive'              is [\(String(describing: self.bPFTherapistFileNotActive))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'bPFTherapistFileOffice'                 is [\(String(describing: self.bPFTherapistFileOffice))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'bPFTherapistFileIsSupervisor'           is [\(String(describing: self.bPFTherapistFileIsSupervisor))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'bPFTherapistFileHaveAssistants'         is [\(String(describing: self.bPFTherapistFileHaveAssistants))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'iPFTherapistFileType'                   is (\(String(describing: self.iPFTherapistFileType)))...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'iPFTherapistFileSuperID'                is (\(String(describing: self.iPFTherapistFileSuperID)))...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'iPFTherapistFileMentorID'               is (\(String(describing: self.iPFTherapistFileMentorID)))...")

        self.xcgLogMsg("\(sCurrMethodDisp) 'sPFTherapistFileLastSync'               is [\(String(describing: self.sPFTherapistFileLastSync))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'iPFTherapistFileIpadUpdate'             is (\(String(describing: self.iPFTherapistFileIpadUpdate)))...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'iPFTherapistFileIphoneUpdate'           is (\(String(describing: self.iPFTherapistFileIphoneUpdate)))...")

        self.xcgLogMsg("\(sCurrMethodDisp) 'sPFTherapistFileStartWeek'              is [\(String(describing: self.sPFTherapistFileStartWeek))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sPFTherapistFileWeekStartInvoice'       is [\(String(describing: self.sPFTherapistFileWeekStartInvoice))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'iPFTherapistFileExpectedWeekVisits'     is (\(String(describing: self.iPFTherapistFileExpectedWeekVisits)))...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'iPFTherapistFileLateWeekVisits'         is (\(String(describing: self.iPFTherapistFileLateWeekVisits)))...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'iPFTherapistFilePreviousWeekVoids2'     is (\(String(describing: self.iPFTherapistFilePreviousWeekVoids2)))...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'bPFTherapistFileMakeupsAllowed'         is [\(String(describing: self.bPFTherapistFileMakeupsAllowed))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'bPFTherapistFileOver50Allowed'          is [\(String(describing: self.bPFTherapistFileOver50Allowed))]...")

        self.xcgLogMsg("\(sCurrMethodDisp) 'listPFTherapistFileFinalSyncRatios'     is [\(String(describing: self.listPFTherapistFileFinalSyncRatios))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'listPFTherapistFileWeekPtMissingVisits' is [\(String(describing: self.listPFTherapistFileWeekPtMissingVisits))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'listPFTherapistFilePidsForFriday'       is [\(String(describing: self.listPFTherapistFilePidsForFriday))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'listPFTherapistFileParentIDs'           is [\(String(describing: self.listPFTherapistFileParentIDs))]...")

        self.xcgLogMsg("\(sCurrMethodDisp) 'pfTherapistFileObjectLatitude'          is [\(String(describing: self.pfTherapistFileObjectLatitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'pfTherapistFileObjectLongitude'         is [\(String(describing: self.pfTherapistFileObjectLongitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sPFTherapistFileObjectLatitude'         is [\(String(describing: self.sPFTherapistFileObjectLatitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sPFTherapistFileObjectLongitude'        is [\(String(describing: self.sPFTherapistFileObjectLongitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'dblPFTherapistFileObjectLatitude'       is [\(String(describing: self.dblPFTherapistFileObjectLatitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'dblPFTherapistFileObjectLongitude'      is [\(String(describing: self.dblPFTherapistFileObjectLongitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'dblConvertedLatitude'                   is [\(String(describing: self.dblConvertedLatitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'dblConvertedLongitude'                  is [\(String(describing: self.dblConvertedLongitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sCurrentLocationName'                   is [\(String(describing: self.sCurrentLocationName))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sCurrentCity'                           is [\(String(describing: self.sCurrentCity))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sCurrentCountry'                        is [\(String(describing: self.sCurrentCountry))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sCurrentPostalCode'                     is [\(String(describing: self.sCurrentPostalCode))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sCurrentTimeZone'                       is [\(String(describing: self.sCurrentTimeZone))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'bCurrentAddessLookupComplete'           is [\(String(describing: self.bCurrentAddessLookupComplete))]...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // END of public func displayParsePFTherapistFileItemToLog().

    public func constructParsePFTherapistFileItemFromPFObject(pfTherapistFileObject:PFObject)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'pfTherapistFileObject' is [\(String(describing: pfTherapistFileObject))]...")

        // Assign the various field(s) of this object from the supplied PFObject...

        self.pfTherapistFileObject                  = pfTherapistFileObject                                                             
        
        self.sPFTherapistFileClassName              = pfTherapistFileObject.parseClassName
        self.sPFTherapistFileObjectId               = pfTherapistFileObject.objectId  != nil ? pfTherapistFileObject.objectId!  : ""
        self.datePFTherapistFileCreatedAt           = pfTherapistFileObject.createdAt != nil ? pfTherapistFileObject.createdAt! : nil
        self.datePFTherapistFileUpdatedAt           = pfTherapistFileObject.updatedAt != nil ? pfTherapistFileObject.updatedAt! : nil
        self.aclPFTherapistFile                     = pfTherapistFileObject.acl
        self.bPFTherapistFileIsDataAvailable        = pfTherapistFileObject.isDataAvailable
        self.bPFTherapistFileIdDirty                = pfTherapistFileObject.isDirty
        self.listPFTherapistFileAllKeys             = pfTherapistFileObject.allKeys

        self.iPFTherapistFileTID                    = Int(String(describing: pfTherapistFileObject.object(forKey:"ID")))         ?? -1
        self.sPFTherapistFileName                   = String(describing: (pfTherapistFileObject.object(forKey:"name")            ?? ""))
        self.sPFTherapistFilePhone                  = String(describing: (pfTherapistFileObject.object(forKey:"phone")           ?? ""))
        self.sPFTherapistFileEmail                  = String(describing: (pfTherapistFileObject.object(forKey:"email")           ?? ""))
        self.sPFTherapistFileUsername               = String(describing: (pfTherapistFileObject.object(forKey:"username")        ?? ""))
        self.sPFTherapistFilePassword               = String(describing: (pfTherapistFileObject.object(forKey:"password")        ?? ""))
    //  self.listPFTherapistFileHomeLoc             = pfTherapistFileObject.object(forKey:"homeLoc") ?? []
        self.iPFTherapistFileLicenseNumber          = Int(String(describing: pfTherapistFileObject.object(forKey:"licenseNum"))) ?? -1

        self.bPFTherapistFileNotActive              = Bool(String(describing: pfTherapistFileObject.object(forKey:"notActive")))    ?? false
        self.bPFTherapistFileOffice                 = Bool(String(describing: pfTherapistFileObject.object(forKey:"office")))       ?? false
        self.bPFTherapistFileIsSupervisor           = Bool(String(describing: pfTherapistFileObject.object(forKey:"isSupervisor"))) ?? false
        self.bPFTherapistFileHaveAssistants         = Bool(String(describing: pfTherapistFileObject.object(forKey:"haveAssts")))    ?? false
        self.iPFTherapistFileType                   = pfTherapistFileObject.object(forKey:"type")!     as! Int
        self.iPFTherapistFileSuperID                = pfTherapistFileObject.object(forKey:"superID")!  as! Int
        self.iPFTherapistFileMentorID               = pfTherapistFileObject.object(forKey:"mentorID")! as! Int

        self.sPFTherapistFileLastSync               = String(describing: pfTherapistFileObject.object(forKey:"lastSync")!)
        self.iPFTherapistFileIpadUpdate             = pfTherapistFileObject.object(forKey:"iPadUpdate")!   as! Int
        self.iPFTherapistFileIphoneUpdate           = pfTherapistFileObject.object(forKey:"iPhoneUpdate")! as! Int

        self.sPFTherapistFileStartWeek              = String(describing: pfTherapistFileObject.object(forKey:"startWk")!)
        self.sPFTherapistFileWeekStartInvoice       = String(describing: pfTherapistFileObject.object(forKey:"wkStartInvoice")!)
        self.iPFTherapistFileExpectedWeekVisits     = pfTherapistFileObject.object(forKey:"expectedWkVisits")! as! Int
        self.iPFTherapistFileLateWeekVisits         = pfTherapistFileObject.object(forKey:"lateWkVisits")!     as! Int
    //  self.iPFTherapistFilePreviousWeekVoids2     = pfTherapistFileObject.object(forKey:"prevWkVoids2")!     as! Int
        self.bPFTherapistFileMakeupsAllowed         = Bool(String(describing: pfTherapistFileObject.object(forKey:"makeupsAllowed"))) ?? false
        self.bPFTherapistFileOver50Allowed          = Bool(String(describing: pfTherapistFileObject.object(forKey:"over50Allowed")))  ?? false

    //  self.listPFTherapistFileFinalSyncRatios     = pfTherapistFileObject[finalSyncRatios]!
    //  self.listPFTherapistFileWeekPtMissingVisits = pfTherapistFileObject[wkPtsMissingVisits]!
    //  self.listPFTherapistFilePidsForFriday       = pfTherapistFileObject[pidsForFriday]!
    //  self.listPFTherapistFileParentIDs           = pfTherapistFileObject[parentIDs]!
        
    //  self.pfTherapistFileObjectLatitude          = (pfTherapistFileObject.object(forKey:"latitude"))  != nil ? pfTherapistFileObject.object(forKey:"latitude")  : nil
    //  self.pfTherapistFileObjectLongitude         = (pfTherapistFileObject.object(forKey:"longitude")) != nil ? pfTherapistFileObject.object(forKey:"longitude") : nil
    //  self.sPFTherapistFileObjectLatitude         = String(describing: self.pfTherapistFileObjectLatitude!)
    //  self.sPFTherapistFileObjectLongitude        = String(describing: self.pfTherapistFileObjectLongitude!)
    //  self.dblPFTherapistFileObjectLatitude       = Double(self.sPFTherapistFileObjectLatitude)  ?? 0.0
    //  self.dblPFTherapistFileObjectLongitude      = Double(self.sPFTherapistFileObjectLongitude) ?? 0.0
    //  self.dblConvertedLatitude                   = Double(String(describing: pfTherapistFileObject.object(forKey:"latitude")!))  ?? 0.0
    //  self.dblConvertedLongitude                  = Double(String(describing: pfTherapistFileObject.object(forKey:"longitude")!)) ?? 0.0
    //  
    //  self.sCurrentLocationName                   = ""
    //  self.sCurrentCity                           = ""
    //  self.sCurrentCountry                        = ""
    //  self.sCurrentPostalCode                     = ""
    //  self.sCurrentTimeZone                       = ""
    //
    //  self.bCurrentAddessLookupComplete           = false
    //
    //  if (self.jmAppDelegateVisitor.jmAppCLModelObservable2 != nil)
    //  {
    //
    //      let clModelObservable2:CoreLocationModelObservable2 = self.jmAppDelegateVisitor.jmAppCLModelObservable2!
    //
    //      self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idpfTherapistFileObject)): Calling 'updateGeocoderLocation()' for Latitude/Longitude of [\(self.dblConvertedLatitude)/\(self.dblConvertedLongitude)]...")
    //
    //      let _ = clModelObservable2.updateGeocoderLocations(requestID: self.idpfTherapistFileObject, 
    //                                                         latitude:  self.dblConvertedLatitude, 
    //                                                         longitude: self.dblConvertedLongitude, 
    //                                                         withCompletionHandler:
    //                                                             { (requestID:Int, dictCurrentLocation:[String:Any]) in
    //                                                         
    //                                                                 self.sCurrentLocationName         = String(describing: (dictCurrentLocation["sCurrentLocationName"] ?? ""))
    //                                                                 self.sCurrentCity                 = String(describing: (dictCurrentLocation["sCurrentCity"]         ?? ""))
    //                                                                 self.sCurrentCountry              = String(describing: (dictCurrentLocation["sCurrentCountry"]      ?? ""))
    //                                                                 self.sCurrentPostalCode           = String(describing: (dictCurrentLocation["sCurrentPostalCode"]   ?? ""))
    //                                                                 self.sCurrentTimeZone             = String(describing: (dictCurrentLocation["tzCurrentTimeZone"]    ?? ""))
    //                                                                 self.bCurrentAddessLookupComplete = true
    //                                                         
    //                                                             }
    //                                                        )
    //
    //  }
    //  else
    //  {
    //
    //      self.xcgLogMsg("\(sCurrMethodDisp) #(\(self.idpfTherapistFileObject)): CoreLocation (service) is NOT available...")
    //
    //      self.bCurrentAddessLookupComplete = false
    //
    //  }

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // END of public func constructParsePFTherapistFileItemFromPFObject(pfTherapistFileObject:PFObject).

}   // End of class ParsePFTherapistFileItem(NSObject, Identifiable).

