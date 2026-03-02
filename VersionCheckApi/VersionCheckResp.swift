    //
    //  VersionCheckResp.swift
    //  Vs_GradItCollege
    //
    //  Created by MACBOOKPRO on 08/04/23.
    //

    import Foundation
    import ObjectMapper


    class VersionCheckResponce : Mappable{

    var Status :     Int!
    var Message    :     String!

    var versionData                   : [VersionCheckData]!



    required init?(map: Map) {
    mapping(map: map)
    }

    func mapping(map: Map) {

    Status        <- map["Status"]
    Message           <- map["Message"]
    versionData                        <- map["data"]


    }

    }

    class VersionCheckData : Mappable{




    var isversionupdateavailable :     Int!
    var isforceupdaterequired    :     Int!

    var resultvalue                    : Int!
    var resultmessage             : String!
    var imagecount               : String!
    var pdfcount                  : String!
    var eventphotoscount                     : String!
    var attendancedaycount                   : String!
    var privarypolicy             : String!
    var faq        : String!
    var help         : String!
    var termsandcondition        : String!
    var playstorelink           : String!
    var versionalerttitle                : String!
    var versionalertcontent  : String!
    var playstoremarketid       : String!
    var videojson      : String!
    var videosizelimit : String!
    var videosizealert : String!
    var feepaymentlink : String!


    init(){}



    required init?(map: Map) {
    mapping(map: map)
    }

    func mapping(map: Map) {

        isversionupdateavailable  <- map["isversionupdateavailable"]
        isforceupdaterequired     <- map["isforceupdaterequired"]
        resultvalue               <- map["resultvalue"]
        resultmessage             <- map["resultmessage"]
        imagecount                <- map["imagecount"]
        pdfcount                  <- map["pdfcount"]
        eventphotoscount          <- map["eventphotoscount"]
        attendancedaycount        <- map["attendancedaycount"]
        privarypolicy             <- map["privarypolicy"]
        faq                       <- map["faq"]
        help                      <- map["help"]
        termsandcondition         <- map["termsandcondition"]
        playstorelink             <- map["playstorelink"]
        versionalerttitle         <- map["versionalerttitle"]
        versionalertcontent       <- map["versionalertcontent"]
        playstoremarketid         <- map["playstoremarketid"]
        videojson                 <- map["videojson"]
        videosizelimit            <- map["videosizelimit"]
        videosizealert            <- map["videosizealert"]
        feepaymentlink            <- map["feepaymentlink"]


    }




    }
