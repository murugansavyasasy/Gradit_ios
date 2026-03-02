//
//  vimeoVideoRequest.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 12/04/23.
//

import Foundation
class VimeoUploadRequest{

    

    

    

    

    

    static func call_request (param : String,token : String,completion_handler : @escaping(String) -> ()) {



        



        

        print("get_url",get_url())



        BaseRequest.vimeo(url: get_url(), param: param ,Token : token).success {





            



            (res) in



            completion_handler(res as! String)



        }



        



    }



    



    



    private static func get_url() -> String {



        



        return String (format:  "%@me/videos", Constant.VimeoUrl)



    }

    

    

    

    

}
