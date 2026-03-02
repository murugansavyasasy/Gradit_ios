//
//  SemCreditDetailsRequest.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 22/12/22.
//

import Foundation
import  KRProgressHUD

class semCreditDetailsRequest{

    

    static func call_request(param : String, completion_handler : @escaping(String)->()) {

        KRProgressHUD.show()

        

        

        BaseRequest.raw_post(url: get_url(), param: param).success {

          

            (res) in

            completion_handler (res as! String)

        }

    }

    

    

    private static func get_url() -> String{

        

        return String(format: "%@/semesterwisestudentcreditdetails", Constant.baseUrl)



    }

    

}

class semCreditDetailsRequestAll{
    
    
    
    static func call_request(param : String, completion_handler : @escaping(String)->()) {
        
        KRProgressHUD.show()
        
        
        
        
        
        BaseRequest.raw_post(url: get_url(), param: param).success {
            
            
            
            (res) in
            
            completion_handler (res as! String)
            
        }
        
    }
    
    
    
    
    
    private static func get_url() -> String{
        
        
        
        return String(format: "%@/semesterwisestudentcreditdetailsALL", Constant.baseUrl)
        
      
        
    }
    
}



