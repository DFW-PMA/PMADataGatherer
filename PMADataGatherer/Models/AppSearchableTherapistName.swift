//
//  AppSearchableTherapistName.swift
//  SearchableListMPApp1
//
//  Created by Daryl Cox on 01/10/2025.
//  Copyright © JustMacApps 2023-2025. All rights reserved.
//

import Foundation
import SwiftUI

@available(iOS 14.0, *)
final class AppSearchableTherapistName: Identifiable
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "AppSearchableTherapistName"
        static let sClsVers      = "v1.0401"
        static let sClsDisp      = sClsId+".("+sClsVers+"): "
        static let sClsCopyRight = "Copyright © JustMacApps 2023-2025. All rights reserved."
        static let bClsTrace     = true
        static let bClsFileLog   = true
        
    }

    // App Data field(s):

    var id:UUID                = UUID()
    var sTherapistTName:String = ""

    init(id:UUID? = nil, sTherapistTName:String)
    {

        if (id != nil)
        {
        
            self.id = id ?? UUID()
        
        }
        else
        {
        
            self.id = UUID()
        
        }

        self.sTherapistTName = sTherapistTName

    }   // End of init(id:UUID, sTherapistTName:String).

}   // End of final class AppSearchableTherapistName(Identifiable).

