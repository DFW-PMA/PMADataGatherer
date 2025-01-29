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
//final class AppSearchableTherapistName: Identifiable, Hashable, Equatable
final class AppSearchableTherapistName: Identifiable
{
    
    struct ClassInfo
    {
        
        static let sClsId        = "AppSearchableTherapistName"
        static let sClsVers      = "v1.0304"
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

//  public func hash(into hasher:inout Hasher)
//  {
//
//      hasher.combine(self.id)
//
//  }   // End of public func hash(into hasher:inout Hasher).
//
//  static func ==(lhs:AppSearchableTherapistName, rhs:AppSearchableTherapistName)->Bool
//  {
//      
//      return lhs.id < rhs.id
//      
//  }   // End of static func ==(lhs:AppSearchableTherapistName, rhs:AppSearchableTherapistName)->Bool.
    
}   // End of final class AppSearchableTherapistName(Identifiable).

