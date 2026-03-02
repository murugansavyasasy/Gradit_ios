//
//  MessageSendReceiverSideRequest.swift
//  Vs_GradItCollege
//
//  Created by Apple on 03/04/23.
//

import Foundation
import  KRProgressHUD

class MessageSendReceiverSideRequest{

    

    static func call_request(param : String, completion_handler : @escaping(String)->()) {

        KRProgressHUD.show()

        

        

        BaseRequest.raw_post(url: get_url(), param: param).success {

          

            (res) in

            completion_handler (res as! String)

        }

    }

    

    

    private static func get_url() -> String{

        

        return String(format: "%@/StudentAskQuestionForApp", Constant.baseUrl)


        

    }

    

}






