
//  ChatReceiverInteractModal.swift
//  Vs_GradItCollege
//
//  Created by Apple on 03/04/23.
//

import Foundation
import ObjectMapper


struct ChatReceiverInteractModal : Codable{
    
    var offset : String?
    var student_id : String?
    var staff_id : String?
    var section_id : String?
    var subject_id : String?
    var is_classteacher : String?
    var limit  : String?
}

struct ChatReceiverInteractResponse : Codable{
    var Status : Int?
    var Message : String?
    var data : [ChatReceiverInteractData]?
    
}


struct ChatReceiverInteractData : Codable{
    var offset : String?
    var limit : String?
    var count : String?
    var  List : [StaffChatList]?
    
}


struct StaffChatList : Codable{
    
    var studentid : String?
    var studentname : String?
    var questionid : String?
    var  question : String?
    var createdon : String?
    var answer : String?
    var answeredon : String?
    var  myquestion : String?
    
}
