//
//  chatBlockResp.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 17/04/23.
//

import Foundation

struct ChatBlockModal : Codable{
    var student_id : String?
    var staff_id : String?
    var college_id : String?
}

struct ChatBlocResponse : Codable{
    var Status : Int?
    var Message : String?
    var data : [ChatBlockData]?
}

struct ChatBlockData : Codable{
    var idstudent : String?
    var idstaff : String?
}

