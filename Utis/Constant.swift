


//
//  Constant.swift
//  Api Integration
//
//  Created by MACBOOKPRO on 12/09/22.
//

import Foundation


class Constant {
    
//    static let CountrybaseUrl : String = "https://gradit.voicesnap.com/api/AppDetailsBal/"
    static var baseUrl : String = "https://www.thegradit.com/api/AppDetailsBal/"
    //"https://gradit.voicesnap.com/api/AppDetailsBal/"
    
    static let Aws_baseUrl : String = "https://api.schoolchimes.com/nodejs/api/MergedApi/"
    static let CountryResponse : String = "Getcountrylist"
    static let VimeoUrl : String = "https://api.vimeo.com/"
    static let keyId : String = "LoginFromApp"
    static let Resume_baseUrl : String = "http://placement.thegradit.com/v1/api/"
    
    
}

struct DefaultsKeys {
    static let Password = "Password"
    static let loginDataList = "loginDataList"
    static let country = "country"
    static let mobileNumber = "mobileNumber"
    static let colglogo = "colglogo"
    static let  memberName = "memberName"
    static let  colgName = "colgName"
    static let loginAsType = "loginAsType"
    static let  collegeid  = "collegeid"
    static let  memberid  = "memberid"
    static let  priority  = "priority"
    static let  colgcity  = "colgcity"
    static let  divid     = "divid"
    static let  divname   = "divname"
    static let  courseid  = "courseid"
    static let  coursename = "coursename"
    static let  deptid    = "deptid"
    static let  deptname = "deptname"
    static let  yearid   = "yearid"
    static let  yearname  = "yearname"
    static let  sectionid  = "sectionid"
    static let  sectionname = "sectionname"
    static let  semesterid  = "semesterid"
    static let  semestername = "semestername"
    static let  semesterno = "semesterno"
    static let  is_parent_target_enabled   =  "is_parent_target_enabled"
    static let feepaymentlink = "feepaymentlink"
    static let  vimeoAccessToken = "vimeoAccessToken"
    
    static let versionID = 40
   // static let versionID = 39 Note: attachemnt in resume academic records added
   // static let versionID = 38 Note: sort function added in attendance and staff group enabled in recipient
   // static let versionID = 37 Note: admission no added in attendance page
    

    static let   videosizelimit = " videosizelimit"
    static let   DEVICETOKEN = "deviceToken"
    static let   videosizealert = "videosizealert"
    static let   TermsAndCondition = "TermsAndCondition"
    static let   CountryId = "CountryId"
    static var  resiverId : [String] = []
    static var saves : [SubjectDetailsRef] = []
    static var clgsection : [SectiondetailRef] = []
    static var saveButtonId : String! // important
    static var saveEdit : [EditSubjectDetailsRef] = [] // important
    static var MenuRefName :[menuApiDataDetails] = []
    static var   Filepath : [FilepathDataDetails] = []
    static let   isversionupdateavailable = "isversionupdateavailable"
        static let   isforceupdaterequired = "isforceupdaterequired"
    static let  is_allow_to_make_call = "is_allow_to_make_call"
    static let   versionalertcontent = "versionalertcontent"
        static let   versionalerttitle = "versionalerttitle"
    
//    static let S3BucketName = "schoolchimes-files-india"
//    static let S3BucketName = "gradit-app-files"
    
    static let S3BucketName = "gradit-communication"
    static   let CognitoPoolID = "ap-south-1:a8650d2e-79d6-4668-85db-110e9917583f"
    
    
    
    static var Voice : String!
    static var Text : String!
    
    static var DeviceToken = "DeviceToken"
//    static let keyId  = "keyId"
}



           
           
           
          
   
