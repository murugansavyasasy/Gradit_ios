//
//  SendTextEntierCollegeResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 06/03/23.
//

import Foundation
import ObjectMapper


struct EntierCollegeModal: Codable{
    
    var collegeid : String?
    var staffid : String?
    var callertype : String?
    var filetype : String?
    var messagecontent : String?
    var isstudent : Bool?
    var isstaff : Bool?
    var isparent : Bool?
    var description : String?
}

struct EntierCollegeResponce : Codable{
    
    var Status : Int?
    var Message : String?
    var data : [EntiercollegeDataDetails]?
}

struct EntiercollegeDataDetails : Codable{
    
    var ivrheader : String?
}
