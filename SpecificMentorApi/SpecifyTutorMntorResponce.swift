//
//  SpecifyTutorMntorResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 14/03/23.
//

import Foundation
import ObjectMapper



class GetMentorstudentListforappModal : Mappable{

    

    var collegeid : String!

    var staffid : String!

    var deptid : String!

    var yearid : String!

    var sectionid : String!

  
    init(){}

   

    required init?(map: ObjectMapper.Map) {

        mapping(map: map)

    }

    

    func mapping(map: ObjectMapper.Map) {

        

        collegeid <- map["collegeid"]

        staffid <- map["staffid"]

        deptid <- map["deptid"]

        yearid <- map["yearid"]

        sectionid <- map["sectionid"]

        

    }

}



class GetMentorstudentListforappResponse : Mappable{

    

    

    

    var Status : Int!

    var Message : String!

    var data : [GetMentorstudentListData]!

    

    

    

    required init?(map: ObjectMapper.Map) {

        mapping(map: map)

    }

    

    func mapping(map: ObjectMapper.Map) {

        

        Status <- map ["Status"]

        Message <- map ["Message"]

        data <- map ["data"]

        

        

    }

}



class GetMentorstudentListData : Mappable{

 
    var name : String!

    var memberid : String!

    var admissionno : String!

    var regno : String!

    var course : String!

    var year : String!

    var section : String!
    var isSelected : Bool!

 
    required init?(map: ObjectMapper.Map) {

        mapping(map: map)

    }

    

    func mapping(map: ObjectMapper.Map) {

        name <- map ["name"]

        memberid <- map ["memberid"]

        admissionno <- map ["admissionno"]

        regno <- map ["regno"]

        course <- map ["course"]

        year <- map ["year"]

        section <- map ["section"]

        

    }


}

