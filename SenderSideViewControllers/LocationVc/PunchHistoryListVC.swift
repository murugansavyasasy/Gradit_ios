//
//  PunchHistoryListVC.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 24/09/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import UIKit
import ObjectMapper
class PunchHistoryListVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
 
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var noRecordLbl: UILabel!
    @IBOutlet weak var tv: UITableView!
    var staffId : Int!
    var collegeId : Int!
    var date = "27/11/2024"
    var timeData : [Timing] = []
    var identifier = "PunchHistTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()

       let rowNiib = UINib(nibName: identifier, bundle: nil)
        tv.register(rowNiib, forCellReuseIdentifier: identifier)
        
        noRecordLbl.isHidden = true
        punchHistory(date : date)
        
        let back = UITapGestureRecognizer(target: self, action: #selector(backClick))
        backView.addGestureRecognizer(back)
    }



    @IBAction func backClick(){
        
        dismiss(animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PunchHistTableViewCell
        
        let data : Timing  = timeData[indexPath.row]
        cell.timing.text = data.time
        
        
        if data.device_model == nil || data.device_model == ""{
            
//            cell.phoneModel.isHidden =
            cell.phoneModel.text = "Device Modal - " + "null"
        }else{
            cell.phoneModel.isHidden = false
            cell.phoneModel.text = "Device Modal - " + (data.device_model ?? "")
        }
        
        
       
        if data.punch_type?.value == nil || data.punch_type?.value == "" {
            
//            cell.punchType.isHidden = true
            cell.punchType.text = "Punch Type - " + "null"
        }else{
            cell.punchType.isHidden = false
            cell.punchType.text = "Punch Type - " + (data.punch_type?.value ?? "")
        }
        
        

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    func punchHistory(date : String){
        
        timeData.removeAll()
        
        var  punchHistry = punchHistryModalReq()
        
        punchHistry.CollegeId = collegeId
        punchHistry.UserId = staffId
        punchHistry.fromdate = date
        punchHistry.todate = date
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.GetBiometricPunchHistory,
            httpMethod: .post,
            queryParam: nil,
            requestBody: punchHistry
        ) {[weak self] (result:Result<punchHistryResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                
                for i in success.data ?? []{
                    
                    timeData.append(contentsOf: i.timings)
                    
                }
                
                noRecordLbl.isHidden = success.status == 1 ? true : false
                noRecordLbl.text = success.message
                tv.dataSource = self
                tv.delegate = self
                tv.reloadData()
                
            case .failure(let failure):
                print("Error:",failure.localizedDescription)
                timeData = []
                noRecordLbl.isHidden = false
                noRecordLbl.text = failure.localizedDescription
                tv.reloadData()
            }
            
        }
        
    }
}
