//
//  VersionCheckReq.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 08/04/23.
//

import Foundation
import KRProgressHUD

class VersionCheckRequest{
    
    
    
    
    
    static func call_request (param : [String : Any],completion_handler : @escaping(String) -> ()) {

        print("priyA",get_url())

        KRProgressHUD.show()

        

        BaseRequest.getVersion(url: get_url(), param: param).success {

            

            (res) in
            print("priyAhgfd",res)
            completion_handler(res as! String)

        }

        

    }

    

    

    private static func get_url() -> String {

        

        return String (format:  "%@VersionCheck", Constant.baseUrl)

    }
    
    
    
    
}
