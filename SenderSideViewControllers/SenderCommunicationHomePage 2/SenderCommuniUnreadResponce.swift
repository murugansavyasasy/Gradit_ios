//
//  SenderCommuniUnreadResponce.swift
//  GraditSenderCommunicationMenu
//
//  Created by MACBOOKPRO on 07/12/22.
//

//
//  SenderCommuniReadResponce.swift
//  GraditSenderCommunicationMenu
//
//  Created by MACBOOKPRO on 07/12/22.
//



import Foundation
import ObjectMapper

class SenderCommuniUnReadModal : Mappable{
   
    var userid       :  String!
    var priority     :  String!
    var readtype     :  String!
    var appid        :  String!
    
    
    init(){}
    
    
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        userid        <- map["userid"]
        priority      <- map["priority"]
        readtype      <- map["readtype"]
        appid         <- map["appid"]
        
        
        
        
        
        
        
    }
    
    
    
}


class SenderCommuniUnReadResponce : Mappable{
    
    var Status         :    Int!
    var Message        :    String!
    var data           : [SenderCommuniUnReadDataDetails]!
    
    
    
    
    
    
    
    
    
    
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        Status   <- map["Status"]
        Message  <- map["Message"]
        data     <- map["data"]
        
        
        
        
        
    }
    
    
}


class SenderCommuniUnReadDataDetails : Mappable{
   
    var     typename              :      String!
    var      sentby               :      String!
    var      headerid             :      String!
    var      msgdetailsid         :      String!
    var      timing               :      String!
    var     duration              :      String!
    var     msgcontent            :      String!
    var     description           :      String!
    var     isappread             :      String!
    var     isemergency           :      String!
    var     voicefile             :      String!
    
    
               
                
                
           
               
    
    init(){}
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        typename                  <- map  ["typename"]
        sentby                    <- map  ["sentby"]
        headerid                  <- map  ["headerid"]
        msgdetailsid              <- map  ["msgdetailsid"]
        timing                    <- map  ["timing"]
        duration                  <- map  ["duration"]
        msgcontent                <- map  ["msgcontent"]
        description               <- map  ["description"]
        isappread                 <- map  ["isappread"]
        isemergency               <- map  ["isemergency"]
        voicefile                 <- map  ["voicefile"]
      
    }
    
    
    
}




