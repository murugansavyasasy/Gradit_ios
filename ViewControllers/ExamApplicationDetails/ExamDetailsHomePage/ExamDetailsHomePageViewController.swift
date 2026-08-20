//
//  ExamDetailsHomePageViewController.swift
//  ExamApplicationDetails
//
//  Created by MACBOOKPRO on 05/11/22.
//

import UIKit
import ObjectMapper

@available(iOS 16.0, *)
class ExamDetailsHomePageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
   
    @IBOutlet weak var noDataTextLabel: UILabel!
    @IBOutlet weak var noDataView: UIView!
    
    
    @IBOutlet weak var examDetailsTabelView: UITableView!
    
   
    var identifers = "ExamesApplicationTableViewCell"
    var examRef : [examesDataDetails] = []
    let menuIdentifier = "MenuCollectionViewCell"
    var MenuRefName :[menuApiDataDetails] = []
    
    var colgId  : String!
    var courseid : String!
    var memberId : String!
    var semesterid : String!
    var  priority : String!
    var str : [String] = []
    
    var strName : [String] = []
    
    var is_read_enabled = ""
    var is_write_enabled = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noDataView.isHidden = true
        noDataTextLabel.isHidden = true
        overrideUserInterfaceStyle = .light
        
        
        let defaults = UserDefaults.standard
        
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        
        courseid = defaults.string(forKey: DefaultsKeys.courseid)
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        semesterid  = defaults.string(forKey: DefaultsKeys.semesterid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        
        let rowNib = UINib(nibName: identifers, bundle: nil)
        examDetailsTabelView.register(rowNib, forCellReuseIdentifier: identifers)
        examDetailsTabelView.delegate = self
        examDetailsTabelView.dataSource = self
        examRefname ()
        
     
        if priority == "p1" {
            
            
            print("PrincipalVieewwColor")
            view.backgroundColor = UIColor(named: "Principal" )
            
            
        }else if priority == "p4" {
            
            print("StudentVieewwColor")
            view.backgroundColor = UIColor(named: "studentViewColors")
            
            
        } else if priority == "p3" ||  priority == "p2" {
            
            print("HooodddVieewwColor")
            view.backgroundColor = UIColor(named: "Teaching Staff")
            
            
        }
        else if priority == "p5"{
            
            
            
            view.backgroundColor = UIColor(named: "FatherColor")
            
            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return examRef.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifers, for:indexPath) as!
        ExamesApplicationTableViewCell
        
        let exam : examesDataDetails = examRef[indexPath.row]
        
        cell.cellCodeLabel.text = exam.subject_code
        cell.cellFeeAmountLabel.text = exam.amount
        cell.cellSemNumberLabel.text = exam.sem_number
        cell.cellSubjectNameLabel.text = exam.subject_name
        
        
        return cell
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    
    
    
    func examRefname () {
        
        var examDetail = examDetailsModal()
        
        examDetail.colgid = Int(colgId)
        examDetail.i_course_id = Int(courseid)
        examDetail.i_semester_id = Int(semesterid)
        examDetail.i_student_id  = Int(memberId)
        
        APiCallManager.shared.callApi(url: APIEndpoints.getExamApplicationDetails, httpMethod: .post, queryParam: nil, requestBody: examDetail) {[weak self] (result:Result<examDetailsResponce, Error>) in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
                examRef = success.data ?? []
                
                if success.Status == 1 {
                    
                    noDataView.isHidden = true
                    noDataTextLabel.isHidden = true
                    examDetailsTabelView.reloadData()
                }else{
                    
                    noDataTextLabel.text = success.Message
                    noDataView.isHidden = false
                    noDataTextLabel.isHidden = false
                    examDetailsTabelView.reloadData()
                }
            case .failure(let failure):
                examRef = []
                noDataTextLabel.text = failure.localizedDescription
                noDataView.isHidden = false
                noDataTextLabel.isHidden = false
                examDetailsTabelView.reloadData()
            }
        }
    }
    
    // this part  bottom swipe  view.
    
    
    
    
    
   
    
    
    
    
    
    @IBAction func back(_ sender: Any) {
        
        dismiss(animated: true)
    }
}
