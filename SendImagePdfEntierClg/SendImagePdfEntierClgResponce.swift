//
//  SendImagePdfEntierClgResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 19/03/23.
//

import Foundation
import ObjectMapper

class SendImagePdfModal : Mappable{
    
    
    var collegeid :  String!
    var Staffid  : String!
    var callertype : String!
    var filetype  : String!
    var fileduration  : String!
    var isstudent  : Bool!
    var isparent : Bool!
    var isstaff  : Bool!
    
    var title : String!
    
    var Description : String!
    
    var FileNameArray : [FileNameImage]!
    
    
    init(){}
    
    required init?(map: ObjectMapper.Map) {
       mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        collegeid <- map["collegeid"]
        Staffid <- map["Staffid"]
        callertype  <- map["callertype"]
        filetype <- map["filetype"]
        fileduration <- map["fileduration"]
        isstudent <- map["isstudent"]
        isparent <- map["isparent"]
        isstaff <- map["isstaff"]
        title <- map["title"]
        Description <- map["Description"]
        
        FileNameArray <- map["FileNameArray"]
        
    }
    
    
    
    
    
    
    
    
    
}




class FileNameImage : Mappable{
    
    var FileName : String!
    
    
    init(){}
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        FileName <- map ["FileName"]
    }
    
    
    
    
    
    
    
    
    
    
}



class SendImagePdfResponce : Mappable{
    
    
    
    var Status : Int!
    var Message : String!
    var data : [sendImagePdfDataDetails]!
    
    
    
   
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status <- map ["Status"]
        Message <- map["Message"]
        data <- map ["data"]
        
        
    }
    
    
    
    
    
    
    
}



class sendImagePdfDataDetails : Mappable{
    
    
    var ivrheader : String!
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        ivrheader <- map["ivrheader"]
        
    }
    
    
    
    
    
    
    
}
