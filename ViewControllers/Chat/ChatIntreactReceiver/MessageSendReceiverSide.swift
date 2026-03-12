//
//  MessageSendReceiverSide.swift
//  Vs_GradItCollege
//
//  Created by Apple on 03/04/23.
//

import Foundation
import ObjectMapper

struct MessageSendReceiverSideModal : Codable{
    var offset : String?
    var student_id : String?
    var staff_id : String?
    var section_id : String?
    var subject_id : String?
    var is_classteacher : String?
    var college_id : String?
    var question : String?
}

struct MessageSendResponse : Codable{
    var Status : Int?
    var Message : String?
    var data : [MessageData]?
}
struct MessageData : Codable{
    var studentid : String?
    var studentname : String?
    var questionid : String?
    var  question : String?
    var createdon : String?
    var answer : String?
    var answeredon : String?
    var  myquestion : String?
}
