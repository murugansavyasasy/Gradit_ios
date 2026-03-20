//
//  HallTicketViewController.swift
//  Vs_GradItCollege
//
//  Created by admin on 14/12/23.
//

import UIKit
import ObjectMapper

class HallTicketViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var pageController: UIPageControl!
    
    @IBOutlet weak var hallticketCv: UICollectionView!
    
    @IBOutlet weak var cv: UICollectionView!
    @IBOutlet weak var swipeMenu: UIView!
    
    
    @IBOutlet weak var swipeMenuHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var arrowImg: UIImageView!
    
    
    @IBOutlet weak var menuImg: UIImageView!
    
    
    
    
    
    
    @IBOutlet weak var downView: UIView!
    
    
    var identifier  = "HallTicketCollectionViewCell"
    var menuIdentifier = "MenuCollectionViewCell"
    var str : [String] = []
    
    var strName : [String] = []
    var hallticketsDataDetails : [HallticketDataDetails] = []
    var i_course_id  : Int!
    var memberId : Int!
    var clgId : Int!
    var i_semester_id : Int!
    var i_student_id : Int!
    var priority : String!
    var is_read_enabled : String!
    var is_write_enabled : String!
    var clgName : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        
        let hallticketCvdient = UINib(nibName: identifier, bundle: nil)
        hallticketCv.register(hallticketCvdient, forCellWithReuseIdentifier: identifier)
        
        
        
        let defaults = UserDefaults.standard
        
        i_course_id = defaults.integer(forKey: DefaultsKeys.courseid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        clgId = defaults.integer(forKey: DefaultsKeys.collegeid)
        i_semester_id = defaults.integer(forKey: DefaultsKeys.semesterid)
        clgName = defaults.string(forKey: DefaultsKeys.colgName)
        i_student_id = defaults.integer(forKey: DefaultsKeys.memberid)
        hallticketCv.dataSource = self
        hallticketCv.delegate = self
        hallticketApi()
        pageController.hidesForSinglePage = true
    }
    
    
    @IBAction func backbtn(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        pageController.numberOfPages = hallticketsDataDetails.count
        
        return hallticketsDataDetails.count
        
        
    }
    
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        print("chat3")
        
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as!
        
        HallTicketCollectionViewCell
        
        let halltickets : HallticketDataDetails = hallticketsDataDetails[indexPath.row]
        
        
        cell.clgName.text = clgName
        
        
        if halltickets.student_name.isEmpty{
            
            cell.nameLbl.isHidden = true
            
        }else{
            
            cell.nameLbl.text = halltickets.student_name
            
            cell.nameLbl.isHidden = false
            
        }
        
        if halltickets.register_number.isEmpty{
            
            
            cell.registerLbl.isHidden = true
        }else{
            
            
            
            cell.registerLbl.text = halltickets.register_number
            cell.registerLbl.isHidden = false
            
        }
        
        if halltickets.dob.isEmpty{
            
            cell.dateOfBrithLbl.isHidden = true
            
        }else{
            
            cell.dateOfBrithLbl.text = halltickets.dob
            cell.dateOfBrithLbl.isHidden = false
            
            
            
        }
        if halltickets.department.isEmpty{
            
            cell.deparmentLbl.isHidden = true
            
            
        }else{
            cell.deparmentLbl.text = halltickets.department
            cell.deparmentLbl.isHidden = false
            
            
        }
        
        if halltickets.course_name.isEmpty {
            
            
            cell.courseLbl.isHidden = true
            
        }else{
            cell.courseLbl.text = halltickets.course_name
            
            cell.courseLbl.isHidden = false
            
            
            
        }
        
        if  halltickets.current_sem.isEmpty{
            
            cell.semesterLbl.isHidden =  true
            
        }else{
            
            cell.semesterLbl.text = halltickets.current_sem
            
            cell.semesterLbl.isHidden =  false
            
            
        }
        
        if  halltickets.subject_code.isEmpty{
            cell.subjectCodeLbl.isHidden =  true
            
        }else{
            
            
            
            
            cell.subjectCodeLbl.text = halltickets.subject_code
            
            cell.subjectCodeLbl.isHidden =  false
        }
        
        if  halltickets.exam_date.isEmpty{
            
            
            cell.exameDateLbl.isHidden =  true
            
        }else{
            
            cell.exameDateLbl.text = halltickets.exam_date
            cell.exameDateLbl.isHidden =  false
            
            
        }
        
        if  halltickets.exam_time.isEmpty{
            
            
            cell.exameTime.isHidden =  true
            
        }else{
            cell.exameTime.text =  halltickets.exam_time
            cell.exameTime.isHidden =  false
            
            
        }
        
        if halltickets.arrear_regular.isEmpty{
            
            
            cell.arrearRegularLbl.isHidden = true
        }else{
            
            cell.arrearRegularLbl.text = halltickets.arrear_regular
            
            cell.arrearRegularLbl.isHidden = false
            
        }
        
        if halltickets.arrear_regular.isEmpty{
            cell.arrearRegularLbl.isHidden = true
            
        }else{
            
            
            cell.arrearRegularLbl.text = halltickets.arrear_regular
            
            cell.arrearRegularLbl.isHidden = false
            
        }
        if halltickets.overall_semester_attendance.isEmpty{
            
            
            cell.overallAttendDefaultlbl.isHidden =  true
        }else{
            cell.overallSemesterAttLbl.text = halltickets.overall_semester_attendance
            
            cell.overallAttendDefaultlbl.isHidden =  false
            
        }
        if halltickets.course_wise_attendance.isEmpty{
            
            cell.courseWiseAttLbl.isHidden = true
            cell.course.isHidden = true
        }else{
            
            cell.courseWiseAttLbl.text = halltickets.course_wise_attendance
            cell.course.isHidden = false
            
            
            
        }
        
        
        if   halltickets.condonation_paid.isEmpty{
            
            cell.condonationPaidLbl.isHidden = true
            cell.condonationPaidDefaultlbl.isHidden = true
        }else{
            
            cell.condonationPaidLbl.text = halltickets.condonation_paid
            cell.condonationPaidLbl.isHidden = false
            cell.condonationPaidDefaultlbl.isHidden = false
        }
        
        
        if halltickets.subject_name.isEmpty{
            
            cell.subjectLbl.isHidden =  true
            
        }else{
            
            cell.subjectLbl.text = halltickets.subject_name
            
            cell.subjectLbl.isHidden =  false
            
        }
        
        
        
        return cell
        
        
        
        
    }
    
    
   
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2
        
        pageController.currentPage = Int(offSet + horizontalCenter) / Int(width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        print("chat5")
        
        
        
        return   CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        
        
        
        
        
    }
    
    
    
    
    
    @IBAction func backbtns(_ sender: Any) {
        
        
        
        dismiss(animated: true)
    }
    
    
    
    func hallticketApi(){
        
        var halltick = HallticketModal()
        
        halltick.colgid  = clgId
        halltick.i_course_id = i_course_id
        halltick.i_semester_id = i_semester_id
        halltick.i_student_id = i_student_id
        
        APiCallManager.shared.callApi(url: APIEndpoints.getHallTicketDetails, httpMethod: .post, queryParam: nil, requestBody: halltick) {[weak self] (result:Result<HallticketResponce, Error>) in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
                if success.Status == 1{
                    
                    pageController.isHidden = true
                    hallticketsDataDetails = success.data ?? []
                    hallticketCv.reloadData()
                }else{
                    
                    pageController.isHidden = true
                    
                    let refreshAlert = UIAlertController(title: "", message: success.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        self.dismiss(animated: true)
                    }))
                    
                    present(refreshAlert, animated: true, completion: nil)
                }
            case .failure(let failure):
                pageController.isHidden = true
                
                let refreshAlert = UIAlertController(title: "", message: failure.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    self.dismiss(animated: true)
                }))
                
                present(refreshAlert, animated: true, completion: nil)
            }
        }
        
    }
}
