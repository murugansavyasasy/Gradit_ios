

import Foundation
import ObjectMapper

class SenderUpcommingExamModal : Mappable{
    
    
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

class SenderUpcommingExamResponce : Mappable{
    
    
    var  Status : Int!
    var  Message : String!
    var  data    :[SenderUpcommingExamDataDetails]!
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status  <- map["Status"]
        Message <- map["Message"]
        data    <- map["data"]
        
        
        
    }

    
}

class SenderUpcommingExamDataDetails : Mappable{
    
    
   
    
    var headerid            : String!
    var createdby           : String!
    var examname            : String!
    var startdate         : String!
    var enddate           : String!
    var createdon             : String!
    var createdbyname            : String!
   
   
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        headerid  <- map["headerid"]
        createdby  <- map["createdby"]
        examname   <- map["examname"]
        startdate  <- map["startdate"]
        enddate    <- map["enddate"]
        startdate   <- map["startdate"]
        createdon   <- map["createdon"]
        createdbyname <- map["createdbyname"]
        createdbyname <- map["createdbyname"]
    }
 
}
