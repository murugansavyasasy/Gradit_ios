//
//  YearSectionResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 14/03/23.
//

import Foundation
import ObjectMapper



class YearAndSectionListforAppModal : Mappable{

    

    var idcollege : String!

    var idcourse : String!

    var clgprocessby : String!
    
    

   

    

    

    init(){}

    

    required init?(map: ObjectMapper.Map) {

        mapping(map: map)

    }

    

    func mapping(map: ObjectMapper.Map) {

        

       

        idcollege <- map["idcollege"]

        idcourse <- map["idcourse"]

        clgprocessby <- map["clgprocessby"]
        
        

        

        

    }

    

    

    

    

}



class YearAndSectionListforAppResponse : Mappable{

    

               

    

    

    var Status : Int!

    var Message : String!

    var data : [YearAndSectionListData]!

    

    

    

    required init?(map: ObjectMapper.Map) {

        mapping(map: map)

    }

    

    func mapping(map: ObjectMapper.Map) {

        

        Status <- map ["Status"]

        Message <- map ["Message"]

        data <- map ["data"]

        

        

    }

    

    

    

}



class YearAndSectionListData : Mappable{

   

         

   

    var yearid : Int!

    var yearname : String!

    var sectiondetails : [sectionDetailsData]!

   

    

    

    

    

    

    required init?(map: ObjectMapper.Map) {

        mapping(map: map)

    }

    

    func mapping(map: ObjectMapper.Map) {

        yearid <- map ["yearid"]

        yearname <- map ["yearname"]

        sectiondetails <- map ["sectiondetails"]

       

    }

    

    

    

}









class sectionDetailsData : Mappable{

   

          

   
    var isSelected : Bool!
    var sectionid : Int!

    var sectionname : String!

   

   

    

    

    

    

    

    required init?(map: ObjectMapper.Map) {

        mapping(map: map)

    }

    

    func mapping(map: ObjectMapper.Map) {

        sectionid <- map ["sectionid"]

        sectionname <- map ["sectionname"]

       

       

    }

    

    

    

}
