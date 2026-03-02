//
//  ExamCreation.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 22/06/23.
//

import Foundation


class exameMainDetail{
    
    
    var collegeid: String!
    var examid: String!
    var examname: String!
    var staffid: String!
    var startdate: String!
    var enddate: String!
    var processtype: String!
    var sectiondetails: [SectiondetailRef]!
    
    
}

class SectiondetailRef {
    
    
    
    
//    var clgdepartmentid: String!
    var clgsectionid: String!
    var subjectdetails: [SubjectDetailsRef]!
    
    
    
    
}


class SubjectDetailsRef {
    
    
    var examsubjectid: String!
    var examdate: String!
    var examsyllabus: String!
    var examvenue: String!
    var examsession: String!
    
    
    
    
}
