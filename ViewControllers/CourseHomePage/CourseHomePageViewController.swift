//
//  CourseHomePageViewController.swift
//  CourseDetailsGradit
//
//  Created by MACBOOKPRO on 24/10/22.
//

import UIKit
import ObjectMapper

@available(iOS 16.0, *)
class CourseHomePageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    @IBOutlet weak var reusee: ReuseView!
    
    @IBOutlet weak var noDataTextLabel: UILabel!
    @IBOutlet weak var noDataView: UIView!
    
    
    @IBOutlet weak var courseTabelView: UITableView!
    
    @IBOutlet weak var swipeMenuHeight: NSLayoutConstraint!
    
  
    var identifers = "CourseTableViewCell"
    
    var courseRefName : [courseDataDetails] = []
    let menuIdentifier = "MenuCollectionViewCell"
    var MenuRefName :[menuApiDataDetails] = []
    
    
    var colgId : String!
    var memberId : String!
    var deptid      : String!
    
    var sectionid   : String!
    
    var semesterid  : String!
    var priority : String!
    
    var str : [String] = []
    
    var strName : [String] = []
    
    var is_read_enabled = ""
    var is_write_enabled = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        overrideUserInterfaceStyle = .light
        
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        deptid     = defaults.string(forKey: DefaultsKeys.deptid)
        
        sectionid = defaults.string(forKey: DefaultsKeys.sectionid)
        
        
        semesterid  = defaults.string(forKey: DefaultsKeys.semesterid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        
        
        
        
        
        
        
        CourseRefModals()
        
        
        
        
        let rownib = UINib(nibName: identifers, bundle: nil)
        courseTabelView.register(rownib, forCellReuseIdentifier: identifers)
        
        
        courseTabelView.delegate = self
        courseTabelView.dataSource = self
        
        
        
        noDataView.isHidden = true
        noDataTextLabel.isHidden = true
        
        if priority == "p1" {
            
            
            print("PrincipalVieewwColor")
            view.backgroundColor = UIColor(named: "Principal" )
            
                reusee.menuImg.image = UIImage(named: "principalBigMenu")
            
        }else if priority == "p4" {
            
            print("StudentVieewwColor")
            view.backgroundColor = UIColor(named: "studentViewColors")
            
            
            reusee.menuImg.image = UIImage(named: "studentSwipeImage")
            
        } else if priority == "p3" ||  priority == "p2" {
            
            print("HooodddVieewwColor")
            view.backgroundColor = UIColor(named: "Teaching Staff")
            
            reusee.menuImg.image = UIImage(named: "HodImage")
            
        }
        else if priority == "p5"{
            
            
            
            view.backgroundColor = UIColor(named: "FatherColor")
            
            reusee.menuImg.image = UIImage(named: "StaffBigMenu")
            
            
        }
        swipeMenuHeight.constant = 150
                reusee.call_back = { [self]
                    (val) in
                  
                    
                        self.swipeMenuHeight.constant =  reusee.callid
                   
                    print("CourseHomePageViewController",reusee.callid)
                    
               
                }
     
        
        
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseRefName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifers, for: indexPath) as!
        CourseTableViewCell
        
        
        
        
        if indexPath.row % 2 == 0{
            
            
        }
        
        
        else{
            
            cell.lineView.backgroundColor = UIColor(named: "odd")
            
        }
        
        let Shopres : courseDataDetails = courseRefName[indexPath.row]
        
        cell.SubjectLabel.text = Shopres.subject_name
        cell.typeLabel.text = Shopres.subject_type
        cell.categoryLabel.text  = Shopres.subject_category
        cell.creditsLabel.text = Shopres.subject_credits
        cell.codeLabel.text = Shopres.subject_code
        cell.requirementLabel.text = Shopres.subject_requirement
        
        
        return cell
        
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
        
    }
    
    
    
    func CourseRefModals() {
        
        var Cour = courseModal()
        
        Cour.user_id       = memberId
        Cour.college_id     = colgId
        Cour.dept_id      =  deptid
        Cour.sem_id      =   semesterid
        Cour.section_id   =    sectionid
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.GetSubjectDetailsForSemester,
            httpMethod: .post,
            queryParam: nil,
            requestBody: Cour
        ) {[weak self] (result:Result<courseResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                if success.Status == 1 {
                    
                    courseRefName = success.data ?? []
                    noDataView.isHidden = true
                    noDataTextLabel.isHidden = true
                    
                }else{
                    courseRefName = success.data ?? []
                    noDataView.isHidden = false
                    noDataTextLabel.isHidden = false
                    noDataTextLabel.text = success.Message
                }
            case .failure(let failure):
                courseRefName = []
                noDataView.isHidden = false
                noDataTextLabel.isHidden = false
                noDataTextLabel.text = failure.localizedDescription
            }
            courseTabelView.reloadData()
        }
    }
    
    
    // this part  bottom swipe  view.
    
    
    
  
    
    
    
    
    
    
    
    
    @IBAction func back(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}


