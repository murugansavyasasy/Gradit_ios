//
//  AssigmentNotSubViewController.swift
//  Vs_GradItCollege
//
//  Created by admin on 04/03/24.
//

import UIKit
import ObjectMapper

class AssigmentNotSubViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    @IBOutlet weak var tv: UITableView!
    
    var assigmentId : String!
    
    var memberId  : String!
    var Indentifiers = "NotSubmitTableViewCell"
    
    var assigmentMemberCount : [AssigmentmebCountData] = []
    var priority : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        let defaults = UserDefaults.standard
        
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        
        
        let rowNib = UINib(nibName: Indentifiers, bundle: nil)
        tv.register(rowNib, forCellReuseIdentifier: Indentifiers)
        
        
        assigmentCount()
        
        
        
        if priority == "p1"{
            
            view.backgroundColor = UIColor(named: "Principal" )
            
            
        }
        
        else if priority == "p4"{
            view.backgroundColor = UIColor(named: "studentViewColors" )
            
        }
        
        else if priority == "p2" {
            view.backgroundColor = UIColor(named: "Teaching Staff")
            
            
        }
        
        else if priority == "p5"{
            
            view.backgroundColor = UIColor(named: "FatherColor")
            
            
            
        }
        
        else if priority == "p3"{
            view.backgroundColor = UIColor(named: "Teaching Staff")
            
        }
        
        
    }
    
    
    @IBAction func back(_ sender: Any) {
        
        dismiss(animated: true)
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assigmentMemberCount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Indentifiers, for: indexPath) as!
        
        
        
        NotSubmitTableViewCell
        
        
        let notSubmit : AssigmentmebCountData = assigmentMemberCount[indexPath.row]
        cell.serilNom.text = String(indexPath.row+1)
        cell.regNumber.text = notSubmit.register_number
        cell.courseLbl.text = notSubmit.course
        cell.nameLbl.text = notSubmit.studentname
        cell.yearLbl.text = notSubmit.year
        
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func assigmentCount(){
        
        var assigmentCount = assigmentMemberCountModal()
        
        assigmentCount.assignmentid = assigmentId
        assigmentCount.processby = memberId
        assigmentCount.submissiontype = "notsubmitted"
        
        print("yearAndSectionModalStr", assigmentCount)
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.GetAssignmentSubmissions,
            httpMethod: .post,
            queryParam: nil,
            requestBody: assigmentCount
        ) { [weak self] (result: Result<assigmentMemberCountResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let AssigmentResp):
                
                if AssigmentResp.Status == 1 {
                    
                    self.assigmentMemberCount = AssigmentResp.data ?? []
                    
                    self.tv.delegate = self
                    self.tv.dataSource = self
                    self.tv.reloadData()
                    
                }
                else{
                    self.tv.delegate = self
                    self.tv.dataSource = self
                    self.tv.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
}
