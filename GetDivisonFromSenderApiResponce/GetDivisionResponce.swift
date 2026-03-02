//
//  GetDivisionResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 04/03/23.
//

import Foundation
import ObjectMapper

class getDivisionModal : Mappable{
    
    var user_id : String!
    var college_id : String!
    
  
    
    init(){}
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        user_id <- map["user_id"]
        college_id <- map["college_id"]
        
        
        
    }
    
    
  
    
    
    
    
}

class GetDivisionResponce : Mappable{
    
    
    
    var Status : Int!
    
    var Message : String!
    
    var data : [getDivisonDataDetails]!
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status <- map["Status"]
        Message <- map["Message"]
        data  <- map["data"]
        
        
        
    }
    
  

    }
    
    
class getDivisonDataDetails : Mappable{
    
    var division_code : String!
    var division_name : String!
    var division_id : String!
    var isSelected : Bool!
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        division_code <- map["division_code"]
        division_name  <- map["division_name"]
        division_id <- map["division_id"]
        
        
    }
    
 
}
    
    

