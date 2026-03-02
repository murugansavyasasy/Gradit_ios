//
//  ResumeVC.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 28/05/25.
//

import UIKit
import ObjectMapper
import UniformTypeIdentifiers

class ResumeVC: UIViewController, PopupVcDelegate {
    
    @IBOutlet weak var myProfileLbl: UILabel!
    @IBOutlet weak var profileEditBtn: UIButton!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var NameLbl: UILabel!
    @IBOutlet weak var MobileNoBtn: UIButton!
    @IBOutlet weak var EmailBtn: UIButton!
    @IBOutlet weak var AvilablePlacementLbl: UILabel!
    @IBOutlet weak var consentedBtn: UIButton!
    @IBOutlet weak var BuildResumeBtn: UIButton!
    @IBOutlet weak var UploadResumeBtn: UIButton!
    @IBOutlet weak var BasicDetailsLbl: UILabel!
    @IBOutlet weak var RollNoDefLbl: UILabel!
    @IBOutlet weak var RollNoLbl: UILabel!
    @IBOutlet weak var RegNoDefLbl: UILabel!
    @IBOutlet weak var RegNoLbl: UILabel!
    @IBOutlet weak var CourseDefLbl: UILabel!
    @IBOutlet weak var DepartmentDefLbl: UILabel!
    @IBOutlet weak var CourseLbl: UILabel!
    @IBOutlet weak var DepartmentLbl: UILabel!
    @IBOutlet weak var YearOfStudyDefLbl: UILabel!
    @IBOutlet weak var YearofStudyLbl: UILabel!
    @IBOutlet weak var SemesterDefLbl: UILabel!
    @IBOutlet weak var SemesterLbl: UILabel!
    @IBOutlet weak var DateOfbirthDefLbl: UILabel!
    @IBOutlet weak var DateOfBirthLbl: UILabel!
    @IBOutlet weak var GenderDefLbl: UILabel!
    @IBOutlet weak var GenderLbl: UILabel!
    @IBOutlet weak var AddressDefLbl: UILabel!
    @IBOutlet weak var AddressLbl: UILabel!
    @IBOutlet weak var AcademicRecordsLbl: UILabel!
    @IBOutlet weak var AcademicEditBtn: UIButton!
    @IBOutlet weak var tenthLbl: UILabel!
    @IBOutlet weak var tenthBtn: UIButton!
    @IBOutlet weak var twelthLbl: UILabel!
    @IBOutlet weak var UGlbl: UILabel!
    @IBOutlet weak var twelthBtn: UIButton!
    @IBOutlet weak var UGBtn: UIButton!
    @IBOutlet weak var PgLbl: UILabel!
    @IBOutlet weak var PgBtn: UIButton!
    @IBOutlet weak var BacklogsLbl: UILabel!
    @IBOutlet weak var BacklogsBtn: UIButton!
    @IBOutlet weak var NumArrearBtn: UIButton!
    @IBOutlet weak var NoOfArrearsLbl: UILabel!
    @IBOutlet weak var AcademicRecordView: UIView!
    @IBOutlet weak var SkillSetLbl: UILabel!
    @IBOutlet weak var SkillSetEditBtn: UIButton!
    @IBOutlet weak var LanguagesDefLbl: UILabel!
    @IBOutlet weak var LanguagesLbl: UILabel!
    @IBOutlet weak var SoftSkillsDefLbl: UILabel!
    @IBOutlet weak var SoftSkillsLbl: UILabel!
    @IBOutlet weak var AreaOfInterestDefLbl: UILabel!
    @IBOutlet weak var AreaOfInterestLbl: UILabel!
    @IBOutlet weak var InternshipDefLbl: UILabel!
    @IBOutlet weak var InternshipLbl: UILabel!
    @IBOutlet weak var ProgrammingDefLbl: UILabel!
    @IBOutlet weak var ProgrammingLbl: UILabel!
    @IBOutlet weak var ToolsDefLbl: UILabel!
    @IBOutlet weak var ToolsLbl: UILabel!
    @IBOutlet weak var CertificationsDefLbl: UILabel!
    @IBOutlet weak var CertificationLbl: UILabel!
    @IBOutlet weak var AssesmentScoreDefLbl: UILabel!
    @IBOutlet weak var AssesmentScoreLbl: UILabel!
    @IBOutlet weak var PlacementStatusBGView: UIView!
    @IBOutlet weak var BackView: UIView!
    @IBOutlet weak var BackBtn: UIButton!
    @IBOutlet weak var InternshipStack: UIStackView!
    @IBOutlet weak var CertificationsStack: UIStackView!
    @IBOutlet weak var AssesmentStack: UIStackView!
    @IBOutlet weak var AcademicCv: UICollectionView!
    @IBOutlet weak var BacklogsStack: UIStackView!
    @IBOutlet weak var CvHeight: NSLayoutConstraint!
    @IBOutlet weak var ProjectsDefLbl: UILabel!
    @IBOutlet weak var ProjectsLbl: UILabel!
    @IBOutlet weak var ProjectsStack: UIStackView!
    @IBOutlet weak var MyresumesView: UIView!
    @IBOutlet weak var myResumesLbl: UILabel!
    @IBOutlet weak var BuildMyresumeStack: UIStackView!
    @IBOutlet weak var ResumeIcon: UIImageView!
    
    var Profile_Details : Profile?
    var Academic_Details : EducationData?
    var Skill_data : SkillProfile?
    let defaults = UserDefaults.standard
    var memberId : String?
    var param : [String: Any] = [:]
    var SoftSkills: [String] = []
    var My_resumes: ResumeTitleData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Update_UI()
        
        ApplyFont()
        
        memberId = defaults.string(forKey: DefaultsKeys.memberid) ?? ""
        param = ["idMember":memberId ?? ""]
        
        MyresumesView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MyResumesAct)))
        
        let nib = UINib(nibName: "AcademicCvcell", bundle: nil)
        AcademicCv.register(nib, forCellWithReuseIdentifier: "AcademicCvcell")
        
        AcademicCv.delegate = self
        AcademicCv.dataSource = self
        
//        if let layout = AcademicCv.collectionViewLayout as? UICollectionViewFlowLayout {
//                    layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//                    layout.minimumInteritemSpacing = 10
//                    layout.minimumLineSpacing = 10
//                    layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//                }
        
        if let layout = AcademicCv.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.minimumInteritemSpacing = 10
                layout.minimumLineSpacing = 10
                layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        BuildResumeBtn.setGradientBackground(colors: [.systemYellow.withAlphaComponent(0.5),.systemOrange])
        
//        if let layout = AcademicCv.collectionViewLayout as? UICollectionViewFlowLayout {
//                   let totalSpacing = layout.minimumInteritemSpacing * 2 + layout.sectionInset.left + layout.sectionInset.right
//                   let availableWidth = AcademicCv.frame.width - totalSpacing
//                   let itemWidth = floor(availableWidth / 3)
//                   layout.estimatedItemSize = CGSize(width: itemWidth, height: UICollectionViewFlowLayout.automaticSize.height)
//               }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAllData()
    }
    
    func Update_UI(){
        
        BackView.layer.shadowColor = UIColor.black.cgColor
        BackView.layer.shadowOpacity = 0.25
        BackView.layer.shadowOffset = CGSize(width: 0, height: 4)
        BackView.layer.shadowRadius = 8
        BackView.layer.masksToBounds = false
        
        profileView.layer.cornerRadius = 10
        profileView.layer.borderWidth = 0.5
        profileView.layer.borderColor = UIColor.systemGray.cgColor
        
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.layer.borderWidth = 1
        profileImage.layer.borderColor = UIColor.systemGray.cgColor
        
        BuildResumeBtn.layer.cornerRadius = 10
        
        MyresumesView.layer.cornerRadius = 10
        MyresumesView.layer.borderWidth = 1
        MyresumesView.layer.borderColor = UIColor.systemGray4.cgColor
        MyresumesView.isHidden = true
        
        
        if let image = UIImage(systemName: "text.document") {
            ResumeIcon.image = image
        } else if let fallback = UIImage(systemName: "doc.text") {
            ResumeIcon.image = fallback
        } else {
            ResumeIcon.image = UIImage(named: "pdf-file") // custom asset
        }

        
        PlacementStatusBGView.layer.cornerRadius = 10
        
        AcademicRecordView.layer.cornerRadius = 10
        
        tenthBtn.layer.cornerRadius = 8
        twelthBtn.layer.cornerRadius = 8
        UGBtn.layer.cornerRadius = 8
        PgBtn.layer.cornerRadius = 8
        BacklogsBtn.layer.cornerRadius = 8
        NumArrearBtn.layer.cornerRadius = 8
    }
    
    func ApplyFont() {
        
        
        let fullText  = "Basic Details (Managed by your institution)"
        
        let attributedString = NSMutableAttributedString(string: fullText)
        
        let titleFont = UIFont(name: "Poppins-Medium", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .medium)
        let subtitleFont = UIFont(name: "Poppins-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .regular)

        attributedString.addAttributes([
            .font : titleFont,
            .foregroundColor : UIColor(named: "IndigoColour") ?? .label
        ], range: (fullText as NSString).range(of: "Basic Details"))

        attributedString.addAttributes([
            .font : subtitleFont,
            .foregroundColor : UIColor.darkGray
        ], range: (fullText as NSString).range(of: "(Managed by your institution)"))

        BasicDetailsLbl.attributedText = attributedString
        
        BackBtn.setTitleFont(style: .medium, size: 18)
        
        RollNoDefLbl.setFont(style: .regular, size: FontSize.body)
        RegNoDefLbl.setFont(style: .regular, size: FontSize.body)
        CourseDefLbl.setFont(style: .regular, size: FontSize.body)
        DepartmentDefLbl.setFont(style: .regular, size: FontSize.body)
        YearOfStudyDefLbl.setFont(style: .regular, size: FontSize.body)
        SemesterDefLbl.setFont(style: .regular, size: FontSize.body)
        DateOfbirthDefLbl.setFont(style: .regular, size: FontSize.body)
        GenderDefLbl.setFont(style: .regular, size: FontSize.body)
        AddressDefLbl.setFont(style: .regular, size: FontSize.body)
        LanguagesDefLbl.setFont(style: .regular, size: FontSize.body)
        SoftSkillsDefLbl.setFont(style: .regular, size: FontSize.body)
        AreaOfInterestDefLbl.setFont(style: .regular, size: FontSize.body)
        InternshipDefLbl.setFont(style: .regular, size: FontSize.body)
        ProgrammingDefLbl.setFont(style: .regular, size: FontSize.body)
        ToolsDefLbl.setFont(style: .regular, size: FontSize.body)
        CertificationsDefLbl.setFont(style: .regular, size: FontSize.body)
        AssesmentScoreDefLbl.setFont(style: .regular, size: FontSize.body)
        ProjectsDefLbl.setFont(style: .regular, size: FontSize.body)
        
        // MARK: - Set Medium Style (size 12) for UILabels
        myProfileLbl.setFont(style: .medium, size: FontSize.header)
       // BasicDetailsLbl.setFont(style: .medium, size: FontSize.header)
        AcademicRecordsLbl.setFont(style: .medium, size: FontSize.header)
        SkillSetLbl.setFont(style: .medium, size: FontSize.header)
        
        NameLbl.setFont(style: .semibold, size: FontSize.header)
        AvilablePlacementLbl.setFont(style: .medium, size: FontSize.title)
       
        RollNoLbl.setFont(style: .semibold, size: FontSize.body)
        RegNoLbl.setFont(style: .semibold, size: FontSize.body)
        CourseLbl.setFont(style: .semibold, size: FontSize.body)
        DepartmentLbl.setFont(style: .semibold, size: FontSize.body)
        YearofStudyLbl.setFont(style: .semibold, size: FontSize.body)
        SemesterLbl.setFont(style: .semibold, size: FontSize.body)
        DateOfBirthLbl.setFont(style: .semibold, size: FontSize.body)
        GenderLbl.setFont(style: .semibold, size: FontSize.body)
        AddressLbl.setFont(style: .semibold, size: FontSize.body)
        ProjectsLbl.setFont(style: .semibold, size: FontSize.body)
        
        tenthLbl.setFont(style: .regular, size: FontSize.body)
        twelthLbl.setFont(style: .regular, size: FontSize.body)
        UGlbl.setFont(style: .regular, size: FontSize.body)
        PgLbl.setFont(style: .regular, size: FontSize.body)
        BacklogsLbl.setFont(style: .regular, size: FontSize.body)
        NoOfArrearsLbl.setFont(style: .regular, size: FontSize.body)
        
        LanguagesLbl.setFont(style: .semibold, size: FontSize.body)
        SoftSkillsLbl.setFont(style: .semibold, size: FontSize.body)
        AreaOfInterestLbl.setFont(style: .semibold, size: FontSize.body)
        InternshipLbl.setFont(style: .semibold, size: FontSize.body)
        ProgrammingLbl.setFont(style: .semibold, size: FontSize.body)
        ToolsLbl.setFont(style: .semibold, size: FontSize.body)
        CertificationLbl.setFont(style: .semibold, size: FontSize.body)
        AssesmentScoreLbl.setFont(style: .semibold, size: FontSize.body)
        myResumesLbl.setFont(style: .semibold, size: FontSize.title)
        
        // MARK: - Set Medium Style (size 12) for UIButtons
        profileEditBtn.setTitleFont(style: .regular, size:  FontSize.title)
        AcademicEditBtn.setTitleFont(style: .regular, size: FontSize.title)
        SkillSetEditBtn.setTitleFont(style: .regular, size: FontSize.title)
        
        MobileNoBtn.setTitleFont(style: .regular, size: FontSize.body)
        EmailBtn.setTitleFont(style: .regular, size:  FontSize.body)
        consentedBtn.setTitleFont(style: .regular, size:  FontSize.body)
        BuildResumeBtn.setTitleFont(style: .semibold, size:  FontSize.title)
        UploadResumeBtn.setTitleFont(style: .regular, size:  FontSize.title)
       
        tenthBtn.setTitleFont(style: .semibold, size: FontSize.body)
        twelthBtn.setTitleFont(style: .semibold, size: FontSize.body)
        UGBtn.setTitleFont(style: .semibold, size: FontSize.body)
        PgBtn.setTitleFont(style: .semibold, size: FontSize.body)
        BacklogsBtn.setTitleFont(style: .semibold, size: FontSize.body)
        NumArrearBtn.setTitleFont(style: .semibold, size: FontSize.body)
    }
    
    //MARK: Api CAll Function
    func fetchAllData() {
        let group = DispatchGroup()

        group.enter()
        Get_Profile_Request.call_request(memberId: memberId ?? "", param: [:]) { [weak self] res in
            defer { group.leave() }

            print("request:",self?.param ?? [])
            guard let profileResponse = Mapper<Profile_Response>().map(JSONString: res),
                  profileResponse.status == true,
                  let profile = profileResponse.data?.first else {
                print("Failed: Profile")
                return
            }

            DispatchQueue.main.async {
                self?.Profile_Details = profile
                self?.Set_profile_Data(Details: profile)
            }
        }
        
        group.enter()
        Get_Resume_Request.call_request(param: ["idMember":memberId ?? ""]) { [weak self] res in
            
            defer{ group.leave() }
            
            guard let resumeResponse: ResumeTitleResponse = Mapper<ResumeTitleResponse>().map(JSONString: res) else{return}
            
            print("ResumeList",resumeResponse)
                
            if resumeResponse.status == true {
                DispatchQueue.main.async {
                    self?.My_resumes = resumeResponse.data
                    
                    if (self?.My_resumes?.resumeTitle?.isEmpty ?? true){
                        self?.MyresumesView.isHidden = true
                        self?.BuildMyresumeStack.isHidden = false
                    }else{
                        self?.MyresumesView.isHidden = false
                        self?.BuildMyresumeStack.isHidden = true
                    }
                }
            }else{
                self?.MyresumesView.isHidden = true
                self?.BuildMyresumeStack.isHidden = false
            }
            
            print("response",resumeResponse.message ?? "")
        }

        group.enter()
        Get_academicRecords_Request.call_request(param: ["idMember": memberId ?? ""]) { [weak self] res in
            defer { group.leave() }

            guard let academicResponse = Mapper<EducationResponse>().map(JSONString: res),
                  academicResponse.status == true,
                  let academic = academicResponse.data?.first else {
                print("Failed: Academic")
                return
            }

            DispatchQueue.main.async {
                self?.Academic_Details = academic
                self?.Set_Academic_Data(Details: academic)
            }
        }

        group.enter()
        Get_Skillset_Request.call_request(param: ["idMember": memberId ?? ""]) { [weak self] res in
            defer { group.leave() }

            guard let skillResponse = Mapper<SkillProfileResponse>().map(JSONString: res),
                  skillResponse.status == true,
                  let skill = skillResponse.data?.first else {
                print("Failed: Skillset")
                self?.SkillSetEditBtn.setTitle("Add", for: .normal)
                return
            }

            DispatchQueue.main.async {
                self?.Skill_data = skill
                self?.Set_Skill_Data(Details: skill)
            }
        }
        
        group.enter()
       
            Get_softSkills_Request.call_request(param: [:]) {[weak self] (res) in
                defer { group.leave() }

                if let SkillResponse : SoftSkillsResponse = Mapper<SoftSkillsResponse>().map(JSONString: res) {
                    
                    if SkillResponse.status == true {
                        
                        self?.SoftSkills = SkillResponse.data?.first?.softSkills ?? []
                    }
                }
            }

        group.notify(queue: .main) {
            // You don't need to do anything here unless you want to show/hide a loader or trigger an animation
            print("All data loaded and UI updated.")
        }
    }
    
    //MARK: Button Actions
    @IBAction func EditAct(_ sender: Any) {
        
        let vc = ProfileEditVc(nibName: nil, bundle: nil)
        vc.ProfileDetails = Profile_Details
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    @IBAction func EditAcademicAct(_ sender: Any) {
        
        let vc = EditAcademicVc(nibName: nil, bundle: nil)
        vc.educationData = Academic_Details
        vc.EducationDetail = Academic_Details?.educationalDetails ?? []
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func EditSkillAct(_ sender: Any) {
        
        let vc = EditSkillsVc(nibName: nil, bundle: nil)
        vc.SkillData = Skill_data
        vc.SoftSkills = SoftSkills
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func BuildResumeAct(_ sender: Any) {
        
        let vc = GenerateResumeVC(nibName: nil, bundle: nil)
        vc.EducationDetail = Academic_Details?.educationalDetails
        vc.ProfileDetails = Profile_Details
        vc.SkillData = Skill_data
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func MyResumesAct(){
        
        let vc = PopupVC(nibName: nil, bundle: nil)
        vc.Resumes = My_resumes?.resumeTitle
        vc.EducationDetail = Academic_Details?.educationalDetails
        vc.ProfileDetails = Profile_Details
        vc.SkillData = Skill_data
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    
    func PopupDidDismiss() {
        self.fetchAllData()
    }
    
    @IBAction func BackAct(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    //MARK: Set data
    func Set_profile_Data(Details: Profile){
        
        let image_Url = URL(string: Details.memberImagePath ?? "")
        profileImage.sd_setImage(with: image_Url, placeholderImage: UIImage(systemName: "person.circle"))
        NameLbl.text = Details.memberName
        MobileNoBtn.setTitle(Details.memberPhoneNumber, for: .normal)
        EmailBtn.setTitle(Details.memberstudentEmail, for: .normal)
        AvilablePlacementLbl.text = Details.memberPlacementStatus
        
        switch Details.memberPlacementStatus?.lowercased() {
            
        case "available":
            PlacementStatusBGView.backgroundColor = .systemGreen.withAlphaComponent(0.4)
        case "shortlisted":
            PlacementStatusBGView.backgroundColor = .systemYellow.withAlphaComponent(0.4)
        case "placed":
            PlacementStatusBGView.backgroundColor = .systemIndigo.withAlphaComponent(0.4)
        case "attended interview" :
            PlacementStatusBGView.backgroundColor = .systemBlue.withAlphaComponent(0.4)
        case "not consented" :
            PlacementStatusBGView.backgroundColor = .systemRed.withAlphaComponent(0.4)
        default:
            PlacementStatusBGView.backgroundColor = .systemGreen.withAlphaComponent(0.4)
        }
        
        if Details.memberPlacementStatus?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true{
            PlacementStatusBGView.isHidden = true
        }else{
            PlacementStatusBGView.isHidden = false
        }
       

        if Details.memberNotificationStatus == true {
            consentedBtn.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            consentedBtn.tintColor = .systemGreen
            consentedBtn.setTitle("Consented for placement", for: .normal)
        }else {
            consentedBtn.setImage(UIImage(systemName: "x.circle.fill"), for: .normal)
            consentedBtn.tintColor = .systemRed
            consentedBtn.setTitle("Student opted-out for jobs", for: .normal)
        }
//        consentedBtn.setImage(
//            Details.memberNotificationStatus == true
//            ? UIImage(systemName: "checkmark.circle.fill")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
//            : UIImage(systemName: "x.circle.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal),
//            for: .normal
//        )
        RollNoLbl.text = Details.memberAdmissionNo ?? "-"
        RegNoLbl.text = Details.memberRegno
        CourseLbl.text = Details.courseName
        DepartmentLbl.text = Details.departmentName
        YearofStudyLbl.text = String(Details.noOfYear ?? 0)
        SemesterLbl.text = Details.semesterName
        DateOfBirthLbl.text = Details.memberDob
        GenderLbl.text = Details.memberGender
        AddressLbl.text = "\(Details.memberPermanentAddress1 ?? ""), \(Details.memberPermanentAddressCity ?? ""), \(Details.memberPermanentAddressState ?? ""), \(Details.memberPermanentAddressPincode ?? ""), \(Details.memberPermanentAddressCountry ?? "")"
    }
    
   /* func Set_Academic_Data(Details: EducationData){
        
//        let height = ceil(Double((Academic_Details?.educationalDetails?.count ?? 0) + 0) / 3)
//        CvHeight.constant = height * 70 //AcademicCv.contentSize.height
//        view.layoutIfNeeded()
        AcademicCv.reloadData()
//        self.AcademicCv.layoutIfNeeded()
//
//            let contentHeight = self.AcademicCv.collectionViewLayout.collectionViewContentSize.height
//        self.CvHeight.constant = contentHeight
////        DispatchQueue.main.async {
//            self.AcademicCv.layoutIfNeeded()
//            let height = self.AcademicCv.contentSize.height
//            if height.isFinite && height > 0 {
//                self.CvHeight.constant = height
//            }
//        }
        
        DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                let contentHeight = self.AcademicCv.collectionViewLayout.collectionViewContentSize.height
                if contentHeight.isFinite && contentHeight > 0 {
                    self.CvHeight.constant = contentHeight
                    // Update layout after changing the constraint
                    self.view.layoutIfNeeded()
                }
            }
        
        if Academic_Details?.educationalDetails?.count == 0  {
            
            AcademicRecordView.isHidden = true
            AcademicEditBtn.setTitle("Add", for: .normal)
        }
        
        BacklogsBtn.setTitle(Details.backlogs, for: .normal)
        NumArrearBtn.setTitle(Details.numberOfArrears, for: .normal)
        BacklogsBtn.backgroundColor = Details.backlogs == "0" ? .clear : .systemRed
        NumArrearBtn.backgroundColor = Details.numberOfArrears == "0" ? .clear : .systemRed
        let backlogsColor: UIColor = Details.backlogs == "0" ? .black : .white
        BacklogsBtn.setTitleColor(backlogsColor, for: .normal)
        let arrearsColor: UIColor = Details.numberOfArrears == "0" ? .black : .white
        NumArrearBtn.setTitleColor(arrearsColor, for: .normal)

    }*/
    
    func Set_Academic_Data(Details: EducationData) {
        AcademicCv.reloadData()
        AcademicCv.layoutIfNeeded()
        AcademicCv.collectionViewLayout.invalidateLayout()

        let contentHeight = AcademicCv.collectionViewLayout.collectionViewContentSize.height
        CvHeight.constant = contentHeight

        if Academic_Details?.educationalDetails?.count == 0 {
            AcademicRecordView.isHidden = true
            AcademicEditBtn.setTitle("Add", for: .normal)
        }

        BacklogsBtn.setTitle(Details.backlogs, for: .normal)
        NumArrearBtn.setTitle(Details.numberOfArrears, for: .normal)
        BacklogsBtn.backgroundColor = Details.backlogs == "0" ? .clear : .systemRed
        NumArrearBtn.backgroundColor = Details.numberOfArrears == "0" ? .clear : .systemRed
        BacklogsBtn.setTitleColor(Details.backlogs == "0" ? .black : .white, for: .normal)
        NumArrearBtn.setTitleColor(Details.numberOfArrears == "0" ? .black : .white, for: .normal)
    }
    
    func Set_Skill_Data(Details: SkillProfile){
        
        LanguagesLbl.text = Details.languages
        SoftSkillsLbl.text = Details.softSkill
        AreaOfInterestLbl.text = Details.areaInterest
        ProgrammingLbl.text = Details.programmingLanguage
        ToolsLbl.text = Details.toolsPlatform
        UpdateProjects(projects: Details.projects ?? [])
        updateInternships(Details.internship ?? [])
        UpdateAssesment(assesments: Details.assessmentDetails ?? [])
        Updatecertification(certificates: Details.certifications ?? [])
    }
    
    func updateInternships(_ internships: [Internship]) {
            // Optional: clear old labels except first (if it's a static title)
            for view in InternshipStack.arrangedSubviews {
                if view != InternshipStack.arrangedSubviews.first {
                    InternshipStack.removeArrangedSubview(view)
                    view.removeFromSuperview()
                }
            }

        for internship in internships {
                    // Create a container vertical stack for each internship block
                    let internshipStack = UIStackView()
                    internshipStack.axis = .vertical
                    internshipStack.spacing = 2
                    internshipStack.alignment = .leading

                    // Company name label
                    let companyLabel = UILabel()
                    companyLabel.text = internship.companyName
            companyLabel.setFont(style: .semibold, size: FontSize.body)
                    companyLabel.textColor = .label

                    // Date label
                    let dateLabel = UILabel()
                    dateLabel.text = formatDateRange(from: internship.from ?? "", to: internship.to ?? "")
                    dateLabel.setFont(style: .regular, size: 11)
                    dateLabel.textColor = .secondaryLabel

                    internshipStack.addArrangedSubview(companyLabel)
                    internshipStack.addArrangedSubview(dateLabel)

                    // Add the block to main vertical stack view
            InternshipStack.addArrangedSubview(internshipStack)
                }
        }
    
    func formatDateRange(from: String, to: String) -> String {
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "dd-MM-yyyy"

            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd MMM yyyy"

            guard let fromDate = inputFormatter.date(from: from),
                  let toDate = inputFormatter.date(from: to) else {
                return "Invalid date"
            }

            let fromStr = outputFormatter.string(from: fromDate)
            let toStr = outputFormatter.string(from: toDate)

            return "\(fromStr) to \(toStr)"
        }
    
    func UpdateAssesment(assesments:[Assessment]){
        
        for view in AssesmentStack.arrangedSubviews {
            
            if view != AssesmentStack.arrangedSubviews.first {
                AssesmentStack.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
        }
        
        for Assesment in assesments {
            
            let label = UILabel()
            label.text = (Assesment.assessment ?? "") + " : " + (Assesment.score ?? "") /*+ "/100"*/
            label.setFont(style: .semibold, size: FontSize.body)
            label.numberOfLines = 0
            label.textColor = .label
            AssesmentStack.addArrangedSubview(label)
        }
    }
    
    func Updatecertification(certificates:[Certification]){
        
        for view in CertificationsStack.arrangedSubviews{
            
            if view != CertificationsStack.arrangedSubviews.first {
                CertificationsStack.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
        }
        
        for Certificate in certificates{
            
            let label = UILabel()
            label.text = (Certificate.courseName ?? "") + " - " + (Certificate.institute ?? "") + " - " + (Certificate.duration ?? "")
            label.setFont(style: .semibold, size: FontSize.body)
            label.numberOfLines = 0
            label.textColor = .label
            CertificationsStack.addArrangedSubview(label)
        }
        
    }
    
    func UpdateProjects(projects: [projects]) {
        
        for view in ProjectsStack.arrangedSubviews {
            
            if view != ProjectsStack.arrangedSubviews.first {
                ProjectsStack.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
        }
        
        for project in projects {
            
            let label = UILabel()
            label.text = project.title
            label.setFont(style: .semibold, size: FontSize.body)
            label.numberOfLines = 0
            label.textColor = .label
            ProjectsStack.addArrangedSubview(label)
        }
    }

}

extension ResumeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return Academic_Details?.educationalDetails?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = AcademicCv.dequeueReusableCell(withReuseIdentifier: "AcademicCvcell", for: indexPath) as! AcademicCvcell
        
        if indexPath.item < Academic_Details?.educationalDetails?.count ?? 0{
            let data = Academic_Details?.educationalDetails?[indexPath.row]
            
            cell.ClassLbl.text = (data?.classDegree ?? "") + " %"
            cell.MarkBtn.setTitle(data?.percentage, for: .normal)
            cell.configure(with: data?.percentage ?? "")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize(width: 100, height: 100)
        }
        
        let totalSpacing = layout.minimumInteritemSpacing * 2
            + layout.sectionInset.left
            + layout.sectionInset.right
        let availableWidth = collectionView.frame.width - totalSpacing
        let itemWidth = floor(availableWidth / 3)
        
        // Get your dynamic text from model
        let text = Academic_Details?.educationalDetails?[indexPath.item].classDegree ?? ""
        let font = UIFont.systemFont(ofSize: 14) // match your cell label font
        
        // Calculate dynamic label height
        let textHeight = heightForText(text, font: font, width: itemWidth - 16) // subtract padding
        
        let baseHeight: CGFloat = 40 // padding + other fixed UI in cell
        return CGSize(width: itemWidth, height: baseHeight + textHeight)
    }
    
    private func heightForText(_ text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(
            with: constraintRect,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [.font: font],
            context: nil
        )
        return ceil(boundingBox.height)
    }


    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        let width = AcademicCv.frame.width / 3
//       // return CGSize(width: width, height: 70)
//        return CGSize(width: width, height: UICollectionViewFlowLayout.automaticSize.height)
//    }
    
}


extension ResumeVC: UIDocumentPickerDelegate{
    
    @available(iOS 14.0, *)
    @IBAction func uploadResumeAct(_ sender: Any) {
        
        pickDocument()
    }
    
    @available(iOS 14.0, *)
    func pickDocument() {
        let supportedTypes: [UTType] = [UTType.pdf]

            let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
            documentPicker.delegate = self
            documentPicker.allowsMultipleSelection = false  // ✅ Only one file allowed
            present(documentPicker, animated: true, completion: nil)
        }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        

        
        let fileurl: URL = url as URL
        let filename = url.lastPathComponent
        let fileextension = url.pathExtension
        print("URL: \(fileurl)", "NAME: \(filename)", "EXTENSION: \(fileextension)")
        
                let vc = ViewResumeVC(nibName: nil, bundle: nil)
                vc.isAwsurl = false
                vc.IsNewResume = true
                vc.selectedPDFURL = fileurl
        vc.File_url = fileurl.absoluteString
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true)
        }

       func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
           print("❌ Document picker canceled.")
       }
}
