//
//  SenderNoticeBoardCollegeResponce.swift
//  SenderGraditNoticeBoard
//
//  Created by MACBOOKPRO on 06/12/22.
//


import Foundation
import ObjectMapper

class SenderNoticeBoardCollegeModal : Mappable{
    
    
    var   userid                            : String!
    var   appid                             : String!
    var   priority                          : String!
    var   type                              : String!
    
    
    
    
    init(){}
    
    
    
    required init?(map: Map) {
        
        mapping(map: map)
        
    }
    
    func mapping(map: Map) {
        
        userid                          <- map["userid"]
        appid                           <- map["appid"]
        priority                        <- map["priority"]
        type                            <- map["type"]
        
        
        
        
        
        
    }
    
    
    
  
    
}


class SenderNoticeBoardCollegeResponce : Mappable{
    
    
    
    var   Status    : Int!
    var   Message   : String!
    var   data      : [SenderNoticeBoardCollegeDataDetails]!
    
    
    
    
    
    required init?(map: Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        Status    <- map["Status"]
        Message   <- map["Message"]
        data      <- map["data"]
        
        
    }
    
    
    
    
    
    
    
    
    
    
}


class SenderNoticeBoardCollegeDataDetails : Mappable{
    
    var noticeheaderid  : String!
    var noticedetailsid : String!
    var topic           : String!
    var description     : String!
    var createdondate   : String!
    var createdontime   : String!
    var sentbyname      : String!
    var createdby       : String!
    var isappread       : String!
    var filearray : [ImagefileArrydataDetails]!
    
    init(){}
    
    required init?(map: Map) {
        
        mapping(map: map)
        
    }
    
    func mapping(map: Map) {
        
        noticeheaderid   <- map["noticeheaderid"]
        noticedetailsid  <- map["noticedetailsid"]
        topic            <- map["topic"]
        description      <- map["description"]
        createdondate    <- map["createdondate"]
        createdontime    <- map["createdontime"]
        sentbyname       <- map["sentbyname"]
        createdby        <- map["createdby"]
        isappread        <- map["isappread"]
        filearray        <- map["filearray"]
    }
    
    
    
    
    
    
}

class ImagefileArrydataDetails : Mappable{
    
    
    var filepath : String!
    var filetype : String!
    
    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        filepath <- map["filepath"]
        filetype <- map["filetype"]
    }
}
