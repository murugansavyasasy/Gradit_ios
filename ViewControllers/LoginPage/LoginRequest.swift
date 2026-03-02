



import Foundation
import  KRProgressHUD

class loginRequest{

    

    static func call_request(param : String, completion_handler : @escaping(String)->()) {

        KRProgressHUD.show()
        BaseRequest.raw_post(url: get_url(), param: param).success {
            (res) in

            completion_handler (res as! String)

        }

    }

    

    

    private static func get_url() -> String{

        

        return String(format: "%@/LoginFromApp", Constant.baseUrl)

//        return String(format: "%@api/CallShopping/GetOrderList", Constant.USABaseUrl)

    }

    

}




