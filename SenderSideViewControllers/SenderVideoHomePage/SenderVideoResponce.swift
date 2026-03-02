
import Foundation
import ObjectMapper


class SendervideoModal : Mappable{
   
    
    
    var userid                       : String!
    var collegeid                    : String!
    var priority                     : String!
   
    
    init(){}
    
    
    
    required init?(map: Map) {
        
        mapping(map: map)
        
    }
    
    func mapping(map: Map) {
        
        
        userid   <- map ["userid"]
        collegeid <- map ["collegeid"]
        priority  <- map["priority"]
        
        
    }
    
    
    
}


class SendervideoResponce : Mappable{
    
    var Status    :    Int!
    var Message   :    String!
    var data      :   [SendervideoDataDetails]!
    
    
   
    
    
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        Status  <- map["Status"]
        Message  <- map["Message"]
        data    <- map["data"]
        
        
        
        
        
    }
    
}

class SendervideoDataDetails : Mappable{
    
    var  videoid    : String!
    var  createdby  : String!
    var  createdon  : String!
    var  title      : String!
    var  description : String!
    var  vimeourl    : String!
    var  vimeoid     : String!
    var  detailid    : String!
    var  iframe      : String!
    var  isappviewed : String!
    
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        
        videoid  <- map["videoid"]
        createdby <- map["createdby"]
        createdon <- map["createdon"]
        title     <- map["title"]
        description <- map["description"]
        vimeourl    <- map["vimeourl"]
        vimeoid     <- map["vimeoid"]
        detailid    <- map["detailid"]
        iframe      <- map["iframe"]
        isappviewed <- map["isappviewed"]
        
        
        
        
        
        
        
        
        
        
    }
    
   
    
    
    
    
    
    
}
