//
//  EventsTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by APPLE on 01/11/22.
//

import UIKit
import ObjectMapper

@available(iOS 16.0, *)
class EventsTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
   
    
    @IBOutlet weak var leftBorder: UILabel!
    @IBOutlet weak var EventViewClick: UIViewX!
    @IBOutlet weak var cv: UICollectionView!
    
    var identifier = "EventsCollectionViewCell"
    var dashBoardDataList : [DashBoardData] = []
    var EventData : [UpcomingEventsDashType] = []
    var dashtype : String!
    var colgId : String!
    var memberId : String!
    var loginAsType : String!
    var priority : String!
    var str : [String] = []
    var strName : [String] = []
    var is_read_enabled = ""
    var is_write_enabled = ""
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        EventViewClick.borderColor = .tintColor.withAlphaComponent(0.13)
        EventViewClick.borderWidth = 1
        leftBorder.clipsToBounds = true
        leftBorder.layer.cornerRadius = leftBorder.frame.width/2
        let defaults = UserDefaults.standard
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        loginAsType = defaults.string(forKey: DefaultsKeys.loginAsType)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        
        cv.dataSource  = self
        cv.delegate = self
        
        let cvRowib = UINib(nibName: identifier, bundle: nil)
        cv.register(cvRowib, forCellWithReuseIdentifier: identifier)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("printCounts",EventData.count)
        return EventData.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as!
        
        EventsCollectionViewCell
       
        let circular : UpcomingEventsDashType = EventData[indexPath.row]
        cell.dateLabel.text = circular.eventdate?.dateFormater()
        cell.timeLabel.text = circular.eventtime?.dateFormater(input: "HH:mm:ss",output: "hh:mm a")
        cell.eventTopic.text = circular.eventtopic
        
        
        if (indexPath.row % 2 == 0){
            cell.fullView.backgroundColor = UIColor(red: 184/255, green: 242/255, blue: 200/255, alpha: 0.10)
        }else{
            cell.fullView.backgroundColor = UIColor(red: 184/255, green: 242/255, blue: 200/255, alpha: 0.10)
        }
        
        let  viewClick = UITapGestureRecognizer(target: self, action: #selector(EventViewVc))
        cell.fullView.addGestureRecognizer(viewClick)
        
        return cell
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
    
    
    @IBAction func EventViewVc(){
        
        if priority == "p4" {
            let vc =  EventsViewController(nibName: nil, bundle: nil)
            let currentController = self.getViewController()
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: true, completion: nil)
            
        }else if priority == "p1" {
            
            let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
            let currentController = self.getViewController()
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.eventSegmentName.backgroundColor = UIColor(named: "UnSelector")
            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: true, completion: nil)
            
        }else if priority == "p3" ||  priority == "p2"  {
            
            let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
            let currentController = self.getViewController()
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: true, completion: nil)
        }else if priority == "p5"{
            let vc =  EventsViewController(nibName: nil, bundle: nil)
            let currentController = self.getViewController()
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.eventSegmentName.backgroundColor = UIColor(named: "FatherUnselector")
            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
            vc.view.backgroundColor = UIColor(named: "FatherColor" )
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: true, completion: nil)
        } else if priority == "p6"{
            let vc =  SenderEventHomePageViewController(nibName: nil, bundle: nil)
            let currentController = self.getViewController()
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.eventSegmentName.backgroundColor = UIColor(named: "CellColor")
            vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "attendanceColor")
            vc.view.backgroundColor = UIColor(named: "attendanceColor" )
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: true, completion: nil)
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 258, height: 130)
    }
    
}
