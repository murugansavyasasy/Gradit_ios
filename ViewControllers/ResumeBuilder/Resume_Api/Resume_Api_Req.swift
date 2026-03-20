//
//  Resume_Api_Req.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 03/07/25.
//

import Foundation
import Alamofire
import ObjectMapper
import KRProgressHUD

//MARK: Get Profile Details Request
//class Get_Profile_Request {
//
//    static func call_request(memberId: String, param: [String: Any], completion_handler: @escaping (String) -> ()) {
//
//        KRProgressHUD.show()
//
//        BaseRequest.getAny(url: get_url(memberId: memberId), param: param).success { res in
//            completion_handler(res as! String)
//        }
//    }
//
//    private static func get_url(memberId: String) -> String {
//        return String(format: "%@profile/get-profile/%@", Constant.Resume_baseUrl, memberId)
//    }
//}
//
//
//
////MARK: Get Academic Records
//class Get_academicRecords_Request{
//    
//    static func call_request(param : [String: Any], completion_handler : @escaping(String)->()) {
//
//        KRProgressHUD.show()
//
//        BaseRequest.getAny(url: get_url(), param: param).success {
//
//            (res) in
//
//            completion_handler (res as! String)
//            
//            // ✅ Log request details
//                   print("===== Academic Records Request =====")
//                   print("URL:", get_url())
//                   print("Parameters:", param)
//                   print("===================================")
//
//        }
//    }
//
//    private static func get_url() -> String{
//
//        return String(format: "%@academicrecord/get-academic/", Constant.Resume_baseUrl)
//
//    }
//}
//
//
////MARK: Get Skillset
//class Get_Skillset_Request{
//    
//    static func call_request(param : [String: Any], completion_handler : @escaping(String)->()) {
//
//        KRProgressHUD.show()
//
//        BaseRequest.getAny(url: get_url(), param: param).success {
//
//            (res) in
//
//            completion_handler (res as! String)
//            
//            // ✅ Log request details
//                   print("===== skill set Request =====")
//                   print("URL:", get_url())
//                   print("Parameters:", param)
//                   print("===================================")
//
//
//        }
//    }
//
//    private static func get_url() -> String{
//
//        return String(format: "%@skillset/get-skillset/", Constant.Resume_baseUrl)
//
//    }
//}
//
//
//class Edit_Profile_Request{
//    
//    static func call_request(param : String, completion_handler : @escaping(String)->()) {
//
//        KRProgressHUD.show()
//
//        BaseRequest.raw_post(url: get_url(), param: param).success {
//
//            (res) in
//
//            completion_handler (res as! String)
//
//        }
//    }
//
//    private static func get_url() -> String{
//
//        return String(format: "%@profile/add-edit-profile", Constant.Resume_baseUrl)
//
//    }
//}
//
//class Edit_Academic_Request{
//    
//    static func call_request(param : String, completion_handler : @escaping(String)->()) {
//
//        KRProgressHUD.show()
//
//        BaseRequest.raw_post(url: get_url(), param: param).success {
//
//            (res) in
//
//            completion_handler (res as! String)
//            
//        }
//    }
//
//    private static func get_url() -> String{
//
//        return String(format: "%@academicrecord/add-edit-academic", Constant.Resume_baseUrl)
//
//    }
//}
//
//class Get_softSkills_Request{
//    
//    static func call_request(param : [String: Any], completion_handler : @escaping(String)->()) {
//
//        KRProgressHUD.show()
//
//        BaseRequest.getAny(url: get_url(), param: param).success {
//
//            (res) in
//
//            completion_handler (res as! String)
//
//        }
//    }
//
//    private static func get_url() -> String{
//
//        return String(format: "%@skillset/get-softskill", Constant.Resume_baseUrl)
//    }
//}
//
//class Edit_Skill_Request{
//    
//    static func call_request(param : String, completion_handler : @escaping(String)->()) {
//
//        KRProgressHUD.show()
//
//        BaseRequest.raw_post(url: get_url(), param: param).success {
//
//            (res) in
//
//            completion_handler (res as! String)
//            
//            // ✅ Log request details
//                   print("===== Edit skill set Request =====")
//                   print("URL:", get_url())
//                   print("Parameters:", param)
//                   print("===================================")
//
//
//        }
//    }
//
//    private static func get_url() -> String{
//
//        return String(format: "%@skillset/add-edit-skillset", Constant.Resume_baseUrl)
//
//    }
//}
//
//class Get_Template_Request{
//    
//    static func call_request(param : [String: Any], completion_handler : @escaping(String)->()) {
//
//        KRProgressHUD.show()
//
//        BaseRequest.getAny(url: get_url(), param: param).success {
//
//            (res) in
//
//            completion_handler (res as! String)
//
//        }
//    }
//
//    private static func get_url() -> String{
//
//        return String(format: "%@get/resumetemplatethemecolor", Constant.Resume_baseUrl)
//
//    }
//}
//
//class Generate_Resume_Request{
//    
//    static func call_request(param : String, completion_handler : @escaping(String)->()) {
//
//        KRProgressHUD.show()
//
//        BaseRequest.raw_post(url: get_url(), param: param).success {
//
//            (res) in
//
//            completion_handler (res as! String)
//
//        }
//    }
//
//    private static func get_url() -> String{
//
//        return String(format: "%@resume/post-resume", Constant.Resume_baseUrl)
//
//    }
//}
//
//
//class Save_Resume_Request{
//    
//    static func call_request(param : String, completion_handler : @escaping(String)->()) {
//
//        KRProgressHUD.show()
//
//        BaseRequest.raw_post(url: get_url(), param: param).success {
//
//            (res) in
//
//            completion_handler (res as! String)
//
//        }
//    }
//
//    private static func get_url() -> String{
//        return String(format: "%@resume/saveTitleResume", Constant.Resume_baseUrl)
//    }
//}
//
//class Get_Resume_Request{
//    
//    static func call_request(param : [String: Any], completion_handler : @escaping(String)->()) {
//
//        KRProgressHUD.show()
//
//        BaseRequest.getAny(url: get_url(), param: param).success {
//
//            (res) in
//
//            completion_handler (res as! String)
//        }
//    }
//
//    private static func get_url() -> String{
//        return String(format: "%@get/profileresume", Constant.Resume_baseUrl)
//    }
//}
//
//
//class Delete_Resume_Request{
//    
//    static func call_request(param : String,memberId: String, completion_handler : @escaping(String)->()) {
//
//        KRProgressHUD.show()
//
//        BaseRequest.raw_post(url: get_url(id: memberId), param: param).success {
//
//            (res) in
//
//            completion_handler (res as! String)
//
//        }
//        
//        BaseRequest.raw_post(url: get_url(id: memberId), param: param).error{ (error) in
//            
//            completion_handler (error as! String)
//        }
//    }
//
//    private static func get_url(id: String) -> String{
//        return String(format: "%@delete/studentresume/:\(id)", Constant.Resume_baseUrl)
//    }
//}
//
//
//class Upload_Resume_Request{
//    
//    static func call_request(param : String, completion_handler : @escaping(String)->()) {
//
//        KRProgressHUD.show()
//
//        BaseRequest.raw_post(url: get_url(), param: param).success {
//
//            (res) in
//
//            completion_handler (res as! String)
//
//        }
//    }
//
//    private static func get_url() -> String{
//        return String(format: "%@get/uploadresume", Constant.Resume_baseUrl)
//    }
//}
