//
//  AppLocationView.swift
//  PMADataGatherer
//
//  Created by Daryl Cox on 11/18/2024.
//  Copyright © JustMacApps 2023-2025. All rights reserved.
//

import SwiftUI

struct AppLocationView: View 
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "AppLocationView"
        static let sClsVers      = "v1.1601"
        static let sClsDisp      = sClsId+"(.swift).("+sClsVers+"):"
        static let sClsCopyRight = "Copyright (C) JustMacApps 2023-2025. All Rights Reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }
    
    // App Data field(s):

//  @Environment(\.dismiss)          var dismiss
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.openWindow)       var openWindow

    static          var timerOnDemand90Sec                                    = Timer()
    static          var timerOnDemand3Sec                                     = Timer()
    
    @State private  var cAppLocationViewLogPFDataButtonPresses:Int            = 0

    @State private  var isAppLogPFDataViewModal:Bool                          = false

    @State private  var cAppLocationViewRefreshButtonPresses:Int              = 0
    @State private  var cAppLocationViewRefreshAutoTimer:Int                  = 0
    @State private  var cAppScheduleViewRefreshAutoTimer:Int                  = 0
    @State private  var cContentViewAppDataButtonPresses:Int                  = 0

    @State private  var isAppDataViewModal:Bool                               = false

                    var jmAppDelegateVisitor:JmAppDelegateVisitor             = JmAppDelegateVisitor.ClassSingleton.appDelegateVisitor
    @ObservedObject var jmAppParseCoreManager:JmAppParseCoreManager           = JmAppParseCoreManager.ClassSingleton.appParseCodeManager
                    var jmAppParseCoreBkgdDataRepo:JmAppParseCoreBkgdDataRepo = JmAppParseCoreBkgdDataRepo.ClassSingleton.appParseCodeBkgdDataRepo
    
    init()
    {

        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
    //  // Handle the 'jmAppParseCoreManager' parameter...
    //  self._jmAppParseCoreManager = StateObject(wrappedValue: jmAppParseCoreManager)

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

                    Spacer()

                    Button
                    {

                        let _ = xcgLogMsg("\(ClassInfo.sClsDisp):AppLocationView.Button(Xcode).'Sync PFData' pressed...")

                        self.syncPFDataItems()

                    }
                    label:
                    {

                        VStack(alignment:.center)
                        {

                            Label("", systemImage: "doc.text.magnifyingglass")
                                .help(Text("Sync PFQuery Data Item(s)..."))
                                .imageScale(.small)

                            Text("Sync PFData")
                                .font(.caption2)

                        }

                    }
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

                        self.cAppLocationViewRefreshButtonPresses += 1

                        let _ = self.xcgLogMsg("...\(ClassInfo.sClsDisp)AppLocationView.Button(Xcode).'Refresh'.#(\(self.cAppLocationViewRefreshButtonPresses))...")

                        let _ = self.checkIfAppParseCoreHasPFCscDataItems(bRefresh:true)
                        let _ = self.checkIfAppParseCoreHasPFQueryBackgroundItems(bRefresh:true)

                    }
                    label:
                    {

                        VStack(alignment:.center)
                        {

                            Label("", systemImage: "arrow.clockwise")
                                .help(Text("'Refresh' App Location Screen..."))
                                .imageScale(.large)

                            Text("Refresh - #(\(self.cAppLocationViewRefreshButtonPresses))...")
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

                        self.cContentViewAppDataButtonPresses += 1

                        let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp):ContentView.Button(Xcode).'App Data...'.#(\(self.cContentViewAppDataButtonPresses))...")

                        self.isAppDataViewModal.toggle()

                    #if os(macOS)

                        // Using -> @Environment(\.openWindow)var openWindow and 'openWindow(id:"...")' on MacOS...
                        openWindow(id:"AppDataGathererView")

                    #endif

                //  #if os(macOS)
                //
                //      // Using -> @Environment(\.openWindow)var openWindow and 'openWindow(id:"...")' on MacOS...
                //      openWindow(id:"AppLocationView", value:self.getAppParseCoreManagerInstance())
                //
                //      //  ERROR: Instance method 'callAsFunction(id:value:)' requires that 'JmAppParseCoreManager' conform to 'Encodable'
                //      //  ERROR: Instance method 'callAsFunction(id:value:)' requires that 'JmAppParseCoreManager' conform to 'Decodable'
                //
                //  #endif

                    }
                    label:
                    {

                        VStack(alignment:.center)
                        {

                            Label("", systemImage: "swiftdata")
                                .help(Text("App Data Gatherer"))
                                .imageScale(.large)

                            Text("Data")
                                .font(.caption)

                        }

                    }
            //  #if os(macOS)
            //      .sheet(isPresented:$isAppDataViewModal, content:
            //          {
            //
            //              AppDataGathererView()
            //
            //          }
            //      )
            //  #endif
                #if os(iOS)
                    .fullScreenCover(isPresented:$isAppDataViewModal)
                    {

                        AppDataGathererView()

                    }
                #endif
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

                        let _ = xcgLogMsg("\(ClassInfo.sClsDisp):AppLocationView.Button(Xcode).'Dismiss' pressed...")

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

                Text("")
                    .onAppear(
                        perform:
                        {
                            let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp).onAppear(perform:) Initial View - invoking the 'syncPFDataItems()'...")
                            self.syncPFDataItems()
                            let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp).onAppear(perform:) Initial View - invoked  the 'syncPFDataItems()'...")

                            AppLocationView.timerOnDemand90Sec = Timer.scheduledTimer(withTimeInterval:90, repeats:false)
                            { _ in
                                let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp) <onDemand Timer> <on demand> '90-second' Timer 'pop' - invoking the 'syncPFDataItems()'...")
                                self.syncPFDataItems()
                                let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp) <onDemand Timer> <on demand> '90-second' Timer 'pop' - invoked  the 'syncPFDataItems()'...")
                            }
                        })

                Text("Auto-Update #(\(jmAppParseCoreManager.cPFCscObjectsRefresh)):(\(cAppLocationViewRefreshButtonPresses).\(cAppLocationViewRefreshAutoTimer).\(cAppScheduleViewRefreshAutoTimer))")
                    .bold()
                    .italic()
                    .underline(true)
                    .font(.footnote)
                    .onChange(of:self.cAppLocationViewRefreshAutoTimer)
                    {
                        let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp).onChange #2 - Auto-Update #(\(jmAppParseCoreManager.cPFCscObjectsRefresh)): for 'cAppLocationViewRefreshAutoTimer' of #(\(self.cAppLocationViewRefreshAutoTimer))...")
                    }
                    .onChange(of:self.cAppScheduleViewRefreshAutoTimer)
                    {
                        let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp).onChange #3 - Auto-Update #(\(jmAppParseCoreManager.cPFCscObjectsRefresh)): for 'cAppScheduleViewRefreshAutoTimer' of #(\(self.cAppScheduleViewRefreshAutoTimer))...")
                    }

                Text("")
                #if os(iOS)
                    .onAppear(
                        perform:
                        {
                            UIApplication.shared.isIdleTimerDisabled = true 
                        })
                    .onDisappear(
                        perform:
                        {
                            UIApplication.shared.isIdleTimerDisabled = false
                        })
                #endif

                ScrollView(.vertical)
                {

                    Grid(alignment:.leadingFirstTextBaseline, horizontalSpacing:5, verticalSpacing: 3)
                    {

                        // Column Headings:

                        Divider() 

                        GridRow 
                        {

                            Text("Map")
                                .font(.caption)
                            Text("Visits")
                                .font(.caption)
                            Text("Name")
                                .font(.caption)
                            Text("Date")
                                .font(.caption)
                            Text("Time")
                                .font(.caption)
                            Text("Address or Location")
                                .font(.caption)

                        }
                        .font(.title3) 

                        Divider() 

                        // Item Rows:

                        // ----------------------------------------------------------------------------------
                        //     ForEach(Array(dict), id: \.key) 
                        //         { key, pfCscObject in
                        //             Text("\(key) = \(pfCscObject)")
                        //         }
                        // ----------------------------------------------------------------------------------

                        ForEach(jmAppParseCoreManager.listPFCscDataItems) 
                        { pfCscObject in

                            GridRow(alignment:.bottom)
                            {

                            #if os(macOS)
                                Button
                                {
                                    // Using -> @Environment(\.openWindow)var openWindow and 'openWindow(id:"...")' on MacOS...
                                    openWindow(id:"AppLocationMapView", value:pfCscObject.id)
                                }
                                label:
                                {

                                    VStack(alignment:.center)
                                    {

                                        Label("", systemImage: "mappin.and.ellipse")
                                            .help(Text("'Map' the App Location..."))
                                            .imageScale(.small)
                                        #if os(macOS)
                                            .onTapGesture(count:1)
                                            {

                                                let _ = xcgLogMsg("\(ClassInfo.sClsDisp):AppLocationView.GridRow.NavigationLink.'.onTapGesture()' received - Map #(\(pfCscObject.idPFCscObject))...")

                                                let _ = AppLocationMapView(parsePFCscDataItem:pfCscObject)

                                            }
                                        #endif

                                        Text("Map #(\(pfCscObject.idPFCscObject))")
                                            .font(.caption2)

                                    }

                                }
                                .gridColumnAlignment(.center)
                                .buttonStyle(.borderedProminent)
                                .padding()
                            //  .background(???.isPressed ? .blue : .gray)
                                .cornerRadius(10)
                                .foregroundColor(Color.primary)
                            #endif
                            #if os(iOS)
                                NavigationLink
                                {
                                    AppLocationMapView(parsePFCscDataItem:pfCscObject)
                                        .navigationBarBackButtonHidden(true)
                                    //  .navigationBarBackButtonHidden(false)
                                    // NOTE: This causes a 'build' failure:
                                    //       >>> The compiler is unable to type-check this expression in reasonable time;
                                    //           try breaking up the expression into distinct sub-expressions...
                                    //  .isDetailLink(false)
                                }
                                label:
                                {

                                    VStack(alignment:.center)
                                    {

                                        Label("", systemImage: "mappin.and.ellipse")
                                            .help(Text("'Map' the App Location..."))
                                            .imageScale(.small)
                                        #if os(macOS)
                                            .onTapGesture(count:1)
                                            {

                                                let _ = xcgLogMsg("\(ClassInfo.sClsDisp):AppLocationView.GridRow.NavigationLink.'.onTapGesture()' received - Map #(\(pfCscObject.idPFCscObject))...")

                                                let _ = AppLocationMapView(parsePFCscDataItem:pfCscObject)

                                            }
                                        #endif

                                        Text("Map #(\(pfCscObject.idPFCscObject))")
                                            .font(.caption2)

                                    }

                                }
                                .gridColumnAlignment(.center)
                            #endif

                                Text("(\(self.getScheduledPatientLocationItemsCountForPFCscDataItem(pfCscDataItem:pfCscObject)))")
                                    .bold()
                                    .font(.caption)
                                Text(pfCscObject.sPFCscParseName)
                                    .bold()
                                    .font(.caption)
                                Text(pfCscObject.sPFCscParseLastLocDate)
                                    .gridColumnAlignment(.center)
                                    .font(.caption)
                                Text(pfCscObject.sPFCscParseLastLocTime)
                                    .gridColumnAlignment(.center)
                                    .font(.caption)
                                    .onChange(of:jmAppParseCoreManager.cPFCscObjectsRefresh)
                                    {
                                        let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp).onChange #1 - GridRow(Item(s)) #(\(pfCscObject.idPFCscObject)) for [\(pfCscObject.sPFCscParseName)] received a 'refresh' COUNT update #(\(jmAppParseCoreManager.cPFCscObjectsRefresh))...")
                                    }
                            if (pfCscObject.sCurrentLocationName.count < 1 ||
                                pfCscObject.sCurrentCity.count         < 1)
                            {
                            
                                Text("\(pfCscObject.dblConvertedLatitude), \(pfCscObject.dblConvertedLongitude)")
                                    .font(.caption2)

                            }
                            else
                            {
                            
                                Text("\(pfCscObject.sCurrentLocationName), \(pfCscObject.sCurrentCity)")
                                    .font(.caption)

                            }

                            }

                        }

                    }
                    .onReceive(jmAppParseCoreManager.timerPublisherTherapistLocations,
                        perform:
                        { dtObserved in

                            self.cAppLocationViewRefreshAutoTimer += 1

                            let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp).onReceive #1 - Grid.Timer<notification> - <timerPublisherTherapistLocations> - setting auto 'refresh' by timer to #(\(self.cAppLocationViewRefreshAutoTimer)) - 'dtObserved' is [\(dtObserved)]...")

                            let _ = self.checkIfAppParseCoreHasPFCscDataItems(bRefresh:false)

                            AppLocationView.timerOnDemand90Sec = Timer.scheduledTimer(withTimeInterval:90, repeats:false)
                            { _ in
                                let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp) <onDemand Timer> <on demand> '90-second' Timer 'pop' - invoking the 'jmAppDelegateVisitor.checkAppDelegateVisitorTraceLogFileForSize()' and 'syncPFDataItems()'...")
                                self.jmAppDelegateVisitor.checkAppDelegateVisitorTraceLogFileForSize()
                                self.syncPFDataItems()
                                let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp) <onDemand Timer> <on demand> '90-second' Timer 'pop' - invoked  the 'jmAppDelegateVisitor.checkAppDelegateVisitorTraceLogFileForSize()' and 'syncPFDataItems()'...")
                            }

                        //  AppLocationView.timerOnDemand3Sec = Timer.scheduledTimer(withTimeInterval:3, repeats:false)
                        //  { _ in
                        //      let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp) <onDemand Timer> <on demand> '3-second' Timer 'pop' - invoking the 'syncPFDataItems()'...")
                        //      self.syncPFDataItems()
                        //      let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp) <onDemand Timer> <on demand> '3-second' Timer 'pop' - invoked  the 'syncPFDataItems()'...")
                        //  }

                        })
                    .onReceive(jmAppParseCoreManager.timerPublisherScheduleLocations,
                        perform:
                        { dtObserved in

                            self.cAppScheduleViewRefreshAutoTimer += 1

                            let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp).onReceive #2 - Grid.Timer<notification> - <timerPublisherScheduleLocations> - setting auto 'refresh' by timer to #(\(self.cAppScheduleViewRefreshAutoTimer)) - 'dtObserved' is [\(dtObserved)]...")

                            let _ = self.checkIfAppParseCoreHasPFQueryBackgroundItems(bRefresh:false)

                            AppLocationView.timerOnDemand90Sec = Timer.scheduledTimer(withTimeInterval:90, repeats:false)
                            { _ in
                                let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp) <onDemand Timer> <on demand> '90-second' Timer 'pop' - invoking the 'syncPFDataItems()'...")
                                self.syncPFDataItems()
                                let _ = self.xcgLogMsg("\(ClassInfo.sClsDisp) <onDemand Timer> <on demand> '90-second' Timer 'pop' - invoked  the 'syncPFDataItems()'...")
                            }

                        })

                }

            }

            Text("")            
                .hidden()
                .onAppear(
                    perform:
                    {
                        // Finish App 'initialization'...

                        let _ = self.finishAppInitialization()
                    })

        }
        .padding()
        
    }
    
    private func finishAppInitialization()
    {

        let sCurrMethod:String = #function;
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // Finish the App 'initialization'...
  
        self.xcgLogMsg("\(ClassInfo.sClsDisp) Invoking the 'jmAppDelegateVisitor.checkAppDelegateVisitorTraceLogFileForSize()'...")

        self.jmAppDelegateVisitor.checkAppDelegateVisitorTraceLogFileForSize()

        self.xcgLogMsg("\(ClassInfo.sClsDisp) Invoked  the 'jmAppDelegateVisitor.checkAppDelegateVisitorTraceLogFileForSize()'...")

        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return

    } // End of private func finishAppInitialization().
    
    private func checkIfAppParseCoreHasPFCscDataItems(bRefresh:Bool = false) -> Bool
    {
  
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'bRefresh' is [\(bRefresh)]...")
  
        self.xcgLogMsg("\(sCurrMethodDisp) Calling the 'jmAppParseCoreBkgdDataRepo' method 'getJmAppParsePFQueryForCSC()' to get a 'location' list...")

        let _ = self.jmAppParseCoreBkgdDataRepo.getJmAppParsePFQueryForCSC()

        self.xcgLogMsg("\(sCurrMethodDisp) Called  the 'jmAppParseCoreBkgdDataRepo' method 'getJmAppParsePFQueryForCSC()' to get a 'location' list...")

        if (bRefresh == true)
        {
        
            self.xcgLogMsg("\(sCurrMethodDisp) <Timer> Calling the 'jmAppParseCoreBkgdDataRepo' 'deep copy' method...")

            let _ = self.jmAppParseCoreBkgdDataRepo.deepCopyDictPFAdminsDataItems()

            self.xcgLogMsg("\(sCurrMethodDisp) <Timer> Called  the 'jmAppParseCoreBkgdDataRepo' 'deep copy' method...")
        
        }

        var bWasAppPFCscDataPresent:Bool = false

        if (self.jmAppParseCoreManager.listPFCscDataItems.count < 1)
        {

            self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppParseCoreManager' has a 'listPFCscDataItems' that is 'empty'...")

            bWasAppPFCscDataPresent = false

        }
        else
        {

            self.xcgLogMsg("\(sCurrMethodDisp) 'jmAppParseCoreManager' has a 'listPFCscDataItems' that is [\(String(describing: jmAppDelegateVisitor.jmAppParseCoreManager?.listPFCscDataItems))]...")

            bWasAppPFCscDataPresent = true

            self.xcgLogMsg("\(sCurrMethodDisp) Sorting #(\(self.jmAppParseCoreManager.listPFCscDataItems.count)) Item(s) in the 'jmAppParseCoreManager.listPFCscDataItems' of [\(self.jmAppParseCoreManager.listPFCscDataItems)]...")

            self.jmAppParseCoreManager.listPFCscDataItems.sort
            { (pfCscDataItem1, pfCscDataItem2) in

            //  Compare for Sort: '<' sorts 'ascending' and '>' sorts 'descending'...

            var bIsItem1GreaterThanItem2:Bool = false

            if (pfCscDataItem1.sPFCscParseLastLocDate != pfCscDataItem2.sPFCscParseLastLocDate)
            {
                bIsItem1GreaterThanItem2 = (pfCscDataItem1.sPFCscParseLastLocDate > pfCscDataItem2.sPFCscParseLastLocDate)
            }
            else
            {
            //  bIsItem1GreaterThanItem2:Bool = (pfCscDataItem1.sPFCscParseLastLocTime < pfCscDataItem2.sPFCscParseLastLocTime)
                bIsItem1GreaterThanItem2 = (pfCscDataItem1.sPFCscParseLastLocTime > pfCscDataItem2.sPFCscParseLastLocTime)
            }

            //  self.xcgLogMsg("\(sCurrMethodDisp) Sort <OP> Returning 'bIsItem1GreaterThanItem2' of [\(bIsItem1GreaterThanItem2)] because 'pfCscDataItem1.sPFCscParseLastLocTime' is [\(pfCscDataItem1.sPFCscParseLastLocTime)] and is less than 'pfCscDataItem2.sPFCscParseLastLocTime' is [\(pfCscDataItem2.sPFCscParseLastLocTime)]...")

                return bIsItem1GreaterThanItem2

            }

            self.xcgLogMsg("\(sCurrMethodDisp) Sorted  #(\(self.jmAppParseCoreManager.listPFCscDataItems.count)) Item(s) in the 'jmAppParseCoreManager.listPFCscDataItems' of [\(self.jmAppParseCoreManager.listPFCscDataItems)]...")

        }

        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'bWasAppPFCscDataPresent' is [\(String(describing: bWasAppPFCscDataPresent))]...")
  
        return bWasAppPFCscDataPresent
  
    }   // End of private func checkIfAppParseCoreHasPFCscDataItems().

    private func checkIfAppParseCoreHasPFQueryBackgroundItems(bRefresh:Bool = false) -> Bool
    {
  
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - 'bRefresh' is [\(bRefresh)]...")
  
        self.xcgLogMsg("\(sCurrMethodDisp) <Timer> Calling the 'jmAppParseCoreBkgdDataRepo' method 'gatherJmAppParsePFQueriesForScheduledLocationsInBackground()' to gather 'scheduled' Patient Schedule location data...")

        let _ = self.jmAppParseCoreBkgdDataRepo.gatherJmAppParsePFQueriesForScheduledLocationsInBackground()

        self.xcgLogMsg("\(sCurrMethodDisp) <Timer> Called  the 'jmAppParseCoreBkgdDataRepo' method 'gatherJmAppParsePFQueriesForScheduledLocationsInBackground()' to gather 'scheduled' Patient Schedule location data...")

        self.xcgLogMsg("\(sCurrMethodDisp) <Timer> Calling the 'jmAppParseCoreBkgdDataRepo' method 'gatherJmAppParsePFQueriesForPatientFileInBackground()' to gather PatientFile data...")

        let _ = self.jmAppParseCoreBkgdDataRepo.gatherJmAppParsePFQueriesForPatientFileInBackground()

        self.xcgLogMsg("\(sCurrMethodDisp) <Timer> Called  the 'jmAppParseCoreBkgdDataRepo' method 'gatherJmAppParsePFQueriesForPatientFileInBackground()' to gather PatientFile data...")

        if (bRefresh == true)
        {
        
            self.xcgLogMsg("\(sCurrMethodDisp) <Timer> Calling the 'jmAppParseCoreBkgdDataRepo' 'deep copy' method(s)...")

            let _ = self.jmAppParseCoreBkgdDataRepo.deepCopyDictTherapistTidXref()
            let _ = self.jmAppParseCoreBkgdDataRepo.deepCopyDictPFTherapistFileItems()
            let _ = self.jmAppParseCoreBkgdDataRepo.deepCopyDictPatientPidXref()
            let _ = self.jmAppParseCoreBkgdDataRepo.deepCopyDictPFPatientFileItems()
            let _ = self.jmAppParseCoreBkgdDataRepo.deepCopyDictSchedPatientLocItems()
            let _ = self.jmAppParseCoreBkgdDataRepo.deepCopyListPFCscDataItems()
            let _ = self.jmAppParseCoreBkgdDataRepo.deepCopyListPFCscNameItems()

            self.xcgLogMsg("\(sCurrMethodDisp) <Timer> Called  the 'jmAppParseCoreBkgdDataRepo' 'deep copy' method(s)...")
        
        }

        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return true

    }   // End of private func checkIfAppParseCoreHasPFQueryBackgroundItems().

    private func convertPFCscDataItemToTid(pfCscDataItem:ParsePFCscDataItem)->String
    {
  
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'pfCscDataItem' is [\(pfCscDataItem)]...")

        // Use the TherapistName in the PFCscDataItem to lookup the 'sPFTherapistParseTID'...

        var sPFTherapistParseTID:String                 = ""
        let jmAppParseCoreManager:JmAppParseCoreManager = JmAppParseCoreManager.ClassSingleton.appParseCodeManager

        if (pfCscDataItem.sPFCscParseName.count > 0)
        {

            sPFTherapistParseTID = jmAppParseCoreManager.convertTherapistNameToTid(sPFTherapistParseName:pfCscDataItem.sPFCscParseName)

            if (sPFTherapistParseTID.count < 1)
            {

                sPFTherapistParseTID = jmAppParseCoreBkgdDataRepo.convertTherapistNameToTid(sPFTherapistParseName:pfCscDataItem.sPFCscParseName)

                if (sPFTherapistParseTID.count < 1)
                {

                    let _ = jmAppParseCoreBkgdDataRepo.deepCopyListPFCscDataItems()
                    let _ = jmAppParseCoreBkgdDataRepo.deepCopyListPFCscNameItems()

                }

            }

        }

        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'sPFTherapistParseTID' is [\(sPFTherapistParseTID)] for Name 'pfCscDataItem.sPFCscParseName' of [\(pfCscDataItem.sPFCscParseName)]...")
  
        return sPFTherapistParseTID
  
    }   // End of private func convertPFCscDataItemToTid(pfCscDataItem:PFCscDataItem)->String.

    private func getScheduledPatientLocationItemsForTid(sPFTherapistParseTID:String = "")->[ScheduledPatientLocationItem]
    {
  
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'sPFTherapistParseTID' is [\(sPFTherapistParseTID)]...")

        // Use the TherapistName in the PFCscDataItem to lookup any ScheduledPatientLocationItem(s)...

        var listScheduledPatientLocationItems:[ScheduledPatientLocationItem] = []
        let jmAppParseCoreManager:JmAppParseCoreManager                      = JmAppParseCoreManager.ClassSingleton.appParseCodeManager

        if (sPFTherapistParseTID.count > 0)
        {

            if (jmAppParseCoreManager.dictSchedPatientLocItems.count > 0)
            {

                listScheduledPatientLocationItems = jmAppParseCoreManager.dictSchedPatientLocItems[sPFTherapistParseTID] ?? []

            }

        }
        
        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'listScheduledPatientLocationItems' is [\(listScheduledPatientLocationItems)]...")
  
        return listScheduledPatientLocationItems
  
    }   // End of private func getScheduledPatientLocationItemsForTid(sPFTherapistParseTID:String = "")->[ScheduledPatientLocationItem].

    private func getScheduledPatientLocationItemsForPFCscDataItem(pfCscDataItem:ParsePFCscDataItem)->[ScheduledPatientLocationItem]
    {
  
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'pfCscDataItem' is [\(pfCscDataItem)]...")

        // Use the Therapist TID to lookup any ScheduledPatientLocationItem(s)...

        let sPFTherapistParseTID:String
            = self.convertPFCscDataItemToTid(pfCscDataItem:pfCscDataItem)
        let listScheduledPatientLocationItems:[ScheduledPatientLocationItem] 
            = self.getScheduledPatientLocationItemsForTid(sPFTherapistParseTID:sPFTherapistParseTID)

        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'listScheduledPatientLocationItems' is [\(listScheduledPatientLocationItems)]...")
  
        return listScheduledPatientLocationItems
  
    }   // End of private func getScheduledPatientLocationItemsForPFCscDataItem(pfCscDataItem:PFCscDataItem)->[ScheduledPatientLocationItem].

    private func getScheduledPatientLocationItemsCountForPFCscDataItem(pfCscDataItem:ParsePFCscDataItem)->Int
    {
  
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked - parameter 'pfCscDataItem' is [\(pfCscDataItem)]...")

        // Use the 'pfCscDataItem' to lookup any ScheduledPatientLocationItem(s) and return their count...

        var cScheduledPatientLocationItems:Int = 0
        let listScheduledPatientLocationItems:[ScheduledPatientLocationItem]
            = self.getScheduledPatientLocationItemsForPFCscDataItem(pfCscDataItem:pfCscDataItem)

        if (listScheduledPatientLocationItems.count > 0)
        {
        
            cScheduledPatientLocationItems = listScheduledPatientLocationItems.count
        
            self.xcgLogMsg("\(sCurrMethodDisp) <Checking> There are #(\(cScheduledPatientLocationItems)) Patient 'visit'(s) for 'sPFTherapistParseTID' of [\(pfCscDataItem.sPFTherapistParseTID)] with 'sPFCscParseName' of [\(pfCscDataItem.sPFCscParseName)]...")
        
        }
        else
        {
        
            cScheduledPatientLocationItems = 0
        
            self.xcgLogMsg("\(sCurrMethodDisp) <Checking> There are NO Patient 'visit'(s) for 'sPFTherapistParseTID' of [\(pfCscDataItem.sPFTherapistParseTID)] with 'sPFCscParseName' of [\(pfCscDataItem.sPFCscParseName)] and NO 'placeholder' object - Error!")

        }

        if (cScheduledPatientLocationItems == 1)
        {
        
            let scheduledPatientLocationItem:ScheduledPatientLocationItem = listScheduledPatientLocationItems[0]

            self.xcgLogMsg("\(sCurrMethodDisp) <Checking> The ONLY Patient 'visit' for 'sPFTherapistParseTID' of [\(scheduledPatientLocationItem.sTid)] to determine if it is a 'placeholder' object...")

            // If the ONLY Patient 'visit' is a 'placeholder' object (no PID or Date values), reset the returned Visit count to 0...

            if (scheduledPatientLocationItem.iPid                     == -1 &&
                scheduledPatientLocationItem.sVDate.count              < 1  &&
                scheduledPatientLocationItem.sVDateStartTime.count     < 1  &&
                scheduledPatientLocationItem.sVDateStartTime24h.count  < 1)
            {

                cScheduledPatientLocationItems = 0

                self.xcgLogMsg("\(sCurrMethodDisp) <Checking> The ONLY Patient 'visit' for 'sPFTherapistParseTID' of [\(scheduledPatientLocationItem.sTid)] is a 'placeholder' object - resetting the 'visits' count to 0...")

            }
            else
            {

                self.xcgLogMsg("\(sCurrMethodDisp) <Checking> The ONLY Patient 'visit' for 'sPFTherapistParseTID' of [\(scheduledPatientLocationItem.sTid)] is NOT a 'placeholder' object...")

            }
        
        }

        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting - 'cScheduledPatientLocationItems' is [\(cScheduledPatientLocationItems)]...")
  
        return cScheduledPatientLocationItems
  
    }   // End of private func getScheduledPatientLocationItemsCountForPFCscDataItem(pfCscDataItem:ParsePFCscDataItem)->Int.

    private func syncPFDataItems()
    {
  
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")

        // 'sync' (aka, deep copy) the ParseCoreBkgdDataRepo PFCscDataItem(s) to the ParseCoreManager...

        self.xcgLogMsg("\(sCurrMethodDisp) Invoking 'jmAppParseCoreBkgdDataRepo' 'deepCopyDictPFAdminsDataItems()'...")

        let _ = self.jmAppParseCoreBkgdDataRepo.deepCopyDictPFAdminsDataItems()

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked  'jmAppParseCoreBkgdDataRepo' 'deepCopyDictPFAdminsDataItems()'...")

        self.xcgLogMsg("\(sCurrMethodDisp) Invoking 'jmAppParseCoreBkgdDataRepo' 'deepCopyDictTherapistTidXref()'...")

        let _ = self.jmAppParseCoreBkgdDataRepo.deepCopyDictTherapistTidXref()

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked  'jmAppParseCoreBkgdDataRepo' 'deepCopyDictTherapistTidXref()'...")

        self.xcgLogMsg("\(sCurrMethodDisp) Invoking 'jmAppParseCoreBkgdDataRepo' 'deepCopyDictPFTherapistFileItems()'...")

        let _ = self.jmAppParseCoreBkgdDataRepo.deepCopyDictPFTherapistFileItems()

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked  'jmAppParseCoreBkgdDataRepo' 'deepCopyDictPFTherapistFileItems()'...")

        self.xcgLogMsg("\(sCurrMethodDisp) Invoking 'jmAppParseCoreBkgdDataRepo' 'deepCopyDictPatientPidXref()'...")

        let _ = self.jmAppParseCoreBkgdDataRepo.deepCopyDictPatientPidXref()

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked  'jmAppParseCoreBkgdDataRepo' 'deepCopyDictPatientPidXref()'...")

        self.xcgLogMsg("\(sCurrMethodDisp) Invoking 'jmAppParseCoreBkgdDataRepo' 'deepCopyDictPFPatientFileItems()'...")

        let _ = self.jmAppParseCoreBkgdDataRepo.deepCopyDictPFPatientFileItems()

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked  'jmAppParseCoreBkgdDataRepo' 'deepCopyDictPFPatientFileItems()'...")

        self.xcgLogMsg("\(sCurrMethodDisp) Invoking 'jmAppParseCoreBkgdDataRepo' 'deepCopyDictSchedPatientLocItems()'...")

        let _ = self.jmAppParseCoreBkgdDataRepo.deepCopyDictSchedPatientLocItems()

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked  'jmAppParseCoreBkgdDataRepo' 'deepCopyDictSchedPatientLocItems()'...")

        self.xcgLogMsg("\(sCurrMethodDisp) Invoking 'jmAppParseCoreBkgdDataRepo' 'deepCopyListPFCscDataItems()'...")

        let _ = self.jmAppParseCoreBkgdDataRepo.deepCopyListPFCscDataItems()

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked  'jmAppParseCoreBkgdDataRepo' 'deepCopyListPFCscDataItems()'...")

        self.xcgLogMsg("\(sCurrMethodDisp) Invoking 'jmAppParseCoreBkgdDataRepo' 'deepCopyListPFCscNameItems()'...")

        let _ = self.jmAppParseCoreBkgdDataRepo.deepCopyListPFCscNameItems()

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked  'jmAppParseCoreBkgdDataRepo' 'deepCopyListPFCscNameItems()'...")

        self.xcgLogMsg("\(sCurrMethodDisp) Invoking 'self.detailPFCscDataItems()'...")

        self.detailPFCscDataItems()

        self.xcgLogMsg("\(sCurrMethodDisp) Invoked 'self.detailPFCscDataItems()'...")

        // Exit...
  
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
  
        return
  
    }   // End of private func syncPFDataItems()

    private func detailPFCscDataItems()
    {
    
        let sCurrMethod:String = #function
        let sCurrMethodDisp    = "\(ClassInfo.sClsDisp)'"+sCurrMethod+"':"
        
        self.xcgLogMsg("\(sCurrMethodDisp) Invoked...")
    
        // Log BOTH of the ParseCoreManager and ParseCoreBkgdDataRepo PFCscDataItem(s)...
    
        self.xcgLogMsg("\(sCurrMethodDisp) Displaying 'jmAppParseCoreManager' #(\(self.jmAppParseCoreManager.listPFCscDataItems.count)) PFCscDataItem(s)...")
    
        self.jmAppParseCoreManager.displayListPFCscDataItems()
    
        self.xcgLogMsg("\(sCurrMethodDisp) Displaying 'jmAppParseCoreBkgdDataRepo' #(\(self.jmAppParseCoreBkgdDataRepo.listPFCscDataItems.count)) PFCscDataItem(s)...")
    
        self.jmAppParseCoreBkgdDataRepo.displayListPFCscDataItems()
    
        // Exit...
    
        self.xcgLogMsg("\(sCurrMethodDisp) Exiting...")
    
        return
    
    }   // End of private func detailPFCscDataItems()

}   // End of struct AppLocationView(View).

#Preview 
{
    
    AppLocationView()
    
}

