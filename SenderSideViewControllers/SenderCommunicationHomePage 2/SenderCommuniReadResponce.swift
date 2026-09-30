//
//  SenderCommuniReadResponce.swift
//  GraditSenderCommunicationMenu
//
//  Created by MACBOOKPRO on 07/12/22.
//



import Foundation

struct SenderCommunicationModal : Codable{
    
    var userid       :  String?
    var priority     :  String?
    var readtype     :  String?
    var appid        :  String?
}


struct SenderCommunicationResponse : Codable{
    
    var Status         :    Int?
    var Message        :    String?
    var data           : [SenderCommunicationDataDetails]?
    
}


struct SenderCommunicationDataDetails : Codable{
    
    var typename              :      String?
    var sentby                :      String?
    var headerid              :      String?
    var msgdetailsid          :      String?
    var timing                :      String?
    var duration              :      String?
    var msgcontent            :      String?
    var description           :      String?
    var isappread             :      String?
    var isemergency           :      String?
    var voicefile             :      String?
    
}
