//
//  AssignmentTableviewCel.swift
//  Vs_GradItCollege
//
//  Created by APPLE on 02/11/22.
//

import UIKit
import ObjectMapper

@available(iOS 16.0, *)
class AssignmentTableviewCel: UITableViewCell, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    @IBOutlet weak var pageContorler: UIPageControl!
    @IBOutlet weak var viewAll: UIViewX!
    @IBOutlet weak var cv: UICollectionView!
    
    let cvIdentifier = "AssignmentCollectionViewCell"
    var assignmentDatas : [AssignmentsDashType] = []
    var dashBoardDataList : [DashBoardData] = []
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
    var pageCount : Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let defaults = UserDefaults.standard
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        loginAsType = defaults.string(forKey: DefaultsKeys.loginAsType)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        
        cv.dataSource  = self
        cv.delegate = self
        
        let cvRowib = UINib(nibName: cvIdentifier, bundle: nil)
        cv.register(cvRowib, forCellWithReuseIdentifier: cvIdentifier)
        
        //        pageContorler.numberOfPages = pageCount
        
        startAutoScroll()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(stopAutoScroll), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(stopAutoScroll), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        
        //        UIApplication.
    }
    
    
    
    @objc func startAutoScroll() {
        autoScrollTimer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    @objc func autoScroll() {
        
        let nextIndex = (currentIndex + 1) % assignmentDatas.count
        let nextIndexPath = IndexPath(item: nextIndex, section: 0)
        cv.scrollToItem(at: nextIndexPath, at: .right, animated: true)
        currentIndex = nextIndex
        
        pageContorler.currentPage = currentIndex
        
    }
    
    @objc func stopAutoScroll() {
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
    }
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 310, height: 230)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        pageContorler.numberOfPages = assignmentDatas.count
        return assignmentDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cvIdentifier, for: indexPath) as! AssignmentCollectionViewCell
        
        let assigment : AssignmentsDashType = assignmentDatas[indexPath.row]
        
        
        
        var todaysDate = NSDate()
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        var DateInFormat = dateFormatter.string(from: todaysDate as Date)
        
        
        let dateFormatterGet = DateFormatter()
        
        dateFormatterGet.dateFormat = "dd-MM-yyy"
        
        
        
        let dateFormatterPrint = DateFormatter()
        
        dateFormatterPrint.dateFormat = " dd MMM,yyyy"
        
        
        
        let date: NSDate? = dateFormatterGet.date(from: DateInFormat) as NSDate?
        let date2: NSDate? = dateFormatterGet.date(from: assigment.submissiondate ?? "") as NSDate?
        
        
        cell.dateLbl.text = dateFormatterPrint.string(from: date as! Date)
        cell.dueDateLbl.text = dateFormatterPrint.string(from: date2 as! Date)
        cell.assDescLbl.text = assigment.assignmentdescription
        cell.assTopicLbl.text = assigment.assignmenttopic
        
        if (indexPath.row % 2 == 0){
            
            cell.assigmentFullView.backgroundColor = UIColor(named: "assigmentCvcolor")
            
        }
        
        else{
            
            cell.assigmentFullView.backgroundColor = UIColor(named: "assigmentCvEvenColor")
            
        }
        
        
        let  viewClick = UITapGestureRecognizer(target: self, action: #selector(AssigmentViewAllVc))
        cell.assigmentFullView.addGestureRecognizer(viewClick)
        
        
        if assigment.filepaths == [""]{
            
            cell.attchmentView.isHidden = true
            
            
        }
        
        else if assigment.filepaths == nil {
            
            
            cell.attchmentView.isHidden = true
            
        }
        
        
        else if assigment.filepaths == ([]){
            
            cell.attchmentView.isHidden = true
        }
        else{
            
            
            
            let  play = attchmentClikc(target: self, action: #selector(attachmentVc))
            
            for i in assigment.filepaths ?? []{
                
                play.imagurl =  i
                
            }
            
            
            cell.attchmentView.addGestureRecognizer(play)
            
            
            
        }
        
        
        
        return cell
        
    }
    
    
    
    @IBAction func attachmentVc( gesture : Attchment){
        
        
        let currentController = self.getViewController()
        
        
        let vc =  DashBordShwViewController (nibName: nil, bundle: nil)
        vc.imgfilePath = gesture.img_url
        
        vc.modalPresentationStyle = .fullScreen
        currentController?.present(vc, animated: true, completion: nil)
        
        
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
    
    @IBAction func AssigmentViewAllVc(){
        
        if priority == "p4" {
            let vc =  AssigmentHomePageViewController(nibName: nil, bundle: nil)
            
            let currentController = self.getViewController()
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: true, completion: nil)
            
        }
        
        else if priority == "p1" {
            
            let vc = SenderAssigmentHomePageViewController(nibName: nil, bundle: nil)
            
            let currentController = self.getViewController()
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Principal" )
            vc.assigmentSegmentName.backgroundColor = UIColor(named: "UnSelector")
            vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: true, completion: nil)
            
            
        }
        
        
        else if priority == "p3" ||  priority == "p2"  {
            
            let vc = SenderAssigmentHomePageViewController(nibName: nil, bundle: nil)
           
            let currentController = self.getViewController()
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
            vc.assigmentSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
            vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: true, completion: nil)
            
        }
        
        else if priority == "p5"{
            
            let vc =  AssigmentHomePageViewController(nibName: nil, bundle: nil)
           
            let currentController = self.getViewController()
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.assigmentSegmentName.backgroundColor = UIColor(named: "FatherUnselector")
            vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
            vc.view.backgroundColor = UIColor(named: "FatherColor" )
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: true, completion: nil)
            
            
        }
        
        
        else if priority == "p6"{
            
            
            
            let vc =  SenderAssigmentHomePageViewController(nibName: nil, bundle: nil)
           
            let currentController = self.getViewController()
            vc.str = str
            vc.strName = strName
            vc.is_read_enabled = is_read_enabled
            vc.is_write_enabled = is_write_enabled
            vc.assigmentSegmentName.backgroundColor = UIColor(named: "CellColor")
            vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "attendanceColor")
//            vc.view.backgroundColor = UIColor(named: "attendanceColor" )
            vc.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: true, completion: nil)
            
            
        }
        
    }
}


class attchmentClikc : UITapGestureRecognizer{
    
    
    var imagurl : String!
    
    
    
}
