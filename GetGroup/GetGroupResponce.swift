//
//  GetGroupResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 07/03/23.
//

import Foundation
import ObjectMapper

struct GetGroupModal : Codable{
    var idcollege : String?
}

struct GetGroupResponce : Codable{
    
    var Status : Int?
    var Message : String?
    var data : [getGroupDataDetails]?
}

struct getGroupDataDetails : Codable{
    
    var groupid : Int?
    var groupname : String?
    var grouptype : String?
    var isSelected : Bool?
}




