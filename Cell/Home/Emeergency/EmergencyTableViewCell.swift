    //
    //  EmergencyTableViewCell.swift
    //  Vs_GradIt
    //
    //  Created by APPLE on 26/09/22.
    //

    import UIKit
    import ObjectMapper
    import AVFoundation
    import AVKit
    import KRProgressHUD

    @available(iOS 16.0, *)
    class EmergencyTableViewCell:UITableViewCell,UITableViewDelegate,UITableViewDataSource,AVAudioPlayerDelegate {






    @IBOutlet weak var Cv: UICollectionView!


    @IBOutlet weak var ClickView: UIViewX!


    @IBOutlet weak var tv: UITableView!


    var identifier = "EmerTableViewCell"

    var  emrgencyRef : [EmergencyDashTypes] = []
    var dash : [DashBoardData] = []
    var selectedCell : IndexPath?


    var player:AVPlayer?
    var players: AVAudioPlayer?
    var playerItem:AVPlayerItem?
    fileprivate let seekDuration: Float64 = 10
    var audioPlayer: AVAudioPlayer?


    fileprivate var countPlayer: AVPlayer?  // plays the count number of song

    var myArray: [String] = [ ]
    var UnReadvoiceMsgUrl : String!
    var dashtypes : String!

    var srr : [String] = []

    var yourArray = [String]()

    var colgId : String!
    var memberId : String!
    var loginAsType : String!
    var priority : String!

    var slid : UISlider!

    var times : UILabel!

    var imges : UIImageView!


    var str : [String] = []

    var strName : [String] = []
    var is_read_enabled = ""
    var is_write_enabled = ""
    var helo = HomeScreenViewController()


    var expandType = "0"


    var call_back: ((String) -> Void)?




    override func awakeFromNib() {
    super.awakeFromNib()





    let defaults = UserDefaults.standard
    colgId = defaults.string(forKey: DefaultsKeys.collegeid)
    memberId = defaults.string(forKey: DefaultsKeys.memberid)
    loginAsType = defaults.string(forKey: DefaultsKeys.loginAsType)
    priority = defaults.string(forKey: DefaultsKeys.priority)



    let cvRowib = UINib(nibName: identifier, bundle: nil)
    tv.register(cvRowib, forCellReuseIdentifier: identifier)


    let clickviews = UITapGestureRecognizer(target:self, action: #selector(viewClickVC))

    ClickView.addGestureRecognizer(clickviews)



    tv.dataSource  = self
    tv.delegate = self


    }

    override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)


    }




    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("emrgencyRef.count",emrgencyRef.count)

    return emrgencyRef.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {






    let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as!

    EmerTableViewCell


    cell.selectionStyle = .none


    if let selectedCell = selectedCell, selectedCell == indexPath {

    cell.playFullView.isHidden = false
    cell.BottomView.isHidden = false


    expandType = "1"

    call_back?(expandType)
    print("EXPAND")


    }

    else{
    cell.player?.pause()

    expandType = "0"

    call_back?(expandType)
    cell.btnName.setImage(UIImage(named: "plays"), for: .normal)
    cell.playFullView.isHidden = true
    cell.BottomView.isHidden = true
    }


    let emer : EmergencyDashTypes = emrgencyRef[indexPath.row]


    let fullNameArr = emer.createdon.components(separatedBy: " ")

    let name    = fullNameArr[0]
    let x = String(emer.duration)

    cell.seconds.text = "00:0"+x

    print("namename",name)

    let dateFormatterGet = DateFormatter()

    dateFormatterGet.dateFormat = "dd-MM-yyy"



    let dateFormatterPrint = DateFormatter()

    dateFormatterPrint.dateFormat = " dd MMM,yyyy"



    let date: NSDate? = dateFormatterGet.date(from: name) as NSDate?

    print(dateFormatterPrint.string(from: date as! Date))


    cell.discreptionLabel.text = emer.description
    cell.dateAndTimeLabel.text =  emer.createdon
    cell.createonByLabel.text = emer.membername

    cell.audioFileURL = emer.voicefilepath


    return cell
    }







    @IBAction func OrderplayAudio(gesture : PlayGesture) {




    let url = URL(string: gesture.voicePath)

    print("filePathUrl",url)



    let playerItem:AVPlayerItem = AVPlayerItem(url: url!)



    player = AVPlayer(playerItem: playerItem)

    gesture.sliders.minimumValue = 0

    let duration : CMTime = playerItem.asset.duration

    let seconds : Float64 = CMTimeGetSeconds(duration)





    let currentDuration : CMTime = playerItem.currentTime()



    let currentSeconds : Float64 = CMTimeGetSeconds(currentDuration)



    gesture.timeLbl.text = self.stringFromTimeInterval(interval: currentSeconds)



    gesture.sliders.maximumValue = Float(seconds)

    gesture.sliders.isContinuous = true

    gesture.sliders.addTarget(self, action: #selector(self.playbackSliderValueChanged(_:)), for: .valueChanged)





    NotificationCenter.default.addObserver(self, selector: #selector(self.ordersFinishedPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)





    player!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (CMTime) -> Void in



    if self.player!.currentItem?.status == .readyToPlay {



    let time : Float64 = CMTimeGetSeconds(self.player!.currentTime());



    gesture.sliders.value = Float ( time );



    gesture.timeLbl.text = self.stringFromTimeInterval(interval: time)



    }



    let playbackLikelyToKeepUp = self.player?.currentItem?.isPlaybackLikelyToKeepUp



    if playbackLikelyToKeepUp == false{

    print("buffering")

    }



    else {


    KRProgressHUD.dismiss()
    print("Buffering completed")

    }

    }





    //
    if player?.rate == 0



    {

    print("on")

    player!.play()

    gesture.img.image = UIImage(named: "pauses")


    }
    else {


    print("off")


    player!.pause()



    gesture.img.image = UIImage(named: "plays")
    //
    //
    //
    }





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



    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {




    if let selectedCells = selectedCell, selectedCells == indexPath {

    selectedCell = nil


    }

    else{

    selectedCell = indexPath

    }



    tv.beginUpdates()
    tv.reloadData()
    tv.endUpdates()



    }








    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

    if let selectedCell = selectedCell, selectedCell == indexPath {

    return UITableView.automaticDimension


    } else {

    return 100

    }
    }
    //



















    func emergncy(){

    print("notidee")
    let noti = DashBoardModal()

    noti.collegeid = colgId
    noti.userid = memberId
    noti.priority = priority

    let dashBoardStr = noti.toJSONString()


    DashBoardRequest.call_request(param: dashBoardStr!) {
    [self]
    (res) in




    let dashBoardResponse : DashBoardResponse = Mapper<DashBoardResponse>().map(JSONString: res)!


    dash = dashBoardResponse.data
    for i in dash{

    dashtypes = i.dashType


    if i.dashType == "Emergency Notification" {

    emrgencyRef = i.emerSubData




    }

    tv.delegate = self
    tv.dataSource = self
    tv.reloadData()

    }





    }




    }

    func getViewController() -> UIViewController? {

    if let rootController = UIApplication.shared.keyWindow?.rootViewController {
    var currentController: UIViewController! = rootController
    while( currentController.presentedViewController != nil ) {
    currentController = currentController.presentedViewController
    }
    return currentController
    }
    return nil

    }




    @IBAction func viewClickVC (){

    if priority == "p4" {
    let vc =  CommunicationHomePageViewController(nibName: nil, bundle: nil)
    let currentController = self.getViewController()
    vc.str = str
    vc.strName = strName
    vc.is_read_enabled = is_read_enabled
    vc.is_write_enabled = is_write_enabled

    vc.modalPresentationStyle = .fullScreen
    currentController?.present(vc, animated: true,completion: nil)

    }

    else if priority == "p1"{

    let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)

    vc.view.backgroundColor = UIColor(named: "Principal" )
    vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
    vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
    vc.str = str
    vc.is_read_enabled = is_read_enabled
    vc.is_write_enabled = is_write_enabled

    vc.strName = strName
    let currentController = self.getViewController()
    vc.modalPresentationStyle = .fullScreen
    currentController?.present(vc, animated: true,completion: nil)

    }


    else if priority == "p2" || priority == "p3" || priority == "p6" {

    let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
    vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
    vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
    vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
    vc.str = str
    vc.strName = strName
    vc.is_read_enabled = is_read_enabled
    vc.is_write_enabled = is_write_enabled

    let currentController = self.getViewController()
    vc.modalPresentationStyle = .fullScreen
    currentController?.present(vc, animated: true,completion: nil)

    }






    }






    }
    class PlayGesture : UITapGestureRecognizer {



    var voicePath : String!

    var orderid : String!

    var sliders : UISlider!

    var timeLbl : UILabel!

    var img : UIImageView!

    }
