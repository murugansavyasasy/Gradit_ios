//
//  PlacementEventsVC.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 24/08/25.
//

import UIKit
import ObjectMapper

class PlacementEventsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var BackView: UIView!
    @IBOutlet weak var BackBtn: UIButton!
    @IBOutlet weak var upcomingBtn: UIButton!
    @IBOutlet weak var HistoricalBtn: UIButton!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var noDataLbl: UILabel!
    
    var EventData: [MemberData]?
    var memberId : String?
    var collegeId : String?
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        collegeId = defaults.string(forKey: DefaultsKeys.collegeid)
        BackBtn.setTitleFont(style: .medium, size: 18)
        addUnderline(to: upcomingBtn, unselectedButton: HistoricalBtn)

        tableview.register(UINib(nibName: "PlacementEventTvCell", bundle: nil), forCellReuseIdentifier: "PlacementEventTvCell")
        tableview.delegate = self
        tableview.dataSource = self
        noDataLbl.isHidden = true
        Get_Placement_Evnets_Api()
    }
    
    override func viewDidLayoutSubviews() {
        BackView.applyBottomShadow()
    }
    
    //MARK: Api Call
    func Get_Placement_Evnets_Api(){
        
        let param:[String: Any] = ["memberId":memberId ?? "","collegeId": Int(collegeId ?? "") ?? 0]
        Get_PlacementEvents_Request.call_request(param: param) { [weak self] (res) in
            
            guard let eventsResponse = Mapper<MemberEventsResponse>().map(JSONString: res) else {
                self?.noDataLbl.isHidden = false
                return
            }
            
            DispatchQueue.main.async {
                
                if eventsResponse.status == true {
                    self?.EventData = eventsResponse.data
                    self?.tableview.reloadData()
                    self?.noDataLbl.text = eventsResponse.message
                    if self?.EventData?.isEmpty == true{
                        self?.noDataLbl.isHidden = false
                    }else {
                        self?.noDataLbl.isHidden = true
                    }
                    
                }else {
                    self?.noDataLbl.text = eventsResponse.message
                    self?.noDataLbl.isHidden = false
                    self?.EventData = eventsResponse.data
                    self?.tableview.reloadData()
                    self?.noDataLbl.text = eventsResponse.message
                }
            }
            
        }
    }
    
    func Get_Placement_Evnets_Historical_Api(){
        
        Get_Historical_PlacementEvents_Request.call_request(param: ["memberId":memberId ?? "", "collegeId": Int(collegeId ?? "") ?? 0]) { [weak self] (res) in
            
            guard let eventsResponse = Mapper<MemberEventsResponse>().map(JSONString: res) else {return}
            
            DispatchQueue.main.async {
                
                if eventsResponse.status == true {
                    self?.EventData = eventsResponse.data
                    self?.tableview.reloadData()
                    self?.noDataLbl.isHidden = true
                    self?.noDataLbl.text = eventsResponse.message
                    if self?.EventData?.isEmpty == true{
                        self?.noDataLbl.isHidden = false
                    }else {
                        self?.noDataLbl.isHidden = true
                    }
                }else {
                    self?.noDataLbl.isHidden = false
                    self?.noDataLbl.text = eventsResponse.message
                    self?.EventData = eventsResponse.data
                    self?.tableview.reloadData()
                    self?.noDataLbl.text = eventsResponse.message
                }
            }
        }
    }
    
    func addUnderline(to selectedButton: UIButton, unselectedButton: UIButton) {
        // Remove underline from both buttons
        [selectedButton, unselectedButton].forEach { button in
            button.subviews.filter { $0.tag == 999 }.forEach { $0.removeFromSuperview() }
            button.tintColor = .black
        }

        // Add underline to the selected button
        selectedButton.tintColor = .systemBlue
        let underline = UIView()
        underline.tag = 999
        underline.backgroundColor = .systemBlue
        underline.translatesAutoresizingMaskIntoConstraints = false
        selectedButton.addSubview(underline)

        NSLayoutConstraint.activate([
            underline.heightAnchor.constraint(equalToConstant: 2),
            underline.leadingAnchor.constraint(equalTo: selectedButton.leadingAnchor),
            underline.trailingAnchor.constraint(equalTo: selectedButton.trailingAnchor),
            underline.bottomAnchor.constraint(equalTo: selectedButton.bottomAnchor)
        ])
    }

    
    @IBAction func UpcomingAct(_ sender: Any) {
        
        addUnderline(to: upcomingBtn, unselectedButton: HistoricalBtn)
        Get_Placement_Evnets_Api()
    }
    
    @IBAction func HistoricalAct(_ sender: Any) {
        addUnderline(to: HistoricalBtn, unselectedButton: upcomingBtn)
        Get_Placement_Evnets_Historical_Api()
    }
    
    @IBAction func BackBtnAct(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    func formatEventDateTime(newDate: String, newTime: String) -> (dateText: String, timeText: String)? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = isoFormatter.date(from: newDate) else {
            return nil
        }
        
        // Day + Month
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "dd"
        let day = dayFormatter.string(from: date)
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MMM"
        let month = monthFormatter.string(from: date)
        
        // Parse "16:30:00" into a Date
        let timeFormatter24 = DateFormatter()
        timeFormatter24.dateFormat = "HH:mm:ss"
        guard let parsedTime = timeFormatter24.date(from: newTime) else {
            return nil
        }
        
        // Format time 12-hour
        let timeFormatter12 = DateFormatter()
        timeFormatter12.dateFormat = "hh:mm"
        let timeStr = timeFormatter12.string(from: parsedTime)
        
        let amPmFormatter = DateFormatter()
        amPmFormatter.dateFormat = "a"
        let amPm = amPmFormatter.string(from: parsedTime)
        
        return ("\(day)\n\(month)", "\(timeStr)\n\(amPm)")
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventData?.first?.events?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "PlacementEventTvCell", for: indexPath) as! PlacementEventTvCell
        
        cell.trainingTimeStack.isHidden = true
        
        let Event = EventData?.first?.events?[indexPath.row]
        
        cell.eventNameLbl.text = Event?.eventTitle
        cell.eventDescriptionLbl.text = Event?.aboutEvent
        cell.locationBtn.setTitle(Event?.venue, for: .normal)
        
        if let formatted = formatEventDateTime(newDate: Event?.eventDate ?? "", newTime: Event?.eventTime ?? "") {
            cell.dateLbl.text = formatted.dateText
            cell.dateLbl.numberOfLines = 2
            cell.dateLbl.textAlignment = .center
            
            cell.timeLbl.text = formatted.timeText
            cell.timeLbl.numberOfLines = 2
            cell.timeLbl.textAlignment = .center
        }

        cell.eventModeLbl.text = Event?.modeOfEvent
        let courses =  Event?.eligibleCourses?.joined(separator: ",")
        print("courses",courses ?? "")
        cell.eligibleCoursesLbl.text = courses
        cell.EligibilityCriteriaLbl.text = Event?.eligibleCriteria
        
        cell.configure(first: Event?.companyDetails ?? [], second: Event?.selectionProcess ?? [])
        
        tableview.beginUpdates()
        tableview.endUpdates()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
