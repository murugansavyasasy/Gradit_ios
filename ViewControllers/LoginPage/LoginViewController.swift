    //
    //  LoginViewController.swift
    //  GraditLoginApp
    //
    //  Created by MACBOOKPRO on 16/10/22.
    //

    import UIKit
    import ObjectMapper

    @available(iOS 16.0, *)
    class LoginViewController: UIViewController,UITextFieldDelegate {


        @IBOutlet weak var backView: UIView!
        @IBOutlet weak var mobileNumberText: UITextField!


    @IBOutlet weak var passwordImg: UIImageView!
    @IBOutlet weak var passwordHideView: UIView!
    @IBOutlet weak var passwordText: UITextField!


    @IBOutlet weak var loginBtnView: UIViewX!

    var forArr : [dataForgetDetails] = []
    var ivrn : [String] = []
    var show_password = true
    var mobile_num : String!

    override func viewDidLoad() {
    super.viewDidLoad()

    overrideUserInterfaceStyle = .light
    addDoneButtonOnKeyboard()
    let  tapLoginbtn = UITapGestureRecognizer(target: self, action: #selector(loginVc))

    loginBtnView.addGestureRecognizer(tapLoginbtn)


    mobileNumberText.text = mobile_num

    let eye_gesture = UITapGestureRecognizer(target: self, action: #selector(toggle_password))
    passwordHideView.addGestureRecognizer(eye_gesture)
        
        let backViewss = UITapGestureRecognizer(target: self, action: #selector(BackVc))
        backView.addGestureRecognizer(backViewss)
        

    self.mobileNumberText.delegate = self
    mobileNumberText.keyboardType = .numberPad
    self.passwordText.delegate = self


    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }


        @IBAction func BackVc(){
            
            
            dismiss(animated: true)
        }

    @objc func keyboardWillShow(notification: NSNotification) { // -----> to set key board set height


    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
    if self.view.frame.origin.y == 0 {
    self.view.frame.origin.y -= keyboardSize.height-91
    print("keyboardSize.height",keyboardSize.height)
    }
    }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
    if self.view.frame.origin.y != 0 {
    self.view.frame.origin.y = 0
    }
    }


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {


    self.view.endEditing(true)


    return false


    }

    @objc func toggle_password(){
    print("toggle works")
    show_password = !show_password
    passwordText.isSecureTextEntry = show_password
    passwordImg.image = UIImage(named: show_password ? "lock": "un_lock")

    }



    func addDoneButtonOnKeyboard(){
    let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
    doneToolbar.barStyle = .default

    let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

    let items = [flexSpace, done]
    doneToolbar.items = items
    doneToolbar.sizeToFit()

    mobileNumberText.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction(){
    mobileNumberText.resignFirstResponder()
    }


    @IBAction  func loginVc() {




    if mobileNumberText.text!.isEmpty {





    let refreshAlert = UIAlertController(title: "", message: "Invalid Mobile Number", preferredStyle: UIAlertController.Style.alert)

    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in





    }))
    present(refreshAlert, animated: true, completion: nil)
    }

    else if (mobileNumberText.text?.count) != 10 {




    let refreshAlert = UIAlertController(title: "", message: "Enter valid Mobile Number", preferredStyle: UIAlertController.Style.alert)

    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in





    }))
    present(refreshAlert, animated: true, completion: nil)
    }



    else if  passwordText.text!.isEmpty{



    let refreshAlert = UIAlertController(title: "", message: "Invalid Mobile Number ", preferredStyle: UIAlertController.Style.alert)

    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in





    }))
    present(refreshAlert, animated: true, completion: nil)

    } else{



    let login = LoginModal ()
    login.mobilenumber = mobileNumberText.text
    login.Password     =  passwordText.text
    print("lojff",login.Password)


    let loginStr = login.toJSONString()

    loginRequest.call_request(param: loginStr!){ [self]

    (res) in


    let loginResponse : LoginResponse =
    Mapper<LoginResponse>().map(JSONString: res)!


    if loginResponse.Status == 1 {





    PreferencesUtil.saveToPrefs(key: Constant.keyId, value: res)

    print("loginResponse.data.count",loginResponse.data.count)
    if loginResponse.data.count == 1 {
    let vc = HomeScreenViewController(nibName: nil, bundle: nil)
    for i in loginResponse.data {


    let defaults = UserDefaults.standard
    defaults.set(i.colglogo, forKey: DefaultsKeys.colglogo)
    defaults.set(mobileNumberText.text, forKey: DefaultsKeys.mobileNumber)
    defaults.set(passwordText.text,forKey: DefaultsKeys.Password)

    var getmobil = defaults.string(forKey: DefaultsKeys.mobileNumber)
    var getpassword = defaults.string(forKey: DefaultsKeys.Password)
    print("login.mobilenumber",getmobil)

    print("login.passs",getpassword)
    defaults.set(i.loginas, forKey: DefaultsKeys.loginAsType)
    defaults.set(i.membername, forKey: DefaultsKeys.memberName)
    defaults.set(i.colgname, forKey: DefaultsKeys.colgName)
    defaults.set(i.colgid, forKey: DefaultsKeys.collegeid)
    defaults.set(i.memberid, forKey: DefaultsKeys.memberid)
    defaults.set(i.priority, forKey: DefaultsKeys.priority)
    defaults.set(i.colgcity, forKey:DefaultsKeys.colgcity)
    defaults.set(i.divid ,   forKey:DefaultsKeys.divid)
    defaults.set(i.divname, forKey: DefaultsKeys.divname)
    defaults.set(i.courseid,forKey: DefaultsKeys.courseid)

    print("oois_allow_to_make_call",i.is_allow_to_make_call)
    defaults.set(i.coursename,forKey:DefaultsKeys.coursename)
    defaults.set(i.deptid,forKey: DefaultsKeys.deptid)
    defaults.set(i.deptname,forKey: DefaultsKeys.deptname)
    defaults.set(i.yearid,forKey: DefaultsKeys.yearid)
    defaults.set(i.yearname,forKey: DefaultsKeys.yearname)
    defaults.set(i.sectionid,forKey: DefaultsKeys.sectionid)
    defaults.set(i.sectionname,forKey: DefaultsKeys.sectionname)
    defaults.set(i.semesterid,forKey: DefaultsKeys.semesterid)
    defaults.set(i.semestername,forKey: DefaultsKeys.semestername)
    defaults.set(i.is_parent_target_enabled,forKey: DefaultsKeys.is_parent_target_enabled)
    defaults.set(i.is_allow_to_make_call,forKey: DefaultsKeys.is_allow_to_make_call)

    }


    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true,completion: nil)
    }else{


    let vc = PriorityViewController(nibName: nil, bundle: nil)
    vc.modalPresentationStyle = .fullScreen



    let defaults = UserDefaults.standard

    defaults.set(mobileNumberText.text, forKey: DefaultsKeys.mobileNumber)
    defaults.set(passwordText.text,forKey: DefaultsKeys.Password)

    var getmobil = defaults.string(forKey: DefaultsKeys.mobileNumber)
    var getpassword = defaults.string(forKey: DefaultsKeys.Password)
    for i in loginResponse.data{


    if i.priority == "p3"{
    vc.IdentfierLabel = "STAFF"
    vc.loginPrincipal.append(i)

    }

    else if i.priority == "p4"{
    vc.loginStudent.append(i)

    }


    else if i.priority == "p2"{

    vc.IdentfierLabel = "HOD"
    vc.loginPrincipal.append(i)

    }

    else if i.priority == "p1"{

    vc.IdentfierLabel = "PRINCIPAL"
    vc.loginPrincipal.append(i)
    }

    else if i.priority == "p5"{
    vc.IdentfierLabel = "PARENT"
    vc.loginStudent.append(i)


    }



    else if i.priority == "p6"{

    vc.IdentfierLabel = "NON TEACHING"
    vc.loginPrincipal.append(i)
    }



    else if i.priority == "p7"{

    vc.IdentfierLabel = "UNIVERSITY HEAD"
    vc.loginPrincipal.append(i)
    }


    }


    present(vc, animated: true,completion: nil)

    }
    }else{


    let refreshAlert = UIAlertController(title: "", message: loginResponse.Message, preferredStyle: UIAlertController.Style.alert)

    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in





    }))
    present(refreshAlert, animated: true, completion: nil)
    }


    }
    }
        
        

    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {


    if textField === mobileNumberText {

    return range.location <= 9
    }
    else{

    return true

    }

    }




    @IBAction func fogetbtn(_ sender: Any) {

    forget()
    }


    func forget(){


    let forgets =  forgetModal  ()
    forgets.mobilenumber = mobile_num



    let forgetStr = forgets.toJSONString()

    forgetRequest.call_request(param: forgetStr!){ [self]

    (res) in


    let forgetResponse : forgetResponce =
    Mapper<forgetResponce>().map(JSONString: res)!

    if forgetResponse.Status == 1 {


    forArr = forgetResponse.data

    for i in forArr {




    let vc = EnterOtpViewController(nibName: nil, bundle: nil)
    vc.phnNumber = forgetResponse.Message
    vc.resiveMsg = i.ivrnumbers
    vc.ShowPhnumber = mobile_num
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true,completion: nil)

    }


    }




    }
    }
    }



