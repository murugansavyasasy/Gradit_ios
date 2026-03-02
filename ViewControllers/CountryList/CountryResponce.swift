

import Foundation
import ObjectMapper




class CountryListResponse : Mappable {
    
    

    
    var Status                : Int!
    var Message               : String!
    var data : [dataDetails]!
    
    
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        
        
        Status                   <- map["Status"]
        Message                  <- map["Message"]
        data                     <- map["data"]
       
        
    }
    
    
    

    
}


class dataDetails : Mappable{
    
    
    
    var countryid              : Int!
    var country                : String!
    var mobilenumberlen        : String!
    var baseurls               : String!
    var codecountry            : String!
    var idapplication          : Int!
    var isSelected             : Bool!
    
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
      
        countryid                    <- map["countryid"]
        country                      <- map["country"]
        mobilenumberlen              <- map["mobilenumberlen"]
        baseurls                     <- map["baseurls"]
        codecountry                  <- map["codecountry"]
        idapplication                <- map["idapplication"]
      
        
        
        
        
        
        
        
    }
    
}
 

