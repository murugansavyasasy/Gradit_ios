


import Foundation




import Foundation

import  KRProgressHUD





class CountryListRequest {

    

    

    static func call_request (param : [String : String],completion_handler : @escaping(String) -> ()) {

        print("countryListUrl",get_url())

        KRProgressHUD.show()

        

        BaseRequest.get(url: get_url(), param: param).success {

            

            (res) in

            completion_handler(res as! String)

        }

        

    }

    

    

    private static func get_url() -> String {

        

        return String (format:  "%@/Getcountrylist?AppId=1", Constant.baseUrl)

    }

}

