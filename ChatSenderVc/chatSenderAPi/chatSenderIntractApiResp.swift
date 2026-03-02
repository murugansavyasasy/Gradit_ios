//
//  chatSenderIntractApiResp.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 17/04/23.
//

import Foundation
import Foundation

import ObjectMapper







class AnswerStudentQuestionForAppModal : Mappable{

   

  

    

    var question_id : String!

    var answer : String!

    var is_changeanswer : String!

    var reply_type : String!

    var staff_id : String!







   

    init(){}

    

    

    

    required init?(map: ObjectMapper.Map) {

        

        mapping(map: map)

    }

    

    func mapping(map: ObjectMapper.Map) {

        

    question_id <- map["question_id"]

    answer <- map["answer"]

    is_changeanswer <- map ["is_changeanswer"]

    reply_type <- map["reply_type"]

    staff_id <- map["staff_id"]

       

    }

    

  

    

}











class AnswerStudentQuestionForAppResponse : Mappable{

   

   

               

            

                   

    var Status : Int!

    var Message : String!

    var data : [AnswerStudentQuestionForAppData]!

        

        

        

    

    

    required init?(map: ObjectMapper.Map) {

        mapping(map: map)

    }

    

    func mapping(map: ObjectMapper.Map) {

        

        Status <- map ["Status"]

        Message <- map["Message"]

        data <- map["data"]

    }

    

    

    

    

    

    

    

}





class AnswerStudentQuestionForAppData : Mappable{

   

  



    

    var studentid : String!

    var studentname : String!

var question : String!

var questionid : String!

var replytype : String!

var createdon : String!

var answer : String!

var answeredon : String!

var changeanswer : String!

var is_student_blocked : String!



    

    

    

   

    required init?(map: ObjectMapper.Map) {

        mapping(map: map)

    }

    

    func mapping(map: ObjectMapper.Map) {

        

        

    

    studentid <- map ["studentid"]

    studentname <- map ["studentname"]

    questionid <- map ["questionid"]

    question <- map ["question"]

    replytype <- map ["replytype"]

    createdon <- map ["createdon"]

    answer <- map ["answer"]

    answeredon <- map ["answeredon"]

    changeanswer <- map ["changeanswer"]

    is_student_blocked <- map ["is_student_blocked"]

       

    

        

        

    }

    

    

    

    

    

}
