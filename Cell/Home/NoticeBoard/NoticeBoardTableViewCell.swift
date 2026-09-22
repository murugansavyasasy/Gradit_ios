//
//  NoticeBoardTableViewCell.swift
//  Vs_GradIt
//
//  Created by APPLE on 26/09/22.
//

import UIKit
import ObjectMapper

@available(iOS 16.0, *)
class NoticeBoardTableViewCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var noticeView: UIViewX!
    @IBOutlet weak var sideIndicater: UILabel!
    @IBOutlet weak var cv: UICollectionView!
    
    var dashtypes : String!
    var colgId : String!
    var memberId : String!
    var loginAsType : String!
    var priority : String!
    var str : [String] = []
    var strName : [String] = []
    var is_read_enabled = ""
    var is_write_enabled = ""
    var currentIndex = 0
    var autoScrollTimer: Timer?
    var noticeBoardData : [NoticeBoardDashType] = []
    var dash : [DashBoardData] = []
    let cvIdentifier = "NoticeBoardScrollCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sideIndicater.clipsToBounds = true
        sideIndicater.layer.cornerRadius = sideIndicater.frame.width/2
        noticeView.layer.borderColor = UIColor.tintColor.withAlphaComponent(0.13).cgColor
        noticeView.layer.borderWidth = 1
        cv.dataSource = self
        cv.delegate = self
        let defaults = UserDefaults.standard
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        loginAsType = defaults.string(forKey: DefaultsKeys.loginAsType)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        let cvRowib = UINib(nibName: cvIdentifier, bundle: nil)
        cv.register(cvRowib, forCellWithReuseIdentifier: cvIdentifier)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return noticeBoardData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cvIdentifier, for: indexPath) as! NoticeBoardScrollCollectionViewCell
        
        
        let notice :  NoticeBoardDashType =  noticeBoardData[indexPath.row]
        cell.headingLbl.text = notice.topicheading
        cell.descLbl.text = notice.topicbody
        cell.dateLbl.text = notice.createddate?.dateFormater()
        cell.timeLbl.text = notice.createdtime?.dateFormater(input: "hh:mm:ss a",output: "hh:mm a")
        
        
        if (indexPath.row % 2 == 0){
            UIGraphicsBeginImageContext(cell.noteImageView.frame.size)
            if let image = UIGraphicsGetImageFromCurrentImageContext(){
                UIGraphicsEndImageContext()
                cell.noteImageView.image = UIImage(named: "noticeboard_blue")
            }else{
                UIGraphicsEndImageContext()
                debugPrint("Image not available")
            }
            
        }else{
            UIGraphicsBeginImageContext(cell.noteImageView.frame.size)
            UIImage(named: "noticeboard_yellow")?.draw(in: cell.noteImageView.bounds)
            
            if let image = UIGraphicsGetImageFromCurrentImageContext(){
                UIGraphicsEndImageContext()
                cell.noteImageView.image = UIImage(named: "noticeboard_yellow")
            }else{
                UIGraphicsEndImageContext()
                debugPrint("Image not available")
            }
            
        }
        
        
        let cellView = UITapGestureRecognizer(target: self, action: #selector(CellVc))
        cell.noticeCvFullv.addGestureRecognizer(cellView)
        
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
    
    
    
    
    
    
    @IBAction func CellVc(){
        
        if priority == "p4" {
            let vc =  NoticeBoardHomePageViewController(nibName: nil, bundle: nil)
            let currentController = self.getViewController()
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: true,completion: nil)
            
        }else if priority == "p1" {
            
            let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            let currentController = self.getViewController()
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.noticeSegments.backgroundColor = UIColor(named: "UnSelector")
            vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "Selector")
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: true,completion: nil)
        }else if priority == "p2" || priority == "p3" {
            
            let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
           
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            let currentController = self.getViewController()
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
            vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: true,completion: nil)
            
        }else if priority == "p6"  {
            
            let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
           
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            let currentController = self.getViewController()
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
            vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: true,completion: nil)
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 195, height: 289)
    }
    
    
    
    
    
    
    
    
}
