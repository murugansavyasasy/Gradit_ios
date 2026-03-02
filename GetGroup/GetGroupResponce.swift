//
//  GetGroupResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 07/03/23.
//

import Foundation
import ObjectMapper

class GetGroupModal : Mappable{
    
    
    var idcollege : String!
    
    init(){}
    

    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
    idcollege <- map["idcollege"]
    }
    
    

    
}

class GetGroupResponce : Mappable{
    
    
    var Status : Int!
    var Message : String!
    var data : [getGroupDataDetails]!
    
   
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status <- map ["Status"]
        Message <- map ["Message"]
        data <- map ["data"]
        
        
    }
    

    
}

class getGroupDataDetails : Mappable{
    
    
    var groupid : Int!
    var groupname : String!
    var grouptype : String!
    var isSelected : Bool!
    
   
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        groupid <- map ["groupid"]
        groupname <- map ["groupname"]
        grouptype <- map ["grouptype"]
        
        
    }
    

    
}




