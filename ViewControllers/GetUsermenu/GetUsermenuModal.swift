//
//  GetUsermenuModal.swift
//  Vs_GradItCollege
//
//  Created by APPLE on 02/11/22.
//

import Foundation
import ObjectMapper


class GetUsermenuModal : Mappable  {
    
    var collegeid                   : String!
    var userid                      : String!
    var countryid                    : String!
    var langid                    : String!
    
    
    
    init(){}
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        
        
        collegeid                        <- map ["collegeid"]
        userid                           <- map ["userid"]
        countryid                        <- map ["countryid"]
        langid                           <- map ["langid"]
    }
    
    
    
    
}



class GetUsermenuResponse : Mappable  {
    
    
    var Status                      : Int!
    var Message                     : String!
    var menuData                    : [GetUsermenuData]!
    
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        
        Status                          <- map ["Status"]
        Message                         <- map ["Message"]
        menuData                        <- map ["data"]
    }
    
    
    
    
}
class GetUsermenuData : Mappable  {
    
    
    var id                    : Int!
    var name                   : String!
    var order                 : Int!
    
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        
        
        
        id                    <- map ["id"]
        name                   <- map ["name"]
        order                 <- map ["order"]
    }
    
    
    
    
}
