

import Foundation
import ObjectMapper

class dropDownModal : Mappable{
    
    
    var yearid : Int!
    
    init(){}
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        yearid <- map["yearid"]
    }
    
 
    
}

class dropDownResponce : Mappable{
    
    
    var Status : Int!
    var Message : String!
    var data    : [dropDownDataDetails]!
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status <- map["Status"]
        Message <- map["Message"]
        data    <- map["data"]
        
    }
  
}

class dropDownDataDetails : Mappable{
    
    
    var clgsemesterid : String!
    var semestername  : String!
    var sectiondetails :[dropDownSectionDetails]!
    
    
    
   
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        clgsemesterid <- map["clgsemesterid"]
        semestername  <- map["semestername"]
        sectiondetails <- map["sectiondetails"]
        
        
    }
    
 
    
}

class dropDownSectionDetails : Mappable{
    
    
    var  sectionid : String!
    var  sectionname : String!
    
    
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        sectionid <- map["sectionid"]
        sectionname <- map["sectionname"]
        
    }
    
    
 
    
}
