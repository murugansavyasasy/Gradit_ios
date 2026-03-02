

import Foundation
import ObjectMapper

class LoginModal :Mappable{
    
    
    var mobilenumber                      : String!
    var Password                          : String!
    
    
    init(){}
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        mobilenumber                        <- map["mobilenumber"]
        Password                            <- map["Password"]
        
    }
    
}

    class LoginResponse : Mappable{
       
        var Status                          : Int!
        var Message                         : String!
        var data                            : [datalogin]!
        
        
        required init?(map: Map) {
            mapping(map: map)
        }
        
        func mapping(map: Map) {
            
            Status                           <- map["Status"]
            Message                          <- map["Message"]
            data                             <- map["data"]
            
            
            
            
        }
        
        
        
        
    }

class datalogin : Mappable{

var colgid                                : Int!
var memberid                              : Int!
var priority                              : String!
var membername                            : String!
var colgname                              : String!
var colgcity                              : String!
var colglogo                              : String!
var divid                                 : String!
var divname                               : String!
var courseid                              : String!
var coursename                            : String!
var deptid                                : String!
var deptname                              : String!
var yearid                                : String!
var yearname                              : String!
var sectionid                             : String!
var sectionname                           : String!
var semesterid                            : String!
var semestername                          : String!

var loginas                               : String!
var is_parent_target_enabled              : String!
var is_allow_to_make_call                 : Int!

init(){}



required init?(map: Map) {
    mapping(map: map)
}

func mapping(map: Map) {
    
    colgid                               <- map["colgid"]
    memberid                             <- map["memberid"]
    priority                             <- map["priority"]
    membername                           <- map["membername"]
    colgname                             <- map["colgname"]
    colgcity                             <- map["colgcity"]
    colglogo                             <- map["colglogo"]
    divid                                <- map["divid"]
    divname                              <- map["divname"]
    courseid                             <- map["courseid"]
    coursename                           <- map["coursename"]
    deptid                               <- map["deptid"]
    deptname                             <- map["deptname"]
    yearid                               <- map["yearid"]
    yearname                             <- map["yearname"]
    sectionid                            <- map["sectionid"]
    sectionname                          <- map["sectionname"]
    semesterid                           <- map["semesterid"]
    semestername                         <- map["semestername"]
    loginas                              <- map["loginas"]
    is_parent_target_enabled             <- map["is_parent_target_enabled"]
    is_allow_to_make_call                <- map["is_allow_to_make_call"]
    
}

}







