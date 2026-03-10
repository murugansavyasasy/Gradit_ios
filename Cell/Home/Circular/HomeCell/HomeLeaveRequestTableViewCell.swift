    //
    //  HomeLeaveRequestTableViewCell.swift
    //  Vs_GradItCollege
    //
    //  Created by Apple on 25/04/23.
    //

    import UIKit
    import ObjectMapper

    @available(iOS 16.0, *)
    class HomeLeaveRequestTableViewCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var leaveView: UIViewX!

    @IBOutlet weak var tv: UITableView!
    var dashtype : String!
    var colgId : String!
    var memberId : String!
    var loginAsType : String!
    var priority : String!
    var userid    : String!
    var leaveId : String!
    var dashBoardDataList : [DashBoardData] = []

    var LeaveRequestData : [LeaveRequestType] = []

    let leaveRequestIdentifier = "HomeScreenLeaveRequestTableViewCell"

    var leaveID = "1"
    var selectedCell : IndexPath?
    var str :  [String] = []
    var strName : [String] = []

    var is_read_enabled = ""
    var is_write_enabled = ""


    var mainPresent : UIViewController?
    override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    tv.dataSource = self
    tv.delegate = self

    let defaults = UserDefaults.standard
    colgId = defaults.string(forKey: DefaultsKeys.collegeid)
    memberId = defaults.string(forKey: DefaultsKeys.memberid)
    loginAsType = defaults.string(forKey: DefaultsKeys.loginAsType)
    priority = defaults.string(forKey: DefaultsKeys.priority)




    userid = defaults.string(forKey: DefaultsKeys.memberid)

    tv.dataSource  = self
    tv.delegate = self

    let leaveRquestRowNib = UINib(nibName: leaveRequestIdentifier, bundle: nil)
    tv.register(leaveRquestRowNib, forCellReuseIdentifier: leaveRequestIdentifier)


    print("HomeLeaveRequestTableViewCell")



    }

    override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
    }



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("LeaveRequestDataLeaveRequestData.count",LeaveRequestData.count)
    return LeaveRequestData.count
    }



    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: leaveRequestIdentifier, for: indexPath)as! HomeScreenLeaveRequestTableViewCell



    cell.selectionStyle = .none

    let leave : LeaveRequestType = LeaveRequestData[indexPath.row]




    if let selectedCell = selectedCell, selectedCell == indexPath {


    cell.rejectView.isHidden = false
    cell.approvalView.isHidden = false
    cell.sectionnameLbl.isHidden = false
    cell.departmentnameLbl.isHidden = false
    cell.coursenameLbl.isHidden = false
    cell.line1.isHidden = false
    cell.line2.isHidden = false
    cell.lineViewssss.isHidden = false
    cell.reasonLabel.isHidden = false
    }

    else{
    cell.rejectView.isHidden = true
    cell.approvalView.isHidden = true
    cell.sectionnameLbl.isHidden = true
    cell.departmentnameLbl.isHidden = true
    cell.coursenameLbl.isHidden = true
    cell.line1.isHidden = true
    cell.line2.isHidden = true
    cell.lineViewssss.isHidden = true
    cell.reasonLabel.isHidden = true

    }


    if  leave.message != nil{



    cell.OverAllView.isHidden = true


    cell.noRecordsFoundLabl.text = "No records found"


    }


    else{


    let first = String(leave.appliedon.prefix(10))

    cell.dateLabel.text = first

    cell.coursenameLbl.text = leave.coursename
    cell.toLbl.text = leave.todate
    cell.fromLbl.text = leave.fromdate
    cell.numberOfDaysLbl.text = leave.noofdays
    cell.leaveStatusLabel.text = leave.leavestatus
    cell.reasonLabel.text = leave.reason
    cell.nameLbl.text = leave.membername
    cell.sectionnameLbl.text = leave.sectionname
    cell.departmentnameLbl.text = leave.departmentname

    if (indexPath.row % 2 == 0){

    cell.OverAllView.backgroundColor = UIColor(named: "circularCellcolor")

    }

    else{

    cell.OverAllView.backgroundColor = UIColor(named: "circularEvenColor")

    }


    }


    let aprovel = approveHome(target: self, action: #selector(approveVc))
    leaveId = "1"
    print("leave.leaveapplicationid",leave.leaveapplicationid)
    aprovel.Leaveid = leave.leaveapplicationid
    cell.approvalView.addGestureRecognizer(aprovel)

    let reject = approveHome(target: self, action: #selector(RejectVc))
    leaveId = "2"
    reject.Leaveid = leave.leaveapplicationid
    cell.rejectView.addGestureRecognizer(reject)




    return cell
    ////

    }


    func getViewController() -> UIViewController? {

    if let rootController = UIApplication.shared.keyWindow?.rootViewController {
    var currentController: UIViewController! = rootController
    while( currentController.presentedViewController != nil ) {
    currentController = currentController.presentedViewController
    }
    return currentController
    }
    return nil

    }


    @IBAction func LeaveViewsVc(){





    if priority == "p1" {

    let vc =  SenderAttendanceVcViewController(nibName: nil, bundle: nil)
    vc.HomepageLeaveHistoryId = leaveID
    vc.view.backgroundColor = UIColor(named: "Principal")
    vc.segmentName.backgroundColor = UIColor(named: "UnSelector")
    vc.segmentName.selectedSegmentTintColor = UIColor(named: "Selector")
    vc.str = str
    vc.strName = strName
    vc.is_read_enabled = is_read_enabled
    vc.is_write_enabled = is_write_enabled

    let currentController = self.getViewController()

    vc.modalPresentationStyle = .fullScreen
    currentController?.present(vc, animated: true, completion: nil)



    }


    else if priority == "p2" || priority == "p3" {


    let vc =  SenderAttendanceVcViewController(nibName: nil, bundle: nil)

    vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
    vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
    vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
    vc.str = str
    vc.strName = strName
    vc.is_read_enabled = is_read_enabled
    vc.is_write_enabled = is_write_enabled

    let currentController = self.getViewController()
    vc.HomepageLeaveHistoryId = leaveID
    vc.modalPresentationStyle = .fullScreen
    currentController?.present(vc, animated: true, completion: nil)



    }


    else if priority == "p6" {


    let vc =  SenderAttendanceVcViewController(nibName: nil, bundle: nil)

    vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
    vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
    vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
    vc.str = str
    vc.strName = strName
    vc.is_read_enabled = is_read_enabled
    vc.is_write_enabled = is_write_enabled

    let currentController = self.getViewController()
    vc.HomepageLeaveHistoryId = leaveID
    vc.modalPresentationStyle = .fullScreen
    currentController?.present(vc, animated: true, completion: nil)



    }




    }



    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {




    if let selectedCells = selectedCell, selectedCells == indexPath {

    selectedCell = nil


    }

    else{

    selectedCell = indexPath

    }



    tv.beginUpdates()
    tv.reloadData()
    tv.endUpdates()



    }




    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {




    let leave : LeaveRequestType = LeaveRequestData[indexPath.row]




    if  leave.message == "No such record found!"{

    return 40

    }else{

    if let selectedCell = selectedCell, selectedCell == indexPath {

    return 260

    } else {

    return 185

    }


    }






    }



    @IBAction func RejectVc(gesture : approveHome){

    print("RejectVcRejectVcRejectVcRejectVc")

    let refreshAlert = UIAlertController(title: "Reject Leave", message: "Once Done can't be changed", preferredStyle: UIAlertController.Style.alert)

    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in


    let leaveAprovel = mangaeLeaveModal()

    leaveAprovel.leaveid = String(gesture.Leaveid)

    print("thidddsdsdcscx",gesture.Leaveid)
    leaveAprovel.userid = userid
    leaveAprovel.processtype = "2"



    let leaveApprovestr = leaveAprovel.toJSONString()

    print("leaveApprovestr",leaveApprovestr)
    manageLeaveRequests.call_request(param: leaveApprovestr!){ [self]

    (res) in



    let addApis : manageLeaveResponces = Mapper<manageLeaveResponces>().map(JSONString: res)!


    if addApis.Status == 1{


    let refreshAlert = UIAlertController(title: "", message: addApis.Message, preferredStyle: UIAlertController.Style.alert)

    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
    //                                        
    //                                    
    //                                        
    }))
    //                                    
    //                                   
    mainPresent!.present(refreshAlert, animated: true, completion: nil)

    }

    else{



    let refreshAlert = UIAlertController(title: "", message: addApis.Message, preferredStyle: UIAlertController.Style.alert)

    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in



    }))

    //                                   
    mainPresent!.present(refreshAlert, animated: true, completion: nil)
    }


    }

    }))


    refreshAlert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (action: UIAlertAction!) in
    print("Handle Cancel Logic here")
    }))

    mainPresent!.present(refreshAlert, animated: true, completion: nil)



    }



    @IBAction func approveVc(gesture : approveHome){


    let refreshAlert = UIAlertController(title: "Approved Leave", message: "Once Done can't be changed", preferredStyle: UIAlertController.Style.alert)

    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in


    let leaveAprovel = mangaeLeaveModal()

    leaveAprovel.leaveid = String(gesture.Leaveid)

    print("thidddsdsdcscx",gesture.Leaveid)
    leaveAprovel.userid = userid
    leaveAprovel.processtype = "1"



    let leaveApprovestr = leaveAprovel.toJSONString()

    print("leaveApprovestr",leaveApprovestr)
    manageLeaveRequests.call_request(param: leaveApprovestr!){ [self]

    (res) in



    let addApis : manageLeaveResponces = Mapper<manageLeaveResponces>().map(JSONString: res)!


    if addApis.Status == 1{



    let refreshAlert = UIAlertController(title: "", message: addApis.Message, preferredStyle: UIAlertController.Style.alert)

    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in



    }))


    mainPresent!.present(refreshAlert, animated: true, completion: nil)



    }

    else{


    let refreshAlert = UIAlertController(title: "", message: addApis.Message, preferredStyle: UIAlertController.Style.alert)

    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in



    }))



    }


    }


    }))


    refreshAlert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (action: UIAlertAction!) in
    print("Handle Cancel Logic here")
    }))

    mainPresent!.present(refreshAlert, animated: true, completion: nil)






    }



    }



    class approveHome : UITapGestureRecognizer{

    var Leaveid : Int!




    }

