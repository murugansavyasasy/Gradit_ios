//
//  SenderNoticeBoardDepartmentResponce.swift
//  SenderGraditNoticeBoard
//
//  Created by MACBOOKPRO on 06/12/22.
//

import Foundation

struct SenderNoticeBoardDepartmentModal : Codable{
    
    
    var   userid                            : String?
    var   appid                             : String?
    var   priority                          : String?
    var   type                              : String?
    
}


struct SenderNoticeBoardDepartmentResponce : Codable{

    var   Status    : Int?
    var   Message   : String?
    var   data      : [SenderNoticeBoardDepartmentDataDetails]?
    
  
}


struct SenderNoticeBoardDepartmentDataDetails : Codable{
    
    var noticeheaderid  : String?
    var noticedetailsid : String?
    var topic           : String?
    var description     : String?
    var createdondate   : String?
    var createdontime   : String?
    var sentbyname      : String?
    var createdby       : String?
    var isappread       : String?
    var filearray : [ImagefileArryDetails]?
    
}

struct ImagefileArryDetails : Codable{
    
    var filepath : String?
    var filetype : String?
  
}

