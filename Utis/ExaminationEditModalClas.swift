//
//  ExaminationEditModalClas.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 19/07/23.
//

import Foundation


class exameEditMainDetail{
    
    
    var collegeid: String!
    var examid: String!
   
    var staffid: String!
    var  userid : String!
    var processtype: String!
    var sectionid: String!
    
    var subjectdetails: [EditSubjectDetailsRef]!
    

    
    
}



class EditSubjectDetailsRef {
    
    
    var examsubjectid: String!
    var examdate: String!
    var examsyllabus: String!
    var examvenue: String!
    var examsession: String!
    
    
    
    
}
