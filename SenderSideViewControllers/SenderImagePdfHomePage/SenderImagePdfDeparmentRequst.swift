//
//  SenderImagePdfDeparmentRequst.swift
//  GraditImagePdf
//
//  Created by MACBOOKPRO on 07/12/22.
//





import Foundation
import  KRProgressHUD

class SenderimageRequest{

    

    static func call_request(param : String, completion_handler : @escaping(String)->()) {

        KRProgressHUD.show()

        

        

        BaseRequest.raw_post(url: get_url(), param: param).success {

          

            (res) in

            completion_handler (res as! String)

        }

    }

    

    

    private static func get_url() -> String{

        

        return String(format: "%@GetCircularListByType", Constant.baseUrl)


    }

    

}





