

import Foundation
import ObjectMapper


class forgetModal : Mappable {
    
    var mobilenumber             : String!
    
    init(){}
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        mobilenumber            <- map["mobilenumber"]
        
        
    }
    
    
    
    
    
    
}


class forgetResponce : Mappable{
    
    var Status                 : Int!
    var Message                : String!
    var data                   : [dataForgetDetails]!
   
    
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        Status                  <- map["Status"]
        Message                 <- map["Message"]
        data                    <- map["data"]
        
       
    }
    
    
    
    
    
    
}

class dataForgetDetails : Mappable{
    
    
    var ivrnumbers                 : [String] = []
    
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        ivrnumbers                 <- map["ivrnumbers"]
        
        
        
    }
    
  



}






