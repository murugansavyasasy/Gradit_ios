    //
    //  RecentNotificationTableViewCell.swift
    //  Vs_GradIt
    //
    //  Created by APPLE on 26/09/22.
    //

    import UIKit
    import ObjectMapper
    import AVFoundation
    import KRProgressHUD



    class RecentNotificationTableViewCell: UITableViewCell,UITableViewDelegate,UITableViewDataSource  {



    @IBOutlet weak var ViewClick: UIViewX!



    @IBOutlet weak var tv: UITableView!


    let MultipleRecentNotificationtIdentifier = "RecentTableViewCell"

    var selectedCell : IndexPath?

    var colgId : String!
    var memberId : String!
    var loginAsType : String!
    var priority : String!
    var RecentDatas : [RecentNotificationsDashType] = []
    var dashBoardDataList : [DashBoardData] = []



    var type : String!


    var player:AVPlayer?
    var players: AVAudioPlayer?
    var playerItem:AVPlayerItem?
    fileprivate let seekDuration: Float64 = 10
    var audioPlayer: AVAudioPlayer?

    var imagess : UIImageView!
    override func awakeFromNib() {
    super.awakeFromNib()



    let defaults = UserDefaults.standard
    colgId = defaults.string(forKey: DefaultsKeys.collegeid)
    memberId = defaults.string(forKey: DefaultsKeys.memberid)
    loginAsType = defaults.string(forKey: DefaultsKeys.loginAsType)
    priority = defaults.string(forKey: DefaultsKeys.priority)

    //        recentNotic()


    tv.dataSource  = self
    tv.delegate = self

    let cvRowib = UINib(nibName: MultipleRecentNotificationtIdentifier, bundle: nil)
    tv.register(cvRowib, forCellReuseIdentifier: MultipleRecentNotificationtIdentifier)





    }

    override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)


    }



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return RecentDatas.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


    let cell = tableView.dequeueReusableCell(withIdentifier: MultipleRecentNotificationtIdentifier, for: indexPath)as!
    RecentTableViewCell


    cell.selectionStyle = .none
    let recentNoti : RecentNotificationsDashType = RecentDatas[indexPath.row]

    //        cell.secodsLabel.text = "00:00"
    cell.durationLAbel.text = "00:00"


    let dateFormatterGet = DateFormatter()

    dateFormatterGet.dateFormat = "dd-MM-yyy"



    let dateFormatterPrint = DateFormatter()

    dateFormatterPrint.dateFormat = " dd MMM,yyyy"



        let date: NSDate? = dateFormatterGet.date(from: recentNoti.createdondate ?? "") as NSDate?

    if let selectedCell = selectedCell, selectedCell == indexPath {
    cell.discreptionLbl.isHidden = false
    cell.playView.isHidden = false
    cell.sendDefltLbl.isHidden = false
    cell.sendBy.isHidden = false
    cell.playbuttonView.isHidden = true
    cell.arrowimageview.isHidden = true

    print("on")
    }

    else{
    cell.discreptionLbl.isHidden = true
    cell.playView.isHidden = true
    cell.sendDefltLbl.isHidden = true
    cell.sendBy.isHidden = true
    cell.playbuttonView.isHidden = false
    cell.arrowimageview.isHidden = false
    }


    if recentNoti.typ == "Voice"{


    print("recentNotirecentNoti",recentNoti.duration)
    cell.discreptionLbl.isHidden = true
    cell.topImageView.image = UIImage(named: "dashboard_recent_voice")

    cell.audioURL = recentNoti.content

    cell.date.text = dateFormatterPrint.string(from: date as! Date)
    var dateString2 = recentNoti.createdontime
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "hh:mm:ss a"
    dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")

    let dateObj = dateFormatter.date(from: dateString2!)
    dateFormatter.dateFormat = "hh:mm a"

        let a  = (recentNoti.sentbyname?.count ?? 0)*2

    var b = a+180

    cell.sendViewWidth.constant = CGFloat(b)

    cell.timesLabel.text = (dateFormatter.string(from: dateObj!))
    cell.sendBy.text = recentNoti.sentbyname
    cell.topic.text = recentNoti.description
    cell.sendbyTop.constant = 5
    cell.playFulViewTop.constant = -20


    if recentNoti.duration == nil{



    }

    else{
    let x = String(recentNoti.duration ?? "")

    cell.secodsLabel.text = "00:0"+x

    }

    }

    else{


    cell.playbuttonView.isHidden = true
    cell.playView.isHidden = true
    cell.topImageView.image = UIImage(named: "dashboard_text")
    cell.date.text = dateFormatterPrint.string(from: date as! Date)

    var dateString2 = recentNoti.createdontime
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "hh:mm:ss a"
    dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")

    let dateObj = dateFormatter.date(from: dateString2!)
    dateFormatter.dateFormat = "hh:mm a"

        let a  = (recentNoti.sentbyname?.count ?? 0)*2

    var b = a+180

    cell.sendViewWidth.constant = CGFloat(b)
    cell.timesLabel.text = (dateFormatter.string(from: dateObj!))
    cell.sendBy.text = recentNoti.sentbyname
    cell.topic.text = recentNoti.content
    cell.sendbyTop.constant = -10

    cell.playFulViewTop.constant = -20
    cell.discreptionLbl.text = recentNoti.description


    }




    return cell


    }






    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {




    if let selectedCells = selectedCell, selectedCells == indexPath {

    selectedCell = nil


    }

    else{

    selectedCell = indexPath

    }



    tv.beginUpdates()
    tv.endUpdates()
    tv.reloadData()


    }








    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

    if let selectedCell = selectedCell, selectedCell == indexPath {

    return 180

    } else {

    return 120

    }
    }
    }
    class RecentPlayGesture : UITapGestureRecognizer {



    var voicePath : String!

    var orderid : String!

    var sliders : UISlider!

    var timeLbl : UILabel!

    var seconds : UILabel!

    var img : UIImageView!

    }
