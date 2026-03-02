

import UIKit
import WebKit
import KRProgressHUD
import ObjectMapper

@available(iOS 16.0, *)
class TermsViewController: UIViewController {


@IBOutlet weak var viewForEmbeddingWebView: UIView!
@IBOutlet weak var webView: WKWebView!
@IBOutlet weak var acceptView: UIView!
var versionCheck : [VersionCheckData] = []
override func viewDidLoad() {
super.viewDidLoad()

KRProgressHUD.show()

overrideUserInterfaceStyle = .light

let myURL = URL(string: "https://gradit.voicesnap.com/Home/TermsAndConditions")
let myRequest = URLRequest(url: myURL!)

webView.load(myRequest)

DispatchQueue.main.asyncAfter(deadline: .now()+2.3) {
KRProgressHUD.dismiss()
}



VersionCheck ()

let  acceptConditions = UITapGestureRecognizer(target: self, action: #selector(acceptVc))
acceptView.addGestureRecognizer(acceptConditions)





}





@IBAction  func acceptVc() {



let vc = CountryListViewController(nibName: nil, bundle: nil)


var term : String = "1"
let userDefault = UserDefaults.standard
userDefault.set(term, forKey: DefaultsKeys.TermsAndCondition)
//        UserDefaults.standard.set(true, forKey: Constant.TermsAndConditionResponse)
vc.modalPresentationStyle = .fullScreen

present(vc, animated: true, completion: nil)



}



func VersionCheck () {
let defaults = UserDefaults.standard
let param : [String : Any] =
[

"versionID" : DefaultsKeys.versionID,

"device_type" : "iphone"
]



print("paramsssss",param)
VersionCheckRequest.call_request(param: param)  {

[self] (res) in

let VersionUpdate : VersionCheckResponce = Mapper<VersionCheckResponce>().map(JSONString: res)!


versionCheck = VersionUpdate.versionData
if VersionUpdate.Status == 1 {

for i in versionCheck {

print("DefaultsKeys.123",i.videojson)
let defaults = UserDefaults.standard

defaults.set(i.videojson, forKey: DefaultsKeys.vimeoAccessToken)

defaults.set(i.videosizelimit, forKey: DefaultsKeys.videosizelimit)

defaults.set(i.videosizealert, forKey: DefaultsKeys.videosizealert)


print("DefaultsKeys.vimeoAccessToken",DefaultsKeys.vimeoAccessToken)
print("DefaultsKeys.",i.videojson)
}


print("VersionCheckSuccess")
}
}
}

}








