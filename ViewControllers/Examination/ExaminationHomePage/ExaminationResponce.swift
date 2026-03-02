

import Foundation
import ObjectMapper

class examModal : Mappable{
    
    
    var  userid         : String!
    var  collegeid      : String!
    var  sectionid      : String!
    var  appid          : String!
    var  priority       : String!
    var  type           : String!
    
    
  
    
    init(){}
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        userid  <- map["userid"]
        collegeid <- map["collegeid"]
        sectionid <- map["sectionid"]
        appid     <- map["appid"]
        priority   <- map["priority"]
        type       <- map["type"]
        
        
        
    }
    
 
    
}

class examResponce : Mappable{
    
    
    var  Status : Int!
    var  Message : String!
    var  data    :[examDataDetails]!
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status  <- map["Status"]
        Message <- map["Message"]
        data    <- map["data"]
        
        
        
    }

    
}

class examDataDetails : Mappable{
    
    
    
    
    var headerid            : String!
    var createdby           : String!
    var examname            : String!
    var subjectname         : String!
    var examvenue           : String!
    var session             : String!
    var syllabus            : String!
    var date                : String!
    var createdbyname       : String!
    
   
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        headerid  <- map["headerid"]
        createdby  <- map["createdby"]
        examname   <- map["examname"]
        subjectname  <- map["subjectname"]
        examvenue    <- map["examvenue"]
        session   <- map["session"]
        syllabus   <- map["syllabus"]
        date     <- map["date"]
        createdbyname <- map["createdbyname"]
    }
 
}
