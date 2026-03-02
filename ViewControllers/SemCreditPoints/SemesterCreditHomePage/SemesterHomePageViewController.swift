//
//  SemesterHomePageViewController.swift
//  GraditSemesterCreditPoints
//
//  Created by MACBOOKPRO on 09/11/22.
//

import UIKit
import ObjectMapper
import DropDown

@available(iOS 16.0, *)
class SemesterHomePageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    @IBOutlet weak var reusee: ReuseView!
   
    
    @IBOutlet weak var swipeMenuHeight: NSLayoutConstraint!
   
    
    @IBOutlet weak var tv: UITableView!
    
    @IBOutlet weak var headingView: UIView!
    
    @IBOutlet weak var noDataTextView: UIView!
    
    @IBOutlet weak var noDataLabel: UILabel!
    
    
    
    
    @IBOutlet weak var arrowImageViews: UIImageView!
    @IBOutlet weak var semCreditDropDownView: UIViewX!
    
    
    @IBOutlet weak var semCreditDropDownLabel: UILabel!
    
    var identiers = "SemCreditTableViewCell"
    let menuIdentifier = "MenuCollectionViewCell"
    var MenuRefName :[menuApiDataDetails] = []
    
    var semCreditDropDownRef : [semCreditDropDownDataDeails] = []
    var allRefName  : [CategoryList] = []
    var RefNameDetails  : [semcreditDataDetails] = []
    
    let dropDown = DropDown()
    var credsEc : String!
    
    var refN   : [CategoryList] = []
    
    
    
    var colgId : String!
    var memberId : String!
    var deptid   : String!
    var sectionid : String!
    var semesterid  : String!
    var courseid   : String!
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
        courseid = defaults.string(forKey: DefaultsKeys.courseid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        
     
        semCreditDropDown()
       
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
                   
                    print("SemesterHomePageViewController",reusee.callid)
                    
               
                }
   
        
        
        let rowNib = UINib(nibName: identiers, bundle: nil)
        tv.register(rowNib, forCellReuseIdentifier: identiers)
        
        
        let  selectCategory = UITapGestureRecognizer(target: self, action: #selector(open_url))
        semCreditDropDownView.addGestureRecognizer(selectCategory)
        
        
        noDataLabel.isHidden = true
        noDataTextView.isHidden = true
        headingView.isHidden = true
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        print("counttt",allRefName.count)
        if credsEc == "ALL" {
            return allRefName.count
        }else{
            return RefNameDetails.count
        }
        
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identiers, for: indexPath) as!
        
        SemCreditTableViewCell
        
        
        if credsEc == "ALL" {
            
            let allCollection : CategoryList = allRefName[indexPath.row]
            
            cell.categoryCellLabel.text = allCollection.category_name
            cell.obtainedCellLabel.text = allCollection.obtained
            cell.semesterCellLabel.text = allCollection.semester_name
            cell.toBeObtainedCellLabel.text = allCollection.to_be_obtained
            cell.totalCellLabel.text = allCollection.total_credits
            
            
        }else{
            let allCollection : semcreditDataDetails = RefNameDetails[indexPath.row]
            
            
            cell.categoryCellLabel.text = allCollection.category_name
            cell.obtainedCellLabel.text = allCollection.obtained
            cell.semesterCellLabel.text = allCollection.semester_name
            cell.toBeObtainedCellLabel.text = allCollection.to_be_obtained
            cell.totalCellLabel.text = allCollection.total_credits
            
            
        }
      
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    
    @IBAction func open_url(){
        
        dropDown.show()
        
        arrowImageViews.image = UIImage(named: "arrow-up")
    }
    
    
  
    func semCreditDropDown(){
        
        let sem = semCreditDropDownModal()
        sem.colgid  = colgId
        sem.i_course_id = courseid
        
        
        
        let semCreditDropDownStr = sem.toJSONString()
        
        semCreditDropDownRequest.call_request(param: semCreditDropDownStr!){ [self]
            (res) in
            
            let categoryResp : semCreditDropDownResponce =
            Mapper<semCreditDropDownResponce>().map(JSONString: res)!
            
            semCreditDropDownRef = categoryResp.data
            
            var myArray: [String] = [ ]
            var semIdArray :[Int] = [ ]
            
            semCreditDropDownRef.forEach {(arrType)  in
                myArray.append((arrType.semseter_name))
                
                print("Ids",arrType.semester_id)
                semIdArray.append(arrType.semester_id)
                
            }
            
            semCreditDropDownLabel.text = "--Selecte Semester--"
            dropDown.anchorView = semCreditDropDownView
            dropDown.dataSource = myArray
            
            dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
            dropDown.direction = .bottom
            DropDown.appearance().backgroundColor = UIColor.white
            
            DropDown.appearance().cornerRadius = 8
            DropDown.appearance().layer.borderColor = UIColor.red.cgColor
            
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                print("myArray",myArray)
                
                self.credsEc = item
                
                let all = semcreditDetailsModal()
                
                all.colgid = colgId
                all.i_course_id = courseid
                all.i_semester_id =  semIdArray[index]
                all.i_student_id = memberId
                
                
                let allstr = all.toJSONString()
                
                
                
                print("gh",allstr)
                
                
                if credsEc == "ALL" {
                    
                    semCreditDetailsRequestAll.call_request(param: allstr!){ [self]
                        (res) in
                        
                        let allResp : semCreditDetailsResponce =
                        Mapper<semCreditDetailsResponce>().map(JSONString: res)!
                        
                        print("kkkkkkkkkk",res)
                        if allResp.Status == 1 {
                            
                            
                            for i in allResp.data {
                                
                                refN = i.category_list
                                //
                                //
                            }
                            allRefName.append(contentsOf: refN)
                            
                            headingView.isHidden = false
                            noDataTextView.isHidden = true
                            noDataLabel.isHidden = true
                            tv.delegate = self
                            tv.dataSource = self
                            tv.reloadData()
                            
                            
                        }
                        
                        else{
                            
                            headingView.isHidden = true
                            noDataTextView.isHidden = false
                            noDataLabel.isHidden = false
                            noDataLabel.text = allResp.Message
                            tv.delegate = self
                            tv.dataSource = self
                            tv.reloadData()
                            
                        }
                        
                        
                        
                    }
                    
                }
                
                
                else{
                    
                    
                    semCreditDetailsRequest.call_request(param: allstr!){ [self]
                        (res) in
                        
                        let allResp : semCreditDetailsResponce =
                        Mapper<semCreditDetailsResponce>().map(JSONString: res)!
                        
                        print("kkkkkkkkkk",res)
                        if allResp.Status == 1 {
                            
                            if allResp.Status == 1 {
                                //
                                RefNameDetails = allResp.data
                                
                                headingView.isHidden = false
                                noDataTextView.isHidden = true
                                noDataLabel.isHidden = true
                                tv.delegate = self
                                tv.dataSource = self
                                tv.reloadData()
                                
                                
                            }
                            
                            else{
                                
                                headingView.isHidden = true
                                noDataTextView.isHidden = false
                                noDataLabel.isHidden = false
                                noDataLabel.text = allResp.Message
                                tv.delegate = self
                                tv.dataSource = self
                                tv.reloadData()
                                
                            }
                            
                            
                            
                        }
                        
                        
                    }
                    
                    
                    
                    self.semCreditDropDownLabel.text = item
                    arrowImageViews.image = UIImage(named: "download")
                }
                
                
            }
            
            
        }
        
        
        
        
    }
    
    
    
    //this part bottom swipe view .
    
    
    
    
  
    
    
    
    
    
    @IBAction func backBtn(_ sender: Any) {
        
        dismiss(animated: true)
    }
}
