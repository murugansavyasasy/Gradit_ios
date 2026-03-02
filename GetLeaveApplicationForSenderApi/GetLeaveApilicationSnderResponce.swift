//
//  GetLeaveApilicationSnderResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 21/03/23.
//

import Foundation
import ObjectMapper


class GetLeaveAppLicationSenderModal : Mappable{
    
    var collegeid : String!
    var staffid : String!
    
    
    
    init(){}

    
    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        
        collegeid <- map["collegeid"]
        staffid <- map ["staffid"]
    }
    
    
    
    
    
    
}


class getLeaveTypeForSenderResponce : Mappable{
    
    
    
    var Status : Int!
    var Message : String!
    var data : [getLeaveApplicationDataDetails]!
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status <- map ["Status"]
        Message <- map["Message"]
        data <- map ["data"]
        
        
    }
    
 
}

class getLeaveApplicationDataDetails : Mappable{
    
    
    var studentid : String!
    var studentname : String!
    var coursename : String!
    var departmentname : String!
    var yearname : String!
    var sectionname : String!
    var semestername : String!
    var applicationid : String!
    var leaveapplicationtype : String!
    var leavefromdate : String!
    var leavetodate : String!
    var leavereason : String!
    var leavestatus : String!
    var leavestatusid : String!
    var numofdays : String!
    var createdon : String!
   
    
    
    
    
   
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
       
        studentid <- map["studentid"]
        studentname <- map["studentname"]
        coursename <- map["coursename"]
        departmentname <- map["departmentname"]
        yearname <- map["yearname"]
        sectionname <- map["sectionname"]
        semestername <- map["semestername"]
        applicationid <- map["applicationid"]
        leaveapplicationtype <- map["leaveapplicationtype"]
        leavefromdate <- map["leavefromdate"]
        leavetodate <- map["leavetodate"]
        leavereason <- map["leavereason"]
        leavestatus <- map["leavestatus"]
        leavestatusid <- map["leavestatusid"]
        numofdays <- map["numofdays"]
        createdon <- map["createdon"]
        
    }
    
    
    
    
    
}
