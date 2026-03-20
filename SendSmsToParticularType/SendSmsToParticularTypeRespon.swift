//
//  SendSmsToParticularTypeRespon.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 16/03/23.
//

import Foundation
import ObjectMapper

struct SendSmsToParticularModal : Codable{
    
    var collegeid : String?
    var staffid : String?
    var callertype : String?
    var messagecontent : String?
    var description  : String?
    var receiverid : String?
    var receivertype : String?
    var isstudent : Bool?
    var isparent : Bool?
    var isstaff : Bool?
    var filetype : String?
    var subjectid : String?
}


struct senderParticularResponce : Codable{
   
   var Status : Int?
   var Message : String?
   var data : [SmsdataDetails]?
}

struct SmsdataDetails : Codable{
    
    var ivrheader : String?
}
