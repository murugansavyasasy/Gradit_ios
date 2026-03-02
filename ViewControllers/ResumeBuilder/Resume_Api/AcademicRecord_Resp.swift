//
//  AcademicRecord_Resp.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 03/07/25.
//

import Foundation
import ObjectMapper

class EducationalDetail: Mappable {
    var percentage: String?
    var classDegree: String?
    var institution: String?
    var file_path : [File]?

    init() {}
    
    required init?(map: Map) {}

    func mapping(map: Map) {
        percentage     <- map["percentage"]
        classDegree    <- map["classDegree"]
        institution    <- map["institution"]
        file_path    <- map["file_path"]
    }
}

class EducationData: Mappable {
    var id: Int?
    var idMember: Int?
    var educationalDetails: [EducationalDetail]?
    var backlogs: String?
    var numberOfArrears: String?
    var createdOn: String?
    var modifiedOn: String?
    var isDelete: Int?

    required init?(map: Map) {}

    func mapping(map: Map) {
        id                <- map["id"]
        idMember          <- map["idMember"]
        educationalDetails <- map["educationalDetails"]
        backlogs          <- map["backlogs"]
        numberOfArrears   <- map["numberOfArrears"]
        createdOn         <- map["createdOn"]
        modifiedOn        <- map["modifiedOn"]
        isDelete          <- map["isDelete"]
    }
}

class EducationResponse: Mappable {
    var status: Bool?
    var message: String?
    var data: [EducationData]?

    required init?(map: Map) {}

    func mapping(map: Map) {
        status  <- map["status"]
        message <- map["message"]
        data    <- map["data"]
    }
}


//Request
class Edit_Academic_req: Mappable {
    
    var idMember: Int?
    var educationalDetails: [EducationalDetail]?
    var backlogs: String?
    var numberOfArrears: String?
    
    init(){}
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        idMember  <- map["idMember"]
        educationalDetails  <- map["educationalDetails"]
        backlogs  <- map["backlogs"]
        numberOfArrears  <- map["numberOfArrears"]
    }
}

//class eduData: Mappable {
//    
//    var classDegree: String?
//    var percentage: String?
//    var institution: String?
//    var Attachment : [File]?
//    
//    init(){}
//    
//    required init?(map: ObjectMapper.Map) {
//        mapping(map: map)
//    }
//    
//    func mapping(map: ObjectMapper.Map) {
//        classDegree  <- map["classDegree"]
//        percentage  <- map["percentage"]
//        institution  <- map["institution"]
//        Attachment  <- map["Attachment"]
//    }
//}

class File: Mappable {
    
    var type : String?
    var url : String?
    
    required init?(map: Map) {}
    
    init(type: String, url: String) {
            self.type = type
            self.url = url
        }
    
    func mapping(map: Map) {
        type    <- map["type"]
        url    <- map["url"]
    }
}

class Edit_Academic_Response: Mappable {
    var status: Bool?
    var message: String?
    var data: [String]?

    required init?(map: Map) {}

    func mapping(map: Map) {
        status  <- map["status"]
        message <- map["message"]
        data    <- map["data"]
    }
}


class Edit_Skill_Response: Mappable {
    var status: Bool?
    var message: String?
    var data: [String]?

    required init?(map: Map) {}

    func mapping(map: Map) {
        status  <- map["status"]
        message <- map["message"]
        data    <- map["data"]
    }
}
