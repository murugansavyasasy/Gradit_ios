//
//  DeviceTokenModal.swift
//  Vs_GradItCollege
//
//  Created by Apple on 09/06/23.
//

import Foundation

import ObjectMapper




class DeviceTokenModal : Mappable  {
    
    var mobileno                   : String!
    var devicetoken                      : String!
    var devicetype                    : String!
    
    
    
    init(){}
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        
        
        mobileno                       <- map ["mobileno"]
        devicetoken                          <- map ["devicetoken"]
        devicetype                        <- map ["devicetype"]
    }
    
    
}
