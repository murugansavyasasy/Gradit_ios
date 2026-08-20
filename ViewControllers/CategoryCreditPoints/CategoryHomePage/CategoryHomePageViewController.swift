//
//  CategoryHomePageViewController.swift
//  GraditCategoryCredit
//
//  Created by MACBOOKPRO on 07/11/22.
//

import UIKit
import DropDown
import ObjectMapper

@available(iOS 16.0, *)
class CategoryHomePageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {


@IBOutlet weak var tv: UITableView!

@IBOutlet weak var upArrowImageView: UIImageView!
@IBOutlet weak var headingView: UIView!


@IBOutlet weak var selectedCategoryView: UIView!
@IBOutlet weak var noDataLabel: UILabel!
@IBOutlet weak var noDataTextView: UIView!
@IBOutlet weak var selectCategoryLabel: UILabel!

let dropDown = DropDown()

var identiers = "CategoryTableViewCell"

var crediEStRef : [creditDataDetails] = []
var creditPCRef : [creditDataDetails] = []
var creditTestRef : [creditDataDetails] = []
var dropDownArr : [categoryDataDetails] = []

let menuIdentifier = "MenuCollectionViewCell"
var MenuRefName :[menuApiDataDetails] = []
var credsEc : String!

var colgId : String!
var memberId : String!
var sectionid : String!
var courseid : String!
var priority : String!
var str : [String] = []

var strName : [String] = []

var is_read_enabled = ""
var is_write_enabled = ""


override func viewDidLoad() {
    super.viewDidLoad()
    overrideUserInterfaceStyle = .light
    let defaults = UserDefaults.standard
    
    
    colgId = defaults.string(forKey: DefaultsKeys.collegeid)
    memberId = defaults.string(forKey: DefaultsKeys.memberid)
    
    sectionid = defaults.string(forKey: DefaultsKeys.sectionid)
    
    courseid = defaults.string(forKey: DefaultsKeys.courseid)
    
    priority = defaults.string(forKey: DefaultsKeys.priority)
    
    tv.delegate = self
    tv.dataSource = self
    
 
    categorys()
    

    let rowNib = UINib(nibName: identiers, bundle: nil)
    tv.register(rowNib, forCellReuseIdentifier: identiers)
    
    
    
    
    let  selectCategory = UITapGestureRecognizer(target: self, action: #selector(open_url))
    selectedCategoryView.addGestureRecognizer(selectCategory)
    
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
   
    noDataTextView.isHidden = true
    noDataLabel.isHidden = true
    headingView.isHidden = true
    
    
}


@IBAction func open_url(){
    
    
    
    
    dropDown.show()
    
    
    upArrowImageView.image = UIImage(named: "arrow-up")
    
    
}


func categorys(){
    
    var cate = categoryModal()
    cate.colgid  = Int(colgId)
    cate.i_student_id = Int(memberId)
    
    APiCallManager.shared.callApi(url: APIEndpoints.getcategorylistforclgeid, httpMethod: .post, queryParam: nil, requestBody: cate) {[weak self] (result:Result<categoryResponce, Error>) in
        
        guard let self = self else { return }
        
        switch result {
        case .success(let success):
            
            dropDownArr = success.data ?? []
            // Prepare data source
            let myArray = dropDownArr.map { $0.category_name ?? ""}

            // Dropdown configuration
            selectCategoryLabel.text = "--Selected Category--"
            dropDown.anchorView = selectedCategoryView
            dropDown.dataSource = myArray
            dropDown.direction = .bottom
            DropDown.appearance().backgroundColor = .white

            if let anchorHeight = dropDown.anchorView?.plainView.bounds.height {
                dropDown.bottomOffset = CGPoint(x: 0, y: anchorHeight)
            }

            // Selection action
            dropDown.selectionAction = { [weak self] index, item in
                guard let self = self else { return }

                print("Selected item: \(item) at index: \(index)")
                print("myArray", myArray)

                self.credsEc = item
                self.selectCategoryLabel.text = item
                self.upArrowImageView.image = UIImage(named: "download")

                switch item {
                case "ES":
                    self.credits()
                case "PC":
                    self.creditsPc()
                case "Test":
                    self.creditsTest()
                default:
                    break
                }
            }
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
}

func credits(){
    
    var cate = creditModal()
    
    cate.colgid = Int(colgId)
    cate.i_course_id = Int(courseid)
    cate.i_category_id = 5
    cate.i_student_id = Int(memberId)
    
    APiCallManager.shared.callApi(url: APIEndpoints.categorywisestudentcreditdetails, httpMethod: .post, queryParam: nil, requestBody: cate) {[weak self]
        (result:Result<creditResponce, Error>) in
        
        guard let self = self else {return}
        
        switch result {
        case .success(let success):
            
            if success.Status == 1{
                
                crediEStRef = success.data ?? []
                headingView.isHidden = false
                noDataLabel.isHidden = true
                noDataTextView.isHidden = true
                tv.reloadData()
            }else {
                
                crediEStRef = success.data ?? []
                headingView.isHidden = true
                noDataTextView.isHidden = false
                noDataLabel.isHidden = false
                noDataLabel.text = success.Message
                tv.reloadData()
            }
            
        case .failure(let failure):
            crediEStRef = []
            headingView.isHidden = true
            noDataTextView.isHidden = false
            noDataLabel.isHidden = false
            noDataLabel.text = failure.localizedDescription
            tv.reloadData()
        }
    }
}


func creditsPc(){
    
    var catePc = creditModal()
    catePc.colgid = Int(colgId)
    catePc.i_course_id = Int(courseid)
    catePc.i_category_id = 6
    catePc.i_student_id = Int(memberId)
    
    APiCallManager.shared.callApi(url: APIEndpoints.categorywisestudentcreditdetails, httpMethod: .post, queryParam: nil, requestBody: catePc) {[weak self] (result:Result<creditResponce, Error>) in
    
        guard let self = self else {return}
        
        switch result {
        case .success(let success):
            if success.Status == 1{
                
                creditPCRef = success.data ?? []
                headingView.isHidden = false
                noDataLabel.isHidden = true
                noDataTextView.isHidden = true
                tv.reloadData()
            }else {
                creditPCRef = success.data ?? []
                headingView.isHidden = true
                noDataLabel.isHidden = false
                noDataTextView.isHidden = false
                noDataLabel.text = success.Message
                tv.reloadData()
            }
        case .failure(let failure):
            creditPCRef = []
            headingView.isHidden = true
            noDataLabel.isHidden = false
            noDataTextView.isHidden = false
            noDataLabel.text = failure.localizedDescription
            tv.reloadData()
        }
    }
}
    
func creditsTest(){
    
    var cateTest = creditModal()
    
    cateTest.colgid = Int(colgId)
    cateTest.i_course_id = Int(courseid)
    cateTest.i_category_id = 19
    cateTest.i_student_id = Int(memberId)
    
    APiCallManager.shared.callApi(url: APIEndpoints.categorywisestudentcreditdetails, httpMethod: .post, queryParam: nil, requestBody: cateTest) {[weak self] (result:Result<creditResponce, Error>) in
    
        guard let self = self else {return}
        
        switch result {
        case .success(let success):
            if success.Status == 1{
                
                creditTestRef = success.data ?? []
                headingView.isHidden = false
                noDataLabel.isHidden = true
                noDataTextView.isHidden = true
                tv.reloadData()
            }else {
                creditTestRef = success.data ?? []
                headingView.isHidden = true
                noDataLabel.isHidden = false
                noDataTextView.isHidden = false
                noDataLabel.text = success.Message
                tv.reloadData()
            }
        case .failure(let failure):
            creditTestRef = []
            headingView.isHidden = true
            noDataLabel.isHidden = false
            noDataTextView.isHidden = false
            noDataLabel.text = failure.localizedDescription
            tv.reloadData()
        }
    }
}



func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if credsEc == "ES"{
        
    
        
        return crediEStRef.count
    }
    else if credsEc == "PC"{
        
        
        
        return creditPCRef.count
    }
    //
    else if credsEc == "Test" {
        
        
        return creditTestRef.count
    }else {
        return 0
    }
    //
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: identiers, for: indexPath) as!
    
    CategoryTableViewCell
    
    if credsEc == "ES"{
        
        let EsCredits : creditDataDetails = crediEStRef[indexPath.row]
        
        cell.cellCategory_name.text = EsCredits.category_name
        cell.cellObtained.text = EsCredits.obtained
        cell.cellto_be_obtained.text = EsCredits.to_be_obtained
        cell.cellTotal_credits.text = EsCredits.total_credits
        
        print("ES")
        
        
        
    }
    
    else if credsEc == "PC"{
        
        print("PC")
        
        let PcCredits : creditDataDetails = creditPCRef[indexPath.row]
        
        cell.cellCategory_name.text = PcCredits.category_name
        cell.cellObtained.text = PcCredits.obtained
        cell.cellto_be_obtained.text = PcCredits.to_be_obtained
        cell.cellTotal_credits.text = PcCredits.total_credits
  
    }
    
    else   if credsEc == "Test"{
        
        let testCredits : creditDataDetails = creditTestRef[indexPath.row]
        
        cell.cellCategory_name.text = testCredits.category_name
        cell.cellObtained.text = testCredits.obtained
        cell.cellto_be_obtained.text = testCredits.to_be_obtained
        cell.cellTotal_credits.text = testCredits.total_credits
        
        
        print("NoRecordFound")
        
    }
    return cell
}



func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    return 48
}




// swipe bottom view .












@IBAction func backbtn(_ sender: Any) {
    
    dismiss(animated: true)
}




}
