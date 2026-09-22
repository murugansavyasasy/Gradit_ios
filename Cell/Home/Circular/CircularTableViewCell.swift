//
//  CircularTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by APPLE on 31/10/22.
//

import UIKit
import ObjectMapper

@available(iOS 16.0, *)
class CircularTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var sideIndicater: UILabel!
    @IBOutlet weak var pageContorler: UIPageControl!
    @IBOutlet weak var circularView: UIViewX!
    @IBOutlet weak var cv: UICollectionView!
    
    
    var identifier = "CircularCollectionViewCell"
    weak var parent:ViewController?
    var dashBoardDataList : [DashBoardData] = []
    var circularData : [CircularDashType] = []
    var dashtype : String!
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
    override func awakeFromNib() {
        super.awakeFromNib()
        circularView.layer.borderColor = UIColor.tintColor.withAlphaComponent(0.13).cgColor
        circularView.layer.borderWidth = 1
        let defaults = UserDefaults.standard
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        loginAsType = defaults.string(forKey: DefaultsKeys.loginAsType)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        
        sideIndicater.clipsToBounds = true
        sideIndicater.layer.cornerRadius = sideIndicater.frame.width/2
        cv.dataSource  = self
        cv.delegate = self
        let cvRowib = UINib(nibName: identifier, bundle: nil)
        cv.register(cvRowib, forCellWithReuseIdentifier: identifier)
        
        startAutoScroll()
        pageContorler.currentPageIndicatorTintColor = .priorityColor
        
        NotificationCenter.default.addObserver(self, selector: #selector(stopAutoScroll), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(stopAutoScroll), name: UIApplication.willEnterForegroundNotification, object: nil)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    
    func startAutoScroll() {
        autoScrollTimer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    @objc func autoScroll() {
        if !circularData.isEmpty {
            let nextIndex = (currentIndex + 1) % circularData.count
            let nextIndexPath = IndexPath(item: nextIndex, section: 0)
            cv.scrollToItem(at: nextIndexPath, at: .right, animated: true)
            currentIndex = nextIndex
            
            pageContorler.currentPage = currentIndex
        }
        
    }
    
    @objc func stopAutoScroll() {
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("printCounts",circularData.count)
        pageContorler.numberOfPages = circularData.count
        return circularData.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as!
        
        CircularCollectionViewCell
        
        cell.parent = parent
        let circular : CircularDashType = circularData[indexPath.row]
        cell.creatDate.text = circular.createddate?.dateFormater()
        cell.createTime.text = circular.createddate?.dateFormater(input: "hh:mm:ss a",output:"hh:mm a")
        cell.discreption.text = circular.description
        cell.title.text = circular.title
        cell.CircularFullView.backgroundColor = UIColor(red: 190/255, green: 174/255, blue: 255/255, alpha: 0.23)
        let  play = Attchment(target: self, action: #selector(attachmentVc))
        for i in circular.filepaths ?? [] {
            play.img_url =  i
        }
        
        
        cell.attachementView.addGestureRecognizer(play)
        
        
        let  viewClick = UITapGestureRecognizer(target: self, action: #selector(viewClickVc))
        cell.CircularFullView.addGestureRecognizer(viewClick)
        
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
    
    
    
    @IBAction func viewClickVc(){
        
        if priority == "p4" {
            let vc =  ImageViewController (nibName: nil, bundle: nil)
            let currentController = self.getViewController()
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: true,completion: nil)
            
        }else if priority == "p1" {
            
            let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
            let currentController = self.getViewController()
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.imageSegmentName.backgroundColor = UIColor(named: "UnSelector")
            vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: true,completion: nil)
            
            
        }else if priority == "p2" || priority == "p3" {
            
            let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
            let currentController = self.getViewController()
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: true,completion: nil)
            
        }else if priority == "p6"  {
            
            let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
            
            let currentController = self.getViewController()
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: true,completion: nil)
            
        }
        
        
    }
    
    
    
    
    
    @IBAction func attachmentVc( gesture : Attchment){
        let currentController = self.getViewController()
        let vc =  DashBordShwViewController (nibName: nil, bundle: nil)
        vc.imgfilePath = gesture.img_url
        vc.modalPresentationStyle = .fullScreen
        currentController?.present(vc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 278, height: 180)
    }
    
}

class Attchment : UITapGestureRecognizer {
    var img_url : String!
}
