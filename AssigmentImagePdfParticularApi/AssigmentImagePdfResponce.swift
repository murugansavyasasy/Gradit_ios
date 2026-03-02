//
//  AssigmentImagePdfResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 29/03/23.
//

import Foundation
import ObjectMapper

class assigmentImagePdfModal : Mappable{
    
    
    
    var collegeid: String!
        var deptid: String!
        var courseid: String!
        var yearid: String!
        var staffid: String!
        var callertype: String!
        var sectionid: String!
        var subjectid: String!
        var assignmenttopic: String!
        var assignmentdescription: String!
        var submissiondate: String!
        var processtype: String!
        var assignmentid: String!
        var assignmenttype: String!
        var receivertype: String!
        var receiverid: String!
    
        var fileNameArray: [FileNameArray]!
    
    init(){}
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        collegeid <- map["collegeid"]
                deptid <- map["deptid"]
                courseid <- map["courseid"]
                yearid <- map["yearid"]
                staffid <- map["staffid"]
                callertype <- map["callertype"]
                sectionid <- map["sectionid"]
                subjectid <- map["subjectid"]
                assignmenttopic <- map["assignmenttopic"]
                assignmentdescription <- map["assignmentdescription"]
                submissiondate <- map["submissiondate"]
                processtype <- map["processtype"]
                assignmentid <- map["assignmentid"]
                assignmenttype <- map["assignmenttype"]
                receivertype <- map["receivertype"]
                receiverid <- map["receiverid"]
                fileNameArray <- map["FileNameArray"]
    }
    
    
}

class FileNameArray: Mappable {

    var fileName: String!

    init(){}
    
    required init?(map: Map){
    }

    func mapping(map: Map) {
        fileName <- map["FileName"]
    }
    
}


class assigmentImagePdfResponce : Mappable{
    
    
    var Status : Int!
    var Message : String!
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status <- map["Status"]
        Message <- map["Message"]
    }
    
    
    
    
    
}


