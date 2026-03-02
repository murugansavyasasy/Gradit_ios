//
//  NotificationRequest.swift
//  Vs_GradIt
//
//  Created by APPLE on 27/09/22.
//

import Foundation
import KRProgressHUD



class NotificationRequest {
    
        static func call_request(param : String, completion_handler : @escaping(String)->()) {
            KRProgressHUD.show()
            BaseRequest.raw_post(url: get_url(), param: param).success {
                
                (res) in
                completion_handler (res as! String)
            }
        }
        
        
        private static func get_url() -> String{
            
            return String(format: "%@/GetNotificationForCollege", Constant.baseUrl)
        }
        
   

}
