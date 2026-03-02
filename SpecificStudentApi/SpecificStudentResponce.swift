//
//  SpecificStudentResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 14/03/23.
//

import Foundation
import ObjectMapper



class GetstudentListforappModal : Mappable{

    

    

    var collegeid : String!

    var courseid : String!

    var dept_id : String!

    var yearid : String!

    var sectionid : String!

    
    var staffid : String!

    var subjectid : String!

    

    init(){}

    

    

    

    

    required init?(map: ObjectMapper.Map) {

        mapping(map: map)

    }

    

    func mapping(map: ObjectMapper.Map) {

        

        collegeid <- map["collegeid"]

        courseid <- map["courseid"]

        dept_id <- map["dept_id"]

        yearid <- map["yearid"]

        sectionid <- map["sectionid"]

        staffid <- map["staffid"]
        subjectid <- map["subjectid"]
    }

    

    

    

    

}



class GetstudentListforappResponse : Mappable{

    

    

    

    var Status : Int!

    var Message : String!

    var data : [GetstudentListData]!

    

    

    

    required init?(map: ObjectMapper.Map) {

        mapping(map: map)

    }

    

    func mapping(map: ObjectMapper.Map) {

        

        Status <- map ["Status"]

        Message <- map ["Message"]

        data <- map ["data"]

        

        

    }

    

    

    

}



class GetstudentListData : Mappable{

    var name : String!
    var memberid : String!
    var admissionno : String!
    var regno : String!
    var course : String!
    var year : String!
    var section : String!
    var isSelected : Bool!
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {

        name <- map ["name"]
        memberid <- map ["memberid"]
        admissionno <- map ["admissionno"]
        regno <- map ["regno"]
        course <- map ["course"]
        year <- map ["year"]
        section <- map ["section"]
    }
}

