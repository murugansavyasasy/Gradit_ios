//
//  HistoryVoiceReq.swift
//  Vs_GradItCollege
//
//  Created by admin on 29/01/24.
//

import Foundation
//
//  HistorySmsRequst.swift
//  Vs_GradItCollege
//
//  Created by admin on 29/01/24.
//

import Foundation
import  KRProgressHUD

class HistoryVoiceReqs{

    

    static func call_request(param : String, completion_handler : @escaping(String)->()) {

        KRProgressHUD.show()

        

        

        BaseRequest.raw_post(url: get_url(), param: param).success {

          

            (res) in

            completion_handler (res as! String)

        }

    }

    

    

    private static func get_url() -> String{

        

        return String(format: "%@/GetVoiceMessageHistory", Constant.baseUrl)


        

    }

    

}





