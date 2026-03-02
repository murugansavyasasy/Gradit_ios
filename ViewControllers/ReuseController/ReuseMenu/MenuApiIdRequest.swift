//
//  MenuApiIdRequest.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 06/12/22.
//

import Foundation

import KRProgressHUD



class UsermenuApiIdRequest {
    
        static func call_request(param : String, completion_handler : @escaping(String)->()) {
            KRProgressHUD.show()
            print("get_url()",get_url())
            BaseRequest.raw_post(url: get_url(), param: param).success {
                
                (res) in
                completion_handler (res as! String)
            }
        }
        
        
        private static func get_url() -> String{
            
            return String(format: "%@/GetParentUserMenuWithReadWriteAccess", Constant.baseUrl)
        }
        
   

}


