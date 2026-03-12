//
//  VoiceRecoredViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 10/02/23.
//

import UIKit
import AVFAudio
import AVFoundation
import Alamofire
import ObjectMapper
import KRProgressHUD



@available(iOS 16.0, *)
class VoiceRecoredViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    
    
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var topNameview: UIView!
    @IBOutlet weak var historyVoiceMsgCheckBox: checkBoxFour!
    @IBOutlet weak var bottomOverAllView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var newVoiceMsgCheckBox: checkBoxFour!
    @IBOutlet weak var btnName: UIButton!
    @IBOutlet weak var tapBarView: UIViewX!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var textViewss: UIView!
    
    @IBOutlet weak var tickMarkView: UIView!
    @IBOutlet weak var clearAudio: UIView!
    
    @IBOutlet weak var pleaseDefaultLabel: UILabel!
    @IBOutlet weak var voiceSilderFullView: UIView!
    @IBOutlet weak var replySwitch: UISwitch!
    
    @IBOutlet weak var cancelView: UIViewX!
    
    @IBOutlet weak var nodataLbl: UILabel!
    @IBOutlet weak var selectRespinceView: UIViewX!
    
    @IBOutlet weak var voiceDisprectionLabl: UITextField!
    @IBOutlet weak var durationLable: UILabel!
    
    @IBOutlet weak var playVoiceImageView: UIImageView!
    @IBOutlet weak var Slider: UISlider!
    
    @IBOutlet weak var PlayAudioView: UIView!
    
    @IBOutlet weak var RecodingImageView: UIImageView!
    
    @IBOutlet weak var voiceRecodeView: UIView!
    
    
    @IBOutlet weak var recodSecondsLabel: UILabel!
    
    
    @IBOutlet weak var notificationView: UIView!
    
    @IBOutlet weak var smallImg: UIImageView!
    
    @IBOutlet weak var bigImg: UIImageView!
    
    @IBOutlet weak var logoutView: UIView!
    
    @IBOutlet weak var changeRolesView: UIView!
    
    
    
    
    @IBOutlet weak var topLabels: UILabel!
    
    
    
    @IBOutlet weak var clgLogoImg: UIImageView!
    
    @IBOutlet weak var topMessageLabel: UILabel!
    
    
    
    @IBOutlet weak var canclView: UIViewX!
    
    @IBOutlet weak var privacyPolicyView: UIView!
    
    
    @IBOutlet weak var redirectLoginView: UIViewX!
    
    @IBOutlet weak var faqView: UIView!
    
    
    @IBOutlet weak var viewTap: UIView!
    
    @IBOutlet weak var helpView: UIView!
    
    
    @IBOutlet weak var changePasswordView: UIView!
    
    
    @IBOutlet weak var termsAndConditionView: UIView!
    
    
    @IBOutlet weak var clickHereLabel: UILabel!
    @IBOutlet weak var sideMenuView: UIView!
    
    
    
    @IBOutlet weak var refreshView: UIView!
    
    
    @IBOutlet weak var CallView: UIView!
    var voiceUploadss : [VoiceEntierDataDetails] = []
    var addapiRef : [AddDataDeatils] = []
    
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    var meterTimer:Timer!
    var isAudioRecordingGranted: Bool!
    var isRecording = false
    var isPlaying = false
   
    var url: URL!
    
    var Types = "11"
    var replyType : String = "0"
    
    var audioSeconds : String!
    var piroty : String!
    
    
    var players: AVAudioPlayer?
    
    var AudioPlayUrl : String!
    
    
    var loginDatas : [datalogin]!
    var logindataprinci :[datalogin]!
    
    
    var previousAddId : Int!
    var MobileNumber : String!
    var password : String!
    
    var colgId : String!
    
    fileprivate let seekDuration: Float64 = 10
    
    var memberId : String!
    
    var colgImg : String!
    var str : [String] = []
    
    var strName : [String] = []
    
    var timeLabelForPlayVoice : String!
    
    var secondsLabel  : String!
    
    var strPlayStatus : NSString = ""
    
    
    var timer = Timer()
    var time : Float64 = 0;
    var sliderIndex : NSInteger = NSInteger()
    var strFilePath : String = String()
    var is_read_enabled = ""
    var is_write_enabled = ""
    var TvCellidentifer = "NextVoiceTableViewCell"
    var historyDataDetails : [HistorySmsVoiceDataDetail] = []
    var CallEnabel : Int!
    var VoiceHstryHeaderId : String!
    var VoiceHstryID  = "1"
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        
        

        
        
        tv.isScrollEnabled = true
        replyType  = "0"
        print("printsss",replyType)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    
        overrideUserInterfaceStyle = .light
        
        refreshView.isHidden = true
        sideMenuView.isHidden = true
        recodSecondsLabel.text = "00:00" + " / " + "03:00"
        durationLable.text = "00:00"
        clickHereLabel.text = "Click here,Start Recording"
        voiceSilderFullView.isHidden = true
        textViewss.isHidden = true
        lineView.isHidden = true
        
        durationLable.isHidden = true
        clearAudio.isHidden = true
        tickMarkView.isHidden = true
        clickHereLabel.isHidden = true
        
        tv.isHidden = true
        newVoiceMsgCheckBox.setImage(UIImage.init(named: "radios"), for: .normal)
        nodataLbl.isHidden = true
        let defaults = UserDefaults.standard
        
        
        piroty = defaults.string(forKey: DefaultsKeys.priority)
        
        MobileNumber = defaults.string(forKey: DefaultsKeys.mobileNumber)
        password = defaults.string(forKey: DefaultsKeys.Password)
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        topMessageLabel.text = defaults.string(forKey: DefaultsKeys.memberName)
        colgImg = defaults.string(forKey: DefaultsKeys.colglogo)
        clgLogoImg.sd_setImage(with: URL(string:  colgImg), placeholderImage: UIImage(named: "person.fill"))
        CallEnabel = defaults.integer(forKey: DefaultsKeys.is_allow_to_make_call)
        
        print("is_write_enabledis_write_enabledis_write_enabledis_write_enabled",is_write_enabled)
        print("is_read_enabledis_read_enabledis_read_enabled",is_read_enabled)
        
        voiceDisprectionLabl.returnKeyType = .done
        voiceDisprectionLabl.delegate = self
        
        
        let TextRownib = UINib(nibName: TvCellidentifer, bundle: nil)
        tv.register(TextRownib, forCellReuseIdentifier: TvCellidentifer)
        
        
        
        if CallEnabel == 1{
            
            CallView.isHidden = false
            
        }
        
        else{
            
            
            CallView.isHidden = true
        }
        
        
        if piroty == "p1"{
            tapBarView.backgroundColor = UIColor(named: "Principal" )
            topLabels.text = "Principal"
            
        }
        
        else if piroty == "p4"{
            
            topLabels.text = "Student"
            
        }
        
        else if piroty == "p2" {
            
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            topLabels.text = "Hod"
            
        }
        
        else if piroty == "p5"{
            
            
            topLabels.text = "Father"
            
            
            
        }
        
        else if piroty == "p3"{
            tapBarView.backgroundColor = UIColor(named: "Teaching Staff" )
            topLabels.text = "Teacher"
            
        }
        
        else if piroty == "p7"{
            tapBarView.backgroundColor = UIColor(named: "univercityColorCod" )
            topLabels.text = "GroupHead"
            
        }
        
        addApi()
        check_record_permission()
        
        
        
        let cancelViewss = UITapGestureRecognizer(target: self, action: #selector(CancelVc))
        canclView.addGestureRecognizer(cancelViewss)
        
        let clearAudioFile = UITapGestureRecognizer(target: self, action: #selector(clearAudioVc))
        clearAudio.addGestureRecognizer(clearAudioFile)
        
        let voiceRecord = UITapGestureRecognizer(target: self, action: #selector(recodeVc))
        voiceRecodeView.addGestureRecognizer(voiceRecord)
        
        let tickView = UITapGestureRecognizer(target: self, action: #selector(TickMarkVC))
        tickMarkView.addGestureRecognizer(tickView)
        
        
        let SelectRespience = UITapGestureRecognizer(target: self, action: #selector(SelectRespienceVc))
        selectRespinceView.addGestureRecognizer(SelectRespience)
        replySwitch.addTarget(self, action: #selector(switchIsChanged), for: UIControl.Event.valueChanged)
        
        
        
        
        
        let changeRolesGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        changeRolesView.addGestureRecognizer(changeRolesGesture)
        
        
        let topname = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        topNameview.addGestureRecognizer(topname)
        
        
        
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
        logoutView.addGestureRecognizer(logoutGesture)
        
        let loginRediectGesture = UITapGestureRecognizer(target: self, action: #selector(priorityVc))
        redirectLoginView.addGestureRecognizer(loginRediectGesture)
        
        
        
        let menuGestureHide = UITapGestureRecognizer(target: self, action: #selector(menu))
        viewTap.addGestureRecognizer(menuGestureHide)
        
        let notificationGesture = UITapGestureRecognizer(target: self, action: #selector(notificationVc))
        notificationView.addGestureRecognizer(notificationGesture)
        
        let refreshGesture = UITapGestureRecognizer(target: self, action: #selector(refreshVc))
        refreshView.addGestureRecognizer(refreshGesture)
        
        
        let faqGesture = UITapGestureRecognizer(target: self, action: #selector(faqRedirect))
        faqView.addGestureRecognizer(faqGesture)
        
        
        let helpGesture = UITapGestureRecognizer(target: self, action: #selector(helpRedirect))
        helpView.addGestureRecognizer(helpGesture)
        //
        
        let privacyPolicyGesture = UITapGestureRecognizer(target: self, action: #selector(privacyPolicyRedirect))
        privacyPolicyView.addGestureRecognizer(privacyPolicyGesture)
        
        let termsAndConditionGesture = UITapGestureRecognizer(target: self, action: #selector(termsAndCondition))
        termsAndConditionView.addGestureRecognizer(termsAndConditionGesture)
        
        let chagePassword = UITapGestureRecognizer(target: self, action: #selector(changePassowrdVC))
        changePasswordView.addGestureRecognizer(chagePassword)
        
        
        let newVoice = UITapGestureRecognizer(target: self, action: #selector(NewVoiceMsgVC))
        newVoiceMsgCheckBox.addGestureRecognizer(newVoice)
        
        let HistorynewVoice = UITapGestureRecognizer(target: self, action: #selector(HistoryVoiceMsgVC))
        historyVoiceMsgCheckBox.addGestureRecognizer(HistorynewVoice)
        
        
        
        print("is_read_enabled",is_read_enabled)
        print("is_write_enabled",is_write_enabled)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    
    func touchesBegan(_ touches: Set<AnyHashable>, withEvent event: UIEvent) {
        var touch: UITouch? = touches.first as! UITouch
        //location is relative to the current view
        // do something with the touched point
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyDataDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TvCellidentifer, for: indexPath) as!
        NextVoiceTableViewCell
        
        let historys : HistorySmsVoiceDataDetail = historyDataDetails[indexPath.row]
        
        cell.descriptionLbl.text = historys.description
        cell.dateTimeLbl.text = historys.timing
        
        print("historys.durationhistorys.duration",historys.duration)
        
        if historys.duration != nil{
            cell.durationLAbel.text = "00:00"+historys.duration
        }
        
        else{
            
            cell.durationLAbel.text = "00:00"
            
        }
        cell.audioFileURL = historys.voicefile
        
        
        let send  = sendHistryView(target: self, action: #selector(SendVc))
        send.voiceHeaderId = historys.headerid
        send.Title = historys.description
        cell.sendView.addGestureRecognizer(send)
        
        return cell
    }
    
    
    
    
    @IBAction func btn(_ sender: Any) {
        
        
        replyType = "0"
        if piroty == "p1" {
            
            
            
            
            
            
            let vc = SelectResipientsViewController(nibName: nil, bundle: nil)
            
            
            
            vc.resivre = Types
            
            vc.str = str
            
            vc.strName = strName
            
            vc.voiceUrl = url
            
            vc.discreptionss = voiceDisprectionLabl.text
            
            
            
            vc.voiceDuration = audioSeconds
            
            vc.voiceReplyType = replyType
            
            
            vc.VoiceHstryId = VoiceHstryID
            vc.voiceHstryHeaderId = VoiceHstryHeaderId
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.modalPresentationStyle = .fullScreen
            
            
            
            present(vc, animated: true,completion: nil)
            
            
            
            
        }
        
    
        else if piroty == "p2"   {
            
            
            
            
            selectRespinceView.backgroundColor = UIColor(named: "ConfirmColor")
            
            
            
            selectRespinceView.isUserInteractionEnabled = true
            
            
            
            
            
            let vc = HodSelectResipenceViewController(nibName: nil, bundle: nil)
            
            
            print("VoiceHstryIdVoiceHstryId",VoiceHstryHeaderId)
            vc.resivre = Types
            
            vc.str = str
            
            vc.strName = strName
            
            vc.voiceUrl = url
            
            vc.discreptionss = voiceDisprectionLabl.text
            
            
            vc.voiceDuration = audioSeconds
            
            vc.voiceReplyType = replyType
            
            print("")
            vc.VoiceHstryId = VoiceHstryID
            vc.voiceHstryHeaderId = VoiceHstryHeaderId
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            
            
            
            present(vc, animated: true,completion: nil)
            
            
            
        }
        
        
        
        
        
        
        else if piroty == "p7"   {
            
            
            
            
            selectRespinceView.backgroundColor = UIColor(named: "ConfirmColor")
            
            
            
            selectRespinceView.isUserInteractionEnabled = true
            
            
            
            
            
            let vc = GroupHeadViewController(nibName: nil, bundle: nil)
            
            
            //
            vc.resivre = Types
            
            vc.str = str
            
            vc.strName = strName
            
            vc.voiceUrl = url
            
            vc.discreptionss = voiceDisprectionLabl.text
            
            
            vc.voiceDuration = audioSeconds
            
            vc.voiceReplyType = replyType
            
            vc.VoiceHstryId = VoiceHstryID
            vc.voiceHstryHeaderId = VoiceHstryHeaderId
            
            
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.modalPresentationStyle = .fullScreen
            
            
            
            present(vc, animated: true,completion: nil)
            
            
            
        }
        
        
        
        
        
        else if piroty == "p3" {
            
            
            
            
            selectRespinceView.backgroundColor = UIColor(named: "ConfirmColor")
            
            
            
            selectRespinceView.isUserInteractionEnabled = true
            
            
            
            
            
            let vc = HodRespienViewController(nibName: nil, bundle: nil)
            
            
            
            vc.resivre = Types
            
            vc.str = str
            
            vc.strName = strName
            
            vc.voiceUrl = url
            
            vc.discreptionss = voiceDisprectionLabl.text
            
            
            
            vc.voiceDuration = audioSeconds
            
            vc.voiceReplyType = replyType
            
            vc.VoiceHstryId = VoiceHstryID
            vc.voiceHstryHeaderId = VoiceHstryHeaderId
            
            print("VoiceHstryIdVoiceHstryId",VoiceHstryHeaderId)
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            
            
            
            present(vc, animated: true,completion: nil)
            
            
            
            
            
            
            
            
            
            
            
        }
        
        
        
    }
    
    
    
    
    @IBAction func SendVc(ges : sendHistryView ){
        
        
        tv.isScrollEnabled = false
        
        
    
        VoiceHstryHeaderId = ges.voiceHeaderId
        
        player?.pause()
        
        btnName.setImage(UIImage(named: "plays"), for: .normal)
        
        
        
        
        
        
        
        if piroty == "p1" {
            
            
            
            
            
            
            let vc = SelectResipientsViewController(nibName: nil, bundle: nil)
            
            
            
            vc.resivre = Types
            
            vc.str = str
            
            vc.strName = strName
            
            vc.voiceUrl = url
            
            vc.discreptionss = voiceDisprectionLabl.text
            
            
            
            vc.voiceDuration = audioSeconds
            
            vc.voiceReplyType = replyType
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.VoiceHstryId = VoiceHstryID
            vc.voiceHstryHeaderId = VoiceHstryHeaderId
            
            vc.modalPresentationStyle = .fullScreen
            
            
            
            present(vc, animated: true,completion: nil)
            
            
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        else if piroty == "p2"   {
            
            
            
            
            selectRespinceView.backgroundColor = UIColor(named: "ConfirmColor")
            
            
            
            selectRespinceView.isUserInteractionEnabled = true
            
            
            
            
            
            let vc = HodSelectResipenceViewController(nibName: nil, bundle: nil)
            
            
            
            vc.resivre = Types
            
            vc.str = str
            
            vc.strName = strName
            
            vc.voiceUrl = url
            
            vc.discreptionss = voiceDisprectionLabl.text
            
            
            vc.voiceDuration = audioSeconds
            
            vc.voiceReplyType = replyType
            vc.VoiceHstryId = VoiceHstryID
            vc.voiceHstryHeaderId = VoiceHstryHeaderId
            
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.modalPresentationStyle = .fullScreen
            
            
            
            present(vc, animated: true,completion: nil)
            
            
            
        }
        
        
        
        
        
        
        else if piroty == "p7"   {
            
            
            
            
            selectRespinceView.backgroundColor = UIColor(named: "ConfirmColor")
            
            
            
            selectRespinceView.isUserInteractionEnabled = true
            
            
            
            
            
            let vc = GroupHeadViewController(nibName: nil, bundle: nil)
            
            
            //
            vc.resivre = Types
            
            vc.str = str
            
            vc.strName = strName
            
            vc.voiceUrl = url
            
            vc.discreptionss = voiceDisprectionLabl.text
            
            
            vc.voiceDuration = audioSeconds
            
            vc.voiceReplyType = replyType
            
            vc.VoiceHstryId = VoiceHstryID
            vc.voiceHstryHeaderId = VoiceHstryHeaderId
            
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            
            
            
            present(vc, animated: true,completion: nil)
            
            
            
        }
        
        
        
        
        
        else if piroty == "p3" {
            
            
            
            
            selectRespinceView.backgroundColor = UIColor(named: "ConfirmColor")
            
            
            
            selectRespinceView.isUserInteractionEnabled = true
            
            
            
            
            
            let vc = HodRespienViewController(nibName: nil, bundle: nil)
            
            
            
            vc.resivre = Types
            
            vc.str = str
            
            vc.strName = strName
            
            vc.voiceUrl = url
            
            vc.discreptionss = voiceDisprectionLabl.text
            
            
            
            vc.voiceDuration = audioSeconds
            
            vc.voiceReplyType = replyType
            
            vc.VoiceHstryId = VoiceHstryID
            vc.voiceHstryHeaderId = VoiceHstryHeaderId
            
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            
            vc.modalPresentationStyle = .fullScreen
            
            
            
            present(vc, animated: true,completion: nil)
            
            
            
            
            
            
            
            
            
            
            
            
            
            
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func HistoryApi(){
        
        let History = HistorySmsVoiceModal()
        
        
        History.priority = piroty
        History.userid = memberId
        History.appid = "1"
        
        
        let Historytr = History.toJSONString()
        
        
     
        HistoryVoiceReqs.call_request(param: Historytr!){ [self]
            
            (res) in
            
            
            
            let HistoryResp : HistorySmsVoiceResponce = Mapper<HistorySmsVoiceResponce>().map(JSONString: res)!
            
          
            
            if HistoryResp.Status == 1{
                historyDataDetails =  HistoryResp.data
                nodataLbl.isHidden = true
                tv.delegate = self
                tv.dataSource = self
                tv.reloadData()
            }
            else{
                
                nodataLbl.text = HistoryResp.Message
                nodataLbl.isHidden = false
                tv.delegate = self
                tv.dataSource = self
                tv.reloadData()
                
            }
            
        }
        
    }
    
    
    @IBAction func HistoryVoiceMsgVC(){
        VoiceHstryID = "2"
        
        if historyVoiceMsgCheckBox.isChecked == true{
            
            historyVoiceMsgCheckBox.isChecked = false
            
           
            newVoiceMsgCheckBox.isChecked = true
            print("offff")
            tv.isHidden = true
            
            contentView.isHidden = false
        }
        
        
        
        else{
            
            
            newVoiceMsgCheckBox.isChecked = false
            print("onnnnnn")
            tv.isHidden = false
            contentView.isHidden = true
           
           
            HistoryApi()
            
            
            
            historyVoiceMsgCheckBox.isChecked = true
        }
        
        
        
    }
    
    
    
    
    @IBAction func NewVoiceMsgVC(){
        
        VoiceHstryID = "1"
        if newVoiceMsgCheckBox.isChecked == true{
            
            newVoiceMsgCheckBox.isChecked = false
            
            
            historyVoiceMsgCheckBox.isChecked = true
            
            tv.isHidden = false
            contentView.isHidden = true
            
            print("offff")
        }
        
        
        else{
            
            tv.isHidden = true
            print("onnnnnn")
            contentView.isHidden = false
            
            historyVoiceMsgCheckBox.isChecked = false
            newVoiceMsgCheckBox.isChecked = true
        }
        
        
        
        
        
        
    }
    
    
    
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        
        
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
    
    
    
    @IBAction func switchIsChanged(mySwitch: UISwitch) {
        
        
        
        if replySwitch.isOn == true {
            
            replyType = "1"
            
            print("UISwitch is ON")
            
            
            
            pleaseDefaultLabel.isHidden = true
            
        }else{
            
            replyType = "0"
            
            print("UISwitch is OFF")
            
            pleaseDefaultLabel.isHidden = false
            
        }
        
    }
    
    
    
    
    
    
    @IBAction func CancelVc(){
        
        
        dismiss(animated: true)
        
    }
    
    
    
    
    @IBAction func TickMarkVC(){
        
        
        if  durationLable.text == "00:00" + " / " + "00:00"{
            
            
            let refreshAlert = UIAlertController(title: "", message: "Voice file is Empty ", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                
            }))
            
            
            
            present(refreshAlert, animated: true, completion: nil)
            
            
            
            selectRespinceView.backgroundColor = UIColor(named: "lineView")
            
            selectRespinceView.isUserInteractionEnabled = false
        }
        
        
        else{
            voiceSilderFullView.isHidden = false
            textViewss.isHidden = false
            lineView.isHidden = false
            pleaseDefaultLabel.isHidden = true
            durationLable.isHidden = false
            
            
            if timeLabelForPlayVoice == ""  || timeLabelForPlayVoice == nil {
                
                durationLable.text = "00:00" + " / " +  "00:00"
                
            }
            
            //
            else{
                
                
                durationLable.text = "00:00" + " / " + timeLabelForPlayVoice
                
                selectRespinceView.backgroundColor = UIColor(named: "ConfirmColor")
                
                selectRespinceView.isUserInteractionEnabled = true
            }
            
            
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        voiceDisprectionLabl.resignFirstResponder()
        return true
    }
    
    @IBAction func SelectRespienceVc(){
        
        
        player?.pause()
        
        btnName.setImage(UIImage(named: "plays"), for: .normal)
        
        
        
        
        
        
        if piroty == "p1" {
            
            
            
            
            if selectRespinceView.backgroundColor == .lightGray {
                
                selectRespinceView.isUserInteractionEnabled = false
                
                print("oooooooooo")
                
            }else{
                
                selectRespinceView.isUserInteractionEnabled = true
                
                print("Teacherrrrrr.")
                
                
                
                
                
                if  durationLable.text == "00:00" + " / " + "00:00"{
                    
                    
                    
                    
                }
                
                
                
                
                
                else if voiceDisprectionLabl.text == ""{
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: "Please enter title", preferredStyle: UIAlertController.Style.alert)
                    
                    
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                    }))
                    
                    
                    
                    
                    
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                    
                    
                }
                
                
                
                
                
                
                else if (url != nil)  {
                    
                    
                    
                    
                    
                    selectRespinceView.backgroundColor = UIColor(named: "ConfirmColor")
                    
                    
                    
                    selectRespinceView.isUserInteractionEnabled = true
                    
                    
                    
                    
                    
                    let vc = SelectResipientsViewController(nibName: nil, bundle: nil)
                    
                    
                    
                    vc.resivre = Types
                    
                    vc.str = str
                    
                    vc.strName = strName
                    
                    vc.voiceUrl = url
                    
                    vc.discreptionss = voiceDisprectionLabl.text
                    
                    
                    vc.is_read_enabled = is_read_enabled
                    vc.is_write_enabled = is_write_enabled
                    vc.voiceDuration = audioSeconds
                    
                    vc.voiceReplyType = replyType
                    
                    
                    vc.VoiceHstryId = VoiceHstryID
                    vc.voiceHstryHeaderId = VoiceHstryHeaderId
                    
                    vc.modalPresentationStyle = .fullScreen
                    
                    
                    
                    present(vc, animated: true,completion: nil)
                    
                    
                    
                    
                }
                
                
                
                
            }
            
            
        }
        
        
        
        
        
        
        else if piroty == "p2"   {
            
            
            if selectRespinceView.backgroundColor == .lightGray {
                
                selectRespinceView.isUserInteractionEnabled = false
                
                print("1234y")
                
            }else{
                
                selectRespinceView.isUserInteractionEnabled = true
                
                print("selectRespinceView.")
                
                
                
                
                
                if  durationLable.text == "00:00" + " / " + "00:00"{
                    
                    
                }
                
                
                
                
                else if voiceDisprectionLabl.text == ""{
                    
                    
                    
                    
                    
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: "Please enter title", preferredStyle: UIAlertController.Style.alert)
                    
                    
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                    }))
                    
                    
                    
                    
                    
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }
                
                
                else if (url != nil) {
                    
                    
                    
                    
                    
                    selectRespinceView.backgroundColor = UIColor(named: "ConfirmColor")
                    
                    
                    
                    selectRespinceView.isUserInteractionEnabled = true
                    
                    
                    
                    
                    
                    let vc = HodSelectResipenceViewController(nibName: nil, bundle: nil)
                    
                    
                    
                    vc.resivre = Types
                    
                    vc.str = str
                    
                    vc.strName = strName
                    
                    vc.voiceUrl = url
                    
                    vc.discreptionss = voiceDisprectionLabl.text
                    
                    
                    vc.voiceDuration = audioSeconds
                    
                    vc.voiceReplyType = replyType
                    
                    vc.is_read_enabled = is_read_enabled
                    vc.is_write_enabled = is_write_enabled
                    vc.VoiceHstryId = VoiceHstryID
                    vc.voiceHstryHeaderId = VoiceHstryHeaderId
                    
                    vc.modalPresentationStyle = .fullScreen
                    
                    
                    
                    present(vc, animated: true,completion: nil)
                    
                    
                    
                }
                
            }
            
            
        }
        
        
        else if piroty == "p7"   {
            
            
            if selectRespinceView.backgroundColor == .lightGray {
                
                selectRespinceView.isUserInteractionEnabled = false
                
                
                
            }else{
                
                selectRespinceView.isUserInteractionEnabled = true
                
                
                
                
                
                
                
                if  durationLable.text == "00:00" + " / " + "00:00"{
                    
                    
                }
                
                
                
                
                else if voiceDisprectionLabl.text == ""{
                    
                    
                    
                    
                    
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: "Please enter title", preferredStyle: UIAlertController.Style.alert)
                    
                    
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                    }))
                    
                    
                    
                    
                    
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }
                
                
                else if (url != nil) {
                    
                    
                    
                    
                    
                    selectRespinceView.backgroundColor = UIColor(named: "ConfirmColor")
                    
                    
                    
                    selectRespinceView.isUserInteractionEnabled = true
                    
                    
                    
                    
                    
                    let vc = GroupHeadViewController(nibName: nil, bundle: nil)
                    
                    
                    //                    
                    vc.resivre = Types
                    
                    vc.str = str
                    
                    vc.strName = strName
                    
                    vc.voiceUrl = url
                    
                    vc.discreptionss = voiceDisprectionLabl.text
                    
                    
                    vc.voiceDuration = audioSeconds
                    
                    vc.voiceReplyType = replyType
                    
                    //                    
                    vc.is_read_enabled = is_read_enabled
                    vc.is_write_enabled = is_write_enabled
                    
                    vc.VoiceHstryId = VoiceHstryID
                    vc.voiceHstryHeaderId = VoiceHstryHeaderId
                    vc.modalPresentationStyle = .fullScreen
                    
                    
                    
                    present(vc, animated: true,completion: nil)
                    
                    
                    
                }
                
            }
            
            
        }
        
        
        
        
        
        
        else if piroty == "p3" {
            
            
            
            
            if selectRespinceView.backgroundColor == .lightGray {
                
                selectRespinceView.isUserInteractionEnabled = false
                
                
            }else{
                
                selectRespinceView.isUserInteractionEnabled = true
                
                
                
                
                
                
                
                if  durationLable.text == "00:00" + " / " + "00:00"{
                    
                    
                }
                
                
                
                
                
                else if voiceDisprectionLabl.text == ""{
                    
                    
                    
                    
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: "Please enter title", preferredStyle: UIAlertController.Style.alert)
                    
                    
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                        
                        
                    }))
                    
                    
                    
                    
                    
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                    
                    
                }
                
                
                
                
                
                
                else if (url != nil)  {
                    
                    
                    
                    
                    
                    selectRespinceView.backgroundColor = UIColor(named: "ConfirmColor")
                    
                    
                    
                    selectRespinceView.isUserInteractionEnabled = true
                    
                    
                    
                    
                    
                    let vc = HodRespienViewController(nibName: nil, bundle: nil)
                    
                    
                    
                    vc.resivre = Types
                    
                    vc.str = str
                    
                    vc.strName = strName
                    
                    vc.voiceUrl = url
                    
                    vc.discreptionss = voiceDisprectionLabl.text
                    
                    
                    
                    vc.voiceDuration = audioSeconds
                    
                    vc.voiceReplyType = replyType
                    
                    vc.is_read_enabled = is_read_enabled
                    vc.is_write_enabled = is_write_enabled
                    vc.VoiceHstryId = VoiceHstryID
                    vc.voiceHstryHeaderId = VoiceHstryHeaderId
                    
                    vc.modalPresentationStyle = .fullScreen
                    
                    
                    
                    present(vc, animated: true,completion: nil)
                    
                    
                    
                    
                }
                
                
                
                
            }
            
            
        }
        
        
        
    }
    
    
    
    func addApi(){
        
        var add = AddApiModal()
        
        let defaults = UserDefaults.standard
        var deviceToken = defaults.string(forKey:DefaultsKeys.DeviceToken )
        add.device_token = deviceToken
        print("EventDefaultsKeys.DeviceToken",deviceToken)
        add.member_id = memberId
        add.mobile_no = MobileNumber
        add.priority = piroty
        add.college_id = colgId
        add.previous_add_id = previousAddId
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetAddsForCollege, httpMethod: .post, queryParam: nil, requestBody: add
        ) {[weak self] (result:Result<AddApiResponce,Error>) in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
                if success.Status == 1 {
                    addapiRef = success.data ?? []
                    
                    for i in addapiRef{
                      
                        bigImg.sd_setImage(with: URL(string: i.background_image ?? ""), placeholderImage: UIImage(named: "ic_white"))
                        
                        smallImg.sd_setImage(with: URL(string: i.add_image ?? ""), placeholderImage: UIImage(named: "ic_white"))
                        
                        let singleTap = adds(target: self, action: #selector(adLoad))
                        singleTap.url = i.add_url
                        bigImg.isUserInteractionEnabled = true
                        bigImg.addGestureRecognizer(singleTap)
                    }
                }
                
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    
    
    
    @IBAction func adLoad(gesture : SenderVoiceAdd) {
        
        
        let vc = SendercomuniAddViewController(nibName: nil, bundle: nil)
        vc.AddWebUrl = gesture.addUrls
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
        
        
    }
    
    
    
    
    func check_record_permission()
    {
        switch AVAudioSession.sharedInstance().recordPermission {
        case AVAudioSession.RecordPermission.granted:
            isAudioRecordingGranted = true
            break
        case AVAudioSession.RecordPermission.denied:
            isAudioRecordingGranted = false
            break
        case AVAudioSession.RecordPermission.undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission({ (allowed) in
                if allowed {
                    self.isAudioRecordingGranted = true
                } else {
                    self.isAudioRecordingGranted = false
                }
            })
            break
        default:
            break
        }
    }
    
    func startSlider() {
        Slider.value = 0
        Slider.maximumValue = 10
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] (timer) in
            print("Slider at: \(self?.Slider.value)")
            guard self?.Slider.isTracking == false else { return }
            self?.updateSlider(to: self!.Slider.value + 0.1)
        }
    }
    
    private func updateSlider(to value: Float) {
        Slider.value = value
    }
    
    
    @IBAction func recodeVc(){
        
        clickHereLabel.text = "Click here,Stop Recording"
        if(isRecording)
        {
            finishAudioRecording(success: true)
            
            RecodingImageView.image = UIImage(named: "voiceRecodeMic")
            
            isRecording = false
            if  durationLable.text == "00:00" + " / " + "00:00"{
                
                
                selectRespinceView.backgroundColor = UIColor(named: "lineView")
                
                
                selectRespinceView.isUserInteractionEnabled = false
                
                
                
            }
            
            
        }
        else
        {
            
            
            
            
            if isAudioRecordingGranted == false{
                //                check_record_permission()
                let alert = UIAlertController(title: "Error", message: "Please allow microphone usage from settings", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Open settings", style: .default, handler: { action in
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                present(alert, animated: true, completion: nil)
                
            }else{
                
                
                setup_recorder()
                
                audioRecorder.record()
                meterTimer = Timer.scheduledTimer(timeInterval: 0.1, target:self, selector:#selector(self.updateAudioMeter(timer:)), userInfo:nil, repeats:true)
                
                RecodingImageView.image = UIImage(named: "recodStopMic")
                isRecording = true
            }
            
            
            
            
        }
        
    }
    
    func getDocumentsDirectory() -> URL
    {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        
        
        
        print("asds",paths)
        
        
        
        return documentsDirectory
    }
    
    func getFileUrl() -> URL
    {
        let filename = "myRecording.mp4"
        
        let filePath = getDocumentsDirectory().appendingPathComponent(filename)
        
        print("filee",filePath)
        
        var myurl = filePath
        
        var urlString: String = myurl.absoluteString
        
        
        url = filePath
        
        
        durationLable.text = ""
        
        
        
        AudioPlayUrl = filePath.absoluteString
        
        
        
        let VoicePalyRecord = UITapGestureRecognizer(target: self, action: #selector(OrderplayAudio))
        
        PlayAudioView.addGestureRecognizer(VoicePalyRecord)
        
        
        
        return filePath
    }
    
    
    func setup_recorder()
    {
        if isAudioRecordingGranted
        {
            let session = AVAudioSession.sharedInstance()
            do
            {
                try session.setCategory(AVAudioSession.Category.playAndRecord, options: .defaultToSpeaker)
                try session.setActive(true)
                let settings = [
                    AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                    AVSampleRateKey: 44100,
                    AVNumberOfChannelsKey: 2,
                    AVEncoderAudioQualityKey:AVAudioQuality.high.rawValue
                ]
                audioRecorder = try AVAudioRecorder(url: getFileUrl(), settings: settings)
                audioRecorder.delegate = self
                audioRecorder.isMeteringEnabled = true
                audioRecorder.record(forDuration: 180.00)// record for 3 minutes
                
                audioRecorder.prepareToRecord()
            }
            catch let error {
                display_alert(msg_title: "Error", msg_desc: error.localizedDescription, action_title: "OK")
            }
        }
        else
        {
            display_alert(msg_title: "Error", msg_desc: "Don't have access to use your microphone.", action_title: "OK")
        }
        
    }
    
    
    
  
    
      
    
    func display_alert(msg_title : String , msg_desc : String ,action_title : String)
    {
        let ac = UIAlertController(title: msg_title, message: msg_desc, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: action_title, style: .default)
                     {
            (result : UIAlertAction) -> Void in
            _ = self.navigationController?.popViewController(animated: true)
        })
        present(ac, animated: true)
    }
    
    
    func finishAudioRecording(success: Bool)
    {
        if success
            
        {
            
            audioRecorder.stop()
            
            audioRecorder = nil
            
            meterTimer.invalidate()
            
            
            
            RecodingImageView.image = UIImage(named: "voiceRecodeMic")
            
            
            tickMarkView.isHidden = true
            
            
            
            if  durationLable.text == "00:00" + " / " + "00:00"{
                
                
                let refreshAlert = UIAlertController(title: "", message: "Voice file is Empty ", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                
                
                present(refreshAlert, animated: true, completion: nil)
                
                
                
                
                
                selectRespinceView.backgroundColor = UIColor(named: "lineView")
                
                
                selectRespinceView.isUserInteractionEnabled = false
            }
            
            
            else{
                voiceSilderFullView.isHidden = false
                textViewss.isHidden = false
                lineView.isHidden = false
                
                durationLable.isHidden = false
                
                
                if timeLabelForPlayVoice == ""  || timeLabelForPlayVoice == nil {
                    
                    durationLable.text = "00:00" + " / " +  "00:00"
                    
                }
                
                //
                else{
                    
                    
                    durationLable.text = "00:00" + " / " + timeLabelForPlayVoice
                    
                    selectRespinceView.backgroundColor = UIColor(named: "ConfirmColor")
                    
                    
                    selectRespinceView.isUserInteractionEnabled = true
                }
                
                
            }
            
            
            
            
            
            clearAudio.isHidden = false
            
            
        }
        
        else
        
        {
            
            display_alert(msg_title: "Error", msg_desc: "Recording failed.", action_title: "OK")
            
        }
    }
    
    
    func prepare_play()
    {
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: getFileUrl())
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
        }
        catch{
            print("Error")
        }
    }
    
    
    @objc func updateAudioMeter(timer: Timer)
    {
        if audioRecorder.isRecording
        {
            let hr = Int((audioRecorder.currentTime / 60) / 60)
            let min = Int(audioRecorder.currentTime / 60)
            let sec = Int(audioRecorder.currentTime.truncatingRemainder(dividingBy: 60))
            let totalTimeString = String(format: "%02d:%02d", min, sec)
            let time  = String(format: "%02d",sec)
            
            audioSeconds = time
            print("klllllllfedsaz",time,sec)
            
            timeLabelForPlayVoice = totalTimeString
            recodSecondsLabel.text = totalTimeString + " / " + "03:00"
            
            audioRecorder.updateMeters()
            
            
            
        }
    }
    
    
    
    
    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool)
    {
        if !flag
        {
            finishAudioRecording(success: false)
        }
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool)
    {
        
    }
    
    
    @IBAction func BackBtn(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    
    
    @IBAction func clearAudioVc(){
        
        
        clearAudio.isHidden = true
        
        clickHereLabel.text = "Click here,Start Recording"
        
        durationLable.text = ""
        
        recodSecondsLabel.text = "00:00" + " / " + "03:00"
        
        selectRespinceView.backgroundColor = .lightGray
        
        voiceSilderFullView.isHidden = true
        
        textViewss.isHidden = true
        
        lineView.isHidden = true
        
        
        durationLable.isHidden = true
        
        tickMarkView.isHidden = true
        
        
        
        
        
    }
    
    
    
    @IBAction func OrderplayAudio() {
        
        
        
        var urls = URL(string: AudioPlayUrl)
        
        playerItem = AVPlayerItem(url: urls!)
        player = AVPlayer(playerItem: playerItem!)
        
        if self.player!.currentItem?.status == .readyToPlay{
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying(sender:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: player!.currentItem)
        if(btnName.isSelected)
        {
            btnName.isSelected = false
            let seconds1 : Int64 = Int64(Slider.value)
            let targetTime : CMTime = CMTimeMake(value: seconds1, timescale: 1)
            
            player!.seek(to: targetTime)
            strPlayStatus = "play"
            player?.pause()
            
            btnName.setImage(UIImage(named: "plays"), for: .normal)
            
            
            
        }else{
            btnName.isSelected = true
            let seconds1 : Int64 = Int64(Slider.value)
            let targetTime : CMTime = CMTimeMake(value: seconds1, timescale: 1)
            player!.seek(to: targetTime)
            
            strPlayStatus = "play"
            player?.volume = 1
            player?.play()
            btnName.setImage(UIImage(named: "pauses"), for: .normal)
            
            print("enddddd")
        }
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateSlidersss), userInfo: nil, repeats: true)
        
        
    }
    
    
    
    
    
    
    
    @objc func updateSlidersss(){
        if self.player!.currentItem?.status == .readyToPlay {
            
            time = CMTimeGetSeconds(self.player!.currentTime())
        }
        let duration : CMTime = playerItem!.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        Slider.maximumValue = Float(seconds)
        Slider.minimumValue = 0.0
        Slider.value = Float(time)
        
        if(time > 0){
            let minutes = Int(time) / 60 % 60
            let secondss = Int(time) % 60
            
            let durationFormat = String(format:"%02i:%02i", minutes, secondss)
            durationLable.text = durationFormat + " / " + timeLabelForPlayVoice
        }
        if(time == seconds){
            timer.invalidate()
            btnName.isSelected = false
            Slider.value = 0.0
        }
    }
    func playbackSliderValueChanged(playbackSliders:UISlider){
        let seconds : Int64 = Int64(Slider.value)
        let targetTime : CMTime = CMTimeMake(value: seconds, timescale: 1)
        if(player != nil){
            player!.seek(to: targetTime)
        }else{
            Slider.value = playbackSliders.value
        }
    }
    
    
    @objc func playerDidFinishPlaying(sender: Notification) {
        timer.invalidate()
        Slider.value = 0.0
        player?.pause()
        btnName.isSelected = false
        playerItem?.seek(to: CMTime.zero)
        durationLable.text = "00:00" + " / " + timeLabelForPlayVoice
        btnName.setImage(UIImage(named: "plays"), for: .normal)
    }
    
    
    
    
    
    
    
    
    
    
    
    @objc func ordersFinishedPlaying( _ myNotification:NSNotification) {
        
        
        
        let selectedTime: CMTime = CMTimeMake(value: Int64(0 * 1000 as Float64), timescale: 1000)
        
        player?.seek(to: selectedTime)
        
        
        
        print("Player finished")
        
        
        
    }
    
    
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        
        
        
        let interval = Int(interval)
        
        
        
        let seconds = interval % 60
        
        
        
        let minutes = (interval / 60) % 60
        
        
        
        let hours = (interval / 3600)
        
        
        
        return String(format: "%02d:%02d", minutes, seconds)
        
        
        
    }
    
    
    
    @objc func playbackSliderValueChanged(_ playbackSlider:UISlider) {
        
        
        
        let seconds : Int64 = Int64(playbackSlider.value)
        
        
        
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        
        
        
        player!.seek(to: targetTime)
        
        
        
        if player!.rate == 0 {
            
            
            
            player?.play()
            
            
            
        }
        
        
        
        
        
    }
    
    
    
    
    
    @objc func finishedPlaying( _ myNotification:NSNotification) {
        
    }
    
    
    
    
    
    
    
    
    @IBAction func backbtn(_ sender: Any) {
        
        
        dismiss(animated: true)
    }
    
    
    
    
    
    
    
    // Tab Bar Nagivation
    
    
    
    @IBAction func helpRedirect() {
        
        let vc = HelpViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func termsAndCondition() {
        
        let vc = MenuTermsViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func logoutPressed() {
        
        
        
        
        let refreshAlert = UIAlertController(title: "", message: "Are you sure do you want to logout", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (action: UIAlertAction!) in
            
            
            UserDefaults.standard.removeObject(forKey: DefaultsKeys.mobileNumber)
            
            let vc = LoginNewViewController(nibName: nil, bundle: nil)
            vc.modalPresentationStyle = .fullScreen
            
            self.present(vc, animated: true, completion: nil)
            
            
        }))
        
        
        refreshAlert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func faqRedirect() {
        print("faqRedirect")
        let vc = FaqViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func privacyPolicyRedirect() {
        
        let vc = PrivacyPolicyViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
        
    }
    
    
    
    
    
    @IBAction func refreshVc() {
        
        print("refreshVcWork")
        KRProgressHUD.show()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
          
            
            KRProgressHUD.dismiss()
            
        }
        
        
    }
    
    
    @IBAction func notificationVc() {
        print("NotificationViewController")
        let vc = NotificationViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: false, completion: nil)
        
        
        
    }
    
    
    
    
    @IBAction func menu() {
        
        if sideMenuView.isHidden == true{
            
            sideMenuView.isHidden = false
            //
            
            print("menuVisble")
        }
        
        else{
            
            sideMenuView.isHidden = true
           
            print("mddffenuVisble")
        }
        
        
    }
    
    
    @IBAction func changePassowrdVC(){
        
        let vc = ChangePasswordViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
        
       
    }
    
    

    @IBAction func priorityVc() {
        
        let vc = PriorityViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
}



class SenderVoiceAdd : UITapGestureRecognizer{
    
    
    var addUrls : String!
    
    
}

class sendHistryView : UITapGestureRecognizer{
    
    
    var voiceHeaderId : String!
    var Title : String!
    
}











