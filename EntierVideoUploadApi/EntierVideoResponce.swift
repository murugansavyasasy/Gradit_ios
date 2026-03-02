//
//  EntierVideoResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 12/04/23.
//

import Foundation
import ObjectMapper

class EntierVideoUpload: Mappable {

    var collegeid: String!
    var staffid: String!
    var callertype: String!
    var title: String!
    var description: String!
    var iframe: String!
    var url: String!
    var isstudent: Bool!
    var isparent: Bool!
    var isstaff: Bool!
    var FileName : String!
   
 

    init(){}
    required init?(map: Map){
        
        mapping(map: map)
    }

    func mapping(map: Map) {
        collegeid <- map["collegeid"]
        staffid <- map["staffid"]
        callertype <- map["callertype"]
        title <- map["title"]
        description <- map["description"]
        iframe <- map["iframe"]
        url <- map["url"]
        isstudent <- map["isstudent"]
        isparent <- map["isparent"]
        isstaff <- map["isstaff"]
        FileName <- map["FileName"]
       
        
        
    }
}


class EntierVideoUploadResponce: Mappable {

    var status: Int!
    var message: String!
    var data: [EntierVideoUploadDataDetails]!

    required init?(map: Map){
        mapping(map: map)
    }

    func mapping(map: Map) {
        status <- map["Status"]
        message <- map["Message"]
        data <- map["data"]
    }
}

class EntierVideoUploadDataDetails: Mappable {

    var ivrheader: String!

    required init?(map: Map){
    mapping(map: map)
    }

    func mapping(map: Map) {
        ivrheader <- map["ivrheader"]
    }
}
