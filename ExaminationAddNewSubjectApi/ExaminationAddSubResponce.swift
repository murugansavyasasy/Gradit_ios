//
//  ExaminationAddSubResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 27/03/23.
//

import Foundation
import ObjectMapper

class Main: Mappable {

    var collegeid: String!
    var examid: String!
    var examname: String!
    var staffid: String!
    var startdate: String!
    var enddate: String!
    var processtype: String!
    var sectiondetails: [Sectiondetails]!

    init(){}
    required init?(map: Map){
        mapping(map: map)
    }

    func mapping(map: Map) {
        collegeid <- map["collegeid"]
        examid <- map["examid"]
        examname <- map["examname"]
        staffid <- map["staffid"]
        startdate <- map["startdate"]
        enddate <- map["enddate"]
        processtype <- map["processtype"]
        sectiondetails <- map["sectiondetails"]
    }
    
    
    
    
    
}

class Sectiondetails: Mappable {

    var clgdepartmentid: String!
    var clgsectionid: String!
    var subjectdetails: [Subjectdetails]!

    init(){}
    required init?(map: Map){
        
        mapping(map: map)
    }

    func mapping(map: Map) {
        clgdepartmentid <- map["clgdepartmentid"]
        clgsectionid <- map["clgsectionid"]
        subjectdetails <- map["Subjectdetails"]
    }
}

class Subjectdetails: Mappable {

    
    
    
    
    var examsubjectid: String!
    var examdate: String!
    var examsyllabus: String!
    var examvenue: String!
    var examsession: String!

    
    init(){}
    required init?(map: Map){
        
        mapping(map: map)
    }

    func mapping(map: Map) {
        examsubjectid <- map["examsubjectid"]
        examdate <- map["examdate"]
        examsyllabus <- map["examsyllabus"]
        examvenue <- map["examvenue"]
        examsession <- map["examsession"]
    }
}



class ExaminationAddResponce : Mappable{
    
    
    var status: Int!
        var message: String!
        var data: [Datass]!

        required init?(map: Map){
            mapping(map: map)
        }

        func mapping(map: Map) {
            status <- map["Status"]
            message <- map["Message"]
            data <- map["data"]
        }
}

class Datass: Mappable {

    var ivrheader: String!

    required init?(map: Map){
        mapping(map: map)
    }

    func mapping(map: Map) {
        ivrheader <- map["ivrheader"]
    }
}
