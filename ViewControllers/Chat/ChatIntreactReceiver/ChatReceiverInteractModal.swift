
//  ChatReceiverInteractModal.swift
//  Vs_GradItCollege
//
//  Created by Apple on 03/04/23.
//

import Foundation
import ObjectMapper


class ChatReceiverInteractModal : Mappable{
    
   
    
    
    var offset : String!
    var student_id : String!
    var staff_id : String!
    var section_id : String!
    var subject_id : String!
    var is_classteacher : String!
    var limit  : String!
   
    init(){}
    
    
    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        offset <- map["offset"]
        student_id <- map["student_id"]
        staff_id <- map ["staff_id"]
        section_id <- map ["section_id"]
        subject_id <- map["subject_id"]
        is_classteacher <- map["is_classteacher"]
        limit  <- map["limit"]
        
        
        
        
    }
    
  
    
}





class ChatReceiverInteractResponse : Mappable{
   
              
                   
    var Status : Int!
    
    var Message : String!
    
    var data : [ChatReceiverInteractData]!
    
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status <- map ["Status"]
        Message <- map["Message"]
        data <- map["data"]
    }
    
    
    
    
    
    
    
}


class ChatReceiverInteractData : Mappable{
   
            
    var offset : String!
    var limit : String!
    var count : String!
    var  List : [StaffChatList]!
    
    
    
   
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        offset <- map ["offset"]
        limit <- map ["limit"]
        count <- map ["count"]
        List <- map ["List"]
        
        
    }
    
    
    
    
    
}


class StaffChatList : Mappable{

         
 var studentid : String!
 var studentname : String!
 var questionid : String!
 var  question : String!
 var createdon : String!
 var answer : String!
 var answeredon : String!
 var  myquestion : String!
              
              
 

 required init?(map: ObjectMapper.Map) {
     mapping(map: map)
 }
 
 func mapping(map: ObjectMapper.Map) {
     
        studentid <- map ["studentid"]
        studentname <- map ["studentname"]
        questionid <- map ["questionid"]
        question <- map ["question"]
        createdon <- map ["createdon"]
        answeredon <- map ["answeredon"]
        answer <- map ["answer"]
        myquestion <- map ["myquestion"]
     
     
 }
 
 
 
 
 
}
