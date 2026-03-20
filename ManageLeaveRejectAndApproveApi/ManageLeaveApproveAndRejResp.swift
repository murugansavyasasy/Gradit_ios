//
//  ManageLeaveApproveAndRejResp.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 24/03/23.
//

import Foundation
import ObjectMapper

struct mangaeLeaveModal:Codable{
    
    var leaveid : String?
    var userid : String?
    var processtype : String?
    
}

struct manageLeaveResponces :Codable{
    
    var Status : Int?
    var Message : String?
    
}
