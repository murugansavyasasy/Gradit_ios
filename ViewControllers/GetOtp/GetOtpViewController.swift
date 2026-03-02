//
//  GetOtpViewController.swift
//  GraditLoginApp
//
//  Created by MACBOOKPRO on 17/10/22.
//

import UIKit

@available(iOS 16.0, *)
class GetOtpViewController: UIViewController {


@IBOutlet weak var otpMessageview: UIViewX!
@IBOutlet weak var otpCloseView: UIView!

@IBOutlet weak var otpMessageLable: UILabel!


@IBOutlet weak var ivrNumberView: UIView!


@IBOutlet weak var otpIvrNumber: UILabel!

let application = UIApplication.shared

var messageId   : String!
var ivrNumberId : [String] = []
var MobileNumber : String!

override func viewDidLoad() {
super.viewDidLoad()

otpMessageLable.text = messageId
otpIvrNumber.text =   ivrNumberId.first

overrideUserInterfaceStyle = .light

let tapClose =   UITapGestureRecognizer(target: self, action: #selector(otpclose))

otpCloseView.addGestureRecognizer(tapClose)


let tapOtp =   UITapGestureRecognizer(target: self, action: #selector(tapOtpVc))

ivrNumberView.addGestureRecognizer(tapOtp)

}

@IBAction  func otpclose() {


let vc = EnterOtpPageViewController(nibName: nil, bundle: nil)
vc.mobileNumber = MobileNumber
vc.modalPresentationStyle = .fullScreen
present(vc, animated: true,completion: nil)



}






@IBAction  func tapOtpVc() {



let phoneNumber = URL(string: ivrNumberId.first!)
let numberUrl = URL(string: "tel://\(phoneNumber)")!
if UIApplication.shared.canOpenURL(numberUrl) {
UIApplication.shared.open(numberUrl)

let vc = EnterOtpPageViewController(nibName: nil, bundle: nil)
vc.mobileNumber = MobileNumber
vc.modalPresentationStyle = .fullScreen
present(vc, animated: true,completion: nil)



}

}


}
