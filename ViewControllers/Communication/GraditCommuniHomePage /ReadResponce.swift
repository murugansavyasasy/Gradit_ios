

import Foundation

struct ReadModal : Codable{
   
    var userid       :  String?
    var priority     :  String?
    var readtype     :  String?
    var appid        :  String?
}


struct ReadcommunicationResponce : Codable{
    
    var Status         :    Int?
    var Message        :    String?
    var data           : [ReadCommunicationDetails]?
    
}


struct ReadCommunicationDetails : Codable{
   
    var     typename              :      String?
    var      sentby               :      String?
    var      headerid             :      String?
    var      msgdetailsid         :      String?
    var      timing               :      String?
    var     duration              :      String?
    var     msgcontent            :      String?
    var     description           :      String?
    var     isappread             :      String?
    var     isemergency           :      String?
    var     voicefile             :      String?
    
}



