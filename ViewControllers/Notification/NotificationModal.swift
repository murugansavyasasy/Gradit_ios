//
//  NotificationModal.swift
//  Vs_GradIt
//
//  Created by APPLE on 27/09/22.
//

import Foundation

struct NotificationModal: Codable {

    var member_id: String?
    var college_id: String?

}

struct NotificationResponse: Codable {

    var Status: Int?
    var Message: String?
    var data: [NotificationData]?

}

struct NotificationData: Codable {

    var sent_on: String?
    var title: String?
    var notification_content: String?
    var module_type: String?
    var details_id: String?

}
