//
//  SenderAssigmentPastResponce.swift
//  GraditSenderAssigment
//
//  Created by MACBOOKPRO on 30/11/22.
//

import Foundation

struct senderUpcommingModal : Codable{
    
    var userid              : String?
    var collegeid           : String?
    var departmentid        : String?
    var sectionid           : String?
    var appid               : String?
    var priority            : String?
    var type                : String?
    
}


struct senderUpcommingResponces : Codable{
    
    var Status : Int?
    var Message : String?
    var data    : [upcommingdataDetails]?
    
}

struct upcommingdataDetails : Codable{
    
    var assignmentid : String?
    var subjectname  : String?
    var topic        : String?
    var description  : String?
    var submissiondate : String?
    var createdon      : String?
    var sentbyname     : String?
    var createdby      : String?
    var assignmenttype : String?
    var totalcount     : String?
    var submittedcount  : String?
    var file_path       : String?
    var newfilepath     : [String]?
    var userfilename    : String?
    var assignmentdetailid : String?
    var isappread          : String?
    var newuserfilename   : [String]?
}

