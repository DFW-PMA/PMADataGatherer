//
//  ScheduledPatientLocationItem.swift
//  JustAFirstSwiftDataApp1
//
//  Created by Daryl Cox on 12/04/2024.
//  Copyright © JustMacApps 2023-2025. All rights reserved.
//

import Foundation
import ParseCore

class ScheduledPatientLocationItem: NSObject, Identifiable, ObservableObject
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "ScheduledPatientLocationItem"
        static let sClsVers      = "v1.1202"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2025. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    var id:UUID                                             = UUID()
    var idSchedPatLocObject:Int                             = 0

    var schedPatLocClonedFrom:ScheduledPatientLocationItem? = nil 
    var schedPatLocClonedTo:ScheduledPatientLocationItem?   = nil 

    var sTid:String                                         = "-1" // From 'PFAdminsSwiftDataItem' <String>
                                                                   // -OR- 'PFQuery::TherapistFile["ID"]'
                                                                   // -OR- 'PFQuery::PatientCalDay["tid"]'
    var iTid:Int                                            = -1   // Converted from 'sTid <String>'...
    var sTName:String                                       = ""   // From 'PFQuery::PatientCalDay["tName"]'
    var sTherapistName:String                               = ""   // From 'PFQuery::TherapistFile["name"]' 

    var sPid:String                                         = "-1" // From 'PFQuery::PatientCalDay["pid"]' <Int>
    var iPid:Int                                            = -1   // Converted from 'sPid <String>'...
    var sPtName:String                                      = ""   // From 'PFQuery::PatientCalDay["ptName"]'

    var sVDate:String                                       = ""   // From 'PFQuery::PatientCalDay["VDate"]'
    var sVDateStartTime:String                              = ""   // From 'PFQuery::PatientCalDay["startTime"]'
    var sVDateStartTime24h:String                           = ""   // Converted from 'sVDateStartTime'
    var iVDateStartTime24h:Int                              = 0    // Converted from 'sVDateStartTime24h'

    var sLastVDate:String                                   = ""   // From 'PFQuery::BackupVisit["VDate"]'
    var sLastVDateType:String                               = "-1" // From 'PFQuery::BackupVisit["type"]'
    var iLastVDateType:Int                                  = -1   // Converted from 'sLastVDateType <String>'...
    var sLastVDateLatitude:String                           = ""   // From 'PFQuery::BackupVisit["lat"]'
    var sLastVDateLongitude:String                          = ""   // From 'PFQuery::BackupVisit["long"]'
    var sLastVDateAddress:String                            = ""   // From 'PFQuery::BackupVisit["address"]'

    var clLocationCoordinate2DPatLoc:CLLocationCoordinate2D
    {

        return CLLocationCoordinate2D(latitude:  Double(self.sLastVDateLatitude)  ?? 0.0,
                                      longitude: Double(self.sLastVDateLongitude) ?? 0.0)

    }

    var sVDateAddressOrLatLong:String
    {

        if (self.sLastVDateAddress.count  < 1       ||
            self.sLastVDateAddress       == ""      ||
            self.sLastVDateAddress       == "-N/A-" ||
            self.sLastVDateAddress       == ",,,"   ||
            self.sLastVDateAddress       == ", , , ")
        {

            return ("\(self.sLastVDateLatitude), \(self.sLastVDateLongitude)")

        }
        else
        {

            return (self.sLastVDateAddress)

        }

    }

    var sVDateShortDisplay:String
    {

        if (self.sVDate.count < 1)
        {
        
            return self.sVDate
        
        }
        
        let strategyVDate                  = Date.ParseStrategy(format:  "\(year:.defaultDigits)-\(month:.twoDigits)-\(day:.twoDigits)", 
                                                                timeZone:.current)
        let dateVDate:Date                 = try! Date(self.sVDate, strategy:strategyVDate)
        let dtFormatterVDate:DateFormatter = DateFormatter()

        dtFormatterVDate.locale            = Locale(identifier: "en_US")
        dtFormatterVDate.timeZone          = TimeZone.current
        dtFormatterVDate.dateFormat        = "M/dd/yy"

        return "\(dtFormatterVDate.string(from:dateVDate))"

    }

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

    convenience init(scheduledPatientLocationItem:ScheduledPatientLocationItem)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
  
        self.init()
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter - 'scheduledPatientLocationItem' is [\(scheduledPatientLocationItem)]...")

        // Finish the 'convenience' setup of field(s)...

        self.init(bDeepCopyIsAnOverlay:false, scheduledPatientLocationItem:scheduledPatientLocationItem)

        // Exit:
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return
  
    }   // End of convenience init(scheduledPatientLocationItem:ScheduledPatientLocationItem).

    convenience init(bDeepCopyIsAnOverlay:Bool, scheduledPatientLocationItem:ScheduledPatientLocationItem)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
  
        self.init()
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter is 'scheduledPatientLocationItem' is [\(scheduledPatientLocationItem)]...")

        // Finish the 'convenience' setup of field(s)...

        self.overlayScheduledPatientLocationItemWithAnotherScheduledPatientLocationItem(scheduledPatientLocationItem:scheduledPatientLocationItem)

        if (bDeepCopyIsAnOverlay == false)
        {
        
            self.schedPatLocClonedFrom                         = scheduledPatientLocationItem
            self.schedPatLocClonedFrom                         = self

        //  scheduledPatientLocationItem.schedPatLocClonedFrom = nil
            scheduledPatientLocationItem.schedPatLocClonedFrom = self
        
        }

    //  // Check if the 'current' Location data copied was 'blank'...
    //
    //  if (self.sHomeLocLocationName.count < 1 ||
    //      self.sHomeLocCity.count         < 1)
    //  {
    //  
    //      self.xcgLogMsg("\(sCurrMethodDisp) Intermediate <dup copy 'init'> <ScheduledPatientLocationItem> - Copied 'self.sHomeLocLocationName' is [\(self.sHomeLocLocationName)] and 'self.sHomeLocCity' is [\(self.sHomeLocCity)] - 1 or both are 'blank' - 'pfTherapistFileItem.sHomeLocLocationName' is [\(pfTherapistFileItem.sHomeLocLocationName)] and 'pfTherapistFileItem.sHomeLocCity' is [\(pfTherapistFileItem.sHomeLocCity)] - Warning!")
    //  
    //  }
    //
    //  // Trace the 'clone' From/To fields in both objects...
    //
    //  self.xcgLogMsg("\(sCurrMethodDisp) Intermediate <dup copy 'init'> <ScheduledPatientLocationItem> - From/To 'self.pfTherapistFileObjectClonedFrom' is [\(String(describing: self.pfTherapistFileObjectClonedFrom))] and 'self.pfTherapistFileObjectClonedTo' is [\(String(describing: self.pfTherapistFileObjectClonedTo))] - 'pfTherapistFileItem.pfTherapistFileObjectClonedFrom' is [\(String(describing: pfTherapistFileItem.pfTherapistFileObjectClonedFrom))] and 'pfTherapistFileItem.pfTherapistFileObjectClonedTo' is [\(String(describing: pfTherapistFileItem.pfTherapistFileObjectClonedTo))]...")

        // Exit:
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return
  
    }   // End of convenience init(bDeepCopyIsAnOverlay:Bool, scheduledPatientLocationItem:ScheduledPatientLocationItem).

    convenience init(pfTherapistFileItem:PFObject)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
  
        self.init()
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter is 'pfTherapistFileItem.ID' is [\(String(describing: pfTherapistFileItem.object(forKey:"ID")))]...")

        // Finish the 'convenience' setup of field(s)...

        self.updateScheduledPatientLocationItemFromPFTherapistFile(pfTherapistFileItem:pfTherapistFileItem)

        // Exit:
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return
  
    }   // End of convenience init(pfTherapistFileItem:PFObject).

    convenience init(pfPatientCalDayItem:PFObject)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
  
        self.init()
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter is 'pfPatientCalDayItem.tid' is [\(String(describing: pfPatientCalDayItem.object(forKey:"tid")))]...")

        // Finish the 'convenience' setup of field(s)...

        self.updateScheduledPatientLocationItemFromPFPatientCalDay(pfPatientCalDayItem:pfPatientCalDayItem)

        // Exit:
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return
  
    }   // End of convenience init(pfPatientCalDayItem:PFObject).

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
        asToString.append("'idSchedPatLocObject': [\(String(describing: self.idSchedPatLocObject))],")
        asToString.append("'schedPatLocClonedFrom': [\(String(describing: self.schedPatLocClonedFrom))],")
        asToString.append("'schedPatLocClonedTo': [\(String(describing: self.schedPatLocClonedTo))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'sTid': [\(String(describing: self.sTid))],")
        asToString.append("'iTid': (\(String(describing: self.iTid))),")
        asToString.append("'sTName': [\(String(describing: self.sTName))],")
        asToString.append("'sTherapistName': [\(String(describing: self.sTherapistName))],")
        asToString.append("'sPid': [\(String(describing: self.sPid))],")
        asToString.append("'iPid': (\(String(describing: self.iPid))),")
        asToString.append("'sPtName': [\(String(describing: self.sPtName))],")
        asToString.append("],")
        asToString.append("[")
        asToString.append("'sVDate': [\(String(describing: self.sVDate))],")
        asToString.append("'sVDateStartTime': [\(String(describing: self.sVDateStartTime))],")
        asToString.append("'sVDateStartTime24h': [\(String(describing: self.sVDateStartTime24h))],")
        asToString.append("'iVDateStartTime24h': (\(String(describing: self.iVDateStartTime24h))),")
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
        asToString.append("'clLocationCoordinate2DPatLoc': [\(String(describing: self.clLocationCoordinate2DPatLoc))],")
        asToString.append("'sVDateAddressOrLatLong': [\(String(describing: self.sVDateAddressOrLatLong))],")
        asToString.append("'sVDateShortDisplay': [\(String(describing: self.sVDateShortDisplay))],")
    //  asToString.append("],")
    //  asToString.append("[")
    //  asToString.append("'jmAppDelegateVisitor': [\(self.jmAppDelegateVisitor)],")
        asToString.append("],")
        asToString.append("]")

        let sContents:String = "{"+(asToString.joined(separator: ""))+"}"

        return sContents

    }   // End of public func toString().

    public func displayScheduledPatientLocationItemToLog()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Display the various field(s) of this object...

        self.xcgLogMsg("\(sCurrMethodDisp) 'self'                  is [\(String(describing: self))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'id'                    is [\(String(describing: self.id))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'idSchedPatLocObject'   is [\(String(describing: self.idSchedPatLocObject))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'schedPatLocClonedFrom' is [\(String(describing: self.schedPatLocClonedFrom))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'schedPatLocClonedTo'   is [\(String(describing: self.schedPatLocClonedTo))]...")

        self.xcgLogMsg("\(sCurrMethodDisp) 'sTid'                  is [\(String(describing: self.sTid))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'iTid'                  is (\(String(describing: self.iTid)))...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sTName'                is [\(String(describing: self.sTName))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sTherapistName'        is [\(String(describing: self.sTherapistName))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sPid'                  is [\(String(describing: self.sPid))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'iPid'                  is (\(String(describing: self.iPid)))...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sPtName'               is [\(String(describing: self.sPtName))]...")

        self.xcgLogMsg("\(sCurrMethodDisp) 'sVDate'                is [\(String(describing: self.sVDate))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sVDateStartTime'       is [\(String(describing: self.sVDateStartTime))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sVDateStartTime24h'    is [\(String(describing: self.sVDateStartTime24h))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'iVDateStartTime24h'    is (\(String(describing: self.iVDateStartTime24h)))...")

        self.xcgLogMsg("\(sCurrMethodDisp) 'sLastVDate'            is [\(String(describing: self.sLastVDate))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sLastVDateType'        is [\(String(describing: self.sLastVDateType))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'iLastVDateType'        is (\(String(describing: self.iLastVDateType)))...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sLastVDateLatitude'    is [\(String(describing: self.sLastVDateLatitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sLastVDateLongitude'   is [\(String(describing: self.sLastVDateLongitude))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) 'sLastVDateAddress'     is [\(String(describing: self.sLastVDateAddress))]...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of public func displayScheduledPatientLocationItemToLog().

    public func overlayScheduledPatientLocationItemWithAnotherScheduledPatientLocationItem(scheduledPatientLocationItem:ScheduledPatientLocationItem)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
  
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter is 'scheduledPatientLocationItem' is [\(scheduledPatientLocationItem)]...")

        // Finish the 'convenience' setup of field(s)...

        self.idSchedPatLocObject                           = scheduledPatientLocationItem.idSchedPatLocObject 

    //  // 'Object' From/To update does NOT occur in an 'overlay'...
    //
    //  self.schedPatLocClonedFrom                         = scheduledPatientLocationItem 
    //  self.schedPatLocClonedTo                           = nil 
    //
    //  scheduledPatientLocationItem.schedPatLocClonedFrom = nil
    //  scheduledPatientLocationItem.schedPatLocClonedTo   = self

        self.sTid                                          = scheduledPatientLocationItem.sTid               
        self.iTid                                          = scheduledPatientLocationItem.iTid               
        self.sTName                                        = scheduledPatientLocationItem.sTName             
        self.sTherapistName                                = scheduledPatientLocationItem.sTherapistName     
                                                                                                             
        self.sPid                                          = scheduledPatientLocationItem.sPid               
        self.iPid                                          = scheduledPatientLocationItem.iPid               
        self.sPtName                                       = scheduledPatientLocationItem.sPtName            
                                                                                                             
        self.sVDate                                        = scheduledPatientLocationItem.sVDate             
        self.sVDateStartTime                               = scheduledPatientLocationItem.sVDateStartTime    
        self.sVDateStartTime24h                            = scheduledPatientLocationItem.sVDateStartTime24h
        self.iVDateStartTime24h                            = scheduledPatientLocationItem.iVDateStartTime24h
                                                                                                             
        self.sLastVDate                                    = scheduledPatientLocationItem.sLastVDate         
        self.sLastVDateType                                = scheduledPatientLocationItem.sLastVDateType     
        self.iLastVDateType                                = scheduledPatientLocationItem.iLastVDateType     
        self.sLastVDateLatitude                            = scheduledPatientLocationItem.sLastVDateLatitude 
        self.sLastVDateLongitude                           = scheduledPatientLocationItem.sLastVDateLongitude
        self.sLastVDateAddress                             = scheduledPatientLocationItem.sLastVDateAddress  

        // Check if the 'current' Location data copied was 'blank'...

        if (self.sLastVDateAddress.count   < 1 ||
            self.sLastVDateLatitude.count  < 1 ||
            self.sLastVDateLongitude.count < 1)
        {
        
            self.xcgLogMsg("\(sCurrMethodDisp) Intermediate <dup copy> <SchedPatLoc> - Copied 'self.sLastVDateAddress' is [\(self.sLastVDateAddress)] and 'self.sLastVDateLatitude' is [\(self.sLastVDateLatitude)] and 'self.sLastVDateLongitude' is [\(self.sLastVDateLongitude)] - 1 or all 3 are 'blank' - 'scheduledPatientLocationItem.sLastVDateAddress' is [\(scheduledPatientLocationItem.sLastVDateAddress)] and 'scheduledPatientLocationItem.sLastVDateLatitude' is [\(scheduledPatientLocationItem.sLastVDateLatitude)] and 'scheduledPatientLocationItem.sLastVDateLongitude' is [\(scheduledPatientLocationItem.sLastVDateLongitude)] - Warning!")
        
        }

        // Trace the 'clone' From/To fields in both objects...

        self.xcgLogMsg("\(sCurrMethodDisp) Intermediate <dup copy> <SchedPatLoc> - From/To 'self.schedPatLocClonedFrom' is [\(String(describing: self.schedPatLocClonedFrom))] and 'self.schedPatLocClonedTo' is [\(String(describing: self.schedPatLocClonedTo))] - 'scheduledPatientLocationItem.schedPatLocClonedFrom' is [\(String(describing: scheduledPatientLocationItem.schedPatLocClonedFrom))] and 'scheduledPatientLocationItem.schedPatLocClonedTo' is [\(String(describing: scheduledPatientLocationItem.schedPatLocClonedTo))]...")

        // Exit:
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return
  
    }   // End of public func overlayScheduledPatientLocationItemWithAnotherScheduledPatientLocationItem(scheduledPatientLocationItem:ScheduledPatientLocationItem).
    
    public func updateScheduledPatientLocationItemFromPFTherapistFile(pfTherapistFileItem:PFObject)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter is 'pfTherapistFileItem.ID' is [\(String(describing: pfTherapistFileItem.object(forKey:"ID")))]...")

        // Handle the 'update' (setup) of field(s)...

        if (self.sTid.count  < 1 ||
            self.sTid       == "-1")
        {

            self.sTid = String(describing: (pfTherapistFileItem.object(forKey:"ID") ?? "-1"))
            self.iTid = Int(self.sTid)!

        }
  
        self.sTherapistName = String(describing: (pfTherapistFileItem.object(forKey:"name") ?? ""))

        // Exit:
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return
  
    }   // End of public func updateScheduledPatientLocationItemFromPFTherapistFile(pfTherapistFileItem:PFObject).

    public func updateScheduledPatientLocationItemFromPFPatientCalDay(pfPatientCalDayItem:PFObject)
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
  
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter is 'pfPatientCalDayItem.tid' is [\(String(describing: pfPatientCalDayItem.object(forKey:"tid")))]...")

        // Handle the 'update' (setup) of field(s)...

        if (self.sTid.count  < 1 ||
            self.sTid       == "-1")
        {

            self.sTid = String(describing: (pfPatientCalDayItem.object(forKey:"tid") ?? "-1"))
            self.iTid = Int(self.sTid)!

        }
  
        self.sTName  = String(describing: (pfPatientCalDayItem.object(forKey:"tName")  ?? ""))

        self.sPid    = String(describing: (pfPatientCalDayItem.object(forKey:"pid")    ?? "-1"))
        self.iPid    = Int(self.sPid)!
        self.sPtName = String(describing: (pfPatientCalDayItem.object(forKey:"ptName") ?? ""))

        self.sVDate  = String(describing: (pfPatientCalDayItem.object(forKey:"VDate")  ?? ""))

        // Pull and 'clean' the 'startTime' value...

        let sVDateStartTimeBase:String = String(describing: (pfPatientCalDayItem.object(forKey:"startTime") ?? ""))

        if (sVDateStartTimeBase.count < 1)
        {

            self.sVDateStartTime = ""

        }
        else
        {

        //  let listVDateStartTimeBase:[String]  = sVDateStartTimeBase.components(separatedBy:CharacterSet.illegalCharacters)
        //  let sVDateStartTimeBaseJoined:String = listVDateStartTimeBase.joined(separator:"")
        //  let listVDateStartTimeNoWS:[String]  = sVDateStartTimeBaseJoined.components(separatedBy:CharacterSet.whitespacesAndNewlines)
        //  let sVDateStartTimeUppercased:String = listVDateStartTimeNoWS.joined(separator:"")
        //
        //  self.sVDateStartTime = sVDateStartTimeUppercased.lowercased()

            self.sVDateStartTime = sVDateStartTimeBase.removeUnwantedCharacters(charsetToRemove:[StringCleaning.removeIllegal, StringCleaning.removeWhitespacesAndNewlines], bResultIsLowerCased:true)

            self.xcgLogMsg("\(sCurrMethodDisp) Cleaning - 'self.sVDateStartTime' is [\(self.sVDateStartTime)] <no illegal, no WS, lowercased>...")

        }

        // Convert the VDate 'startTime' from 12-hour to 24-hour (String and Int <for Sort>)...

        if (self.sVDateStartTime.count < 1)
        {

            self.sVDateStartTime24h = ""
            self.iVDateStartTime24h = 0

        }
        else
        {

            (self.sVDateStartTime24h, self.iVDateStartTime24h) = self.convertVDateStartTimeTo24Hour(sVDateStartTime:self.sVDateStartTime)

            self.xcgLogMsg("\(sCurrMethodDisp) Cleaning - 'self.sVDateStartTime24h' is [\(self.sVDateStartTime24h)] - 'self.iVDateStartTime24h' is (\(self.iVDateStartTime24h))...")

        }
  
        // Exit:
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return
  
    }   // End of public func updateScheduledPatientLocationItemFromPFPatientCalDay(pfPatientCalDayItem:PFObject).

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

    public func convertVDateStartTimeTo24Hour(sVDateStartTime:String)->(String, Int)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'sVDateStartTime' is [\(sVDateStartTime)]...")

        // Convert the VDate 'startTime' from 12-hour to 24-hour time...

        var sVDateStartTime24h:String = ""
        var iVDateStartTime24h:Int    = 0
        
        if (sVDateStartTime.count < 1)
        {

            // Exit:

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'sVDateStartTime24h' is [\(sVDateStartTime24h)] - 'iVDateStartTime24h' is [\(iVDateStartTime24h)]...")

            return (sVDateStartTime24h, iVDateStartTime24h)
            
        }
        
        var bVDateStartTimeIsPM:Bool = false

        if sVDateStartTime.hasSuffix("pm")
        {
            
            bVDateStartTimeIsPM = true
            
        }
        else
        {
            
            bVDateStartTimeIsPM = false
            
        }

        var csStartTimeDelimiters:CharacterSet = CharacterSet()

        csStartTimeDelimiters.insert(charactersIn: ":amp")

        let listVDateStartTime:[String] = sVDateStartTime.components(separatedBy:csStartTimeDelimiters)
        let sVDateStartTimeHH:String    = listVDateStartTime[0]
        let sVDateStartTimeMM:String    = listVDateStartTime[1]
        var iVDateStartTimeHH:Int       = Int(sVDateStartTimeHH) ?? 0

        if (bVDateStartTimeIsPM == true &&
            iVDateStartTimeHH   != 12)
        {

            iVDateStartTimeHH += 12
            
        }

        sVDateStartTime24h = "\(iVDateStartTimeHH):\(sVDateStartTimeMM)"
        iVDateStartTime24h = Int("\(iVDateStartTimeHH)\(sVDateStartTimeMM)") ?? 0

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'sVDateStartTime24h' is [\(sVDateStartTime24h)] - 'iVDateStartTime24h' is (\(iVDateStartTime24h))...")

        return (sVDateStartTime24h, iVDateStartTime24h)

    }   // End of convertVDateStartTimeTo24Hour(sVDateStartTime:String)->(String, Int).
    
}   // End of class ScheduledPatientLocationItem(NSObject, Identifiable).

