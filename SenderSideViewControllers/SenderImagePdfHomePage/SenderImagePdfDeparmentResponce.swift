//
//  SenderImagePdfDeparmentResponce.swift
//  GraditImagePdf
//
//  Created by MACBOOKPRO on 07/12/22.
//


import Foundation
import ObjectMapper

class SenderDeparmentImageModal:Mappable{
    
    
    
    
    var  userid  : String!
    var  appid   : String!
    var  priority : String!
    var  type     : String!
    
    
    
    init(){}
    
   
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        userid   <- map["userid"]
        appid    <- map["appid"]
        priority <- map["priority"]
        type     <- map["type"]
        
        
        
        
        
    }

}

class SenderDepartmentImageResponce : Mappable{
    
    
    var Status : Int!
    var Message : String!
    var data   : [SenderDepartmentImageDataDetails]!
    
   
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status  <- map["Status"]
        Message <- map["Message"]
        data    <- map["data"]
        
        
    }
 
}

class SenderDepartmentImageDataDetails : Mappable{
    
    var headerid  : String!
    var detailsid : String!
    var title     : String!
    var description : String!
    var file_path   : String!
    var createdondate : String!
    var createdontime : String!
    var sentbyname    : String!
    var filetype      : String!
    var userfilename  : String!
    var newfilepath   : [String] = []
    var isappread : String!
    var newuserfilename : [String] = []
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        headerid <- map["headerid"]
        detailsid <- map["detailsid"]
        title    <- map["title"]
        description <- map["description"]
        file_path   <- map["file_path"]
        createdondate <- map["createdondate"]
        createdontime <- map["createdontime"]
        sentbyname    <- map["sentbyname"]
        filetype      <- map["filetype"]
        userfilename  <- map["userfilename"]
        newfilepath <- map["newfilepath"]
        isappread <- map["isappread"]
        newuserfilename <- map["newuserfilename"]
    }
    
  
    
    
}





