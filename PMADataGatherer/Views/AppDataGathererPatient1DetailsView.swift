//
//  AppDataGathererPatient1DetailsView.swift
//  PMADataGatherer
//
//  Created by Daryl Cox on 02/05/2025.
//  Copyright © JustMacApps 2023-2025. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

enum PIDType: String, CaseIterable
{
    
    case patient = "patient"
    case parent  = "parent"
//  case mentor  = "mentor"
    
}   // End of enum PIDType(String, CaseIterable).

struct AppDataGathererPatient1DetailsView: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "AppDataGathererPatient1DetailsView"
        static let sClsVers      = "v1.0101"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2025. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }
    
    // App Data field(s):

//  @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode

    @Binding     private var sPatientPID:String

    @State       private var sPatientName:String                         = ""
    @State       private var pfPatientFileItem:ParsePFPatientFileItem?   = nil

    @State       private var sTherapistTID:String                        = ""
    @State       private var sTherapistName:String                       = ""

    @State       private var isAppTherapistDetailsByTIDShowing:Bool      = false

                         var jmAppDelegateVisitor:JmAppDelegateVisitor   = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    @ObservedObject      var jmAppParseCoreManager:JmAppParseCoreManager = JmAppParseCoreManager.ClassSingleton.appParseCodeManager
    
    init(sPatientPID:Binding<String>)
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        // Handle the 'sPatientPID' parameter...

        _sPatientPID = sPatientPID

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
        
        NavigationStack
        {

            VStack
            {

                HStack(alignment:.center)
                {

                    Spacer()

                    Button
                    {

                        let _ = xcgLogMsg("\(ClassInfo.sClsDisp):AppDataGathererPatient1DetailsView.Button(Xcode).'Dismiss' pressed...")

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

                    Text("DATA Gatherer - Patient Details by PID")
                        .bold()
                        .font(.caption2) 
                        .frame(maxWidth:.infinity, alignment:.center)

                    Text(" - - - - - - - - - - - - - - - - - - - - ")
                        .font(.caption2) 
                        .frame(maxWidth:.infinity, alignment:.center)

                }

                HStack()
                {

                    Text(":: Patients' PID: ")
                        .font(.caption) 
                        .onAppear
                        {

                            self.sPatientName = self.locateAppPatientNamebyPid(pidType:PIDType.patient, sPatientPID:self.sPatientPID)

                        }

                    Text("\(self.sPatientPID)")
                        .italic()
                        .font(.caption) 

                    Spacer()

                }

                HStack()
                {

                    Text("Patients' Name: ")
                        .font(.caption) 

                    Text("\(self.sPatientName)")
                        .italic()
                        .font(.caption) 

                    Spacer()

                }

            if (self.pfPatientFileItem != nil)
            {
            
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

                    //  GridRow(alignment:.bottom)
                    //  {
                    //
                    //      Text("Patients' Phone #")
                    //      Text("\(self.formatPhoneNumber(sPhoneNumber:self.pfPatientFileItem!.sPFPatientFilePhone))")
                    //  //  Text("\(self.pfPatientFileItem!.sPFPatientFilePhone)")
                    //
                    //  }
                    //  .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Patients' First Name")
                            Text("\(self.pfPatientFileItem!.sPFPatientFileFirstName)")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Patients' Last Name")
                            Text("\(self.pfPatientFileItem!.sPFPatientFileLastName)")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Patients' Emergency Contact(s)")
                            Text("\(self.pfPatientFileItem!.sPFPatientFileEmerContacts)")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Patients' HOME Location")
                            Text("\(self.pfPatientFileItem!.sPFPatientFileHomeLoc)")

                        }
                        .font(.caption2) 

                        GridRow(alignment:.bottom)
                        {

                            Text("Patients' Name (No Whitespace)")
                            Text("\(self.pfPatientFileItem!.sPFPatientFileNameNoWS)")

                        }
                        .font(.caption2) 

                    //  GridRow(alignment:.bottom)
                    //  {
                    //
                    //      VStack
                    //      {
                    //
                    //          Text("Patients' Therapist TID #")
                    //          Text("")    // ...vertical spacing...
                    //          Text("")    // ...vertical spacing...
                    //
                    //      }
                    //
                    //      HStack()
                    //      {
                    //
                    //          Text("\(sTherapistTID) <\(sTherapistName)>")
                    //              .onAppear
                    //              {
                    //
                    //                  self.sTherapistTID  = "\(self.pfPatientFileItem!.iPFPatientFileSuperID)"
                    //                  self.sTherapistName = self.locateAppPatientNamebyPid(pidType:PIDType.supervisor, sPatientPID:"\(self.pfPatientFileItem!.iPFPatientFileSuperID)")
                    //
                    //              }
                    //
                    //          if (self.sTherapistTID.count    > 0 &&
                    //              (self.sTherapistName.count  > 0 &&
                    //               self.sTherapistName       != "-N/A-"))
                    //          {
                    //
                    //              Button
                    //              {
                    //
                    //                  let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp)AppDataGathererPatient1DetailsView.Button(Xcode).'Therapist Detail(s) by PID'...")
                    //
                    //                  self.isAppTherapistDetailsByTIDShowing.toggle()
                    //
                    //              }
                    //              label:
                    //              {
                    //
                    //                  VStack(alignment:.center)
                    //                  {
                    //
                    //                      Label("", systemImage: "doc.questionmark")
                    //                          .help(Text("Show Therapist Detail(s) by PID..."))
                    //                          .imageScale(.medium)
                    //
                    //                      HStack(alignment:.center)
                    //                      {
                    //
                    //                          Spacer()
                    //
                    //                          Text("Therapist Details...")
                    //                              .font(.caption2)
                    //
                    //                          Spacer()
                    //
                    //                      }
                    //
                    //                  }
                    //
                    //              }
                    //          #if os(macOS)
                    //              .sheet(isPresented:$isAppTherapistDetailsByTIDShowing, content:
                    //              {
                    //
                    //                  AppDataGathererPatient1DetailsView(sPatientPID:$sTherapistTID)
                    //
                    //              })
                    //          #endif
                    //          #if os(iOS)
                    //              .fullScreenCover(isPresented:$isAppTherapistDetailsByTIDShowing)
                    //              {
                    //
                    //                  AppDataGathererPatient1DetailsView(sPatientPID:$sTherapistTID)
                    //
                    //              }
                    //          #endif
                    //          #if os(macOS)
                    //              .buttonStyle(.borderedProminent)
                    //              .padding()
                    //          //  .background(???.isPressed ? .blue : .gray)
                    //              .cornerRadius(10)
                    //              .foregroundColor(Color.primary)
                    //          #endif
                    //              .padding()
                    //
                    //          }
                    //          else
                    //          {
                    //
                    //              Spacer()
                    //
                    //          }
                    //
                    //      }
                    //
                    //  }
                    //  .font(.caption2) 

                        Divider() 

                    }

                }

            }
            else
            {

                Divider() 

                // Item Rows:

                GridRow(alignment:.bottom)
                {

                    Text("<<< NO Data >>>")
                    Text("Patient PID #(\(self.sPatientPID))")
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
    
    private func locateAppPatientNamebyPid(pidType:PIDType, sPatientPID:String = "")->String
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'pidType' is [\(pidType)] - 'sPatientPID' is [\(sPatientPID)]...")

        // Locate the Patient 'name' by PID...

        var sPatientName:String = ""

        if (sPatientPID.count > 0)
        {
        
            sPatientName = self.jmAppParseCoreManager.convertPidToPatientName(sPFPatientParsePID:sPatientPID)

            let iPatientPID:Int = Int(sPatientPID)!

            if (iPatientPID >= 0)
            {

                if (pidType == PIDType.patient)
                {
                
                    self.pfPatientFileItem = self.jmAppParseCoreManager.dictPFPatientFileItems[iPatientPID]

                    self.xcgLogMsg("\(sCurrMethodDisp) Intermediate - 'self.pfPatientFileItem' is [\(String(describing: self.pfPatientFileItem))]...")
                
                }
                else
                {

                    self.xcgLogMsg("\(sCurrMethodDisp) Intermediate - bypassing the setting of 'self.pfPatientFileItem' - 'pidType' of [\(pidType)] is NOT PIDType.patient...")

                }

            }
            else
            {
            
                self.xcgLogMsg("\(sCurrMethodDisp) Intermediate - bypassing the setting of 'self.pfPatientFileItem' - 'iPatientPID' of (\(iPatientPID)) is less than Zero...")

            }

        }

        if (sPatientName.count < 1)
        {
        
            sPatientName = "-N/A-"
        
        }

        // Exit...

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'sPatientPID' is [\(sPatientPID)] - 'sPatientName' is [\(sPatientName)]...")
  
        return sPatientName
  
    }   // End of private func locateAppPatientNamebyPid(sPatientPID:String)->String.

    private func formatPhoneNumber(sPhoneNumber:String = "")->String
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'sPhoneNumber' is [\(sPhoneNumber)]...")

        // Format the supplied Phone #...

        var sPhoneNumberFormatted:String = ""
        
        if (sPhoneNumber.count < 1)
        {
            
            // Exit...

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'sPhoneNumber' is [\(sPhoneNumber)] - 'sPhoneNumberFormatted' is [\(sPhoneNumberFormatted)]...")

            return sPhoneNumberFormatted
            
        }
        
        let sPhoneNumberMask:String              = "(XXX) XXX-XXXX"
        let sPhoneNumberCleaned:String           = sPhoneNumber.components(separatedBy:CharacterSet.decimalDigits.inverted).joined()
        var siPhoneNumberStartIndex:String.Index = sPhoneNumberCleaned.startIndex
        let eiPhoneNumberEndIndex:String.Index   = sPhoneNumberCleaned.endIndex
        
        for chCurrentNumber in sPhoneNumberMask where siPhoneNumberStartIndex < eiPhoneNumberEndIndex
        {
            
            if chCurrentNumber == "X"
            {
                
                sPhoneNumberFormatted.append(sPhoneNumberCleaned[siPhoneNumberStartIndex])
                
                siPhoneNumberStartIndex = sPhoneNumberCleaned.index(after:siPhoneNumberStartIndex)
                
            }
            else
            {
                
                sPhoneNumberFormatted.append(chCurrentNumber)
                
            }
            
        }

        // Exit...

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'sPhoneNumber' is [\(sPhoneNumber)] - 'sPhoneNumberFormatted' is [\(sPhoneNumberFormatted)]...")
  
        return sPhoneNumberFormatted
        
    }   // End of private func formatPhoneNumber(sPhoneNumber:String)->String

}   // End of struct AppDataGathererPatient1DetailsView(View).
