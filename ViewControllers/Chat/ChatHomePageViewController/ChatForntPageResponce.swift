//
//  ChatForntPageResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 23/12/22.
//

import Foundation
import ObjectMapper

struct ChatFrontPageModal : Codable{
    var student_id : String?
    var college_id : String?
}

struct ChatFrontPageResponce : Codable{
    var  Status : Int?
    var  Message : String?
    var  data : [chatFrontPageDataDetails]?

}

struct chatFrontPageDataDetails : Codable{
    var subjectid : String?
    var subjectname : String?
    var staffid : String?
    var staffname : String?
    var isclassteacher : String?
    var sectionid : String?
    var subjectcount : String?

}
