//
//  DepartmentResponces.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 24/11/22.
//

import Foundation

struct DepartmentResponces : Codable{
    
    var  userid  : String?
    var  appid   : String?
    var  priority : String?
    var  type     : String?
    
}

struct departmentImageResponce : Codable{
    var Status : Int?
    var Message : String?
    var data   : [departmentImageDataDetails]?
    
}

struct departmentImageDataDetails : Codable{
    
    var headerid  : String?
    var detailsid : String?
    var title     : String?
    var description : String?
    var file_path   : String?
    var createdondate : String?
    var createdontime : String?
    var sentbyname    : String?
    var filetype      : String?
    var userfilename  : String?
    var newfilepath   : [String]?
    var isappread : String?
    var newuserfilename : [String]?
    
}


