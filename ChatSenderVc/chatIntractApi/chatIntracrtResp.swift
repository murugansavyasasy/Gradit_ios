//
//  chatIntracrtResp.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 17/04/23.
//

import Foundation
import ObjectMapper

struct ChatSenderInteractModal : Codable{
    
    var offset : String?
    var limit : String?
    var staff_id : String?
    var section_id : String?
    var subject_id : String?
    var is_classteacher : String?
    
}

struct ChatSenderInteractResponse : Codable{
    var offset : String?
    var limit : String?
    var count : String?
    var result : String?
    var resultmessage : String?
    var data : [ChatSenderInteractData]?
    
}

struct ChatSenderInteractData : Codable{
    
    var studentid : String?
    var studentname : String?
    var questionid : String?
    var  question : String?
    var replytype : String?
    var createdon : String?
    var answer : String?
    var  answeredon : String?
    var changeanswer : String?
    var is_student_blocked : String?
    
}



