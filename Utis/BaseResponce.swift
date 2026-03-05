

//
//  BaseRequest.swift
//  Api Integration
//
//  Created by MACBOOKPRO on 12/09/22.
//

import Foundation
import Foundation
import Alamofire
import KRProgressHUD
import SystemConfiguration

final class BaseRequest{

    var valueHandle : ((AnyObject) -> ())?
    var errorHandle : ((NSError)->())?

    enum MultiPartType {
        case string, file
    }
    public typealias MultiDict = (type: MultiPartType, value: Any)

    @discardableResult

    func success(value:@escaping (AnyObject) -> ())->Self{

        //pass success handle

        self.valueHandle = value

        return self

    }

    

    @discardableResult

    func error(error:@escaping (NSError)->())->Self{

        //pass error handle

        self.errorHandle = error

        return self

    }

    

    class func isConnectedToNetwork() -> Bool {

        

        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))

        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))

        zeroAddress.sin_family = sa_family_t(AF_INET)

        

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {

            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in

                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)

            }

        }

        

        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)

        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {

            return false

        }

        

        // Working for Cellular and WIFI

        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0

        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0

        let ret = (isReachable && !needsConnection)

        

        return ret

        

    }

    

    

    static func get(url: String ,param: [String: String]?) -> BaseRequest {

        

        let call_back = BaseRequest()

        

        if isConnectedToNetwork(){

            AF.request(url, method:.get, parameters: param, encoding: URLEncoding.default , headers:["Content-Type": "application/x-www-form-urlencoded"])

                .validate()

                .responseJSON { response in

                    

                    print("get method response: \(response)")

                    

                    

                    if let data = response.data {

                        let json = String(data: data, encoding: String.Encoding.utf8)

                        

                        KRProgressHUD.dismiss({

                            call_back.valueHandle?(json as AnyObject)

                        })

                    }

                }

        }else{

            print("offline")
            
//            
//            let refreshAlert = UIAlertController(title: "", message: "No Internet Connection", preferredStyle: UIAlertController.Style.alert)
//            
//            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
//            }))
//            .present(refreshAlert, animated: true, completion: nil)
//            

            KRProgressHUD.dismiss({

                call_back.valueHandle?("No Internet Connection" as AnyObject)

            })

        }

        

        return call_back

    }
    
    
    
    
    
    
    static func getAny(url: String ,param: [String: Any]?) -> BaseRequest {

        

        let call_back = BaseRequest()

        

        if isConnectedToNetwork(){

            AF.request(url, method:.get, parameters: param, encoding: URLEncoding.default , headers:["Content-Type": "application/x-www-form-urlencoded"])

                .validate()

                .responseJSON { response in

                    

                    print("get method response: \(response)")

                    

                    

                    if let data = response.data {

                        let json = String(data: data, encoding: String.Encoding.utf8)

                        

                        KRProgressHUD.dismiss({

                            call_back.valueHandle?(json as AnyObject)

                        })

                    }else {
                        
                    }

                }

        }else{

            print("offline")
            
//
//            let refreshAlert = UIAlertController(title: "", message: "No Internet Connection", preferredStyle: UIAlertController.Style.alert)
//
//            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
//            }))
//            .present(refreshAlert, animated: true, completion: nil)
//

            KRProgressHUD.dismiss({

                call_back.valueHandle?("No Internet Connection" as AnyObject)

            })

        }

        

        return call_back

    }
    
    
    
    
    static func getVersion(url: String ,param: [String: Any]?) -> BaseRequest {

        

        let call_back = BaseRequest()

        

        if isConnectedToNetwork(){

            AF.request(url, method:.get, parameters: param, encoding: URLEncoding.default , headers:["Content-Type": "application/x-www-form-urlencoded"])

                .validate()

                .responseJSON { response in

                    

                    print("get method response: \(response)")

                    

                    

                    if let data = response.data {

                        let json = String(data: data, encoding: String.Encoding.utf8)

                        

                        KRProgressHUD.dismiss({

                            call_back.valueHandle?(json as AnyObject)

                        })

                    }

                }

        }else{

            print("offline")

            KRProgressHUD.dismiss({

                call_back.valueHandle?("No Internet Connection" as AnyObject)

            })

        }

        

        return call_back

    }

    
  

    
    static func getInt(url: String ,param: [String: Int]?) -> BaseRequest {

        

        let call_back = BaseRequest()

        

        if isConnectedToNetwork(){

            AF.request(url, method:.get, parameters: param, encoding: URLEncoding.default , headers:["Content-Type": "application/x-www-form-urlencoded"])

                .validate()

                .responseJSON { response in

                    

                    print("get method response: \(response)")

                    

                    

                    if let data = response.data {

                        let json = String(data: data, encoding: String.Encoding.utf8)

                        

                        KRProgressHUD.dismiss({

                            call_back.valueHandle?(json as AnyObject)

                        })

                    }

                }

        }else{

            print("offline")

            KRProgressHUD.dismiss({

                call_back.valueHandle?("No Internet Connection" as AnyObject)

            })

        }

        

        return call_back

    }

    

    static func post(url: String, param: [String : MultiDict]) -> BaseRequest{

        let call_back = BaseRequest()

        

        if isConnectedToNetwork(){

            AF.upload(multipartFormData: { (mfd) in

                

                for (key, value) in param{

                    let val: MultiDict = value

                    if val.type == MultiPartType.string{

                        mfd.append(Data((val.value as! String).utf8), withName: key)

                    }else{

                        let images: [UIImage] = val.value as! [UIImage]

                        images.forEach { img in

                            mfd.append(img.jpegData(compressionQuality: 0.8)!, withName: key, fileName: "image.jpeg", mimeType: "image/jpeg")

                        }

                    }

                }

                

            }, to: url)

            .responseJSON { (res) in

                switch res.result{
                    
                case .success(let success):
                    print("")
                case .failure(let error):
                    print(" ❌ Error occurred: \(error.localizedDescription)")
                }

                print("post method response: \(res)")

                

                if let data = res.data {

                    let json = String(data: data, encoding: String.Encoding.utf8)

                    

                    KRProgressHUD.dismiss({

                        call_back.valueHandle?(json as AnyObject)

                    })

                }

            }

        }else{

            print("offline")

            KRProgressHUD.dismiss({

                call_back.valueHandle?("No Internet Connection" as AnyObject)

            })

        }

        

        return call_back

    }

    

    

    static func raw_post(url: String, param: String) -> BaseRequest{

        let call_back = BaseRequest()

        

        if isConnectedToNetwork(){

            let jsonData = param.data(using: .utf8, allowLossyConversion: false)!

            var request = URLRequest(url: URL(string: url)!)

            request.httpMethod = HTTPMethod.post.rawValue

            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")

            request.httpBody = jsonData

            
            

            AF.request(request).validate().responseJSON { (res) in

                    print(" ⚡ raw post method request : \(res.request!)")

                    print(" ⚡ raw post method response: \(res)")

                    

                    if let data = res.data {

                        let json = String(data: data, encoding: String.Encoding.utf8)

                        

                        KRProgressHUD.dismiss({

                            call_back.valueHandle?(json as AnyObject)

                        })

                    }

                }
            
          
                
                
                
            

        }else{

            print(" ⚡ offline")

            KRProgressHUD.dismiss({

                call_back.valueHandle?("No Internet Connection" as AnyObject)

            })

        }

        

        return call_back

    }

    
    static func vimeo(url: String, param: String,Token : String) -> BaseRequest {





    //        let call_back = BaseRequest()



            

    //                request.addValue("Bearer " + token!, forHTTPHeaderField: "Authorization")



            let call_back = BaseRequest()



            



            if isConnectedToNetwork(){



                let jsonData = param.data(using: .utf8, allowLossyConversion: false)!



                var request = URLRequest(url: URL(string: url)!)



                request.httpMethod = HTTPMethod.post.rawValue

                request.setValue("Bearer " + Token, forHTTPHeaderField: "Authorization")



    //            request.setValue("Bearer " + Token, forHTTPHeaderField: "Authorization")



                request.httpBody = jsonData



                



                AF.request(request)



                    .validate()



                    .responseJSON { (res) in



                        print(" ⚡ raw post method request : \(res.request!)")



                        print(" ⚡ raw post method response: \(res)")



                        



                        if let data = res.data {



                            let json = String(data: data, encoding: String.Encoding.utf8)



                            



                            KRProgressHUD.dismiss({



                                call_back.valueHandle?(json as AnyObject)



                            })



                        }



                    }



            }else{



                print(" ⚡ offline")



                KRProgressHUD.dismiss({



                    call_back.valueHandle?("No Internet Connection" as AnyObject)



                })



            }



            



            return call_back



        }
    

}




