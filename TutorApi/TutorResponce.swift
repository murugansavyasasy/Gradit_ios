//
//  TutorResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 14/03/23.
//

import Foundation
import ObjectMapper

struct TutorModal : Codable {
    
    var collegeid : String?
    var staffid : String?
}

struct TutorResponce : Codable{
    
    var Status : Int?
    var Message : String?
    var data : [TutorDataDetails]?
}

struct TutorDataDetails : Codable{
    
    var courseid : String?
    var coursename : String?
    var departmentid : String?
    var departmentname : String?
    var yearid : String?
    var yearname : String?
    var sectionid : String?
    var sectionname : String?
    var semesterid : String?
    var semestername : String?
    var subjectid : String?
    var subjectname : String?
    var subjecttype : String?
    var isSelected : Bool?
}

