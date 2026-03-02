//
//  SendTxtParticularNoticeApi.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 17/03/23.
//

import Foundation
import ObjectMapper

class NoticeBoardPartiModal : Mappable{
    
   
    
    var noticeboardid : String!
    
    var colgid : String!
    
    var receiveridlist : String!
    
    var receivertype : String!
    
    var topic : String!
    
    var description : String!
    
    var staffid : String!
    
    var callertype : String!
    
    var processtype : String!
    
    var isstudent : Bool!
    
    var isparent : Bool!
    
    var isstaff : Bool!
    var subjectid : String!
    var files : [FiletypeDataDetails]!
    init(){}
    
    
    
   
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
       
        colgid <- map["colgid"]
        receiveridlist <- map["receiveridlist"]
        receivertype <- map ["receivertype"]
       staffid <- map["staffid"]

        
        processtype <- map["processtype"]
        
        isstudent <- map ["isstudent"]
        
        isparent <- map ["isparent"]
        
        isstaff <- map["isstaff"]
        
        subjectid <- map["subjectid"]
        callertype <- map ["Callertype"]
        
        noticeboardid <- map["noticeboardid"]
        
        topic <- map ["topic"]
        description <- map["description"]
        files   <- map["files"]
    }
    

    
    
    
}


class FiletypeDataDetails : Mappable{
    
    var filepath : String!
    var filetype : String!
    init(){}
    required init?(map: ObjectMapper.Map) {
        
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        filepath  <- map["filepath"]
        filetype  <- map ["filetype"]
    }
    
    
    
    
    
}
class NoticePArticularResponce : Mappable{
    
    var Status : Int!
    
    var Message : String!
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status <- map["Status"]
        Message <- map["Message"]
        
    }
    
 
}


