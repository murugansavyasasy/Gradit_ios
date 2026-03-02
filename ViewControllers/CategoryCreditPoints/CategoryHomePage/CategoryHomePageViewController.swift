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


@IBOutlet weak var reusee: ReuseView!

@IBOutlet weak var tv: UITableView!

@IBOutlet weak var upArrowImageView: UIImageView!
@IBOutlet weak var headingView: UIView!


@IBOutlet weak var selectedCategoryView: UIView!
@IBOutlet weak var noDataLabel: UILabel!
@IBOutlet weak var noDataTextView: UIView!
@IBOutlet weak var collection: UICollectionView!
@IBOutlet weak var selectCategoryLabel: UILabel!



@IBOutlet weak var swipeMenuHeight: NSLayoutConstraint!







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
    
 
    categorys()
    

    let rowNib = UINib(nibName: identiers, bundle: nil)
    tv.register(rowNib, forCellReuseIdentifier: identiers)
    
    
    
    
    let  selectCategory = UITapGestureRecognizer(target: self, action: #selector(open_url))
    selectedCategoryView.addGestureRecognizer(selectCategory)
    
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
        
        print("CategoryHomePageViewController",reusee.callid)
        
        
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
    
    let cate = categoryModal()
    cate.colgid  = colgId
    cate.i_student_id = memberId
    
    let categorystStr = cate.toJSONString()
    
    categoryRequest.call_request(param: categorystStr!){ [self]
        (res) in
        
        let categoryResp : categoryResponce =
        Mapper<categoryResponce>().map(JSONString: res)!
        
        dropDownArr = categoryResp.data
        
        var myArray: [String] = [ ]
        
        dropDownArr.forEach {(arrType)  in
            myArray.append((arrType.category_name))
            
        }
        
        
        selectCategoryLabel.text = "--Selected Category--"
        dropDown.anchorView = selectedCategoryView
        dropDown.dataSource = myArray
        
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.direction = .bottom
        DropDown.appearance().backgroundColor = UIColor.white
        
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            print("myArray",myArray)
            
            self.credsEc = item
            
            
            if credsEc == "ES" {
                
                credits()
            }
            else if credsEc == "PC" {
                
                creditsPc()
            }
            else  if credsEc == "Test" {
                
                
                creditsTest()
            }
            
            
            self.selectCategoryLabel.text = item
            
            upArrowImageView.image = UIImage(named: "download")
        }
        
        
    }
    
    
}

func credits(){
    
    let cate = creditModal()
    
    cate.colgid = colgId
    cate.i_course_id = courseid
    cate.i_category_id = "5"
    cate.i_student_id = memberId
    
    let categorystStr = cate.toJSONString()
    
    creditRequest.call_request(param: categorystStr!){ [self]
        
        (res) in
        
        let categoryResp : creditResponce =
        Mapper<creditResponce>().map(JSONString: res)!
        
        
        
        if categoryResp.Status == 1{
            
            crediEStRef = categoryResp.data
            
            headingView.isHidden = false
            noDataLabel.isHidden = true
            noDataTextView.isHidden = true
            tv .delegate = self
            tv.dataSource = self
            tv.reloadData()
            
        }
        
        
        else {
            
            headingView.isHidden = true
            noDataTextView.isHidden = false
            noDataLabel.isHidden = false
            
            noDataLabel.text = categoryResp.Message
            tv .delegate = self
            tv.dataSource = self
            tv.reloadData()
            
            
        }
        
    }
    
    
}


func creditsPc(){
    
    let catePc = creditModal()
    catePc.colgid = colgId
    catePc.i_course_id = courseid
    catePc.i_category_id = "6"
    catePc.i_student_id = memberId
    
    let creditPcStr = catePc.toJSONString()
    
    creditRequest.call_request(param: creditPcStr!){ [self]
        
        (res) in
        
        
        let creditPcResp : creditResponce =
        Mapper<creditResponce>().map(JSONString: res)!
        
        
        if creditPcResp.Status == 1{
            
            creditPCRef = creditPcResp.data
            headingView.isHidden = false
            noDataLabel.isHidden = true
            noDataTextView.isHidden = true
            tv .delegate = self
            tv.dataSource = self
            tv.reloadData()
            
            
        }
        
        
        else {
            
            headingView.isHidden = true
            noDataLabel.isHidden = false
            noDataTextView.isHidden = false
            noDataLabel.text = creditPcResp.Message
            tv .delegate = self
            tv.dataSource = self
            tv.reloadData()
            
            
            
        }
        
        
    }
    
}
func creditsTest(){
    
    let cateTest = creditModal()
    
    cateTest.colgid = colgId
    cateTest.i_course_id = courseid
    cateTest.i_category_id = "19"
    cateTest.i_student_id = memberId
    
    let creditsTestStr = cateTest.toJSONString()
    
    
    creditRequest.call_request(param: creditsTestStr!){ [self]
        
        (res) in
        
        
        let creditsResp : creditResponce =
        Mapper<creditResponce>().map(JSONString: res)!
        
        
        
        if creditsResp.Status == 1{
            
         
            creditTestRef = creditsResp.data
            
            headingView.isHidden = false
            
            noDataLabel.isHidden = true
            noDataTextView.isHidden = true
            tv .delegate = self
            tv.dataSource = self
            tv.reloadData()
            
            
            
        }
        
        
        else {
            
            
            headingView.isHidden = true
            
            noDataLabel.isHidden = false
            noDataTextView.isHidden = false
            noDataLabel.text = creditsResp.Message
            tv .delegate = self
            tv.dataSource = self
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
