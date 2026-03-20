//
//  SpecificStudentResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on ?4/03/23.
//

import Foundation
import ObjectMapper



struct GetstudentListforappModal : Codable{

    var collegeid : String?
    var courseid : String?
    var dept_id : String?
    var yearid : String?
    var sectionid : String?
    var staffid : String?
    var subjectid : String?
}

struct GetstudentListforappResponse : Codable{

    var Status : Int?
    var Message : String?
    var data : [GetstudentListData]?
}

struct GetstudentListData : Codable{

    var name : String?
    var memberid : String?
    var admissionno : String?
    var regno : String?
    var course : String?
    var year : String?
    var section : String?
    var isSelected : Bool?
}

