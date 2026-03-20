//
//  EditSkillsVc.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 30/05/25.
//

import UIKit
import ObjectMapper

class EditSkillsVc: UIViewController, SkillSelectionDelegate {
    
    @IBOutlet weak var BackView: UIView!
    @IBOutlet weak var BackBtn: UIButton!
    @IBOutlet weak var SkillsetsLbl: UILabel!
    @IBOutlet weak var LanguagesKnownLbl: UILabel!
    @IBOutlet weak var LanguagesTextfield: PaddedTextField!
    @IBOutlet weak var softskillsLbl: UILabel!
    @IBOutlet weak var option1Btn: UIButton!
    @IBOutlet weak var option2Btn: UIButton!
    @IBOutlet weak var option3Btn: UIButton!
    @IBOutlet weak var option4Btn: UIButton!
    @IBOutlet weak var option5Btn: UIButton!
    @IBOutlet weak var option6Btn: UIButton!
    @IBOutlet weak var AreaOfIntrestLbl: UILabel!
    @IBOutlet weak var AreaOfInterestTextfield: TextfieldWithImage!
    @IBOutlet weak var InternshipLbl: UILabel!
    @IBOutlet weak var InternShipTextfield: PaddedTextField!
    @IBOutlet weak var ProgrammingLanguageLbl: UILabel!
    @IBOutlet weak var ProgrammmingTextfield: TextfieldWithImage!
    @IBOutlet weak var ToolsLbl: UILabel!
    @IBOutlet weak var ToolsTextfield: TextfieldWithImage!
    @IBOutlet weak var CertificationsLbl: UILabel!
    @IBOutlet weak var CertificationsTextfield: PaddedTextField!
    @IBOutlet weak var AddCertificateBtn: UIButton!
    @IBOutlet weak var AssesmentLbl: UILabel!
    @IBOutlet weak var AssesmentTextfield: TextfieldWithImage!
    @IBOutlet weak var ScoreLbl: UILabel!
    @IBOutlet weak var ScoreTextField: PaddedTextField!
    @IBOutlet weak var AddAssesmentBtn: UIButton!
    @IBOutlet weak var CancelBtn: UIButton!
    @IBOutlet weak var SaveBtn: UIButton!
    @IBOutlet weak var tv: UITableView!
    
    var SkillData: SkillProfile?
    var Sections = ["Skill Sets","Projects","Internship Experiences","Tools","Certifications","Assessment Details"]
    var Languanges = ""
    var Interests: [String] = []
    var SoftSkills: [String] = []
    var InternshipList: [Internship_Request] = []
    var Certificates_List: [Certification_Request] = []
    var Tools: [String] = []
    var Skills: [String] = []
    var AssesmentList: [Assessment_Request] = []
    var ProjectList: [Project_Request] = []
    var SelectedSkills: [String] = []
    var shouldShowValidationErrors = false
    var didAttemptSubmit = false
    let defaults = UserDefaults.standard
    var memberId : String?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        memberId = defaults.string(forKey: DefaultsKeys.memberid) ?? ""
        
        BackView.layer.shadowColor = UIColor.black.cgColor
        BackView.layer.shadowOpacity = 0.25
        BackView.layer.shadowOffset = CGSize(width: 0, height: 4)
        BackView.layer.shadowRadius = 8
        BackView.layer.masksToBounds = false
        
        SetFontStyle()
        CellRegister()
        getData()
        
        tv.delegate = self
        tv.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func getData(){
        
        Languanges = SkillData?.languages ?? ""
        Interests = SkillData?.areaInterest?.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) } ?? []
        Tools = SkillData?.toolsPlatform?.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) } ?? []
        Skills = SkillData?.programmingLanguage?.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) } ?? []
        SelectedSkills = SkillData?.softSkill?.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) } ?? []

        
        if let internship = SkillData?.internship {
            
            InternshipList = internship.map { intern in
                
                var NewIntern = Internship_Request()
                NewIntern.companyName = intern.companyName
                NewIntern.designation = intern.designation
                NewIntern.from = intern.from
                NewIntern.to = intern.to
                return NewIntern
            }
        }
        
        if let certificates = SkillData?.certifications {
            
            Certificates_List = certificates.map { certificate in
                
                var cert =   Certification_Request()
                cert.courseName = certificate.courseName
                cert.institute = certificate.institute
                cert.duration = certificate.duration
                return cert
            }
        }
        
        if let assessments = SkillData?.assessmentDetails {
            
            AssesmentList = assessments.map { assesment in
                
                var assess = Assessment_Request()
                assess.assessment = assesment.assessment
                assess.score = assesment.score
                return assess
            }
        }
        
        if let projects = SkillData?.projects {
            
            ProjectList = projects.map { project in
                
                var ProjectReq = Project_Request()
                ProjectReq.title = project.title
                return ProjectReq
            }
        }
    }
    
    func Get_SoftSkills(){
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.skillset_get_softskill,
            httpMethod: .get,
            isBaseUrl: false,
            queryParam: [:],
            requestBody: nil
        ) {[weak self] (result:Result<SoftSkillsResponse, Error>) in
                
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                if success.status == true {
                    
                    self.SoftSkills = success.data?.first?.softSkills ?? []
                    
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            
            }
    }

    func SetFontStyle() {
        
        BackBtn.setTitleFont(style: .medium, size: 18)
        
        SkillsetsLbl.setFont(style: .medium, size: 16)
        
        AreaOfIntrestLbl.setFont(style: .regular, size: 14)
        InternshipLbl.setFont(style: .regular, size: 14)
        ProgrammingLanguageLbl.setFont(style: .regular, size: 14)
        ToolsLbl.setFont(style: .regular, size: 14)
        CertificationsLbl.setFont(style: .regular, size: 14)
        AssesmentLbl.setFont(style: .regular, size: 14)
        ScoreLbl.setFont(style: .regular, size: 14)
        
        AddCertificateBtn.setTitleFont(style: .regular, size: 12)
        AddAssesmentBtn.setTitleFont(style: .regular, size: 12)
        
        LanguagesTextfield.font = UIFont(name: "Poppins-Regular", size: 15)
        AreaOfInterestTextfield.font = UIFont(name: "Poppins-Regular", size: 15)
        InternShipTextfield.font = UIFont(name: "Poppins-Regular", size: 15)
        ToolsTextfield.font = UIFont(name: "Poppins-Regular", size: 15)
        CertificationsTextfield.font = UIFont(name: "Poppins-Regular", size: 15)
        AssesmentTextfield.font = UIFont(name: "Poppins-Regular", size: 15)
        ScoreTextField.font = UIFont(name: "Poppins-Regular", size: 15)
        
        CancelBtn.layer.cornerRadius = 10
        SaveBtn.layer.cornerRadius = 10
        
        SaveBtn.setTitleFont(style: .medium, size: 14)
        CancelBtn.setTitleFont(style: .medium, size: 14)
        
    }
    
    func CellRegister() {
        
        tv.register(UINib(nibName: "SkillSetsTv", bundle: nil), forCellReuseIdentifier: "SkillSetsTv")
        tv.register(UINib(nibName: "InternshipTv", bundle: nil), forCellReuseIdentifier: "InternshipTv")
        tv.register(UINib(nibName: "CertificationsTv", bundle: nil), forCellReuseIdentifier: "CertificationsTv")
        tv.register(UINib(nibName: "ToolsTv", bundle: nil), forCellReuseIdentifier: "ToolsTv")
        tv.register(UINib(nibName: "AssesmentTv", bundle: nil), forCellReuseIdentifier: "AssesmentTv")
        tv.register(UINib(nibName: "FooterCell", bundle: nil), forCellReuseIdentifier: "FooterCell")
        tv.register(UINib(nibName: "ProjectsTv", bundle: nil), forCellReuseIdentifier: "ProjectsTv")
        tv.register(UINib(nibName: "ResumeHeaderCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "ResumeHeaderCell")
    }
    
    @IBAction func BackAct(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    @IBAction func CancelAct(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    @IBAction func SaveAct(_ sender: Any) {
        
        var emptyFields: [String] = []

        // Projects
        for (index, project) in ProjectList.enumerated() {
            if project.title?.trimmingCharacters(in: .whitespaces).isEmpty ?? true {
                emptyFields.append("Project #\(index + 1)")
            }
        }
        
        // Internships
        for (index, intern) in InternshipList.enumerated() {
            if intern.companyName?.trimmingCharacters(in: .whitespaces).isEmpty ?? true ||
                intern.designation?.trimmingCharacters(in: .whitespaces).isEmpty ?? true ||
                intern.from?.trimmingCharacters(in: .whitespaces).isEmpty ?? true ||
                intern.to?.trimmingCharacters(in: .whitespaces).isEmpty ?? true {
                emptyFields.append("Internship #\(index + 1)")
            }
        }

        // Certifications
        for (index, cert) in Certificates_List.enumerated() {
            if cert.courseName?.trimmingCharacters(in: .whitespaces).isEmpty ?? true ||
                cert.institute?.trimmingCharacters(in: .whitespaces).isEmpty ?? true ||
                cert.duration?.trimmingCharacters(in: .whitespaces).isEmpty ?? true {
                emptyFields.append("Certification #\(index + 1)")
            }
        }

        // Assessments
        for (index, assess) in AssesmentList.enumerated() {
            if assess.assessment?.trimmingCharacters(in: .whitespaces).isEmpty ?? true ||
                assess.score?.trimmingCharacters(in: .whitespaces).isEmpty ?? true {
                emptyFields.append("Assessment #\(index + 1)")
            }
        }

        // If any fields are empty
        if !emptyFields.isEmpty {
            let message = "Please fill all the fields"//"Please fill in the following fields:\n\n" + emptyFields.joined(separator: "\n")
            AlertHelper.showOKAlert(on: self, title: "Missing Information", message: message, okTitle: "OK") {}
            return
        }

        // Save Confirmation
        AlertHelper.showOKCancelAlert(
            on: self,
            title: "Confirm",
            message: "Are you sure you want to update the skillset?",
            okTitle: "Yes",
            cancelTitle: "Cancel",
            okAction: {

                    var newSkill = Edit_Skill_Req()
                    newSkill.idMember = Int(self.memberId ?? "0") ?? 0
                    newSkill.languages = self.Languanges
                    newSkill.areaInterest = self.Interests
                    newSkill.assessmentDetails = self.AssesmentList
                    newSkill.certifications = self.Certificates_List
                    newSkill.internship = self.InternshipList
                    newSkill.programmingLanguage = self.Skills
                    newSkill.projects = self.ProjectList
                    newSkill.softSkill = self.SelectedSkills
                    newSkill.toolsPlatform = self.Tools

                    // Debug log (optional)
                    print("Internships:", self.InternshipList)

                    APiCallManager.shared.callApi(
                        url: APIEndpoints.skillset_add_edit_skillset,
                        httpMethod: .post,
                        isBaseUrl: false,
                        queryParam: nil,
                        requestBody: newSkill
                    ) { [weak self] (result: Result<Edit_Skill_Response, Error>) in

                        guard let self = self else { return }

                        DispatchQueue.main.async {

                            switch result {

                            case .success(let response):

                                if response.status == true {
                                    let alert = UIAlertController(
                                        title: "Success",
                                        message: "Skillset Updated Successfully",
                                        preferredStyle: .alert
                                    )

                                    let ok = UIAlertAction(title: "Ok", style: .default) { _ in
                                        self.dismiss(animated: true)
                                    }

                                    alert.addAction(ok)
                                    self.present(alert, animated: true)

                                } else {
                                    let alert = UIAlertController(title: "Failed", message: "Something went wrong", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                                    self.present(alert, animated: true)
                                }

                            case .failure(let error):
                                print("❌ Error:", error.localizedDescription)
                                let alert = UIAlertController(title: "Failed", message: "Something went wrong", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                                self.present(alert, animated: true)
                            }
                        }
                    }
                
            },
            cancelAction: {}
        )
    }
    
    func validateAllFields() -> Bool {
        var isValid = true

        for intern in InternshipList {
            if intern.companyName?.isEmpty ?? true || intern.designation?.isEmpty ?? true ||
                intern.from?.isEmpty ?? true || intern.to?.isEmpty ?? true {
                isValid = false
            }
        }

        for cert in Certificates_List {
            if cert.courseName?.isEmpty ?? true || cert.institute?.isEmpty ?? true || cert.duration?.isEmpty ?? true {
                isValid = false
            }
        }

        for assessment in AssesmentList {
            if assessment.assessment?.isEmpty ?? true || assessment.score?.isEmpty ?? true {
                isValid = false
            }
        }

        if SkillData?.languages?.isEmpty ?? true || SkillData?.areaInterest?.isEmpty ?? true ||
            SkillData?.programmingLanguage?.isEmpty ?? true || SkillData?.toolsPlatform?.isEmpty ?? true {
            isValid = false
        }

        return isValid
    }
}


extension EditSkillsVc: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section{
            
        case 0:
            return 1
        case 1:
            return ProjectList.count + 1
        case 2:
            return InternshipList.count + 1
        case 3:
            return 1
        case 4:
            return Certificates_List.count + 1
        case 5:
            return AssesmentList.count + 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tv.dequeueReusableHeaderFooterView(withIdentifier: "ResumeHeaderCell") as! ResumeHeaderCell
        header.HeaderLbl.text = Sections[section]
        header.HeaderLbl.setFont(style: .medium, size: FontSize.header)
        header.EditBtn.isHidden = true
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            
            let cell = tv.dequeueReusableCell(withIdentifier: "SkillSetsTv", for: indexPath) as! SkillSetsTv
            cell.softSkills = SoftSkills
            cell.configure(with: SoftSkills, selected: SelectedSkills)
            cell.LanguageTextview.text = SkillData?.languages
            cell.AreaTextview.text = SkillData?.areaInterest
            cell.delegate = self
            cell.onLanguageField = {[weak self] text in
                self?.Languanges = text
            }
            cell.onAreasField = {[weak self] text in
                self?.Interests = text.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }
            }
            return cell
            
        case 1:
            
            if indexPath.row < ProjectList.count{
                
                let cell = tv.dequeueReusableCell(withIdentifier: "ProjectsTv", for: indexPath) as! ProjectsTv
                
                let Data = ProjectList[indexPath.row]
                
                cell.projectTitleTextView.text = Data.title
                
                cell.onProjectField = {[weak self] text in
                    self?.ProjectList[indexPath.row].title = text
                }
                
                cell.deleteAction = {[weak self] in
                    self?.ProjectList.remove(at: indexPath.row)
                    self?.tv.reloadData()
                }
                
                return cell
            }else {
                
                let footerCell = tv.dequeueReusableCell(withIdentifier: "FooterCell", for: indexPath) as! FooterCell
                footerCell.AddBtn.setTitleFont(style: .regular, size: FontSize.title)
                footerCell.AddBtn.removeTarget(nil, action: nil, for: .allEvents)
                footerCell.AddBtn.addTarget(self, action: #selector(Add_Projects), for: .touchUpInside)
                return footerCell
            }
            
        case 2:
            if indexPath.row < InternshipList.count {
                let cell = tv.dequeueReusableCell(withIdentifier: "InternshipTv", for: indexPath) as! InternshipTv
                
               let Data =  InternshipList[indexPath.row]
                
                cell.CompanyField.text = Data.companyName
                cell.RoleField.text = Data.designation
                cell.FromDateLbl.text = (Data.from?.isEmpty ?? false) ? "From" : Data.from?.formattedDate()
                cell.ToDateLbl.text = (Data.to?.isEmpty ?? false) ? "To" : Data.to?.formattedDate()
                
                cell.onCompanyChange = {[weak self] text in
                    
                    self?.InternshipList[indexPath.row].companyName = text
                }
                cell.onRoleChange = {[weak self] text in
                    
                    self?.InternshipList[indexPath.row].designation = text
                }
                cell.onFromChange = {[weak self] text in
                    
                    self?.InternshipList[indexPath.row].from = text
                }
                cell.onToChange = {[weak self] text in
                    
                    self?.InternshipList[indexPath.row].to = text
                }
                
                cell.deleteAction = {[weak self] in
                    
                    self?.InternshipList.remove(at: indexPath.row)
                    self?.tv.reloadData()
                }
                
                let intern = InternshipList[indexPath.row]

                if didAttemptSubmit {
                    cell.CompanyField.setErrorBorder(intern.companyName?.isEmpty ?? true)
                    cell.RoleField.setErrorBorder(intern.designation?.isEmpty ?? true)
                    cell.FromField.setErrorBorder(intern.from?.isEmpty ?? true)
                    cell.ToField.setErrorBorder(intern.to?.isEmpty ?? true)
                } else {
                    // No red borders on first add
                    cell.CompanyField.setNormalBorder()
                    cell.RoleField.setNormalBorder()
                    cell.FromField.setNormalBorder()
                    cell.ToField.setNormalBorder()
                }
               
                return cell
            }else {
                
                let footerCell = tv.dequeueReusableCell(withIdentifier: "FooterCell", for: indexPath) as! FooterCell
                footerCell.AddBtn.setTitleFont(style: .regular, size: FontSize.title)
                footerCell.AddBtn.removeTarget(nil, action: nil, for: .allEvents)
                footerCell.AddBtn.addTarget(self, action: #selector(Add_Internship), for: .touchUpInside)
                return footerCell
            }
            
        case 3:
            
            let cell = tv.dequeueReusableCell(withIdentifier: "ToolsTv", for: indexPath) as! ToolsTv
            cell.SkillTextview.text = SkillData?.programmingLanguage
            cell.ToolsTextview.text = SkillData?.toolsPlatform
            cell.OnSkillChange = {[weak self] text in
                
                self?.Skills = text.components(separatedBy: ",")
            }
            cell.OnToolsChange = {[weak self] text in
                self?.Tools = text.components(separatedBy: ",")
            }
            return cell
            
        case 4:
            if indexPath.row < Certificates_List.count {
                let cell = tv.dequeueReusableCell(withIdentifier: "CertificationsTv", for: indexPath) as! CertificationsTv
                cell.CourseField.text = Certificates_List[indexPath.row].courseName
                cell.InstituteField.text = Certificates_List[indexPath.row].institute
                cell.durationField.text = Certificates_List[indexPath.row].duration
                cell.OnCourse = {[weak self] text in
                    self?.Certificates_List[indexPath.row].courseName = text
                }
                cell.OnInstitute = {[weak self] text in
                    self?.Certificates_List[indexPath.row].institute = text
                }
                cell.OnDuration = {[weak self] text in
                    self?.Certificates_List[indexPath.row].duration = text
                }
                cell.deleteAction = {[weak self] in
                    self?.Certificates_List.remove(at: indexPath.row)
                    self?.tv.reloadData()
                }
                return cell
            }else {
                
                let footerCell = tv.dequeueReusableCell(withIdentifier: "FooterCell", for: indexPath) as! FooterCell
                footerCell.AddBtn.setTitleFont(style: .regular, size: FontSize.title)
                footerCell.AddBtn.removeTarget(nil, action: nil, for: .allEvents)
                footerCell.AddBtn.addTarget(self, action: #selector(Add_Certifications), for: .touchUpInside)
                return footerCell
            }
            
        case 5:
            if indexPath.row < AssesmentList.count {
                let cell = tv.dequeueReusableCell(withIdentifier: "AssesmentTv", for: indexPath) as! AssesmentTv
                cell.AssessmentField.text = AssesmentList[indexPath.row].assessment
                cell.ScoreField.text = AssesmentList[indexPath.row].score
                cell.OnAssessment = {[weak self] text in
                    self?.AssesmentList[indexPath.row].assessment = text
                }
                cell.OnScore = {[weak self] text in
                    self?.AssesmentList[indexPath.row].score = text
                }
                cell.deleteAction = {[weak self] in
                    self?.AssesmentList.remove(at: indexPath.row)
                    self?.tv.reloadData()
                }
                return cell
            }else {
                let footerCell = tv.dequeueReusableCell(withIdentifier: "FooterCell", for: indexPath) as! FooterCell
                footerCell.AddBtn.setTitleFont(style: .regular, size: FontSize.title)
                footerCell.AddBtn.removeTarget(nil, action: nil, for: .allEvents)
                footerCell.AddBtn.addTarget(self, action: #selector(Add_Assessment), for: .touchUpInside)
                return footerCell
            }
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @IBAction func Add_Internship(){
        
        let hasEmptyField = InternshipList.contains { internship in
            return (internship.companyName?.isEmpty ?? true) ||
            (internship.designation?.isEmpty ?? true) ||
            (internship.from?.isEmpty ?? true) ||
            (internship.to?.isEmpty ?? true)
            
        }

        if hasEmptyField {
            AlertHelper.showOKAlert(on: self, title: "Missing Information", message: "Please fill all Internship Details", okTitle: "Ok", okAction: {
               
            })
        } else {
            var intern = Internship_Request()
            intern.companyName = ""
            intern.designation = ""
            intern.from = ""
            intern.to = ""
            InternshipList.append(intern)
            tv.reloadData()
        }
    }
    
    @IBAction func Add_Projects(){
        
        let hasEmptyField = ProjectList.contains { project in
            return (project.title?.isEmpty ?? true)
        }

        if hasEmptyField {
            AlertHelper.showOKAlert(on: self, title: "Missing Information", message: "Please Enter Project Title", okTitle: "Ok", okAction: {
            })
            return
        } else {
            var project = Project_Request()
            project.title = ""
            ProjectList.append(project)
            tv.reloadData()
        }
    }
    
    @IBAction func Add_Certifications(){
        
        let hasEmptyField = Certificates_List.contains { certificate in
            return (certificate.courseName?.isEmpty ?? true) ||
                   (certificate.institute?.isEmpty ?? true) ||
                   (certificate.duration?.isEmpty ?? true)
        }

        if hasEmptyField {
            AlertHelper.showOKAlert(on: self, title: "Missing Information", message: "Please fill all Certification Details", okTitle: "Ok", okAction: {
            })
            return
        } else {
            var certificate = Certification_Request()
            certificate.courseName = ""
            certificate.institute = ""
            certificate.duration = ""
            Certificates_List.append(certificate)
            tv.reloadData()
        }

    }
    
    @IBAction func Add_Assessment(){
        
        let hasEmptyField = AssesmentList.contains { assessment in
            return (assessment.assessment?.isEmpty ?? true) ||
            (assessment.score?.isEmpty ?? true)
        }

        if hasEmptyField {
            AlertHelper.showOKAlert(on: self, title: "Missing Information", message: "Please fill all Assessment Details", okTitle: "Ok", okAction: {
                // Optional action
            })
        } else {
            var assessment = Assessment_Request()
            assessment.assessment = ""
            assessment.score = ""
            AssesmentList.append(assessment)
            tv.reloadData()
        }
    }
    
    func didSelectSkills(_ selectedSkills: [String]) {
        self.SelectedSkills = selectedSkills
            print("Updated skills: \(selectedSkills)")
        }
    

}

extension EditSkillsVc: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let cell = textField.superview?.superview as? UITableViewCell,
              let indexPath = tv.indexPath(for: cell) else { return }
        
        tv.scrollToRow(at: indexPath, at: .none, animated: true)
    }
    
    // MARK: - Keyboard Handling
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let keyboardHeight = keyboardFrame.height
        let bottomInset = keyboardHeight - view.safeAreaInsets.bottom
        
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)
        tv.scrollIndicatorInsets = tv.contentInset
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        tv.contentInset = .zero
        tv.scrollIndicatorInsets = .zero
    }
    
    
}



import UIKit

extension UITextField {
    func setErrorBorder(_ isError: Bool) {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.layer.borderColor = isError ? UIColor.red.cgColor : UIColor.systemGray4.cgColor
    }

    func setNormalBorder() {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.systemGray4.cgColor
    }
}

extension UITextView {
    func setErrorBorder(_ isError: Bool) {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.layer.borderColor = isError ? UIColor.red.cgColor : UIColor.systemGray4.cgColor
    }

    func setNormalBorder() {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.systemGray4.cgColor
    }
}
