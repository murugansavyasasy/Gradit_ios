//
//  AttendanceMarkingResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 04/04/23.
//

import Foundation
import ObjectMapper



class attendanceMarkigModal : Mappable{
    
    var collegeid  : String!
    var sectionid : String!
    var subjectid : String!
    var userid : String!
    var date : String!
    var processtype : String!
    var attendance_hours : String!
    var type  :           String!
    var title     : String!
    var presentlist : [presentListDataDetails]!
    var absentlist : [absentlistdataDetails]!
    var odlist : [onDutylistdataDetails]!
    var leavelist : [onLeavelistdataDetails]!
   
    init(){}
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        sectionid <- map["sectionid"]
        subjectid <- map["subjectid"]
        userid <- map["userid"]
        date <- map["date"]
        processtype <- map["processtype"]
        presentlist <- map["presentlist"]
        absentlist <- map["absentlist"]
        odlist <- map["odlist"]
        leavelist <- map["leavelist"]
        attendance_hours <- map["attendance_hours"]
        collegeid <- map["collegeid"]
        type <- map["type"]
        title <- map["title"]
        
        
    }
}


class presentListDataDetails : Mappable{
    
    
    var  presentmemberid : String!
//    var absentlist : [absentlistdataDetails]!
    
    init(){}
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        presentmemberid <- map["presentmemberid"]
    }
}



class absentlistdataDetails : Mappable{
    
    var absentmemberid : String!
    
    
    init(){}
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        absentmemberid <- map["absentmemberid"]
    }
}

class onDutylistdataDetails : Mappable{
    
    var odmemberid : String!
    
    init(){}
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        odmemberid <- map["odmemberid"]
    }
}

class onLeavelistdataDetails : Mappable{
    
    var leavememberid : String!
    
    init(){}
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        leavememberid <- map["leavememberid"]
    }
}

class MarkAttendanceResponce : Mappable{
    
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
