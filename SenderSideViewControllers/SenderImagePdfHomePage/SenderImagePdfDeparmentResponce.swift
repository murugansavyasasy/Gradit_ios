//
//  SenderImagePdfDeparmentResponce.swift
//  GraditImagePdf
//
//  Created by MACBOOKPRO on 07/12/22.
//


import Foundation

struct SenderDeparmentImageModal:Codable{
    var  userid  : String?
    var  appid   : String?
    var  priority : String?
    var  type     : String?

}

struct SenderDepartmentImageResponce : Codable{
    var Status : Int?
    var Message : String?
    var data   : [SenderDepartmentImageDataDetails]?
}

struct SenderDepartmentImageDataDetails : Codable{
    
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





