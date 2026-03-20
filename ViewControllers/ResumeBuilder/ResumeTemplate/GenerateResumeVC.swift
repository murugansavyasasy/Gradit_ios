//
//  GenerateResumeVC.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 15/07/25.
//

import UIKit

class GenerateResumeVC: UIViewController {

    @IBOutlet weak var BackView: UIView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var BackBtn: UIButton!
    @IBOutlet weak var TitleLbl: UILabel!
    @IBOutlet weak var NextBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var EducationDetail : [EducationalDetail]?
    var ProfileDetails: Profile?
    var SkillData: SkillProfile?
    var context = ResumeContext()
    
    var selectedLanguages: [String] = []
    var selectedSoftSkills: [String] = []
    var selectedAreaInterest: [String] = []
    var selectedInternships: [Internship] = []
    var selectedProjects: [projects] = []
    var selectedCertifications: [Certification] = []
    var selectedEducation: [EducationalDetail] = []
    var selectedSkills: [String] = []
    var address = ""
    
    // MARK: - Row structure
    struct ResumeRow {
        let title: String
        let items: [String]
        let type: RowType
        let showTitleLabel: Bool
        let selectButtonTitle: String
        let hideSelectButton: Bool
    }
    
    enum RowType {
        case education, languages, softSkills, areasOfInterest, internships, skills, projects, certifications
    }
    
    var rows: [ResumeRow] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BackBtn.setTitleFont(style: .medium, size: 18)
        TitleLbl.setFont(style: .medium, size: FontSize.title)
        
        cancelBtn.setTitleFont(style: .medium, size: 14)
        NextBtn.setTitleFont(style: .medium, size: 14)
        
        cancelBtn.layer.cornerRadius = 10
        NextBtn.layer.cornerRadius = 10
        
        tableview.register(UINib(nibName: "SelectionTvcell", bundle: nil), forCellReuseIdentifier: "SelectionTvcell")
        tableview.delegate = self
        tableview.dataSource = self
        
        getdata()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        BackView.applyBottomShadow()
    }
    
    @IBAction func BackAct(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func NextAct(_ sender: Any) {
        print("selctedLanguage",selectedLanguages)
        print("softskill",selectedSoftSkills)
        print("education",selectedEducation)
        print("internship",selectedInternships)
        print("skill",selectedSkills)
        print("areaofInterest",selectedAreaInterest)
        print("Project",selectedProjects)
        GetContext()
        let vc = ResumetemplatesVC(nibName: nil, bundle: nil)
        vc.context = context
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func GetContext() {
        context.name = ProfileDetails?.memberName
        context.email = ProfileDetails?.memberstudentEmail
        context.phone = ProfileDetails?.memberPhoneNumber
        context.address = address
        context.skills = selectedSkills
        context.education = selectedEducation
        context.internship = selectedInternships
        context.areainterest = selectedAreaInterest
        context.softSkill = selectedSoftSkills
        context.certifications = selectedCertifications
        context.languages = selectedLanguages
        context.projects = selectedProjects
    }
    
    func getdata(){
        let Details = ProfileDetails
        address = "\(Details?.memberPermanentAddress1 ?? ""), \(Details?.memberPermanentAddressCity ?? ""), \(Details?.memberPermanentAddressState ?? ""), \(Details?.memberPermanentAddressPincode ?? ""), \(Details?.memberPermanentAddressCountry ?? "")"
        
        selectedLanguages = SkillData?.languages?
            .components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty } ?? []
        
        selectedSoftSkills = SkillData?.softSkill?
            .components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty } ?? []
        
        selectedAreaInterest = SkillData?.areaInterest?
            .components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty } ?? []
        
        selectedInternships = SkillData?.internship ?? []
        selectedProjects = SkillData?.projects ?? []
        selectedCertifications = SkillData?.certifications ?? []
        selectedEducation = EducationDetail ?? []
        
        selectedSkills = SkillData?.programmingLanguage?
            .components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty } ?? []
        
        buildRows()
        tableview.reloadData()
    }
    
    // MARK: - Build rows dynamically
    func buildRows() {
        rows.removeAll()
        
        let edu = EducationDetail?.compactMap { $0.classDegree } ?? []
        if !edu.isEmpty {
            rows.append(ResumeRow(title: "Academic records",
                                  items: edu,
                                  type: .education,
                                  showTitleLabel: true,
                                  selectButtonTitle: "",
                                  hideSelectButton: true))
        }
        
        let langs = SkillData?.languages?
            .components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty } ?? []
        if !langs.isEmpty {
            rows.append(ResumeRow(title: "Skill sets",
                                  items: langs,
                                  type: .languages,
                                  showTitleLabel: true,
                                  selectButtonTitle: "Languages known",
                                  hideSelectButton: false))
        }
        
        let soft = SkillData?.softSkill?
            .components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty } ?? []
        if !soft.isEmpty {
            rows.append(ResumeRow(title: "Soft Skills",
                                  items: soft,
                                  type: .softSkills,
                                  showTitleLabel: false,
                                  selectButtonTitle: "Soft Skills",
                                  hideSelectButton: false))
        }
        
        let area = SkillData?.areaInterest?
            .components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty } ?? []
        if !area.isEmpty {
            rows.append(ResumeRow(title: "Areas of Interest",
                                  items: area,
                                  type: .areasOfInterest,
                                  showTitleLabel: false,
                                  selectButtonTitle: "Areas of Interest",
                                  hideSelectButton: false))
        }
        
        let intern = SkillData?.internship?.compactMap { $0.companyName } ?? []
        if !intern.isEmpty {
            rows.append(ResumeRow(title: "Internships",
                                  items: intern,
                                  type: .internships,
                                  showTitleLabel: false,
                                  selectButtonTitle: "Internships",
                                  hideSelectButton: false))
        }
        
        let skillList = SkillData?.programmingLanguage?
            .components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty } ?? []
        if !skillList.isEmpty {
            rows.append(ResumeRow(title: "Skills",
                                  items: skillList,
                                  type: .skills,
                                  showTitleLabel: false,
                                  selectButtonTitle: "Skills",
                                  hideSelectButton: false))
        }
        
        let proj = SkillData?.projects?.compactMap { $0.title } ?? []
        if !proj.isEmpty {
            rows.append(ResumeRow(title: "Projects",
                                  items: proj,
                                  type: .projects,
                                  showTitleLabel: false,
                                  selectButtonTitle: "Projects",
                                  hideSelectButton: false))
        }
        
        let certs = SkillData?.certifications?.compactMap { $0.courseName } ?? []
        if !certs.isEmpty {
            rows.append(ResumeRow(title: "Certifications",
                                  items: certs,
                                  type: .certifications,
                                  showTitleLabel: false,
                                  selectButtonTitle: "Certifications",
                                  hideSelectButton: false))
        }
    }
    
    // MARK: - Helpers for selection tracking
    func getSelectedItems(for type: RowType) -> [String] {
        switch type {
        case .education: return selectedEducation.map { $0.classDegree ?? "" }
        case .languages: return selectedLanguages
        case .softSkills: return selectedSoftSkills
        case .areasOfInterest: return selectedAreaInterest
        case .internships: return selectedInternships.map { $0.companyName ?? "" }
        case .skills: return selectedSkills
        case .projects: return selectedProjects.map { $0.title ?? "" }
        case .certifications: return selectedCertifications.map { $0.courseName ?? "" }
        }
    }
    
    func updateSelectedItems(_ selected: [String], for type: RowType) {
        switch type {
        case .education:
            selectedEducation = EducationDetail?.filter { selected.contains($0.classDegree ?? "") } ?? []
        case .languages:
            selectedLanguages = selected
        case .softSkills:
            selectedSoftSkills = selected
        case .areasOfInterest:
            selectedAreaInterest = selected
        case .internships:
            selectedInternships = SkillData?.internship?.filter { selected.contains($0.companyName ?? "") } ?? []
        case .skills:
            selectedSkills = selected
        case .projects:
            selectedProjects = SkillData?.projects?.filter { selected.contains($0.title ?? "") } ?? []
        case .certifications:
            selectedCertifications = SkillData?.certifications?.filter { selected.contains($0.courseName ?? "") } ?? []
        }
    }
}

extension GenerateResumeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectionTvcell", for: indexPath) as! SelectionTvcell
        
        // Title label visibility
        cell.TitleLbl.isHidden = !row.showTitleLabel
        cell.TitleLbl.text = row.title
        
        // Select button visibility + title
        cell.SelectBtn.isHidden = row.hideSelectButton
        if !row.hideSelectButton {
            cell.SelectBtn.setTitle(row.selectButtonTitle, for: .normal)
        }
        
        cell.configure(with: row.items, selectedItems: getSelectedItems(for: row.type))
        
        cell.onSelectionChanged = { [weak self] selected in
            self?.updateSelectedItems(selected, for: row.type)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

