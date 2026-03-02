//
//  GetYearListResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 25/03/23.
//

import Foundation
import ObjectMapper

class getYearListModal:Mappable{
    
    var idcollege : String!
    var idcourse : String!
    var iddept : String!
    var clgprocessby : String!
  
    
    init(){}
  
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        idcollege <- map["idcollege"]
        idcourse <- map["idcourse"]
        iddept <- map["iddept"]
        clgprocessby <- map["clgprocessby"]
    }
    
    
    
    
    
    
    
}

class getYearListResponce : Mappable{
    
    
    
    var Status : Int!
    var Message : String!
    var data : [getYearListDataDetails]!
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        Status <- map ["Status"]
        Message <- map["Message"]
        data <- map["data"]
    }
    

}


class getYearListDataDetails : Mappable{
    
    var yearid : Int!
    var yearname : String!
 
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        yearid <- map["yearid"]
        yearname <- map["yearname"]
        
    }
    
    
    
    
    
    
    
}
