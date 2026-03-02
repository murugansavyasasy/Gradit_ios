

import Foundation
import ObjectMapper

class chageModal : Mappable{
    
    
    var mobilenumber : String!
    var oldpassword  : String!
    var newpassword  : String!
    
    
    
    init(){}
    
    
    
    
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        
        mobilenumber  <- map["mobilenumber"]
        oldpassword   <- map["oldpassword"]
        newpassword   <- map["newpassword"]
        
        
        
        
        
    }
    
    
    
    
    
    
}

class chageResponce : Mappable{
   
    var Status   : Int!
    var Message  : String!
    
    
    
    
    
    
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        Status    <- map["Status"]
        Message   <- map["Message"]
        
    }
    
    
}


