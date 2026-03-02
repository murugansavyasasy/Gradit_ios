//
//  EventParticularResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 18/03/23.
//

import Foundation
import ObjectMapper

class EventParticualrModal : Mappable{
    
    
    var eventid : String!
   
    var collegeid : String!
    var staffid : String!
     var eventdate : String!

    var eventtime : String!
    var eventbody : String!
    var eventvenue : String!
    var receiveridlist : String!
    var isstudent : Bool!
    var isstaff : Bool!
    var isparent : Bool!
    var  receivertype : String!
     var Callertype  : String!
    var subjectid : String!
    var eventtopic : String!
     var processtype  : String!

    init(){}
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        eventid <- map["eventid"]
      collegeid <- map["collegeid"]
        receiveridlist <- map["receiveridlist"]
        receivertype <- map ["receivertype"]
       staffid <- map["staffid"]

        
        processtype <- map["processtype"]
        
        isstudent <- map ["isstudent"]
        
        isparent <- map ["isparent"]
        
        isstaff <- map["isstaff"]
        
        eventdate <- map ["eventdate"]
        eventtime <- map["eventtime"]
        eventbody <- map["eventbody"]
        eventtopic <- map["eventtopic"]
        eventvenue <- map["eventvenue"]
        Callertype <- map ["Callertype"]
        subjectid <- map["subjectid"]
       
    }
    

}



class EventParticularResponce : Mappable{
    
    
    
    
    
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
