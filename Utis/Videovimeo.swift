//
//  Videovimeo.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 30/03/23.
//

import ObjectMapper

class VimeoModalAndroid: Mappable {
    
var description : String!



var upload : VimeoUpload!



var name      :  String!



var link      :  String!

var privacy    :    VideoPrivacy!



var embed   :    VideoEmbed!





init(){}







required init?(map: Map) {



mapping(map: map)



}







func mapping(map: Map) {





description <- map["description"]

upload <- map["upload"]

name <- map["name"]

privacy <- map["privacy"]



link <- map["link"]

embed <- map["embed"]



}



}





class VimeoUpload: Mappable {





var size    :    String!



var approach   :    String!



init(){}







required init?(map: Map) {



mapping(map: map)



}







func mapping(map: Map) {





size <- map["size"]

approach <- map["approach"]





}

}





class VideoPrivacy: Mappable {





var view    :    String!

init(){}







required init?(map: Map) {



mapping(map: map)



}







func mapping(map: Map) {





view <- map["view"]





}



}



class VideoEmbed: Mappable {





var buttons    :    VideoEmbedButtons!



init(){}







required init?(map: Map) {



mapping(map: map)



}







func mapping(map: Map) {





buttons <- map["buttons"]





}

}





class VideoEmbedButtons: Mappable {





var share    :    String!

init(){}







required init?(map: Map) {



mapping(map: map)



}







func mapping(map: Map) {





share <- map["share"]



}



}





class VimeoModalData : Mappable {











var VimeoTitle    :    String!



var VideoData   :    String!



var VimeoDescription      :  String!



var vimeoAccessToken      :  String!



init(){}





required init?(map: Map) {



mapping(map: map)



}







func mapping(map: Map) {





VimeoTitle <- map["VimeoTitle"]

VideoData <- map["VideoData"]

VimeoDescription <- map["VimeoDescription"]

vimeoAccessToken <- map["vimeoAccessToken"]







}







}







class VimeoData : Mappable{







var  uri    : String!



var  name  : String!



//    var  description  : String!



var  type      : String!



var  link : String!



var  player_embed_url    : String!



var  duration     : Int!



var  width    : Int!



//    var  language      : String!



var  height : Int!



var  vimeoembed : VimeoEmbed!

    var  upload : VimeoUploadRe!







init(){}



required init?(map: Map) {



mapping(map: map)



}







func mapping(map: Map) {







//        "uri": "/videos/816817415",



//           "name": "Untitled",



//           "description": null,



//           "type": "video",



//           "link": "https://vimeo.com/816817415",



//           "player_embed_url": "https://player.vimeo.com/video/816817415?h=2f7888e0e1",



//           "duration": 0,



//           "width": 400,



//           "language": null,



//           "height": 300,











uri  <- map["uri"]



name <- map["name"]



    upload <- map["upload"]



type     <- map["type"]



//        description <- map["description"]



link    <- map["link"]



player_embed_url     <- map["player_embed_url"]



duration    <- map["duration"]



width      <- map["width"]



//        language <- map["language"]



height <- map["height"]



vimeoembed <- map["embed"]





}







}





class VimeoEmbed : Mappable{







var  html    : String!











required init?(map: Map) {



mapping(map: map)



}







func mapping(map: Map) {







html  <- map["html"]





}



}



class VimeoUploadRe : Mappable{







var  upload_link    : String!











required init?(map: Map) {



mapping(map: map)



}







func mapping(map: Map) {







    upload_link  <- map["upload_link"]





}



}
