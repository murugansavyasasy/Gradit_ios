//
//  DeviceTokenRequest.swift
//  Vs_GradItCollege
//
//  Created by Apple on 09/06/23.
//

import Foundation
import KRProgressHUD

class DeviceTokenRequest {
    
        static func call_request(param : String, completion_handler : @escaping(String)->()) {
            KRProgressHUD.show()
            print("dashboard get_url()",get_url())
            BaseRequest.raw_post(url: get_url(), param: param).success {
                
                (res) in
                completion_handler (res as! String)
            }
        }
        
        
        private static func get_url() -> String{
            
            return String(format: "%@DeviceToken", Constant.baseUrl)
        }
        
   

}
