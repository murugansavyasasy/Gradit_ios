//
//  GetAddsForCollegeRequest.swift
//  Vs_GradItCollege
//
//  Created by APPLE on 04/11/22.
//

import Foundation
import KRProgressHUD



class GetAddsForCollegeRequest {
    
        static func call_request(param : String, completion_handler : @escaping(String)->()) {
            KRProgressHUD.show()
            print("get_url()",get_url())
            BaseRequest.raw_post(url: get_url(), param: param).success {
                
                (res) in
                completion_handler (res as! String)
            }
        }
        
        
        private static func get_url() -> String{
            
            return String(format: "%@/GetAddsForCollege", Constant.baseUrl)
        }
        
   

}

