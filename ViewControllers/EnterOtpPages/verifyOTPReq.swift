//
//  verifyOTPReq.swift
//  Vs_GradItCollege
//
//  Created by admin on 25/08/23.
//

import Foundation
import KRProgressHUD
class verifyOTPRequest{
    
    
    
    
    
    
    static func call_request(param : String, completion_handler : @escaping(String)->()) {

        KRProgressHUD.show()

        

        

        BaseRequest.raw_post(url: get_url(), param: param).success {

          

            (res) in

            completion_handler (res as! String)

        }

    }

    

    

    private static func get_url() -> String{

        

        return String(format: "%@/VerifyOTP", Constant.baseUrl)


        

    }
}
