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
    
    @IBOutlet weak var sideIndicater: UILabel!
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
        ViewClick.layer.borderColor = UIColor.tintColor.withAlphaComponent(0.13).cgColor
        ViewClick.layer.borderWidth = 1
        let defaults = UserDefaults.standard
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        loginAsType = defaults.string(forKey: DefaultsKeys.loginAsType)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        tv.dataSource  = self
        tv.delegate = self
        sideIndicater.clipsToBounds = true
        sideIndicater.layer.cornerRadius = sideIndicater.frame.width/2
        let cvRowib = UINib(nibName: MultipleRecentNotificationtIdentifier, bundle: nil)
        tv.register(cvRowib, forCellReuseIdentifier: MultipleRecentNotificationtIdentifier)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RecentDatas.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MultipleRecentNotificationtIdentifier, for: indexPath)as!
        RecentTableViewCell
        
        cell.selectionStyle = .none
        let recentNoti : RecentNotificationsDashType = RecentDatas[indexPath.row]
        cell.hideShow(show: selectedCell == indexPath, type:recentNoti.typ ?? "")
        if recentNoti.typ == "Voice"{
            cell.discreptionLbl.isHidden = true
            cell.topImageView.image = UIImage(named: "dashboard_recent_voice")
            cell.audioURL = recentNoti.content
            cell.date.text = recentNoti.createdondate?.dateFormater()
            cell.timesLabel.text = recentNoti.createdontime?.dateFormater(input: "hh:mm:ss a",output: "hh:mm a")
            cell.sendBy.text = recentNoti.sentbyname
            cell.topic.text = recentNoti.description
            cell.durationLAbel.text = Int(recentNoti.duration ?? "0")?.durationFormat()
        }else{
            cell.playbuttonView.isHidden = true
            cell.playView.isHidden = true
            cell.topImageView.image = UIImage(named: "dashboard_text")
            cell.date.text = recentNoti.createdondate?.dateFormater()
            cell.timesLabel.text =  recentNoti.createdontime?.dateFormater(input: "hh:mm:ss a",output: "hh:mm a")
            cell.sendBy.text = recentNoti.sentbyname
            cell.topic.text = recentNoti.content
            cell.discreptionLbl.text = recentNoti.description
            
            
        }
        return cell
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedCells = selectedCell, selectedCells == indexPath {
            selectedCell = nil
        }else{
            selectedCell = indexPath
        }
        
        tv.beginUpdates()
        tv.endUpdates()
        tv.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
