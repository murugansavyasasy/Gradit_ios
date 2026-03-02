    //
    //  NoticeBoardTableViewCell.swift
    //  Vs_GradIt
    //
    //  Created by APPLE on 26/09/22.
    //

    import UIKit
    import ObjectMapper

    @available(iOS 16.0, *)
    class NoticeBoardTableViewCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {



    var noticeBoardData : [NoticeBoardDashType] = []

    var dash : [DashBoardData] = []

    let cvIdentifier = "NoticeBoardScrollCollectionViewCell"

    @IBOutlet weak var noticeView: UIViewX!

    @IBOutlet weak var cv: UICollectionView!

    var dashtypes : String!

    var colgId : String!
    var memberId : String!
    var loginAsType : String!
    var priority : String!

    var str : [String] = []

    var strName : [String] = []
    var is_read_enabled = ""
    var is_write_enabled = ""
    var currentIndex = 0
    var autoScrollTimer: Timer?
    override func awakeFromNib() {
    super.awakeFromNib()


    print("noticeBoardCheck")

    //        print("asdfghjklkjhgf")


    cv.dataSource = self
    cv.delegate = self
    let defaults = UserDefaults.standard
    colgId = defaults.string(forKey: DefaultsKeys.collegeid)
    memberId = defaults.string(forKey: DefaultsKeys.memberid)
    loginAsType = defaults.string(forKey: DefaultsKeys.loginAsType)
    priority = defaults.string(forKey: DefaultsKeys.priority)

    //        notice()
    let cvRowib = UINib(nibName: cvIdentifier, bundle: nil)
    cv.register(cvRowib, forCellWithReuseIdentifier: cvIdentifier)




    }



    override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)


    }








    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {


    return noticeBoardData.count


    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {





    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cvIdentifier, for: indexPath) as! NoticeBoardScrollCollectionViewCell


    let notice :  NoticeBoardDashType =  noticeBoardData[indexPath.row]


    let dateFormatterGet = DateFormatter()

    dateFormatterGet.dateFormat = "dd-MM-yyy"



    let dateFormatterPrint = DateFormatter()

    dateFormatterPrint.dateFormat = " dd MMM,yyyy"



    let date: NSDate? = dateFormatterGet.date(from: notice.createddate) as NSDate?

    print(dateFormatterPrint.string(from: date as! Date))



    var dateString2 = notice.createdtime
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "hh:mm:ss a"
    dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")

            let dateObj = dateFormatter.date(from: dateString2!)
            dateFormatter.dateFormat = "hh:mm a"

    cell.headingLbl.text = notice.topicheading
    cell.descLbl.text = notice.topicbody
    cell.dateLbl.text = dateFormatterPrint.string(from: date as! Date)
    cell.timeLbl.text = (dateFormatter.string(from: dateObj!))





    if (indexPath.row % 2 == 0){

    UIGraphicsBeginImageContext(cell.noteImageView.frame.size)
    if let image = UIGraphicsGetImageFromCurrentImageContext(){
    UIGraphicsEndImageContext()
    cell.noteImageView.image = UIImage(named: "noticeboard_blue")
    }else{
    UIGraphicsEndImageContext()
    debugPrint("Image not available")
    }



    }

    else{
    UIGraphicsBeginImageContext(cell.noteImageView.frame.size)
    UIImage(named: "noticeboard_yellow")?.draw(in: cell.noteImageView.bounds)

    if let image = UIGraphicsGetImageFromCurrentImageContext(){
    UIGraphicsEndImageContext()

    cell.noteImageView.image = UIImage(named: "noticeboard_yellow")
    }else{
    UIGraphicsEndImageContext()
    debugPrint("Image not available")
    }

    }


    let cellView = UITapGestureRecognizer(target: self, action: #selector(CellVc))

    cell.noticeCvFullv.addGestureRecognizer(cellView)

    return cell

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






    @IBAction func CellVc(){

    if priority == "p4" {
    let vc =  NoticeBoardHomePageViewController(nibName: nil, bundle: nil)
    let currentController = self.getViewController()
    vc.str = str
    vc.strName = strName
    vc.is_read_enabled = is_read_enabled
    vc.is_write_enabled = is_write_enabled
    vc.modalPresentationStyle = .fullScreen
    currentController?.present(vc, animated: true,completion: nil)

    }

    else if priority == "p1" {

    let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)

    vc.view.backgroundColor = UIColor(named: "Principal" )
    vc.noticeSegments.backgroundColor = UIColor(named: "UnSelector")
    vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "Selector")
    vc.str = str
    vc.strName = strName
    vc.is_read_enabled = is_read_enabled
    vc.is_write_enabled = is_write_enabled
    let currentController = self.getViewController()
    vc.modalPresentationStyle = .fullScreen
    currentController?.present(vc, animated: true,completion: nil)

    }


    else if priority == "p2" || priority == "p3" {

    let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
    vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
    vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
    vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
    vc.str = str
    vc.strName = strName
    vc.is_read_enabled = is_read_enabled
    vc.is_write_enabled = is_write_enabled
    let currentController = self.getViewController()
    vc.modalPresentationStyle = .fullScreen
    currentController?.present(vc, animated: true,completion: nil)

    }


    else if priority == "p6"  {

    let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
    vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
    vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
    vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
    vc.str = str
    vc.strName = strName
    vc.is_read_enabled = is_read_enabled
    vc.is_write_enabled = is_write_enabled
    let currentController = self.getViewController()
    vc.modalPresentationStyle = .fullScreen
    currentController?.present(vc, animated: true,completion: nil)

    }


    }



    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {


    //
    }



    func notice(){

    print("notidee")
    let noti = DashBoardModal()

    noti.collegeid = colgId
    noti.userid = memberId
    noti.priority = priority

    let dashBoardStr = noti.toJSONString()


    DashBoardRequest.call_request(param: dashBoardStr!) {
    [self]
    (res) in




    let dashBoardResponse : DashBoardResponse = Mapper<DashBoardResponse>().map(JSONString: res)!


    dash = dashBoardResponse.data
    for i in dash{

    dashtypes = i.dashType


    if i.dashType == "Notice Board"{

    noticeBoardData =   i.noticeSubData

    print("nonoon",noticeBoardData)


    }

    cv.delegate = self
    cv.dataSource = self
    cv.reloadData()

    }





    }




    }








    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {


    return CGSize(width: 195, height: 289)
    }








    }
