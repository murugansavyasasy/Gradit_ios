//
//  ProfileRequest.swift
//  Vs_GradIt
//
//  Created by APPLE on 28/09/22.
//

import Foundation
import KRProgressHUD



class GetProfileDetailsRequest {
    
    static func call_request (param : [String : Int],completion_handler  : @escaping(String) -> ()) {
        
        
        print("get_url",get_url())
        KRProgressHUD.show()

        BaseRequest.getInt(url: get_url(), param: param).success {
            
            (res) in

            completion_handler(res as! String)
        }
    }
    
    
    
    private static func get_url() -> String {
        return String(format: "%@/GetProfileDetails", Constant.baseUrl)
        }
    }
    


