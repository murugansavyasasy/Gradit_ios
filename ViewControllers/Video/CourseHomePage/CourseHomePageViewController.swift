//
//  CourseHomePageViewController.swift
//  CourseDetailsGradit
//
//  Created by MACBOOKPRO on 24/10/22.
//

import UIKit
import ObjectMapper

class CourseHomePageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    @IBOutlet weak var courseTabelView: UITableView!
    
    
    var identifers = "CourseTableViewCell"
    
    var courseRefName : [courseDataDetails] = []
    
    
    
    var colgId : String!
    var memberId : String!
    var deptid      : String!
    
    var sectionid   : String!
    
    var semesterid  : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        deptid     = defaults.string(forKey: DefaultsKeys.deptid)
       
        sectionid = defaults.string(forKey: DefaultsKeys.sectionid)
        
        
        semesterid  = defaults.string(forKey: DefaultsKeys.semesterid)
        
        
        
        
        
        
        
        CourseRefModals()
        
        let rownib = UINib(nibName: identifers, bundle: nil)
        courseTabelView.register(rownib, forCellReuseIdentifier: identifers)
        
        
        courseTabelView.delegate = self
        courseTabelView.dataSource = self
        
        
        
        
        print("memberId",memberId!)
        print("colgId",colgId!)
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseRefName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifers, for: indexPath) as!
        CourseTableViewCell
        
        
        
        
        
        
        let Shopres : courseDataDetails = courseRefName[indexPath.row]
        
        cell.SubjectLabel.text = Shopres.subject_name
        cell.typeLabel.text = Shopres.subject_type
        cell.categoryLabel.text  = Shopres.subject_category
        cell.creditsLabel.text = Shopres.subject_credits
        cell.codeLabel.text = Shopres.subject_code
        cell.requirementLabel.text = Shopres.subject_requirement
        
        if (indexPath.row % 2 == 0)
        {
            cell.lineView.backgroundColor = UIColor(named: "evenColor")
        } else {
            cell.lineView.backgroundColor = UIColor(named: "oddColor")
        }
        return cell
        
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 215
    }
    
    
    
    func CourseRefModals() {
        
        let Cour = courseModal()
        
        Cour.user_id       = memberId
        Cour.college_id     = colgId
        Cour.dept_id      =  deptid
        Cour.sem_id      =   semesterid
        Cour.section_id   =    sectionid
        
        
        let courseStr = Cour.toJSONString()
        
        
        courseRequest .call_request(param: courseStr!){ [self]
            
            (res) in
            
            
            let courseResp : courseResponce =
            Mapper<courseResponce>().map(JSONString: res)!
            
            print("order data",courseResp)
            
            
            courseRefName = courseResp.data
            
            courseTabelView.delegate = self
            courseTabelView.dataSource = self
            
            
            
            courseTabelView.reloadData()
            
            
            
        }
        
        
    }
    
    
    @IBAction func back(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}


