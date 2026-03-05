//
//  PlacementTrainingVC.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 25/08/25.
//

import UIKit
import ObjectMapper

class PlacementTrainingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var BackView: UIView!
    @IBOutlet weak var BackBtn: UIButton!
    @IBOutlet weak var upcomingBtn: UIButton!
    @IBOutlet weak var HistoricalBtn: UIButton!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var noDataLbl: UILabel!
    
    var trainingData: [Training]?
    var departmentName : String?
    var semesterNo : String?
    var semesterNo1 : String?
    var collegeId : String?
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        departmentName = defaults.string(forKey: DefaultsKeys.deptname) ?? ""
        semesterNo = defaults.string(forKey: DefaultsKeys.semestername)
        collegeId = defaults.string(forKey: DefaultsKeys.collegeid)
        let component =  semesterNo?.components(separatedBy: " ")
        semesterNo = component?.last
        BackBtn.setTitleFont(style: .medium, size: 18)
        addUnderline(to: upcomingBtn, unselectedButton: HistoricalBtn)
        
        noDataLbl.isHidden = true
        
        tableview.register(UINib(nibName: "PlacementEventTvCell", bundle: nil), forCellReuseIdentifier: "PlacementEventTvCell")
        tableview.delegate = self
        tableview.dataSource = self
        
        Get_Placement_trainings_Api()
    }
    
    override func viewDidLayoutSubviews() {
        BackView.applyBottomShadow()
    }
    
    //MARK: Api Call
    func Get_Placement_trainings_Api(){
        
        let param: [String: String] = [
            "departmentname": departmentName ?? "",
            "semesterno": semesterNo ?? "",
            "collegeId": collegeId ?? ""
        ]
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.trainingEvent,
            httpMethod: .get,
            isBaseUrl: false,
            queryParam: param,
            requestBody: nil
        ) { [weak self] (result: Result<TrainingResponse,Error>) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                
                trainingData = success.data
                tableview.reloadData()
                let isEmpty = trainingData?.isEmpty ?? true
                noDataLbl.isHidden = !isEmpty
                tableview.isHidden = isEmpty
                tableview.reloadData()
                
            case .failure(let failure):
                self.trainingData = []
                self.noDataLbl.text = failure.localizedDescription
                self.noDataLbl.isHidden = false
                self.tableview.isHidden = true
                self.tableview.reloadData()
            }
        }
    }
    
    func Get_Placement_Training_Historical_Api(){
        
        let param: [String: String] = [
            "departmentname": departmentName ?? "",
            "semesterno": semesterNo ?? "",
            "collegeId": collegeId ?? ""
        ]
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.trainingEventHistorical,
            httpMethod: .get,
            isBaseUrl: false,
            queryParam: param,
            requestBody: nil
        ) { [weak self] (result: Result<TrainingResponse,Error>) in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                
                trainingData = success.data
                tableview.reloadData()
                let isEmpty = trainingData?.isEmpty ?? true
                noDataLbl.isHidden = !isEmpty
                tableview.isHidden = isEmpty
                tableview.reloadData()
                
            case .failure(let failure):
                self.trainingData = []
                self.noDataLbl.text = failure.localizedDescription
                self.noDataLbl.isHidden = false
                self.tableview.isHidden = true
                self.tableview.reloadData()
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
        Get_Placement_trainings_Api()
    }
    
    @IBAction func HistoricalAct(_ sender: Any) {
        addUnderline(to: HistoricalBtn, unselectedButton: upcomingBtn)
        Get_Placement_Training_Historical_Api()
    }
    
    @IBAction func BackBtnAct(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    func formatEventDateTime(dateString: String, timeString: String) -> (dateText: String, timeText: String) {
        // Formatters for parsing
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let timeFormatter24 = DateFormatter()
        timeFormatter24.dateFormat = "HH:mm:"
        timeFormatter24.locale = Locale(identifier: "en_US_POSIX")
        
        // Prepare formatted date
        let dateText: String
        if let date = dateFormatter.date(from: dateString) {
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "dd"
            let day = dayFormatter.string(from: date)
            
            let monthFormatter = DateFormatter()
            monthFormatter.dateFormat = "MMM"
            let month = monthFormatter.string(from: date)
            
            dateText = "\(day)\n\(month)"
        } else {
            dateText = dateString // fallback
        }
        
        // Prepare formatted time
        let timeText: String
        if let parsedTime = timeFormatter24.date(from: timeString) {
            let timeFormatter12 = DateFormatter()
            timeFormatter12.dateFormat = "hh:mm"
            timeFormatter12.locale = Locale(identifier: "en_US_POSIX")
            
            let amPmFormatter = DateFormatter()
            amPmFormatter.dateFormat = "a"
            amPmFormatter.locale = Locale(identifier: "en_US_POSIX")
            
            let timeStr = timeFormatter12.string(from: parsedTime)
            let amPm = amPmFormatter.string(from: parsedTime)
            
            timeText = "\(timeStr)\n\(amPm)"
        } else {
            timeText = timeString // fallback
        }
        
        return (dateText, timeText)
    }
    
    
    func formatTrainingTime(startTime: String, endTime: String) -> String {
        // Formatter to parse "HH:mm"
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "HH:mm:"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        // Formatter to display "hh:mm a"
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "hh:mm a"
        outputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        // Parse start time
        let startFormatted: String
        if let startDate = inputFormatter.date(from: startTime) {
            startFormatted = outputFormatter.string(from: startDate)
        } else {
            startFormatted = startTime // fallback
        }
        
        // Parse end time
        let endFormatted: String
        if let endDate = inputFormatter.date(from: endTime) {
            endFormatted = outputFormatter.string(from: endDate)
        } else {
            endFormatted = endTime // fallback
        }
        
        return "\(startFormatted) to \(endFormatted)"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trainingData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "PlacementEventTvCell", for: indexPath) as! PlacementEventTvCell
        
        cell.companiesCV.isHidden = true
        cell.selectionProcessStack.isHidden = true
        
        cell.PlacementEventDefLbl.text = "Placement Training"
        cell.placementDefView.backgroundColor = .systemRed
        cell.dateBaseView.backgroundColor = .systemRed
        
        let training = trainingData?[indexPath.row]
        
        cell.eventNameLbl.text = training?.trainingTitle
        cell.eventDescriptionLbl.text = training?.trainingAbout
        cell.locationBtn.setTitle(training?.venue, for: .normal)
        
        let formatted = formatEventDateTime(dateString: training?.trainingDate ?? "", timeString: training?.startTime ?? "")
        cell.dateLbl.text = formatted.dateText
        cell.dateLbl.numberOfLines = 2
        cell.dateLbl.textAlignment = .center
        
        cell.timeLbl.text = formatted.timeText
        cell.timeLbl.numberOfLines = 2
        cell.timeLbl.textAlignment = .center
        
        
        cell.eventModeLbl.text = training?.modeTraining
        cell.eligibleCourseDefLbl.text = "Applicable Batches"
        cell.eligibleCoursesLbl.text = training?.applicableBatches?.joined(separator: ",")
        cell.eligibilityCriteriaDefLbl.text = "Trainer Name"
        cell.EligibilityCriteriaLbl.text = training?.trainerName
        
        // cell.scheduledTimeLbl.text = formatTrainingTime(startTime: training?.startTime ?? "", endTime: training?.endTime ?? "")
        
        cell.scheduledTimeLbl.text = (training?.startTime ?? "") + " to " + (training?.endTime ?? "")
        
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        // Try to parse the repeatUntil date
        let formattedDate: String
        if let repeatUntil = training?.repeatUntil,
           let date = isoFormatter.date(from: repeatUntil) {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM yyyy"
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formattedDate = formatter.string(from: date)
        } else {
            formattedDate = training?.repeatUntil ?? "" // fallback to original string
        }
        
        // Build final string
        let repeatText = "Repeats every \(training?.repeatTraining ?? "") \(training?.selectDay ?? "") until \(formattedDate)"
        cell.repeatsonLbl.text = repeatText
        
        cell.repeatsOnBaseView.isHidden = !(training?.recursiveTraining ?? false)
        //        tableview.beginUpdates()
        //        tableview.endUpdates()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
