//
//  PriorityViewController.swift
//  Vs_GradItCollege
//
//  Created by APPLE on 27/10/22.
//

import UIKit
import SDWebImage

@available(iOS 16.0, *)
class PriorityViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var parentView: UIViewX!
    @IBOutlet weak var studentView: UIViewX!
    @IBOutlet weak var logoutView: UIViewX!
    
    @IBOutlet weak var principalLeading: NSLayoutConstraint!
    @IBOutlet weak var parentDefaultLbl: UILabel!
    @IBOutlet weak var studentDefaultLbl: UILabel!
    @IBOutlet weak var principalDefaultLbl: UILabel!
    @IBOutlet weak var principalView: UIViewX!
    @IBOutlet weak var tv: UITableView!
    
    var loginData : [datalogin] = []
    var loginStudent : [datalogin] = []
    var loginPrincipal : [datalogin] = []
    var loginParent : [datalogin] = []
    var loginTeaching : [datalogin] = []
//    var loginS
    
    var lops : [datalogin]!
    var loginType : String!
    var priority1 : String!
    
    
//    myArray
    var identifer = "PriorityTableViewCell"
    var changeRoleType : String!
    
    var IdentfierLabel : String!
    var parentIdentifyLabl : String!
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .light
        tv.delegate = self
        tv.dataSource = self
        
        
        
        print("IdentfierLabel",IdentfierLabel)
       
      parentView.isHidden = true
        
        
        
        
        
        if IdentfierLabel == nil{
            
            
            
            principalView.isHidden = true
            parentView.isHidden = true
            
            StudentViewVc()
            
        }
        
      
        
       
        
        else{
            
            
            principalDefaultLbl.text = IdentfierLabel
           
            principalView.isHidden = false
            
            
            if loginStudent.count == 0 {
                
                
                studentView.isHidden = true
                
                principalLeading.constant = 140
                
            }
          
            
            
        }
        
        
        
        
        
        
        print("kljljljl",loginPrincipal.count)
        
        
        
      
       let defaults = UserDefaults.standard
////       var myLoginData = defaults.stringArray(forKey: "SavedStringArray") ?? [String]()
//
        print("myLoginData")
        
        if changeRoleType == "1" {
            
            
//            loginData = defaults.array(forKey:DefaultsKeys.loginDataList) as! [datalogin]
            //                    defaults.string(forKey: DefaultsKeys.loginDataList)
        }
//        priority = defaults.string(forKey: DefaultsKeys.priority)
        let rownib = UINib(nibName: identifer, bundle: nil)
        tv.register(rownib, forCellReuseIdentifier: identifer)
        
        
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(logoutPressed))
        logoutView.addGestureRecognizer(logoutGesture)
        
      
        
        let principalViews = UITapGestureRecognizer(target: self, action: #selector(principalViewVc))
        principalView.addGestureRecognizer(principalViews)
        
        
        let StudentView = UITapGestureRecognizer(target: self, action: #selector(StudentViewVc))
        studentView.addGestureRecognizer(StudentView)
        
        
        let Parent = UITapGestureRecognizer(target: self, action: #selector(parentViewVC))
        parentView.addGestureRecognizer(Parent)
        
    }
    
    
    
    @IBAction func principalViewVc() {
        
        
        if principalView.isUserInteractionEnabled == true{
            
            principalView.isUserInteractionEnabled =  true
            

            principalView.backgroundColor = UIColor.black
            principalDefaultLbl.textColor = UIColor.white
            
            
            studentView.backgroundColor = UIColor.white
            studentDefaultLbl.textColor = UIColor.black
            
            
          
            parentView.backgroundColor = UIColor.white
            parentDefaultLbl.textColor = UIColor.black
            
            print("pricipal click on")
            
            
           
            tv.reloadData()
            
            
        }
        
        
        else{
            
            
            studentView.isUserInteractionEnabled = false
            parentView.isUserInteractionEnabled = false
            
            studentView.backgroundColor = UIColor.white
            studentDefaultLbl.textColor = UIColor.black
            
            
          
            parentView.backgroundColor = UIColor.white
            parentDefaultLbl.textColor = UIColor.black
            
            
            print("pricipal click off")
            
        }
        
    }
    
    @IBAction func StudentViewVc() {
        
//        
//        studentView.backgroundColor = UIColor.black
//        studentDefaultLbl.backgroundColor = UIColor.white
//        principalView.backgroundColor = UIColor.white
//        principalDefaultLbl.backgroundColor = UIColor.black
//        parentView.backgroundColor = UIColor.white
//        parentDefaultLbl.backgroundColor = UIColor.black
        
        
        
        
        if studentView.isUserInteractionEnabled == true{
            
            studentView.isUserInteractionEnabled =  true
            

            studentView.backgroundColor = UIColor.black
            studentDefaultLbl.textColor = UIColor.white
            
            
            principalView.backgroundColor = UIColor.white
            principalDefaultLbl.textColor = UIColor.black
            
            parentView.backgroundColor = UIColor.white
            parentDefaultLbl.textColor = UIColor.black
            
            print("studentView click on")
            
           
            tv.reloadData()
            
            
            
        }
        
        
        else{
            
            parentView.isUserInteractionEnabled = false
            principalView.isUserInteractionEnabled = false
            
            
            principalView.backgroundColor = UIColor.white
            principalDefaultLbl.textColor = UIColor.black
            
            parentView.backgroundColor = UIColor.white
            parentDefaultLbl.textColor = UIColor.black
          
            
            
            print("studentView click off")
            
        }
        
    }
    
    
    @IBAction func parentViewVC() {
        

        
        
        if parentView.isUserInteractionEnabled == true{
            
            parentView.isUserInteractionEnabled =  true
           
            parentView.backgroundColor = UIColor.black
            parentDefaultLbl.textColor = UIColor.blue
//
           studentView.backgroundColor = UIColor.white
            studentDefaultLbl.textColor = UIColor.black
            
//            
            principalView.backgroundColor = UIColor.white
            principalDefaultLbl.textColor = UIColor.black
            
//           
            print("parentView click on")
            
           
            tv.reloadData()
            
            
            
        }
        
        
        else{
            
            
            studentView.isUserInteractionEnabled = false
            principalView.isUserInteractionEnabled = false
            studentView.backgroundColor = UIColor.white
            studentDefaultLbl.textColor = UIColor.black
            principalView.backgroundColor = UIColor.white
            principalDefaultLbl.textColor = UIColor.black
            
            
            
            print("parentView click off")
            
        }
//
    }
    
    
    @IBAction func logoutPressed() {
        
        
      
        
     
            
            

            
            let refreshAlert = UIAlertController(title: "", message: "Are you sure do you want to logout", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (action: UIAlertAction!) in
                
                
                UserDefaults.standard.removeObject(forKey: DefaultsKeys.mobileNumber)
                
                let vc = LoginNewViewController(nibName: nil, bundle: nil)
                vc.modalPresentationStyle = .fullScreen
               
                    self.present(vc, animated: true, completion: nil)
                
                
            }))
            
            
            refreshAlert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            
            present(refreshAlert, animated: true, completion: nil)
            
        }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       
            
            print("logins",loginData.count)
        
        if  principalView.backgroundColor == UIColor.black{
            
            return loginPrincipal.count
            
            
        }
        
       
        
        else if studentView.backgroundColor == UIColor.black{
            
            
            return loginStudent.count
            
            
        }
        
        
        return 0
        
        
        }
    
    
    
    
    
    
    
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: identifer, for: indexPath) as!
            PriorityTableViewCell
            
            
            
            
            if  principalView.backgroundColor == UIColor.black{
                
                let loginDetail : datalogin = loginPrincipal[indexPath.row]
                cell.StudentLabl.text = loginDetail.membername
                cell.clgNameLabl.text = loginDetail.colgname
//                cell.loginAsLabel.text = loginDetail.loginas
                
                if loginDetail.coursename == "" {
                    
                    cell.CoureLabl.text =  ""
                    cell.DepartmentLabl.text = ""
                  cell.SectionLbl.text = ""
                cell.YearANdSemeLbl.text = ""
                                       
                    
                    print("YearANdSemeLblYearANdSemeLbl",cell.YearANdSemeLbl.text)
                }
                
                
                else{
                    cell.DepartmentLabl.text = loginDetail.deptname
                    cell.CoureLabl.text = loginDetail.coursename
                    
                    cell.YearANdSemeLbl.text = loginDetail.yearname + "-" + loginDetail.semestername
                      
                       cell.SectionLbl.text  =  loginDetail.sectionname
                    print("ytrtytreytfrds",cell.YearANdSemeLbl.text)
                    
                }
               
             
          
                
                if loginDetail.colglogo == ""{
                    
                    cell.clgLogoImg.image = UIImage(named: "school")
                    
                }else{
                    
                    cell.clgLogoImg.sd_setImage(with: URL(string:  loginDetail.colglogo), placeholderImage: UIImage(named: "person.fill"))
                    
                    
                }
                
                
                
                
            }
            
          
            else if studentView.backgroundColor == UIColor.black{
                
                
                let loginDetail : datalogin = loginStudent[indexPath.row]
                cell.StudentLabl.text = loginDetail.membername
                cell.clgNameLabl.text = loginDetail.colgname
//                cell.loginAsLabel.text = loginDetail.loginas
                
                if loginDetail.deptname == "" {
                    
                    cell.CoureLabl.text =  ""
                    cell.DepartmentLabl.text = ""
                  cell.SectionLbl.text = ""
                                        cell.YearANdSemeLbl.text = ""
                                       
                    
                }
                
                
                else{
                    cell.DepartmentLabl.text = loginDetail.deptname
                    cell.CoureLabl.text = loginDetail.coursename
                    cell.YearANdSemeLbl.text = loginDetail.yearname + "-" + loginDetail.semestername
                      
                       cell.SectionLbl.text  =  loginDetail.sectionname
                    
                    
                }
               
             
          
                
                if loginDetail.colglogo == ""{
                    
                    cell.clgLogoImg.image = UIImage(named: "school")
                    
                }else{
                    
                    cell.clgLogoImg.sd_setImage(with: URL(string:  loginDetail.colglogo), placeholderImage: UIImage(named: "person.fill"))
                    
                    
                }
                
                
                
            }
            
            
         
            
            
            
            
           
          
            return cell
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if  principalView.backgroundColor == UIColor.black{
            
            let loginDetail : datalogin = loginPrincipal[indexPath.row]

            
            let vc = HomeScreenViewController(nibName: nil, bundle: nil)
            let defaults = UserDefaults.standard
            
          
            defaults.set(loginDetail.colglogo, forKey: DefaultsKeys.colglogo)
            print()
           
            defaults.set(loginDetail.loginas, forKey: DefaultsKeys.loginAsType)
            defaults.set(loginDetail.membername, forKey: DefaultsKeys.memberName)
            defaults.set(loginDetail.colgname, forKey: DefaultsKeys.colgName)
            defaults.set(loginDetail.colgid, forKey: DefaultsKeys.collegeid)
            defaults.set(loginDetail.memberid, forKey: DefaultsKeys.memberid)
            
            defaults.set(loginDetail.priority, forKey: DefaultsKeys.priority)
            defaults.set(loginDetail.colgcity, forKey:DefaultsKeys.colgcity)
            defaults.set(loginDetail.divname, forKey: DefaultsKeys.divname)
            defaults.set(loginDetail.divid ,   forKey:DefaultsKeys.divid)
            defaults.set(loginDetail.courseid,forKey: DefaultsKeys.courseid)
            
            print("coureeeee",loginDetail.courseid)
            defaults.set(loginDetail.coursename,forKey:DefaultsKeys.coursename)
            defaults.set(loginDetail.deptid,forKey: DefaultsKeys.deptid)
            defaults.set(loginDetail.deptname,forKey: DefaultsKeys.deptname)
            defaults.set(loginDetail.yearid,forKey: DefaultsKeys.yearid)
            defaults.set(loginDetail.yearname,forKey: DefaultsKeys.yearname)
            defaults.set(loginDetail.sectionid,forKey: DefaultsKeys.sectionid)
            defaults.set(loginDetail.sectionname,forKey: DefaultsKeys.sectionname)
            defaults.set(loginDetail.semesterid,forKey: DefaultsKeys.semesterid)
            defaults.set(loginDetail.semestername,forKey: DefaultsKeys.semestername)
            defaults.set(loginDetail.is_parent_target_enabled,forKey: DefaultsKeys.is_parent_target_enabled)
            defaults.set(loginDetail.is_allow_to_make_call,forKey: DefaultsKeys.is_allow_to_make_call)
           
            vc.loginAsType = defaults.string(forKey: DefaultsKeys.loginAsType)
            print("vc.loginAsType\(vc.loginAsType)")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
            
        }
        
       
        
        else if studentView.backgroundColor == UIColor.black{
            
            
           
            let loginDetail : datalogin = loginStudent[indexPath.row]

            
            let vc = HomeScreenViewController(nibName: nil, bundle: nil)
            let defaults = UserDefaults.standard
            
          
            defaults.set(loginDetail.colglogo, forKey: DefaultsKeys.colglogo)
            print()
           
            defaults.set(loginDetail.loginas, forKey: DefaultsKeys.loginAsType)
            defaults.set(loginDetail.membername, forKey: DefaultsKeys.memberName)
            defaults.set(loginDetail.colgname, forKey: DefaultsKeys.colgName)
            defaults.set(loginDetail.colgid, forKey: DefaultsKeys.collegeid)
            defaults.set(loginDetail.memberid, forKey: DefaultsKeys.memberid)
            
            defaults.set(loginDetail.priority, forKey: DefaultsKeys.priority)
            defaults.set(loginDetail.colgcity, forKey:DefaultsKeys.colgcity)
            defaults.set(loginDetail.divname, forKey: DefaultsKeys.divname)
            defaults.set(loginDetail.divid ,   forKey:DefaultsKeys.divid)
            defaults.set(loginDetail.courseid,forKey: DefaultsKeys.courseid)
            
            print("coureeeee",loginDetail.courseid)
            defaults.set(loginDetail.coursename,forKey:DefaultsKeys.coursename)
            defaults.set(loginDetail.deptid,forKey: DefaultsKeys.deptid)
            defaults.set(loginDetail.deptname,forKey: DefaultsKeys.deptname)
            defaults.set(loginDetail.yearid,forKey: DefaultsKeys.yearid)
            defaults.set(loginDetail.yearname,forKey: DefaultsKeys.yearname)
            defaults.set(loginDetail.sectionid,forKey: DefaultsKeys.sectionid)
            defaults.set(loginDetail.sectionname,forKey: DefaultsKeys.sectionname)
            defaults.set(loginDetail.semesterid,forKey: DefaultsKeys.semesterid)
            defaults.set(loginDetail.semestername,forKey: DefaultsKeys.semestername)
            defaults.set(loginDetail.is_parent_target_enabled,forKey: DefaultsKeys.is_parent_target_enabled)

           
            vc.loginAsType = defaults.string(forKey: DefaultsKeys.loginAsType)
            print("vc.loginAsType\(vc.loginAsType)")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        }
        
        
        
        
        
        
                
    }
    
    
    
    
    
}
