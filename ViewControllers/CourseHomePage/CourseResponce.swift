//
//  CourseResponce.swift
//  CourseDetailsGradit
//
//  Created by MACBOOKPRO on 24/10/22.
//

import Foundation
import ObjectMapper
class courseModal : Mappable{
    
    
    
    var user_id    : String!
    var college_id : String!
    var dept_id    : String!
    var sem_id     : String!
    var section_id : String!
   
    
    init(){}
    
    
    
    
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        user_id             <- map ["user_id"]
        college_id          <- map["college_id"]
        dept_id             <- map["dept_id"]
        sem_id              <- map["sem_id"]
        section_id          <- map["section_id"]
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
}


class courseResponce : Mappable{
    
    
    var Status                   : Int!
    var Message                  : String!
    var data                     : [courseDataDetails]!
    
    
    
    
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
          
        Status  <- map["Status"]
        Message <- map["Message"]
        data    <- map["data"]
        
        
        
    }
    
    
}

class courseDataDetails : Mappable{
    
    var  subject_id                    : String!
    var  subject_name                  : String!
    var  subject_code                  : String!
    var  subject_type                  : String!
    var  subject_credits               : String!
    var  subject_category              : String!
    var  subject_requirement           : String!
    
    
    
    required init?(map: Map) {
        
        mapping(map: map)
        
    }
    
    func mapping(map: Map) {
        subject_id                          <- map["subject_id"]
        subject_name                        <- map["subject_name"]
        subject_code                        <- map["subject_code"]
        subject_type                        <- map["subject_type"]
        subject_credits                     <- map["subject_credits"]
        subject_category                    <- map["subject_category"]
        subject_requirement                 <- map["subject_requirement"]
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
}


