//
//  AppTidScheduleView.swift
//  PMADataGatherer
//
//  Created by Daryl Cox on 12/17/2024.
//  Copyright © JustMacApps 2023-2025. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit

@available(iOS 14.0, *)
struct AppTidScheduleView: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "AppTidScheduleView"
        static let sClsVers      = "v1.0601"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright © JustMacApps 2023-2025. All rights reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    // App Data field(s):

    @Environment(\.presentationMode)     var presentationMode
    @Environment(\.openURL)              var openURL

    // App Data field(s):

                     var listScheduledPatientLocationItems:[ScheduledPatientLocationItem]
    
    @State private   var isAppPatientDetailsByPidShowing:Bool      = false

                     var jmAppDelegateVisitor:JmAppDelegateVisitor = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    
    init(listScheduledPatientLocationItems:[ScheduledPatientLocationItem])
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        // Handle the 'listScheduledPatientLocationItems' parameter...

        self.listScheduledPatientLocationItems = listScheduledPatientLocationItems

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'listScheduledPatientLocationItems' is [\(listScheduledPatientLocationItems)]...")

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

    //  BLOCKED: Note - This would write a message into the log on EVERY tick of the timer...
    //  let _ = self.xcgLogMsg("...'AppTidScheduleView(.swift):body' \(JmXcodeBuildSettings.jmAppVersionAndBuildNumber)...")

        NavigationStack
        {

            VStack(alignment:.center)
            {

                HStack(alignment:.center)
                {

                    Spacer()

                    Button
                    {

                        let _ = xcgLogMsg("\(ClassInfo.sClsDisp):AppTidScheduleView.Button(Xcode).'Dismiss' pressed...")

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

            }

            if (listScheduledPatientLocationItems.count < 1)
            {

                Spacer()

                VStack(alignment:.center)
                {

                    Text("There are NO Scheduled visit(s)...")
                        .bold()
                        .italic()
                        .underline()

                }

                Spacer()

            }
            else
            {

                ScrollView
                {

                    VStack(alignment:.center)
                    {

                        Text("Schedule::\(listScheduledPatientLocationItems[0].sTName) TID #(\(listScheduledPatientLocationItems[0].sTid)) Visits #(\(listScheduledPatientLocationItems.count))")
                            .underline()
                        Text("")

                        Grid(alignment:.leadingFirstTextBaseline, horizontalSpacing:5, verticalSpacing: 3)
                        {

                            // Column Headings:

                            Divider() 

                            GridRow 
                            {

                                Text("PID")
                                Text("Patient")

                                Text("Date")
                                Text("Time")
                                Text("Address or Location")

                            //  Text("Details")

                            }
                            .font(.title2) 

                            Divider() 

                            // Item Rows:

                            ForEach(listScheduledPatientLocationItems)
                            { scheduledPatientLocationItem in

                                GridRow(alignment:.bottom)
                                {

                                    AppTidScheduleRowView(scheduledPatientLocationItem:scheduledPatientLocationItem)

                                }

                            }

                        }

                    }

                }

                Spacer()

            }

        }
        .padding()

    }

                        //  ForEach(listScheduledPatientLocationItems)
                        //  { scheduledPatientLocationItem in
                        //
                        //      GridRow(alignment:.bottom)
                        //      {
                        //
                        //          AppTidScheduleRowView(scheduledPatientLocationItem:scheduledPatientLocationItem)
                        //
                        //      #if os(macOS)
                        //          Text(scheduledPatientLocationItem.sPid)
                        //              .font(.caption)
                        //      #endif
                        //  //  #if os(macOS)
                        //  //      Button
                        //  //      {
                        //  //          // Using -> @Environment(\.openWindow)var openWindow and 'openWindow(id:"...")' on MacOS...
                        //  //          openWindow(id:"AppWorkRouteMapView", value:pfCscObject.id)
                        //  //      }
                        //  //      label:
                        //  //      {
                        //  //
                        //  //          VStack(alignment:.center)
                        //  //          {
                        //  //
                        //  //              Label("", systemImage: "mappin.and.ellipse")
                        //  //                  .help(Text("'Map' the App WorkRoute..."))
                        //  //                  .imageScale(.small)
                        //  //              #if os(macOS)
                        //  //                  .onTapGesture(count:1)
                        //  //                  {
                        //  //
                        //  //                      let _ = xcgLogMsg("\(ClassInfo.sClsDisp):AppTidScheduleView.GridRow.NavigationLink.'.onTapGesture()' received - Map #(\(pfCscObject.idPFCscObject))...")
                        //  //
                        //  //                      let _ = AppWorkRouteMapView(parsePFCscDataItem:pfCscObject)
                        //  //
                        //  //                  }
                        //  //              #endif
                        //  //
                        //  //              Text("Map #(\(pfCscObject.idPFCscObject))")
                        //  //                  .font(.caption2)
                        //  //
                        //  //          }
                        //  //
                        //  //      }
                        //  //      .gridColumnAlignment(.center)
                        //  //      .buttonStyle(.borderedProminent)
                        //  //      .padding()
                        //  //  //  .background(???.isPressed ? .blue : .gray)
                        //  //      .cornerRadius(10)
                        //  //      .foregroundColor(Color.primary)
                        //  //  #endif
                        //      #if os(iOS)
                        //          Text(scheduledPatientLocationItem.sPid)
                        //              .font(.caption)
                        //      //
                        //      //  NavigationLink
                        //      //  {
                        //      //      AppDataGathererPatient1DetailsView(sPatientPID:scheduledPatientLocationItem.sPid)
                        //      //          .navigationBarBackButtonHidden(true)
                        //      //  }
                        //      //  label:
                        //      //  {
                        //      //
                        //      //      VStack(alignment:.center)
                        //      //      {
                        //      //
                        //      //          Label("", systemImage: "doc.questionmark")
                        //      //              .help(Text("Show Patient Detail(s) by PID..."))
                        //      //              .imageScale(.small)
                        //      //          
                        //      //          #if os(macOS)
                        //      //              .onTapGesture(count:1)
                        //      //              {
                        //      //
                        //      //                  let _ = xcgLogMsg("\(ClassInfo.sClsDisp):AppTidScheduleView.GridRow.NavigationLink.'.onTapGesture()' received - PID #[\(scheduledPatientLocationItem.sPid)]...")
                        //      //
                        //      //                  let _ = AppDataGathererPatient1DetailsView(sPatientPID:scheduledPatientLocationItem.sPid)
                        //      //
                        //      //              }
                        //      //          #endif
                        //      //
                        //      //          Text("PID: \(scheduledPatientLocationItem.sPid)")
                        //      //              .font(.caption2)
                        //      //
                        //      //      }
                        //      //
                        //      //  }
                        //      //  .gridColumnAlignment(.center)
                        //      #endif
                        //
                        //          Text(scheduledPatientLocationItem.sPtName)
                        //              .font(.caption)
                        //
                        //          Text(scheduledPatientLocationItem.sVDate)
                        //              .font(.caption)
                        //
                        //          Text(scheduledPatientLocationItem.sVDateStartTime)
                        //              .font(.caption)
                        //
                        //      if (scheduledPatientLocationItem.sLastVDateAddress.count  < 1       ||
                        //          scheduledPatientLocationItem.sLastVDateAddress       == ""      ||
                        //          scheduledPatientLocationItem.sLastVDateAddress       == "-N/A-" ||
                        //          scheduledPatientLocationItem.sLastVDateAddress       == ",,,"   ||
                        //          scheduledPatientLocationItem.sLastVDateAddress       == ", , , ")
                        //      {
                        //
                        //          Text("\(scheduledPatientLocationItem.sLastVDateLatitude), \(scheduledPatientLocationItem.sLastVDateLongitude)")
                        //              .font(.caption2)
                        //
                        //      }
                        //      else
                        //      {
                        //
                        //          Text(scheduledPatientLocationItem.sLastVDateAddress)
                        //              .font(.caption2)
                        //
                        //      }
                        //
                        //  //      Button
                        //  //      {
                        //  //
                        //  //          let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp)AppTidScheduleView.Button(Xcode).'Patient Detail(s) by PID' for PID - 'scheduledPatientLocationItem.sPid' is [\(scheduledPatientLocationItem.sPid)]...")
                        //  //
                        //  //          self.isAppPatientDetailsByPidShowing.toggle()
                        //  //
                        //  //      }
                        //  //      label:
                        //  //      {
                        //  //
                        //  //          VStack(alignment:.center)
                        //  //          {
                        //  //
                        //  //              Label("", systemImage: "doc.questionmark")
                        //  //                  .help(Text("Show Patient Detail(s) by PID..."))
                        //  //                  .imageScale(.small)
                        //  //
                        //  //              HStack(alignment:.center)
                        //  //              {
                        //  //
                        //  //                  Spacer()
                        //  //
                        //  //                  Text("PID: \(scheduledPatientLocationItem.sPid)")
                        //  //                      .font(.caption2)
                        //  //
                        //  //                  Spacer()
                        //  //
                        //  //              }
                        //  //
                        //  //          }
                        //  //
                        //  //      }
                        //  //  #if os(macOS)
                        //  //      .sheet(isPresented:$isAppPatientDetailsByPidShowing, content:
                        //  //      {
                        //  //
                        //  //          AppDataGathererPatient1DetailsView(sPatientPID:scheduledPatientLocationItem.sPid)
                        //  //
                        //  //      })
                        //  //  #endif
                        //  //  #if os(iOS)
                        //  //      .fullScreenCover(isPresented:$isAppPatientDetailsByPidShowing)
                        //  //      {
                        //  //
                        //  //          AppDataGathererPatient1DetailsView(sPatientPID:scheduledPatientLocationItem.sPid)
                        //  //
                        //  //      }
                        //  //  #endif
                        //  //  #if os(macOS)
                        //  //      .buttonStyle(.borderedProminent)
                        //  //      .padding()
                        //  //  //  .background(???.isPressed ? .blue : .gray)
                        //  //      .cornerRadius(10)
                        //  //      .foregroundColor(Color.primary)
                        //  //  #endif
                        //  //  #if os(iOS)
                        //  //      .padding()
                        //  //  #endif
                        //
                        //      }
                        //
                        //  }

//                      }
//                      .padding()
//
//                      Spacer()
//
//                  }
//
//              }
//
//          }
//
//      }
//      .padding()
//
//  }
    
}   // End of struct AppTidScheduleView(View).

