//
//  chatBlockResp.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 17/04/23.
//

import Foundation

import ObjectMapper







class ChatBlockModal : Mappable{

    

   

   

    

    var student_id : String!

    var staff_id : String!

    var college_id : String!

   

   

    init(){}

    

    

    

    required init?(map: ObjectMapper.Map) {

        

        mapping(map: map)

    }

    

    func mapping(map: ObjectMapper.Map) {

       

        student_id <- map["student_id"]

        staff_id <- map["staff_id"]

        college_id <- map ["college_id"]

      

    }

    

  

    

}











class ChatBlocResponse : Mappable{

   

      

    var Status : Int!

    

    var Message : String!

    

    

        

        var data : [ChatBlockData]!

        

        

        

    

    

    required init?(map: ObjectMapper.Map) {

        mapping(map: map)

    }

    

    func mapping(map: ObjectMapper.Map) {

        

        Status <- map ["Status"]

        Message <- map["Message"]

       

        data <- map["data"]

    }

    

    

    

    

    

    

    

}





class ChatBlockData : Mappable{

   

            

   

    var idstudent : String!

    var idstaff : String!

  

  

    

    

    

   

    required init?(map: ObjectMapper.Map) {

        mapping(map: map)

    }

    

    func mapping(map: ObjectMapper.Map) {

        

        idstudent <- map ["idstudent"]

        idstaff <- map ["idstaff"]

     

    }

    

    

    

    

    

}

