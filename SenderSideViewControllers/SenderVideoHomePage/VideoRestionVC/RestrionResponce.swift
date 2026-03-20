//
//  RestrionResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 15/05/23.
//

import Foundation


struct restionResponce: Codable {

    var Status: Int?
    var Message: String?
    var data: [RestionDataDetails]?

}

struct RestionDataDetails: Codable {

    var content: String?

}
