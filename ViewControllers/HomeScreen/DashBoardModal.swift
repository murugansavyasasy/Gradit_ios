//
//  DashBoardModal.swift
//  Vs_GradIt
//
//  Created by APPLE on 26/09/22.
//

import Foundation
import ObjectMapper




class DashBoardModal : Mappable  {
    
    var collegeid                   : String!
    var userid                      : String!
    var priority                    : String!
    
   
    
    init(){}

    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        
        
    collegeid                       <- map ["collegeid"]
    userid                          <- map ["userid"]
    priority                        <- map ["priority"]
    }
    
    


}




class DashBoardResponse : Mappable  {
    
   
    var Status                      : Int!
    var Message                     : String!
    var data                    : [DashBoardData]!
    
   

    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        
    Status                          <- map ["Status"]
    Message                         <- map ["Message"]
    data                            <- map ["data"]
    }
    
    


}

      
class DashBoardData : Mappable  {

   
    var dashType                    : String!
    var dashOrder                   : Int!
    var dashSubData                 : [AdData]!
    var emerSubData                 : [EmergencyDashTypes]!
    var attendanceSubData           : [AttendanceDashType]!
    var noticeSubData               : [NoticeBoardDashType]!
    var recentNotificationSubData   : [RecentNotificationsDashType]!
    var circular                    : [CircularDashType]!
    var Events                      : [UpcomingEventsDashType]!
    var assigment                   : [AssignmentsDashType]!
    var Chat                         : [chatData]!
    
    var leaveRequest                 : [LeaveRequestType]!

    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        
        
        
        dashType                    <- map ["type"]
        dashOrder                   <- map ["order"]
        dashSubData                 <- map ["data"]
        emerSubData                 <- map ["data"]
        attendanceSubData           <- map ["data"]
        noticeSubData               <- map ["data"]
        recentNotificationSubData   <- map ["data"]
        circular                    <- map ["data"]
        Events                      <- map ["data"]
        assigment                   <- map ["data"]
        Chat                        <- map["data"]
        leaveRequest                  <- map["data"]


        

    }
    
    
    
    
    }



class LeaveRequestType : Mappable{

    
    var appliedon : String!
    var message        : String!

    var fromdate : String!

    var  coursename : String!

    var  membername   : String!

    var  leavestatus : String!

    var  reason : String!

    var  noofdays   : String!

    var  todate  : String!
    var   departmentname : String!
    var sectionname : String!

    var leaveapplicationid : Int!

    

    required init?(map: Map) {

        

        

        mapping(map: map)

    }

    

    func mapping(map: Map) {

        

        

        fromdate                   <- map ["fromdate"]

        coursename                 <- map ["coursename"]

        membername                     <- map ["membername"]

        leavestatus            <- map ["leavestatus"]

        reason                   <- map ["reason"]

        noofdays                     <- map ["noofdays"]

        todate                   <- map ["todate"]

        message                 <- map["message"]
        
        sectionname     <- map["sectionname"]

        departmentname <- map["departmentname"]
         
        appliedon <- map["appliedon"]
        leaveapplicationid <- map["leaveapplicationid"]

    }

    

    

    

    

    

    

    

}

class chatData : Mappable{
    
    
    var coursename : String!
    var  departmentname : String!
    var  yearname   : String!
    var  sectionname : String!
    var  studentname : String!
    var  question   : String!
    var  createdon  : String!
    var message        : String!
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        coursename                   <- map ["coursename"]
        departmentname                 <- map ["departmentname"]
        yearname                     <- map ["yearname"]
        sectionname            <- map ["sectionname"]
        studentname                   <- map ["studentname"]
        question                     <- map ["question"]
        createdon                   <- map ["createdon"]
        message      <- map ["message"]
        
    }
    
    
    
    
    
    
    
}

class AdData : Mappable  {

   
    var add_title                   : String!
    var add_content                 : String!
    var company                     : String!
    var background_image            : String!
    var add_image                   : String!
    var add_url                     : String!
    var video_url                   : String!
    
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        
        
        add_title                   <- map ["add_title"]
        add_content                 <- map ["add_content"]
        company                     <- map ["company"]
        background_image            <- map ["background_image"]
        add_image                   <- map ["add_image"]
        add_url                     <- map ["add_url"]
        video_url                   <- map ["video_url"]
    }
    
    
    
    
    }


class EmergencyDashTypes : Mappable  {

    var message        : String!
    var detailsid                   : Int!
    var description                 : String!
    var voicefilepath               : String!
    var duration                    : Int!
    var membername                  : String!
    var createdon                   : String!
//    var video_url                 : String!
  
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        
        
        detailsid                   <- map ["detailsid"]
        description                 <- map ["description"]
        voicefilepath               <- map ["voicefilepath"]
        duration                    <- map ["duration"]
        membername                  <- map ["membername"]
        createdon                  <- map ["createdon"]
        message   <- map ["message"]
    }
    
    
    
    
    }



class AssignmentsDashType : Mappable  {

    var message        : String!
    var idassignmentdetails          : Int!
    var assignmenttopic              : String!
    var assignmentdescription        : String!
    var submissiondate               : String!
    var filepaths                    : [String]!
    
  
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        
        message    <- map ["message"]
        idassignmentdetails         <- map ["idassignmentdetails"]
        assignmenttopic             <- map ["assignmenttopic"]
        assignmentdescription       <- map ["assignmentdescription"]
        submissiondate              <- map ["submissiondate"]
        filepaths                   <- map ["filepaths"]
      
        
    }
    
    
    
    
    }








class NoticeBoardDashType: Mappable  {
   

    var idnoticeboarddetails        : Int!
    var topicheading                : String!
    var topicbody                   : String!
    var createddate                 : String!
    var createdtime                 : String!
    var message        : String!
  
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        
        
        idnoticeboarddetails        <- map ["idnoticeboarddetails"]
        topicheading                <- map ["topicheading"]
        topicbody                   <- map ["topicbody"]
        createddate                 <- map ["createddate"]
        createdtime                 <- map ["createdtime"]
        message     <- map ["message"]
        
    }


}





class CircularDashType: Mappable  {

   
    var idfiledetails               : Int!
    var title                       : String!
    var description                 : String!
    var filepaths                   : [String] = []
    var createddate                 : String!
    var circularCreatedtime         : String!
    var message        : String!
  
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        
        
        idfiledetails               <- map ["idfiledetails"]
        title                       <- map ["title"]
        description                 <- map ["description"]
        filepaths                   <- map ["filepaths"]
        createddate                 <- map ["createddate"]
        circularCreatedtime         <- map ["createdtime"]
        
        message      <- map ["message"]
        
    }


}





class AttendanceDashType: Mappable  {


   
    var message        : String!
   
    
    var subjectname : String!
    var attendancetype : String!
    var attendancedate : String!
    
   
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
      
        message <- map["message"]
        attendancetype <- map["attendancetype"]
        attendancedate <- map["attendancedate"]
        subjectname <- map["subjectname"]
        
      
        
    }


}




class RecentNotificationsDashType: Mappable  {

    
    var message        : String!
    var id                          : Int!
    var typ                         : String!
    var sentbyname                  : String!
    var createdondate               : String!
    var createdontime               : String!
    var content                     : String!
    var description                 : String!
    var duration                    : String!
    
    
  
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
                
        id                          <- map ["id"]
        typ                         <- map ["typ"]
        sentbyname                  <- map ["sentbyname"]
        createdondate               <- map ["createdondate"]
        createdontime               <- map ["createdontime"]
        content                     <- map ["content"]
        description                 <- map ["description"]
        duration                    <- map ["duration"]
        message           <- map ["message"]
      
        
    }


}



class UpcomingEventsDashType: Mappable  {
    

    var message        : String!
    var ideventdetails          : Int!
    var eventtopic              : String!
    var eventdate               : String!
    var eventtime               : String!
   
    
    
  
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
                
        ideventdetails              <- map ["ideventdetails"]
        eventtopic                         <- map ["eventtopic"]
        eventdate                  <- map ["eventdate"]
        eventtime               <- map ["eventtime"]
        message     <- map ["message"]
        
      
        
    }


}
