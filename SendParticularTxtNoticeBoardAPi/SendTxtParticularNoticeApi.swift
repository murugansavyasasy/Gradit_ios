//
//  SendTxtParticularNoticeApi.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 17/03/23.
//

import Foundation
import ObjectMapper

struct NoticeBoardPartiModal : Codable{
    
    var noticeboardid : String?
    var colgid : String?
    var receiveridlist : String?
    var receivertype : String?
    var topic : String?
    var description : String?
    var staffid : String?
    var callertype : String?
    var processtype : String?
    var isstudent : Bool?
    var isparent : Bool?
    var isstaff : Bool?
    var subjectid : String?
    var files : [FiletypeDataDetails]?
}


struct FiletypeDataDetails : Codable{
    
    var filepath : String?
    var filetype : String?
}

struct NoticePArticularResponce : Codable{
    var Status : Int?
    var Message : String?
}


