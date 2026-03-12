//
//  SenderNoticeBoardCollegeResponce.swift
//  SenderGraditNoticeBoard
//
//  Created by MACBOOKPRO on 06/12/22.
//


import Foundation

struct SenderNoticeBoardCollegeModal : Codable{

    var   userid                            : String?
    var   appid                             : String?
    var   priority                          : String?
    var   type                              : String?
  
}


struct SenderNoticeBoardCollegeResponce : Codable{

    var   Status    : Int?
    var   Message   : String?
    var   data      : [SenderNoticeBoardCollegeDataDetails]?
    
}


struct SenderNoticeBoardCollegeDataDetails : Codable{
    
    var noticeheaderid  : String?
    var noticedetailsid : String?
    var topic           : String?
    var description     : String?
    var createdondate   : String?
    var createdontime   : String?
    var sentbyname      : String?
    var createdby       : String?
    var isappread       : String?
    var filearray : [ImagefileArrydataDetails]?
   
}

struct ImagefileArrydataDetails : Codable{

    var filepath : String?
    var filetype : String?
  
}
