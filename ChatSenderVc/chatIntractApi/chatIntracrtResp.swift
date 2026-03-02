//
//  chatIntracrtResp.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 17/04/23.
//

import Foundation

import ObjectMapper







class ChatSenderInteractModal : Mappable{

    

   

   

    

    var offset : String!

    var limit : String!

    var staff_id : String!

    var section_id : String!

    var subject_id : String!

    var is_classteacher : String!

   

   

    init(){}

    

    

    

    required init?(map: ObjectMapper.Map) {

        

        mapping(map: map)

    }

    

    func mapping(map: ObjectMapper.Map) {

        

        offset <- map["offset"]

        limit <- map["limit"]

        staff_id <- map ["staff_id"]

        section_id <- map ["section_id"]

        subject_id <- map["subject_id"]

        is_classteacher <- map["is_classteacher"]

        

        

        

        

        

    }

    

  

    

}











class ChatSenderInteractResponse : Mappable{

   

    

                   

    var offset : String!

    

    var limit : String!

    

    var count : String!

    

    

        var result : String!

        

        var resultmessage : String!

        

        var data : [ChatSenderInteractData]!

        

        

        

    

    

    required init?(map: ObjectMapper.Map) {

        mapping(map: map)

    }

    

    func mapping(map: ObjectMapper.Map) {

        

        offset <- map ["offset"]

        limit <- map["limit"]

        count <- map["count"]

        result <- map ["result"]

        resultmessage <- map["resultmessage"]

        data <- map["data"]

    }

    

    

    

    

    

    

    

}





class ChatSenderInteractData : Mappable{

   

            

   

    var studentid : String!

    var studentname : String!

    var questionid : String!

    var  question : String!

    

    var replytype : String!

    var createdon : String!

    var answer : String!

    var  answeredon : String!

    

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



