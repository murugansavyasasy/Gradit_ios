//
//  chatSenderIntractApiResp.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 17/04/23.
//

import Foundation


struct AnswerStudentQuestionForAppModal : Codable{

    var question_id : String?
    var answer : String?
    var is_changeanswer : String?
    var reply_type : String?
    var staff_id : String?

}

struct AnswerStudentQuestionForAppResponse : Codable{
    var Status : Int?
    var Message : String?
    var data : [AnswerStudentQuestionForAppData]?

}

struct AnswerStudentQuestionForAppData : Codable{
    var studentid : String?
    var studentname : String?
    var question : String?
    var questionid : String?
    var replytype : String?
    var createdon : String?
    var answer : String?
    var answeredon : String?
    var changeanswer : String?
    var is_student_blocked : String?
    
}
