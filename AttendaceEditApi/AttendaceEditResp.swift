//
//  AttendaceEditResp.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 06/04/23.
//

import Foundation
import ObjectMapper


class attendanceEditModal : Mappable{
   
    
    
    var sectionid : String!
    var subjectid : String!
    var userid    : String!
    var  appid : String!
    var  date : String!
    var attendancehour : String!
    
    init(){}
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        sectionid <- map["sectionid"]
        subjectid <- map["subjectid"]
        userid  <- map["userid"]
        appid <- map["appid"]
        date  <- map["date"]
        attendancehour <- map["attendancehour"]
    }
    

    
    
    
}

class attendanceEditResponce : Mappable{
   
    var Status : Int!
    var Message : String!
    var data : [AttendanceEditDataDEtails]!
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        Status <- map["Status"]
        Message <- map["Message"]
        data <- map["data"]
        
    }
    
    
           

}

class AttendanceEditDataDEtails : Mappable{
    
    var memberid : String!
    var attendancetype : String!
    var membername    : String!
    var rollno : String!
    var isSelected : Bool!
    var admissionno : String!
    
    
   
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        memberid <- map["memberid"]
        attendancetype <- map["attendancetype"]
        membername <- map["membername"]
        rollno <- map["rollno"]
        admissionno <- map["admissionno"]
        
        
    }
    
    
    
    
    
    
}
