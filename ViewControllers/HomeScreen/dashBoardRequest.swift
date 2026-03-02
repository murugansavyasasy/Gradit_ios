//
//  DashBoardRequest.swift
//  Vs_GradIt
//
//  Created by APPLE on 26/09/22.
//

import Foundation
import KRProgressHUD



class DashBoardRequest {
    
        static func call_request(param : String, completion_handler : @escaping(String)->()) {
            KRProgressHUD.show()
            print("dashboard get_url()",get_url())
            BaseRequest.raw_post(url: get_url(), param: param).success {
                
                (res) in
                completion_handler (res as! String)
            }
        }
        
        
        private static func get_url() -> String{
            
            return String(format: "%@/DashboardApi_Live", Constant.baseUrl)
        }
        
   

}

