//
//  NoticeBoardResponce.swift
//  GraditNoticeBoard
//
//  Created by MACBOOKPRO on 26/10/22.
//

import Foundation
import ObjectMapper

struct departmentModal : Codable{
    
    
    var   userid                            : String?
    var   appid                             : String?
    var   priority                          : String?
    var   type                              : String?
}


struct departmentResponce : Codable{
    
    var   Status    : Int?
    var   Message   : String?
    var   data      : [departmentDataDetails]?
}


struct departmentDataDetails : Codable{
    
    var noticeheaderid  : String?
    var noticedetailsid : String?
    var topic           : String?
    var description     : String?
    var createdondate   : String?
    var createdontime   : String?
    var sentbyname      : String?
    var createdby       : String?
    var isappread       : String?
    var filearray        : [NoticeDataDeailss]?
}

struct NoticeDataDeailss : Codable{
    
    var filepath : String?
    var filetype : String?
    
}
