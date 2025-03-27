//
//  AppDataGathererSchedule1DetailsView.swift
//  PMADataGatherer
//
//  Created by Daryl Cox on 03/27/2025.
//  Copyright © JustMacApps 2023-2025. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct AppDataGathererSchedule1DetailsView: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "AppDataGathererSchedule1DetailsView"
        static let sClsVers      = "v1.0111"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2025. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }
    
    // App Data field(s):

//  @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.openURL)          var openURL
    @Environment(\.openWindow)       var openWindow

    @Binding     private var sTherapistTID:String
    @Binding     private var sScheduledPatientLocationItemID:String

//  @State       private var scheduledPatientLocationItem:ScheduledPatientLocationItem? = nil

                         var jmAppDelegateVisitor:JmAppDelegateVisitor                  = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    @ObservedObject      var jmAppParseCoreManager:JmAppParseCoreManager                = JmAppParseCoreManager.ClassSingleton.appParseCodeManager
//                       var appScheduleLoadingAssistant:AppScheduleLoadingAssistant    = AppScheduleLoadingAssistant.ClassSingleton.appScheduleLoadingAssistant
    
    init(sTherapistTID:Binding<String>, sScheduledPatientLocationItemID:Binding<String>)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        // Handle the 'sTherapistTID' and 'sScheduledPatientLocationItemID' parameters...

        _sTherapistTID                   = sTherapistTID
        _sScheduledPatientLocationItemID = sScheduledPatientLocationItemID

    //  // Locate the ScheduledPatientLocationItem by TID and Item ID...
    //
    //  self.scheduledPatientLocationItem = 
    //      self.getScheduledPatientLocationItemForTidByID(sTherapistTID:                  _sTherapistTID.wrappedValue,
    //                                                     sScheduledPatientLocationItemID:_sScheduledPatientLocationItemID.wrappedValue)

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

    var body: some View
    {
        
        let _ = xcgLogMsg("\(ClassInfo.sClsDisp):body(some View) \(ClassInfo.sClsCopyRight)...")

    //  let _ = self.locateScheduledPatientLocationItemForTidByID()

        NavigationStack
        {

            VStack
            {

                HStack(alignment:.center)
                {

                    Spacer()

                    Button
                    {

                        let _ = xcgLogMsg("\(ClassInfo.sClsDisp):AppDataGathererSchedule1DetailsView.Button(Xcode).'Dismiss' pressed...")

                        self.presentationMode.wrappedValue.dismiss()

                    //  dismiss()

                    }
                    label:
                    {

                        VStack(alignment:.center)
                        {

                            Label("", systemImage: "xmark.circle")
                                .help(Text("Dismiss this Screen"))
                                .imageScale(.large)

                            Text("Dismiss")
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
                    .padding()

                }

                VStack(alignment:.center)
                {

                    Text(" - - - - - - - - - - - - - - - - - - - - ")
                        .font(.caption2) 
                        .frame(maxWidth:.infinity, alignment:.center)

                    Text("DATA Gatherer - Schedule Details by TID/Scheduled Item ID")
                        .bold()
                        .font(.caption2) 
                        .frame(maxWidth:.infinity, alignment:.center)

                    Text(" - - - - - - - - - - - - - - - - - - - - ")
                        .font(.caption2) 
                        .frame(maxWidth:.infinity, alignment:.center)

                }

                HStack()
                {

                    Text("::: Therapist: TID #")
                        .font(.caption) 

                    Text("\(self.sTherapistTID)")
                        .italic()
                        .font(.caption) 
                        .foregroundColor(.red)

                    Spacer()

                }

                let scheduledPatientLocationItem:ScheduledPatientLocationItem? =
                    self.locateScheduledPatientLocationItemForTidByID()

            if (scheduledPatientLocationItem != nil)
            {

            //  let _ = xcgLogMsg("\(ClassInfo.sClsDisp):body(some View) <Diagnostic #1> - 'self.sTherapistTID' is [\(self.sTherapistTID)] - 'self.sScheduledPatientLocationItemID' is [\(self.sScheduledPatientLocationItemID)] - 'self.scheduledPatientLocationItem' is [\(String(describing: self.scheduledPatientLocationItem))] - 'scheduledPatientLocationItem' is [\(String(describing: scheduledPatientLocationItem))]...")
                let _ = xcgLogMsg("\(ClassInfo.sClsDisp):body(some View) <Diagnostic #1> - 'self.sTherapistTID' is [\(self.sTherapistTID)] - 'self.sScheduledPatientLocationItemID' is [\(self.sScheduledPatientLocationItemID)] - 'scheduledPatientLocationItem' is [\(String(describing: scheduledPatientLocationItem))]...")

                ScrollView(.vertical)
                {

                    Grid(alignment:.leadingFirstTextBaseline, horizontalSpacing:5, verticalSpacing: 3)
                    {

                        // Column Headings:

                        Divider() 

                        GridRow 
                        {

                            Text("Item")
                                .bold()
                                .underline()
                            Text("Value")
                                .bold()
                                .underline()

                        }
                        .font(.caption) 

                        Divider() 

                        // Item Rows:

                        GridRow(alignment:.bottom)
                        {

                            Text("Schedule Item ID")
                            Text("\(String(describing: scheduledPatientLocationItem!.getScheduledPatientLocationItemId()))")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Schedule Object ID")
                            Text("\(String(describing:scheduledPatientLocationItem!.idSchedPatLocObject))")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Schedule 'cloned' From")
                            Text("\(String(describing:scheduledPatientLocationItem!.schedPatLocClonedFrom))")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Schedule 'cloned' To")
                            Text("\(String(describing:scheduledPatientLocationItem!.schedPatLocClonedTo))")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Schedule Item TID")
                            Text("\(String(describing:scheduledPatientLocationItem!.sTid))")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Schedule Item TID <Int>")
                            Text("\(String(describing:scheduledPatientLocationItem!.iTid))")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Schedule Item Therapist TName")
                            Text("\(String(describing:scheduledPatientLocationItem!.sTName))")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Schedule Item Therapist Name")
                            Text("\(String(describing:scheduledPatientLocationItem!.sTherapistName))")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Schedule Item PID")
                            Text("\(String(describing:scheduledPatientLocationItem!.sPid))")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Schedule Item PID <Int>")
                            Text("\(String(describing:scheduledPatientLocationItem!.iPid))")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Schedule Item Patient Name")
                            Text("\(String(describing:scheduledPatientLocationItem!.sPtName))")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Schedule Item VDate")
                            Text("\(String(describing:scheduledPatientLocationItem!.sVDate))")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Schedule Item VDate 'start' Time")
                            Text("\(String(describing:scheduledPatientLocationItem!.sVDateStartTime))")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Schedule Item VDate 'start' Time (24 hour)")
                            Text("\(String(describing:scheduledPatientLocationItem!.sVDateStartTime24h))")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Schedule Item VDate 'start' Time (24 hour) <Int>")
                            Text("\(String(describing:scheduledPatientLocationItem!.iVDateStartTime24h))")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Schedule Item 'last' VDate")
                            Text("\(String(describing:scheduledPatientLocationItem!.sLastVDate))")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Schedule Item 'last' VDate 'type'")
                            Text("\(String(describing:scheduledPatientLocationItem!.sLastVDateType))")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Schedule Item 'last' VDate 'type' <Int>")
                            Text("\(String(describing:scheduledPatientLocationItem!.iLastVDateType))")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Schedule Item 'last' VDate Latitude")
                            Text("\(String(describing:scheduledPatientLocationItem!.sLastVDateLatitude))")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Schedule Item 'last' VDate Longitude")
                            Text("\(String(describing:scheduledPatientLocationItem!.sLastVDateLongitude))")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Schedule Item 'last' VDate Address")
                            Text("\(String(describing:scheduledPatientLocationItem!.sLastVDateAddress))")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Schedule Item 'last' VDate Coordinate")
                            Text("\(String(describing:scheduledPatientLocationItem!.clLocationCoordinate2DPatLoc))")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Schedule Item 'last' VDate Addr/Lat/Long")
                            Text("\(String(describing:scheduledPatientLocationItem!.sVDateAddressOrLatLong))")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Schedule Item VDate 'short' Display")
                            Text("\(String(describing:scheduledPatientLocationItem!.sVDateShortDisplay))")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Schedule Item 'status'")
                            Text("\(String(describing:scheduledPatientLocationItem!.scheduleType))")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Schedule Item 'status' Color")
                            Text("\(String(describing:scheduledPatientLocationItem!.colorOfItem))")
                                .foregroundStyle(scheduledPatientLocationItem!.colorOfItem)

                        }
                        .font(.caption2) 

                        Divider() 

                    }

                }

            }
            else
            {

            //  let _ = xcgLogMsg("\(ClassInfo.sClsDisp):body(some View) <Diagnostic #2> - 'self.sTherapistTID' is [\(self.sTherapistTID) - 'self.sScheduledPatientLocationItemID' is [\(self.sScheduledPatientLocationItemID) - 'self.scheduledPatientLocationItem' is [\(String(describing: self.scheduledPatientLocationItem))]...")
                let _ = xcgLogMsg("\(ClassInfo.sClsDisp):body(some View) <Diagnostic #2> - 'self.sTherapistTID' is [\(self.sTherapistTID) - 'self.sScheduledPatientLocationItemID' is [\(self.sScheduledPatientLocationItemID)...")

                Divider() 

                // Item Rows:

                GridRow(alignment:.bottom)
                {

                    Text("<<< NO Data >>>")
                    Text("Therapist TID #(\(self.sTherapistTID)) - Schedule Item ID #[\(self.sScheduledPatientLocationItemID)]")
                        .italic()

                }
                .font(.caption2) 

                Divider() 

            }

                Spacer()

            }

            Spacer()

        }
        .padding()
        
    }

    private func locateScheduledPatientLocationItemForTidByID()->ScheduledPatientLocationItem?
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
    //  self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'self.scheduledPatientLocationItem' is [\(String(describing: self.scheduledPatientLocationItem))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Locate the ScheduledPatientLocationItem by TID and Item ID...

        let scheduledPatientLocationItem:ScheduledPatientLocationItem? =
            self.getScheduledPatientLocationItemForTidByID(sTherapistTID:                  self.sTherapistTID,
                                                           sScheduledPatientLocationItemID:self.sScheduledPatientLocationItemID)

    //  if (scheduledPatientLocationItem      != nil &&
    //      self.scheduledPatientLocationItem == nil)
    //  {
    //  
    //      self.scheduledPatientLocationItem = scheduledPatientLocationItem
    //  
    //  }
        
        // Exit...

    //  self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'scheduledPatientLocationItem' is [\(String(describing: scheduledPatientLocationItem))] - 'self.scheduledPatientLocationItem' is [\(String(describing: self.scheduledPatientLocationItem))]...")
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'scheduledPatientLocationItem' is [\(String(describing: scheduledPatientLocationItem))]...")

        return scheduledPatientLocationItem

    }   // End of private func locateScheduledPatientLocationItemForTidByID()->ScheduledPatientLocationItem?.
    
    private func getScheduledPatientLocationItemForTidByID(sTherapistTID:String = "", sScheduledPatientLocationItemID:String = "")->ScheduledPatientLocationItem?
    {
  
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameters 'sTherapistTID' is [\(sTherapistTID)] - 'sScheduledPatientLocationItemID' is [\(sScheduledPatientLocationItemID)]...")
  
        // Use the supplied TherapistTID and Scheduled item ID to lookup the ScheduledPatientLocationItem...
  
        var scheduledPatientLocationItem:ScheduledPatientLocationItem?       = nil
        var listScheduledPatientLocationItems:[ScheduledPatientLocationItem] = [ScheduledPatientLocationItem]()
  
        if (sTherapistTID.count > 0)
        {
  
            if (self.jmAppParseCoreManager.dictSchedPatientLocItems.count > 0)
            {
  
                listScheduledPatientLocationItems = self.jmAppParseCoreManager.dictSchedPatientLocItems[sTherapistTID] ?? [ScheduledPatientLocationItem]()

                if (listScheduledPatientLocationItems.count > 0)
                {
                
                    for currentScheduledPatientLocationItem in listScheduledPatientLocationItems
                    {
                        
                        let sCurrentItemId:String = currentScheduledPatientLocationItem.id.uuidString
                        
                        if (sCurrentItemId == sScheduledPatientLocationItemID)
                        {
                        
                            scheduledPatientLocationItem = currentScheduledPatientLocationItem

                            break
                        
                        }

                    }
                
                }
  
            }
  
        }
        
        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'scheduledPatientLocationItem' is [\(String(describing: scheduledPatientLocationItem))]...")
  
        return scheduledPatientLocationItem
  
    }   // End of private func getScheduledPatientLocationItemForTidByID(sTherapistTID:String, sScheduledPatientLocationItemID:String)->ScheduledPatientLocationItem?.

}   // End of struct AppDataGathererSchedule1DetailsView(View).
