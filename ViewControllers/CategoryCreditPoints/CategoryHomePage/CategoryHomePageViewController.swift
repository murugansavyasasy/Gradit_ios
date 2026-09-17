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
    var creditRef : [creditDataDetails] = []
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
            
            view.backgroundColor = UIColor(named: "Principal" )
            
        }else if priority == "p4" {
            
            view.backgroundColor = UIColor(named: "studentViewColors")
            
        }else if priority == "p3" ||  priority == "p2" {
            
            view.backgroundColor = UIColor(named: "Teaching Staff")
            
        }else if priority == "p5"{
            
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
                    
                    if let categoryId = dropDownArr.first(where: { $0.category_name == item })?.category_id {
                        
                        self.credits(categoryId: categoryId)
                    }
                    
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func credits(categoryId: Int){
        
        var cate = creditModal()
        
        cate.colgid = Int(colgId)
        cate.i_course_id = Int(courseid)
        cate.i_category_id = categoryId
        cate.i_student_id = Int(memberId)
        
        APiCallManager.shared.callApi(url: APIEndpoints.categorywisestudentcreditdetails, httpMethod: .post, queryParam: nil, requestBody: cate) {[weak self]
            (result:Result<creditResponce, Error>) in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
                
                if success.Status == 1{
                    
                    creditRef = success.data ?? []
                    headingView.isHidden = false
                    noDataLabel.isHidden = true
                    noDataTextView.isHidden = true
                    tv.reloadData()
                }else {
                    
                    creditRef = success.data ?? []
                    headingView.isHidden = true
                    noDataTextView.isHidden = false
                    noDataLabel.isHidden = false
                    noDataLabel.text = success.Message
                    tv.reloadData()
                }
                
            case .failure(let failure):
                creditRef = []
                headingView.isHidden = true
                noDataTextView.isHidden = false
                noDataLabel.isHidden = false
                noDataLabel.text = failure.localizedDescription
                tv.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return creditRef.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identiers, for: indexPath) as! CategoryTableViewCell
        
        let Credits : creditDataDetails = creditRef[indexPath.row]
        
        cell.cellCategory_name.text = Credits.category_name
        cell.cellObtained.text = Credits.obtained
        cell.cellto_be_obtained.text = Credits.to_be_obtained
        cell.cellTotal_credits.text = Credits.total_credits
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 48
    }
    
    @IBAction func backbtn(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
}
