//
//  ProfileResponse.swift
//  Vs_GradIt
//
//  Created by APPLE on 28/09/22.
//

import Foundation
import ObjectMapper





class ProfileResponse : Mappable  {
    
   
    var Status                      : Int!
    var Message                     : String!
    var data                    : [ProfileData]!
    
   

    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        
    Status                          <- map ["Status"]
    Message                         <- map ["Message"]
    data                        <- map ["data"]
    }
    
    


}




class ProfileData : Mappable  {
    
   
   
    
    var key                      : String!
    var value                     : String!
    var type                    : String!
    
   

    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        
        key                          <- map ["key"]
        value                         <- map ["value"]
        type                        <- map ["type"]
    }
    
    


}

