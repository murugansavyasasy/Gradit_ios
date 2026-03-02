//
//  NotificationModal.swift
//  Vs_GradIt
//
//  Created by APPLE on 27/09/22.
//

import Foundation
import ObjectMapper



class NotificationModal : Mappable  {

    var member_id                   : String!
    var college_id                  : String!


    init(){}

    required init?(map: Map) {
         mapping(map: map)
         }

    func mapping(map: Map) {

    member_id                       <- map ["member_id"]
    college_id                      <- map ["college_id"]


    }




    }


class NotificationResponse : Mappable  {

    var Status                      : Int!
    var Message                     : String!
    var data                        : [NotificationData]!



        required init?(map: Map) {
        mapping(map: map)
        }

       func mapping(map: Map) {



    Status                          <- map ["Status"]
    Message                         <- map ["Message"]
    data                            <- map ["data"]


}




}


class NotificationData : Mappable  {


    var sent_on                     : String!
    var title                       : String!
    var notification_content        : String!
    var module_type                 : String!
    var details_id                  : String!



required init?(map: Map) {
mapping(map: map)
}

func mapping(map: Map) {



    sent_on                         <- map ["sent_on"]
    title                           <- map ["title"]
    notification_content            <- map ["notification_content"]
    module_type                     <- map ["module_type"]
    details_id                      <- map ["details_id"]


}




}


