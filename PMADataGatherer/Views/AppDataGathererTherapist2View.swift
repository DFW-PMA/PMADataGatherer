//
//  AppDataGathererTherapist2View.swift
//  PMADataGatherer
//
//  Created by Daryl Cox on 12/26/2024.
//  Copyright © JustMacApps 2023-2025. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct AppDataGathererTherapist2View: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "AppDataGathererTherapist2View"
        static let sClsVers      = "v1.0805"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2025. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }
    
    // App Data field(s):

//  @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode)     var presentationMode
    @Environment(\.openURL)              var openURL
    @Environment(\.openWindow)           var openWindow

    enum FocusedFields
    {
       case therapistName
    }
    
    @FocusState  private var focusedField:FocusedFields?

    @State       private var sTherapistTID:String                                   = ""
    @State       private var sTherapistName:String                                  = ""

    @State       private var listSelectableTherapistNames:[AppSearchableTherapistName] 
                                                                                    = [AppSearchableTherapistName]()

    @State       private var cAppLocationViewLogPFDataButtonPresses:Int             = 0
    @State       private var cAppDataGathererTherapist2ViewRefreshButtonPresses:Int = 0

    @State       private var isAppLogPFDataViewModal:Bool                           = false
    @State       private var isAppRunTherapistLocateByTNameShowing:Bool             = false
    @State       private var isAppTherapistDetailsByTNameShowing:Bool               = false

                         var jmAppDelegateVisitor:JmAppDelegateVisitor              = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    @ObservedObject      var jmAppParseCoreManager:JmAppParseCoreManager            = JmAppParseCoreManager.ClassSingleton.appParseCodeManager
    
    init()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
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
        
    //  NavigationStack
        ScrollView
        {

            VStack
            {

                HStack(alignment:.center)
                {

                    if (AppGlobalInfo.bPerformAppDevTesting == true)
                    {

                        Button
                        {

                            self.cAppLocationViewLogPFDataButtonPresses += 1

                            let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):AppLocationView.Button(Xcode).'Log PFData'.#(\(self.cAppLocationViewLogPFDataButtonPresses)) pressed...")

                            self.isAppLogPFDataViewModal.toggle()

                        //  self.detailPFCscDataItems()

                        }
                        label:
                        {

                            VStack(alignment:.center)
                            {

                                Label("", systemImage: "doc.text.magnifyingglass")
                                    .help(Text("Log PFXxxDataItem(s)..."))
                                    .imageScale(.small)

                                Text("Log PFData")
                                    .font(.caption2)

                            }

                        }
                    #if os(macOS)
                        .sheet(isPresented:$isAppLogPFDataViewModal, content:
                            {

                                AppLogPFDataView()

                            }
                        )
                    #endif
                    #if os(iOS)
                        .fullScreenCover(isPresented:$isAppLogPFDataViewModal)
                        {

                            AppLogPFDataView()

                        }
                    #endif
                        .padding()
                    #if os(macOS)
                        .buttonStyle(.borderedProminent)
                    //  .background(???.isPressed ? .blue : .gray)
                        .cornerRadius(10)
                        .foregroundColor(Color.primary)
                    #endif

                    }

                    Spacer()

                    Button
                    {

                        self.cAppDataGathererTherapist2ViewRefreshButtonPresses += 1

                        let _ = self.xcgLogMsg("...\(ClassInfo.sClsDisp)AppDataGathererTherapist2View.Button(Xcode).'Refresh'.#(\(self.cAppDataGathererTherapist2ViewRefreshButtonPresses))...")

                    }
                    label:
                    {

                        VStack(alignment:.center)
                        {

                            Label("", systemImage: "arrow.clockwise")
                                .help(Text("'Refresh' App Data Gatherer Therapist by tName Screen..."))
                                .imageScale(.large)

                            Text("Refresh - #(\(self.cAppDataGathererTherapist2ViewRefreshButtonPresses))...")
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

                    Spacer()

                    Button
                    {

                        let _ = xcgLogMsg("\(ClassInfo.sClsDisp):AppDataGathererTherapist2View.Button(Xcode).'Dismiss' pressed...")

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

                    HStack
                    {

                        Button
                        {

                            let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp)AppDataGathererTherapist2View.Button(Xcode).'Locate the Therapist by tName'...")

                            self.sTherapistTID = self.locateAppTherapistNameByTName(sTherapistName:sTherapistName)

                            self.isAppRunTherapistLocateByTNameShowing.toggle()

                        }
                        label:
                        {

                            HStack(alignment:.center)
                            {

                                Spacer()

                                Label("", systemImage: "figure.run.circle")
                                    .help(Text("Locate the Therapist by tName..."))
                                    .imageScale(.small)

                                Text("=> Locate Therapist by tName")
                                    .bold()
                                    .font(.caption2)
                                    .foregroundColor(.red)

                                Spacer()

                            }

                        }
                    #if os(macOS)
                        .buttonStyle(.borderedProminent)
                        .padding()
                    //  .background(???.isPressed ? .blue : .gray)
                        .cornerRadius(10)
                        .foregroundColor(Color.primary)
                    #endif
                    //  .padding()

                    }

                    Text(" - - - - - - - - - - - - - - - - - - - - ")
                        .font(.caption2) 
                        .frame(maxWidth:.infinity, alignment:.center)

                }

                HStack()
                {

                    Text("===> Therapists' TID: ")
                        .font(.caption) 

                    Text("\(sTherapistTID)")
                        .font(.caption) 
                        .onChange(of:self.sTherapistName)
                        {
                            let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp).onChange #1 - 'self.sTherapistName' is [\(self.sTherapistName)] - clearing the 'sTherapistTID' field...")

                            self.sTherapistTID = ""
                        }

                    Spacer()

                    if (self.sTherapistTID.count    > 0 &&
                        (self.sTherapistName.count  > 0 &&
                         self.sTherapistName       != "-N/A-"))
                    {

                        Button
                        {

                            let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp)AppDataGathererTherapist2View.Button(Xcode).'Therapist Detail(s) by tName'...")

                            self.isAppTherapistDetailsByTNameShowing.toggle()

                        }
                        label:
                        {

                            VStack(alignment:.center)
                            {

                                Label("", systemImage: "doc.questionmark")
                                    .help(Text("Show Therapist Detail(s) by tName..."))
                                    .imageScale(.medium)

                                HStack(alignment:.center)
                                {

                                    Spacer()

                                    Text("Therapist Details...")
                                        .font(.caption2)

                                    Spacer()

                                }

                            }

                        }
                    #if os(macOS)
                        .sheet(isPresented:$isAppTherapistDetailsByTNameShowing, content:
                        {

                            AppDataGathererTherapist1DetailsView(sTherapistTID:$sTherapistTID)

                        })
                    #endif
                    #if os(iOS)
                        .fullScreenCover(isPresented:$isAppTherapistDetailsByTNameShowing)
                        {

                            AppDataGathererTherapist1DetailsView(sTherapistTID:$sTherapistTID)

                        }
                    #endif
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

                HStack()
                {

                    Text("=> Enter the Therapists' Name: ")
                        .font(.caption) 
                        .foregroundColor(.red)

                    TextField("Therapist tName...", text:$sTherapistName)
                        .italic()
                        .font(.caption) 
                        .focused($focusedField, equals:.therapistName)
                        .onAppear
                        {
                            self.sTherapistName = ""
                            self.sTherapistTID  = ""
                            focusedField        = .therapistName
                        }
                        .onChange(of: self.sTherapistName)
                        {
                            self.updateSelectableTherapistNamesList(sSearchValue:self.sTherapistName)
                            focusedField        = .therapistName

                            if (self.sTherapistName.count < 1)
                            {
                                self.sTherapistTID = ""
                            }
                        }
                        .onSubmit
                        {
                            self.sTherapistTID  = self.locateAppTherapistNameByTName(sTherapistName:sTherapistName)
                            focusedField        = .therapistName
                        }

                    Spacer()
                    
                    Button
                    {

                        let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp)AppDataGathererTherapist2View.Button(Xcode).'Therapist tName delete'...")

                        self.sTherapistName = ""
                        self.sTherapistTID  = ""
                        focusedField        = .therapistName

                    }
                    label:
                    {

                        VStack(alignment:.center)
                        {

                            Label("", systemImage: "delete.left")
                                .help(Text("Delete the Therapist tName..."))
                                .imageScale(.medium)

                            HStack(alignment:.center)
                            {

                                Spacer()

                                Text("Delete Therapist Name")
                                    .font(.caption2)

                                Spacer()

                            }

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

            //  HStack
            //  {
            //
            //      Button
            //      {
            //
            //          let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp)AppDataGathererTherapist2View.Button(Xcode).'Locate the Therapist by tName'...")
            //
            //          self.sTherapistTID = self.locateAppTherapistNameByTName(sTherapistName:sTherapistName)
            //
            //          self.isAppRunTherapistLocateByTNameShowing.toggle()
            //
            //      }
            //      label:
            //      {
            //
            //          VStack(alignment:.center)
            //          {
            //
            //              Label("", systemImage: "figure.run.circle")
            //                  .help(Text("Locate the Therapist by tName..."))
            //                  .imageScale(.large)
            //
            //              HStack(alignment:.center)
            //              {
            //
            //                  Spacer()
            //
            //                  Text("=> Locate the Therapist by tName...")
            //                      .bold()
            //                      .font(.caption)
            //                      .foregroundColor(.red)
            //
            //                  Spacer()
            //
            //              }
            //
            //          }
            //
            //      }
            //  #if os(macOS)
            //      .buttonStyle(.borderedProminent)
            //      .padding()
            //  //  .background(???.isPressed ? .blue : .gray)
            //      .cornerRadius(10)
            //      .foregroundColor(Color.primary)
            //  #endif
            //      .padding()
            //
            //  }
            //
            //  Spacer()

                Text("")
                    .font(.caption2)
                    .onAppear
                    {

                        listSelectableTherapistNames = [AppSearchableTherapistName]()

                        listSelectableTherapistNames.append(AppSearchableTherapistName(sTherapistTName:"...placeholder..."))

                    }

                List(listSelectableTherapistNames, id:\.id)
                { appSearchableTherapistName in

                    Text(appSearchableTherapistName.sTherapistTName)
                        .onTapGesture
                        {
                            self.sTherapistName = appSearchableTherapistName.sTherapistTName
                        }

                }
                .scaledToFill()
                .font(.caption) 
            //  .frame(maxHeight:250)

            }

            Spacer()

        }
        .padding()
        
    }
    
    private func locateAppTherapistNameByTName(sTherapistName:String = "")->String
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'sTherapistName' is [\(sTherapistName)]...")

        // Locate the Therapist TID by 'name'...

        var sTherapistTID:String = self.jmAppParseCoreManager.convertTherapistNameToTid(sPFTherapistParseName:sTherapistName)

        if (sTherapistTID.count < 1)
        {
        
            sTherapistTID = "-1"
        
        }

        // Exit...

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'sTherapistName' is [\(sTherapistName)] - 'sTherapistTID' is [\(sTherapistTID)]...")
  
        return sTherapistTID
  
    }   // End of private func locateAppTherapistNameByTName(sTherapistName:String)->String.

    private func updateSelectableTherapistNamesList(sSearchValue:String = "")
    {
        
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'sSearchValue' is [\(sSearchValue)]...")

        // Update the 'selectable' Therapist 'name(s)' list from the 'sSearchValue' criteria...

        if (sSearchValue.isEmpty)
        {
        
            self.xcgLogMsg("\(sCurrMethodDisp) Intermediate #1 - parameter 'sSearchValue' is an empty 'string' - unable to update the 'selectable' item(s) - Warning!")
            
            // Exit:

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

            return
        
        }

        // var dictPFTherapistFileItems:[Int:ParsePFTherapistFileItem] = [Int:ParsePFTherapistFileItem]()

        if (self.jmAppParseCoreManager.dictPFTherapistFileItems.count < 1)
        {
        
            self.xcgLogMsg("\(sCurrMethodDisp) Intermediate #2 - 'self.jmAppParseCoreManager.dictPFTherapistFileItems' is an empty 'dictionary' - unable to update the 'selectable' item(s) - Warning!")
            
            // Exit:

            self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

            return
        
        }

        self.xcgLogMsg("\(sCurrMethodDisp) Intermediate #3 - 'sSearchValue' is [\(sSearchValue)] - 'self.jmAppParseCoreManager.dictPFTherapistFileItems' contains (\(self.jmAppParseCoreManager.dictPFTherapistFileItems.count)) item(s)...")

        self.listSelectableTherapistNames = [AppSearchableTherapistName]()

        var cTherapistNames:Int           = 0
        var cSelectableTherapistNames:Int = 0
        let sSearchValueLow:String        = sSearchValue.lowercased()
        
        // var dictPFTherapistFileItems:[Int:ParsePFTherapistFileItem] = [Int:ParsePFTherapistFileItem]()

        for (iPFTherapistParseTID, pfTherapistFileItem) in self.jmAppParseCoreManager.dictPFTherapistFileItems
        {

            cTherapistNames += 1

            if (iPFTherapistParseTID < 0)
            {

                self.xcgLogMsg("\(sCurrMethodDisp) Skipping object #(\(cTherapistNames)) 'iPFTherapistParseTID' - the 'tid' field is less than 0 - Warning!")

                continue

            }

            let sTherapistTName:String    = pfTherapistFileItem.sPFTherapistFileName
            let sTherapistTNameLow:String = sTherapistTName.lowercased()

            if (sTherapistTNameLow.contains(sSearchValueLow) == true)
            {
            
                self.listSelectableTherapistNames.append(AppSearchableTherapistName(sTherapistTName:sTherapistTName))

                cSelectableTherapistNames += 1

                self.xcgLogMsg("\(sCurrMethodDisp) #(\(cTherapistNames)): 'sTherapistTName' of [\(sTherapistTName)] contains the 'sSearchValue' of [\(sSearchValue)] - adding to the 'selectable' list...")
            
            }

        }

        self.xcgLogMsg("\(sCurrMethodDisp) Intermediate #3 - added (\(cSelectableTherapistNames)) names(s) to the 'selectable' list of (\(self.listSelectableTherapistNames.count)) item(s)...")

        // Exit:

        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")

        return

    }   // End of private func updateSelectableTherapistNamesList(sSearchValue:String).

}   // End of struct AppDataGathererTherapist2View(View).

#Preview 
{
    
    AppDataGathererTherapist2View()
    
}

