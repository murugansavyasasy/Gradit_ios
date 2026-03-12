
import Foundation

struct videoModal : Codable{
    var userid                       : String?
    var collegeid                    : String?
    var priority                     : String?
 
}


struct videoResponce : Codable{
    
    var Status    :    Int?
    var Message   :    String?
    var data      :   [videoDataDetails]?
}

struct videoDataDetails : Codable{
    
    var  videoid    : String?
    var  createdby  : String?
    var  createdon  : String?
    var  title      : String?
    var  description : String?
    var  vimeourl    : String?
    var  vimeoid     : String?
    var  detailid    : String?
    var  iframe      : String?
    var  isappviewed : String?

}
