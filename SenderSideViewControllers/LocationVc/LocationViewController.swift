//
//  LocationViewController.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 29/08/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import UIKit
import CoreLocation
import ObjectMapper
import DropDown
import LocalAuthentication


class LocationViewController: UIViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var punchView: UIView!
    @IBOutlet weak var histroyView: UIView!
    @IBOutlet weak var markAttendDfltLbl: UILabel!
    @IBOutlet weak var attendanceDefltLbl: UILabel!
    @IBOutlet weak var dropDownStack: UIStackView!
    @IBOutlet weak var selectYrsview: UIViewX!
    @IBOutlet weak var selectMonth: UIViewX!
    @IBOutlet weak var selectYearsLbl: UILabel!
    @IBOutlet weak var selectMonthlbl: UILabel!
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var noRecordLbl: UILabel!
    @IBOutlet weak var punchFullView: UIView!
    @IBOutlet weak var punchButton: UIViewX!
    @IBOutlet weak var faceIdDefaultLbl: UILabel!
    @IBOutlet weak var switchBtn: UISwitch!
    @IBOutlet weak var locationAlertFullView: UIViewX!
    @IBOutlet weak var enabelview: UIViewX!
    @IBOutlet weak var ErrorLablelView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var plusview: UIView!
    @IBOutlet weak var plusOuterview: UIView!
    
    enum Tab { case punch, history }
    
    let tableIdentifier = "LocationTableViewCell"
    let defaults = UserDefaults.standard
    let locationManager = CLLocationManager()
    let dropDown = DropDown()
    var currentTab: Tab = .punch
    var isAuthenticating = false
    var memberId = ""
    var collegeId = ""
    var device = UIDevice.current.name
    var punch_type = 1
    var currentLat = ""
    var currentLogi = ""
    var referenceAddress = ""
    var currentDistanceForPunchCheck: Double?
    var apiDistanceForPunchCheck: Int?
    var is_read_enabled = ""
    var is_write_enabled = ""
    var years: [String] = []
    var monthNames: [String] = []
    var historyData: [GetHirstorydatadetails] = []
    
    // Formatters are expensive – create once
    private static let inputDateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "en_US_POSIX")
        f.dateFormat = "dd/MM/yyyy"
        return f
    }()
    private static let dayNameFormatter: DateFormatter = {
        let f = DateFormatter(); f.dateFormat = "EEEE"; return f
    }()
    private static let monthShortFormatter: DateFormatter = {
        let f = DateFormatter(); f.dateFormat = "MMM"; return f
    }()
    private static let dayNumberFormatter: DateFormatter = {
        let f = DateFormatter(); f.dateFormat = "d"; return f
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memberId = defaults.string(forKey: DefaultsKeys.memberid) ?? ""
        collegeId = defaults.string(forKey: DefaultsKeys.collegeid) ?? ""
        device = UIDevice.current.modelName
        setupInitialUI()
        setupMonthsAndYears()
        setupTable()
        setupGestures()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        selectTab(.punch)
        checkLocationServices()
    }
    
    func setupInitialUI() {
        topView.backgroundColor = .priorityColor
        switchBtn.isHidden = true
        faceIdDefaultLbl.isHidden = true
        ErrorLablelView.isHidden = true
        errorLabel.isHidden = true
        noRecordLbl.isHidden = true
        punchFullView.isHidden = true
        dropDownStack.isHidden = true
        tv.isHidden = true
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 4
        paragraph.alignment = .center
        let text = "Note: You are outside the institute's boundary. You will not be able to mark your attendance.\n\nPlease try again when you are within the designated area."
        errorLabel.attributedText = NSAttributedString(string: text, attributes: [
            .paragraphStyle: paragraph,
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor.white
        ])
    }
    
    func setupMonthsAndYears() {
        let currentYear = Calendar.current.component(.year, from: Date())
        years = (0..<21).map { String(currentYear - $0) }
        selectYearsLbl.text = years.first
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        monthNames = formatter.monthSymbols
        let currentMonthIndex = Calendar.current.component(.month, from: Date()) - 1
        selectMonthlbl.text = monthNames.indices.contains(currentMonthIndex) ? monthNames[currentMonthIndex] : monthNames.first
    }
    
    func setupTable() {
        tv.register(UINib(nibName: tableIdentifier, bundle: nil), forCellReuseIdentifier: tableIdentifier)
        tv.dataSource = self
        tv.delegate = self
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 100
    }
    
    func setupGestures() {
        func tap(_ view: UIView, _ action: Selector) {
            view.isUserInteractionEnabled = true
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: action))
        }
        tap(histroyView, #selector(didTapHistoryTab))
        tap(punchView, #selector(didTapPunchTab))
        tap(punchButton, #selector(didTapPunchButton))
        tap(plusview, #selector(didTapAddLocation))
        tap(backView, #selector(didTapBack))
        tap(enabelview, #selector(didTapEnableLocation))
        tap(selectYrsview, #selector(didTapYearDropDown))
        tap(selectMonth, #selector(didTapMonthDropDown))
    }
    
    func selectTab(_ tab: Tab) {
        currentTab = tab
        let active = UIColor.priorityColor
        let isPunch = tab == .punch
        punchView.backgroundColor = isPunch ? active : .clear
        markAttendDfltLbl.textColor = isPunch ? .white : .black
        histroyView.backgroundColor = isPunch ? .clear : active
        attendanceDefltLbl.textColor = isPunch ? .black : .white
        updatePlusVisibility(showing: isPunch)
    }
    
    func updatePlusVisibility(showing: Bool) {
        let visible = showing && is_write_enabled == "1"
        plusview.isHidden = !visible
        plusOuterview.isHidden = !visible
    }
    
    @objc func didTapPunchTab() {
        selectTab(.punch)
        tv.isHidden = true
        noRecordLbl.isHidden = true
        dropDownStack.isHidden = true
        checkLocationServices()
    }
    
    @objc func didTapHistoryTab() {
        selectTab(.history)
        dropDownStack.isHidden = false
        punchFullView.isHidden = true
        locationAlertFullView.isHidden = true
        ErrorLablelView.isHidden = true
        tv.isHidden = false
        loadAttendanceHistory()
    }
    
    @objc func didTapBack() {
        dismiss(animated: true)
    }
    
    @objc func didTapEnableLocation() {
        guard let url = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @objc func didTapAddLocation() {
        let vc = CreateLocationViewController(nibName: nil, bundle: nil)
        vc.latitude = currentLat
        vc.longitude = currentLogi
        vc.refrenceAddress = referenceAddress
        vc.collegeId = Int(collegeId)
        vc.memberId = Int(memberId)
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true)
    }
    
    @objc func didTapPunchButton() {
        guard let current = currentDistanceForPunchCheck,
              let allowed = apiDistanceForPunchCheck else {
            checkLocationServices()
            return
        }
        if current <= Double(allowed) {
            updateAreaState(inside: true)
            punchAPI()
        } else {
            updateAreaState(inside: false)
        }
    }
    
    func updateAreaState(inside: Bool) {
        punchFullView.isHidden = !inside
        errorLabel.isHidden = inside
        ErrorLablelView.isHidden = inside
    }
    
    @objc func didTapYearDropDown() {
        showDropDown(anchor: selectYrsview, items: years) { [weak self] item in
            guard let self = self else { return }
            self.selectYearsLbl.text = item
            self.selectMonthlbl.text = self.monthNames.first
            self.loadAttendanceHistory()
        }
    }
    
    @objc func didTapMonthDropDown() {
        showDropDown(anchor: selectMonth, items: monthNames) { [weak self] item in
            self?.selectMonthlbl.text = item
            self?.loadAttendanceHistory()
        }
    }
    
    func showDropDown(anchor: UIView, items: [String], onSelect: @escaping (String) -> Void) {
        dropDown.dataSource = items
        dropDown.anchorView = anchor
        dropDown.bottomOffset = CGPoint(x: 0, y: anchor.bounds.height)
        dropDown.direction = .bottom
        DropDown.appearance().backgroundColor = UIColor.white
        dropDown.selectionAction = { (_: Int, item: String) in onSelect(item) }
        dropDown.show()
    }
    
    var authorizationStatus: CLAuthorizationStatus {
        if #available(iOS 14.0, *) { return locationManager.authorizationStatus }
        return CLLocationManager.authorizationStatus()
    }
    
    func checkLocationServices() {
        DispatchQueue.global(qos: .userInitiated).async {
            let isEnabled = CLLocationManager.locationServicesEnabled()
            DispatchQueue.main.async {
                guard isEnabled else {
                    self.showLocationAlert()
                    return
                }

                self.handleAuthorization()
            }
        }
    }
    func handleAuthorization() {
        switch authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            showLocationAlert()
        case .authorizedAlways, .authorizedWhenInUse:
            locationAlertFullView.isHidden = true
            authenticateThenLocate()
        @unknown default:
            break
        }
    }
    
    func showLocationAlert() {
        locationAlertFullView.isHidden = false
        punchFullView.isHidden = true
        ErrorLablelView.isHidden = true
        tv.isHidden = true
    }
    
    func authenticateThenLocate() {
        guard !isAuthenticating else { return }
        
        let context = LAContext()
        let policy: LAPolicy = .deviceOwnerAuthentication
        var error: NSError?
        
        guard context.canEvaluatePolicy(policy, error: &error) else {
            punch_type = 1
            startLocationUpdates()
            return
        }
        
        isAuthenticating = true
        context.evaluatePolicy(policy, localizedReason: "Please authenticate to proceed") { [weak self] success, _ in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isAuthenticating = false
                self.punch_type = success ? 3 : 1
                self.startLocationUpdates()
            }
        }
    }
    
    func startLocationUpdates() {
        locationManager.startUpdatingLocation()
    }
    
    func fetchAllowedLocations(latitude: String, longitude: String) {
        var request = fechRequ()
        request.CollegeId = Int(collegeId)
        request.userId = Int(memberId)
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetStaffLocationDetails, httpMethod: .post, queryParam: nil, requestBody: request) { [weak self] (result: Result<fechModal, Error>) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    guard response.status == 1 else {
                        self.ErrorLablelView.isHidden = true
                        self.showNoRecord(response.message)
                        return
                    }
                    self.noRecordLbl.isHidden = true
                    let candidates = (response.data ?? []).map { (lat: $0.latitude, lon: $0.longitude, radius: $0.distance) }
                    self.evaluateLocations(candidates, latitude: latitude, longitude: longitude)
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func evaluateLocations(_ locations: [(lat: String?, lon: String?, radius: String?)], latitude: String, longitude: String) {
        let userLat = Double(latitude) ?? 0
        let userLon = Double(longitude) ?? 0
        
        var nearest: (distance: Double, radius: Int)?
        var isInside = false
        
        for item in locations {
            guard let lat = Double(item.lat ?? ""), let lon = Double(item.lon ?? "") else { continue }
            let radius = Int(item.radius ?? "") ?? 0
            let distance = haversineDistance(lat1: lat, lon1: lon, lat2: userLat, lon2: userLon)
            
            if distance <= Double(radius) {
                nearest = (distance, radius)
                isInside = true
                break
            }
            if nearest == nil || distance < nearest!.distance {
                nearest = (distance, radius)
            }
        }
        
        guard let result = nearest else {
            showNoRecord("No punch location available.")
            return
        }
        currentDistanceForPunchCheck = result.distance
        apiDistanceForPunchCheck = result.radius
        if currentTab == .punch { updateAreaState(inside: isInside) }
    }
    
    func showNoRecord(_ message: String?) {
        noRecordLbl.text = message
        noRecordLbl.isHidden = false
    }
    
    func haversineDistance(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> Double {
        let earthRadiusMeters = 6_371_000.0
        let dLat = degreesToRadians(lat2 - lat1)
        let dLon = degreesToRadians(lon2 - lon1)
        let a = sin(dLat / 2) * sin(dLat / 2)
        + cos(degreesToRadians(lat1)) * cos(degreesToRadians(lat2)) * sin(dLon / 2) * sin(dLon / 2)
        return earthRadiusMeters * 2 * atan2(sqrt(a), sqrt(1 - a))
    }
    
    func degreesToRadians(_ degrees: Double) -> Double {
        degrees * .pi / 180
    }
    
    func convertCoordinatesToAddress(location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location) { [weak self] placemarks, error in
            if let error = error {
                print("Error in reverse geocoding: \(error.localizedDescription)")
                return
            }
            guard let placemark = placemarks?.first else { return }
            DispatchQueue.main.async {
                self?.referenceAddress = Self.formatAddress(from: placemark)
            }
        }
    }
    
    static func formatAddress(from placemark: CLPlacemark) -> String {
        [placemark.name,
         placemark.thoroughfare,
         placemark.locality,
         placemark.administrativeArea,
         placemark.postalCode,
         placemark.country]
            .compactMap { $0 }
            .joined(separator: ", ")
    }
    
    func punchAPI() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        var request = punchModal()
        request.CollegeId = Int(collegeId)
        request.UserId = Int(memberId)
        request.staff_or_student = "staff"
        request.punch_type = punch_type
        request.deviceId = appDelegate.DeviceToken
        request.device_model = device
        
        APiCallManager.shared.callApi(url: APIEndpoints.BiometricEntryusingApp, httpMethod: .post, queryParam: nil, requestBody: request) { [weak self] (result: Result<[punchResponce], Error>) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    // Same alert for success and failure – the server message tells the user which one it was
                    let alert = UIAlertController(title: "", message: response.first?.message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func loadAttendanceHistory() {
        let year = selectYearsLbl.text ?? ""
        guard let monthIndex = monthNames.firstIndex(of: selectMonthlbl.text ?? "") else {
            print("Invalid month name.")
            return
        }
        let monthParam = String(format: "%@-%02d", year, monthIndex + 1)
        
        var request = GethistoryModalReq()
        request.CollegeId = Int(collegeId)
        request.userId = Int(memberId)
        request.attendance_month = monthParam
        request.attendance_dt = ""
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetBiometricPrincipalAttendance, httpMethod: .post, queryParam: nil, requestBody: request) { [weak self] (result: Result<GethistoryModal, Error>) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    if response.status == 1 {
                        self.historyData = response.data ?? []
                        self.noRecordLbl.isHidden = true
                        self.tv.isHidden = false
                        self.tv.reloadData()
                    } else {
                        self.tv.isHidden = true
                        self.ErrorLablelView.isHidden = true
                        self.showNoRecord(response.message)
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
}

// MARK: - CLLocationManagerDelegate

extension LocationViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        handleAuthorization()
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if #unavailable(iOS 14.0) { handleAuthorization() }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        manager.stopUpdatingLocation()
        
        locationAlertFullView.isHidden = true
        if currentTab == .punch { tv.isHidden = true }
        
        currentLat = String(location.coordinate.latitude)
        currentLogi = String(location.coordinate.longitude)
        
        convertCoordinatesToAddress(location: location)
        fetchAllowedLocations(latitude: currentLat, longitude: currentLogi)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let clError = error as? CLError {
            switch clError.code {
            case .denied: print("Location access denied by user.")
            case .locationUnknown: print("Location could not be determined.")
            default: print("Location Manager error: \(clError.localizedDescription)")
            }
        } else {
            print("Location Manager error: \(error.localizedDescription)")
        }
    }
}


extension LocationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        historyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableIdentifier, for: indexPath) as? LocationTableViewCell else {
            return UITableViewCell()
        }
        let data = historyData[indexPath.row]
        
        cell.selectionStyle = .none
        cell.namelbl.text = data.staff_name
        cell.attendanceTypeLbl.text = data.attendance_type
        cell.StatusLbl.text = data.leave_type
        cell.StatusLbl.layer.cornerRadius = 5
        cell.StatusLbl.layer.masksToBounds = true
        cell.StatusLbl.backgroundColor = (data.leave_type == "Absent") ? .red : UIColor(named: "presentGreen")
        
        if let dateString = data.attendance_dt,
           let date = Self.inputDateFormatter.date(from: dateString) {
            cell.dayLbl.text = Self.dayNameFormatter.string(from: date)
            cell.datelbl.text = Self.dayNumberFormatter.string(from: date)
            cell.mnthLbl.text = Self.monthShortFormatter.string(from: date)
        }
        
        cell.workingHrsLbl.text = "Working Hours - \(data.working_hours ?? 0)"
        cell.workingHrsLbl.isHidden = (data.working_hours ?? 0) == 0
        cell.firstInLbl.text = "First in - \(data.in_time ?? "0")"
        cell.firstInLbl.isHidden = (data.in_time ?? "").isEmpty
        cell.toDateLbl.text = "Last out - \(data.out_time ?? "0")"
        cell.toDateLbl.isHidden = (data.out_time ?? "").isEmpty
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let data = historyData[indexPath.row]
        
        let vc = PunchHistoryListVC(nibName: nil, bundle: nil)
        vc.date = data.attendance_dt ?? ""
        vc.collegeId = Int(collegeId)
        vc.staffId = data.staff_id
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true)
    }
}

// MARK: - Device model name

extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let code = withUnsafePointer(to: &systemInfo.machine) {
            String(cString: UnsafeRawPointer($0).assumingMemoryBound(to: CChar.self))
        }
        return Self.modelMap[code] ?? code
    }
    
    static let modelMap: [String: String] = [
        // iPhone 16 / 15 / 14
        "iPhone17,1": "iPhone 16 Pro", "iPhone17,2": "iPhone 16 Pro Max",
        "iPhone16,3": "iPhone 16", "iPhone16,4": "iPhone 16 Plus",
        "iPhone16,1": "iPhone 15 Pro", "iPhone16,2": "iPhone 15 Pro Max",
        "iPhone15,4": "iPhone 15", "iPhone15,5": "iPhone 15 Plus",
        "iPhone15,2": "iPhone 14 Pro", "iPhone15,3": "iPhone 14 Pro Max",
        "iPhone14,7": "iPhone 14", "iPhone14,8": "iPhone 14 Plus",
        // iPhone 13 / 12 / 11
        "iPhone14,2": "iPhone 13 Pro", "iPhone14,3": "iPhone 13 Pro Max",
        "iPhone14,4": "iPhone 13 mini", "iPhone14,5": "iPhone 13",
        "iPhone13,1": "iPhone 12 mini", "iPhone13,2": "iPhone 12",
        "iPhone13,3": "iPhone 12 Pro", "iPhone13,4": "iPhone 12 Pro Max",
        "iPhone12,1": "iPhone 11", "iPhone12,3": "iPhone 11 Pro", "iPhone12,5": "iPhone 11 Pro Max",
        // iPhone X series and older
        "iPhone11,8": "iPhone XR", "iPhone11,2": "iPhone XS",
        "iPhone11,4": "iPhone XS Max", "iPhone11,6": "iPhone XS Max (China)",
        "iPhone10,3": "iPhone X", "iPhone10,6": "iPhone X (GSM)",
        "iPhone10,1": "iPhone 8", "iPhone10,4": "iPhone 8 (GSM)",
        "iPhone10,2": "iPhone 8 Plus", "iPhone10,5": "iPhone 8 Plus (GSM)",
        "iPhone9,1": "iPhone 7", "iPhone9,3": "iPhone 7 (GSM)",
        "iPhone9,2": "iPhone 7 Plus", "iPhone9,4": "iPhone 7 Plus (GSM)",
        "iPhone8,1": "iPhone 6s", "iPhone8,2": "iPhone 6s Plus", "iPhone8,4": "iPhone SE (1st generation)",
        "iPhone7,2": "iPhone 6", "iPhone7,1": "iPhone 6 Plus",
        "iPhone6,1": "iPhone 5s (GSM)", "iPhone6,2": "iPhone 5s (Global)",
        "iPhone5,1": "iPhone 5 (GSM)", "iPhone5,2": "iPhone 5 (Global)",
        "iPhone5,3": "iPhone 5c (GSM)", "iPhone5,4": "iPhone 5c (Global)",
        "iPhone4,1": "iPhone 4s", "iPhone3,1": "iPhone 4 (GSM)", "iPhone3,2": "iPhone 4 (GSM Rev A)",
        "iPhone3,3": "iPhone 4 (CDMA)", "iPhone2,1": "iPhone 3GS", "iPhone1,2": "iPhone 3G", "iPhone1,1": "iPhone",
        // iPad
        "iPad13,16": "iPad Air (5th generation, WiFi)", "iPad13,17": "iPad Air (5th generation, WiFi+Cellular)",
        "iPad13,4": "iPad Pro 11 inch (3rd generation, WiFi)",
        "iPad13,5": "iPad Pro 11 inch (3rd generation, WiFi+Cellular)",
        "iPad13,6": "iPad Pro 11 inch (3rd generation, WiFi+Cellular)",
        "iPad13,7": "iPad Pro 11 inch (3rd generation, WiFi+Cellular)",
        "iPad13,8": "iPad Pro 12.9 inch (5th generation, WiFi)",
        "iPad13,9": "iPad Pro 12.9 inch (5th generation, WiFi+Cellular)",
        "iPad13,10": "iPad Pro 12.9 inch (5th generation, WiFi+Cellular)",
        "iPad13,11": "iPad Pro 12.9 inch (5th generation, WiFi+Cellular)",
        "iPad12,1": "iPad (9th generation, WiFi)", "iPad12,2": "iPad (9th generation, WiFi+Cellular)",
        "iPad11,6": "iPad (8th generation, WiFi)", "iPad11,7": "iPad (8th generation, WiFi+Cellular)",
        "iPad11,3": "iPad Air (4th generation, WiFi)", "iPad11,4": "iPad Air (4th generation, WiFi+Cellular)",
        "iPad8,1": "iPad Pro 11 inch (1st generation, WiFi)", "iPad8,2": "iPad Pro 11 inch (1st generation, WiFi)",
        "iPad8,3": "iPad Pro 11 inch (1st generation, WiFi+Cellular)",
        "iPad8,4": "iPad Pro 11 inch (1st generation, WiFi+Cellular)",
        "iPad8,9": "iPad Pro 11 inch (2nd generation, WiFi)",
        "iPad8,10": "iPad Pro 11 inch (2nd generation, WiFi+Cellular)",
        "iPad7,5": "iPad (6th generation, WiFi)", "iPad7,6": "iPad (6th generation, WiFi+Cellular)"
    ]
}
class imageClick: UITapGestureRecognizer {
    var date: String!
    var staffId: Int!
}
