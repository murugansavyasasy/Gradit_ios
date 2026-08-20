//
//  MenuPageCVCell.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 06/08/26.
//

import UIKit

@available(iOS 16.0, *)
class MenuPageCVCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var cv: UICollectionView!
    
    var menuList: [menuApiDataDetails] = []
    var NoticeBoardId = "1"
    var videoId = "2"
    var EventId = "3"
    var communicationId = "4"
    var imagePdfId = "5"
    var Assigment = "6"
    let menuIconMapping: [String: String] = [
        
        // MARK: - Common Menus
        
        "home": "house.fill",
        "chat": "bubble.left.and.bubble.right.fill",
        "voice": "mic.fill",
        "text": "text.bubble.fill",
        
        
        // MARK: - Academic
        
        "examination": "list.clipboard.fill",
        "attendance": "calendar.badge.checkmark",
        "assignment": "doc.plaintext.fill",
        "circular": "photo.fill",
        
        
        // MARK: - Communication / Campus
        
        "notice_board": "megaphone.fill",
        "events": "calendar",
        "faculty": "person.2.fill",
        "video": "video.fill",
        
        
        // MARK: - Attendance
        
       // "mark_your_attendance": "hand.point.up.fill",
        "attendance_report": "chart.bar.doc.horizontal.fill",
        
        
        // MARK: - Course / Credit
        
        "course_details": "book.fill",
        "category_credit_points": "chart.bar.fill",
        "sem_credit_points": "chart.pie.fill",
        
        
        // MARK: - Examination
        
       // "exam_application_details": "list.clipboard.fill",
        "hall_ticket": "list.bullet.clipboard.fill",
        
        
        // MARK: - Fees
        
        "feedetails": "indianrupeesign.circle.fill",
        
        
        // MARK: - Placement
        
        "resume_builder": "doc.richtext.fill",
        "placement_events": "briefcase.fill",
        "placement_training": "person.2.badge.gearshape.fill"
    ]
    
    private var priority: String? = UserDefaults.standard.string(forKey: DefaultsKeys.priority)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.priority = UserDefaults.standard.string(forKey: DefaultsKeys.priority)
        
        cv.register(UINib(nibName: "MenuCVCell", bundle: nil), forCellWithReuseIdentifier: "MenuCVCell")
        cv.delegate = self
        cv.dataSource = self
    }
    
    func configure(with data: [menuApiDataDetails]) {
        
        self.menuList = data
        cv.reloadData()
    }
    
    func colorForPriority() -> UIColor? {
        switch priority {
        case "p1":
            return UIColor(named: "Principal")
        case "p2", "p3", "p6":
            return UIColor(named: "Teaching Staff")
        case "p4":
            return UIColor(named: "studentViewColors")
        case "p5":
            return UIColor(named: "FatherColor")
        case "p7":
            return UIColor(named: "univercityColorCod")
        default:
            return UIColor.systemBackground // fallback color
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        menuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = cv.dequeueReusableCell(withReuseIdentifier: "MenuCVCell", for: indexPath) as? MenuCVCell else{
            return UICollectionViewCell()
        }
        
        let menu = menuList[indexPath.item]
        
        cell.menuNameLbl.text = menu.menu_name
        
        if let iconName = menuIconMapping[menu.menu_slug] {
            cell.iconImageview.image = UIImage(systemName: iconName)
        }else{
            cell.iconImageview.image = UIImage(named: String(menu.menu_slug))
        }
        
        cell.iconImageview.tintColor = colorForPriority()
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = cv.frame.width/4
        
        return CGSize(width: width, height: 110)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                let currentController = self.getCurrentViewController()
                guard indexPath.item < menuList.count else { return }
                let menu = menuList[indexPath.item]
                let slug = menu.menu_slug
                let read = String(menu.is_read_enabled)
                let write = String(menu.is_write_enabled)

                // Build arrays similar to ReuseView for downstream VCs that expect them
                let str: [String] = menuList.map { $0.menu_slug }
                let strName: [String] = menuList.map { $0.menu_name }

                guard let priority = self.priority else { return }

                // Helper to present a VC full screen
                func present(_ vc: UIViewController) {
                    
                    vc.modalPresentationStyle = .fullScreen
                    currentController?.present(vc, animated: true, completion: nil)
                }

                // Routing copied from ReuseView.swift, adapted to use `slug`, `str`, and `strName`
                if priority == "p4" {
                    if slug == "home" {
                        let vc = NewHomescreenVC(nibName: nil, bundle: nil)
                        present(vc)
                    } else if slug == "resume_builder" {
                        let vc = ResumeVC(nibName: nil, bundle: nil)
                        present(vc)
                    } else if slug == "placement_events" {
                        let vc = PlacementEventsVC(nibName: nil, bundle: nil)
                        present(vc)
                    } else if slug == "placement_training" {
                        let vc = PlacementTrainingVC(nibName: nil, bundle: nil)
                        present(vc)
                    } else if slug == "voice" {
                        let vc = CommunicationHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "StudentParent")
                        present(vc)
                    } else if slug == "text" {
                        let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "StudentParent")
                        present(vc)
                    } else if slug == "examination" {
                        let vc = ExaminationHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "StudentParent")
                        present(vc)
                    } else if slug == "attendance" {
                        let vc = AttendanceViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "StudentParent")
                        present(vc)
                    } else if slug == "assignment" {
                        let vc = AssigmentHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "StudentParent")
                        present(vc)
                    } else if slug == "feedetails" {
                        let vc = FeePaymentViewController(nibName: nil, bundle: nil)
                        vc.view.backgroundColor = UIColor(named: "StudentParent")
                        present(vc)
                    } else if slug == "circular" {
                        let vc = ImageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "StudentParent")
                        present(vc)
                    } else if slug == "hall_ticket" {
                        let vc = HallTicketViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "StudentParent")
                        present(vc)
                    } else if slug == "notice_board" {
                        let vc = NoticeBoardHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "StudentParent")
                        present(vc)
                    } else if slug == "events" {
                        let vc = EventsViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "StudentParent")
                        present(vc)
                    } else if slug == "faculty" {
                        let vc = FacultyHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "StudentParent")
                        present(vc)
                    } else if slug == "video" {
                        let vc = VideoViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "StudentParent")
                        present(vc)
                    } else if slug == "chat" {
                        let vc = ChatHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "StudentParent")
                        present(vc)
                    } else if slug == "course_details" {
                        let vc = CourseHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "StudentParent")
                        present(vc)
                    } else if slug == "category_credit_points" {
                        let vc = CategoryHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "StudentParent")
                        present(vc)
                    } else if slug == "sem_credit_points" {
                        let vc = SemesterHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "StudentParent")
                        present(vc)
                    } else if slug == "exam_application_details" {
                        let vc = ExamDetailsHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "StudentParent")
                        present(vc)
                    }
                } else if priority == "p1" {
                    if slug == "home" {
                        let vc = NewHomescreenVC(nibName: nil, bundle: nil)
                        vc.view.backgroundColor = UIColor(named: "Principal")
                        present(vc)
                    } else if slug == "feedetails" {
                        let vc = FeePaymentViewController(nibName: nil, bundle: nil)
                        vc.view.backgroundColor = UIColor(named: "Principal")
                        present(vc)
                    } else if slug == "voice" {
                        let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.MenuRefName = menuList
                        vc.view.backgroundColor = UIColor(named: "Principal")
                        vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
                        present(vc)
                    } else if slug == "text" {
                        let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.MenuRefName = menuList
                        vc.view.backgroundColor = UIColor(named: "Principal")
                        vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
                        present(vc)
                    } else if slug == "examination" {
                        let vc = SenderExmainationHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "Principal")
                        vc.examSegmentName.backgroundColor = UIColor(named: "UnSelector")
                        vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                        present(vc)
                    } else if slug == "attendance" {
                        let vc = SenderAttendanceVcViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "Principal")
                        vc.segmentName.backgroundColor = UIColor(named: "UnSelector")
                        vc.segmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                        present(vc)
                    } else if slug == "assignment" {
                        let vc = SenderAssigmentHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.assigmentMenuId = Assigment
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "Principal")
                        vc.assigmentSegmentName.backgroundColor = UIColor(named: "UnSelector")
                        vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                        present(vc)
                    } else if slug == "circular" {
                        let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "Principal")
                        vc.imageSegmentName.backgroundColor = UIColor(named: "UnSelector")
                        vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                        present(vc)
                    } else if slug == "notice_board" {
                        let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "Principal")
                        vc.noticeSegments.backgroundColor = UIColor(named: "UnSelector")
                        vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "Selector")
                        present(vc)
                    } else if slug == "events" {
                        let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "Principal")
                        vc.eventSegmentName.backgroundColor = UIColor(named: "UnSelector")
                        vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                        present(vc)
                    } else if slug == "faculty" {
                        let vc = SenderFacultyViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "Principal")
                        present(vc)
                    } else if slug == "video" {
                        let vc = SenderVideoHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "Principal")
                        present(vc)
                    } else if slug == "chat" {
                        let vc = ChatSenderViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "Principal")
                        present(vc)
                    } else if slug == "mark_your_attendance" {
                        let vc = LocationViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        present(vc)
                    } else if slug == "attendance_report" {
                        let vc = LocationHistoryVc(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "Principal")
                        present(vc)
                    }
                } else if priority == "p3" || priority == "p2" {
                    if slug == "home" {
                        let vc = NewHomescreenVC(nibName: nil, bundle: nil)
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                        present(vc)
                    } else if slug == "feedetails" {
                        let vc = FeePaymentViewController(nibName: nil, bundle: nil)
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                        present(vc)
                    } else if slug == "voice" {
                        let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.ComunimenuId = communicationId
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                        vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                        present(vc)
                    } else if slug == "text" {
                        let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.ComunimenuId = communicationId
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                        vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                        present(vc)
                    } else if slug == "examination" {
                        let vc = SenderExmainationHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                        vc.examSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                        present(vc)
                    } else if slug == "attendance" {
                        let vc = SenderAttendanceVcViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                        vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodUnSelector")
                        present(vc)
                    } else if slug == "assignment" {
                        let vc = SenderAssigmentHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                        vc.assigmentSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                        present(vc)
                    } else if slug == "circular" {
                        let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.imagePdfMenuIdType = imagePdfId
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                        vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                        present(vc)
                    } else if slug == "notice_board" {
                        let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.menuTypessww = NoticeBoardId
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                        vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
                        present(vc)
                    } else if slug == "events" {
                        let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.EventMenuId = EventId
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                        vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                        present(vc)
                    } else if slug == "faculty" {
                        let vc = SenderFacultyViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                        present(vc)
                    } else if slug == "video" {
                        let vc = SenderVideoHomePageViewController(nibName: nil, bundle: nil)
                        vc.VideoMenuId = videoId
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                        present(vc)
                    } else if slug == "chat" {
                        let vc = ChatSenderViewController(nibName: nil, bundle: nil)
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                        present(vc)
                    } else if slug == "mark_your_attendance" {
                        let vc = LocationViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                        present(vc)
                    } else if slug == "attendance_report" {
                        let vc = LocationHistoryVc(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        present(vc)
                    }
                } else if priority == "p7" {
                    if slug == "home" {
                        let vc = NewHomescreenVC(nibName: nil, bundle: nil)
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "univercityColorCod")
                        present(vc)
                    } else if slug == "feedetails" {
                        let vc = FeePaymentViewController(nibName: nil, bundle: nil)
                        vc.view.backgroundColor = UIColor(named: "univercityColorCod")
                        present(vc)
                    } else if slug == "voice" {
                        let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.ComunimenuId = communicationId
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "univercityColorCod")
                        vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                        present(vc)
                    } else if slug == "text" {
                        let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.ComunimenuId = communicationId
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "univercityColorCod")
                        vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                        present(vc)
                    } else if slug == "examination" {
                        let vc = SenderExmainationHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "univercityColorCod")
                        vc.examSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                        present(vc)
                    } else if slug == "attendance" {
                        let vc = SenderAttendanceVcViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "univercityColorCod")
                        vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodUnSelector")
                        present(vc)
                    } else if slug == "assignment" {
                        let vc = SenderAssigmentHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "univercityColorCod")
                        vc.assigmentSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                        present(vc)
                    } else if slug == "circular" {
                        let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.imagePdfMenuIdType = imagePdfId
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "univercityColorCod")
                        vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                        present(vc)
                    } else if slug == "notice_board" {
                        let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.menuTypessww = NoticeBoardId
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "univercityColorCod")
                        vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
                        present(vc)
                    } else if slug == "events" {
                        let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.EventMenuId = EventId
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "univercityColorCod")
                        vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                        present(vc)
                    } else if slug == "faculty" {
                        let vc = SenderFacultyViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "univercityColorCod")
                        present(vc)
                    } else if slug == "video" {
                        let vc = SenderVideoHomePageViewController(nibName: nil, bundle: nil)
                        vc.VideoMenuId = videoId
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "univercityColorCod")
                        present(vc)
                    } else if slug == "chat" {
                        let vc = ChatSenderViewController(nibName: nil, bundle: nil)
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "univercityColorCod")
                        present(vc)
                    } else if slug == "mark_your_attendance" {
                        let vc = LocationViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "univercityColorCod")
                        present(vc)
                    }
                } else if priority == "p5" {
                    if slug == "home" {
                        let vc = NewHomescreenVC(nibName: nil, bundle: nil)
                        vc.modalPresentationStyle = .fullScreen
                        currentController?.present(vc, animated: false, completion: nil)
                    } else if slug == "feedetails" {
                        let vc = FeePaymentViewController(nibName: nil, bundle: nil)
                        vc.view.backgroundColor = UIColor(named: "FatherColor")
                        present(vc)
                    } else if slug == "voice" {
                        let vc = CommunicationHomePageViewController(nibName: nil, bundle: nil)
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "FatherColor")
                        vc.CommuniSegementName.backgroundColor = UIColor(named: "FatherUnselector")
                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
                        present(vc)
                    } else if slug == "text" {
                        let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "FatherColor")
                        vc.CommuniSegementName.backgroundColor = UIColor(named: "FatherUnselector")
                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
                        present(vc)
                    } else if slug == "examination" {
                        let vc = ExaminationHomePageViewController(nibName: nil, bundle: nil)
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "FatherColor")
                        vc.examSegmentName.backgroundColor = UIColor(named: "FatherUnselector")
                        vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
                        present(vc)
                    } else if slug == "attendance" {
                        let vc = AttendanceViewController(nibName: nil, bundle: nil)
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "FatherColor")
                        present(vc)
                    } else if slug == "assignment" {
                        let vc = AssigmentHomePageViewController(nibName: nil, bundle: nil)
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "FatherColor")
                        vc.assigmentSegmentName.backgroundColor = UIColor(named: "FatherUnselector")
                        vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
                        present(vc)
                    } else if slug == "circular" {
                        let vc = ImageViewController(nibName: nil, bundle: nil)
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "FatherColor")
                        vc.imageSegmentName.backgroundColor = UIColor(named: "FatherUnselector")
                        vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
                        present(vc)
                    } else if slug == "notice_board" {
                        let vc = NoticeBoardHomePageViewController(nibName: nil, bundle: nil)
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "FatherColor")
                        vc.noticeSegments.backgroundColor = UIColor(named: "FatherUnselector")
                        vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "FatherSelector")
                        present(vc)
                    } else if slug == "events" {
                        let vc = EventsViewController(nibName: nil, bundle: nil)
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "FatherColor")
                        vc.eventSegmentName.backgroundColor = UIColor(named: "FatherUnselector")
                        vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
                        present(vc)
                    } else if slug == "faculty" {
                        let vc = FacultyHomePageViewController(nibName: nil, bundle: nil)
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "FatherColor")
                        present(vc)
                    } else if slug == "video" {
                        let vc = VideoViewController(nibName: nil, bundle: nil)
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "FatherColor")
                        present(vc)
                    } else if slug == "chat" {
                        let vc = ChatHomePageViewController(nibName: nil, bundle: nil)
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "FatherColor")
                        present(vc)
                    } else if slug == "course_details" {
                        let vc = CourseHomePageViewController(nibName: nil, bundle: nil)
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "FatherColor")
                        present(vc)
                    } else if slug == "category_credit_points" {
                        let vc = CategoryHomePageViewController(nibName: nil, bundle: nil)
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "FatherColor")
                        present(vc)
                    } else if slug == "sem_credit_points" {
                        let vc = SemesterHomePageViewController(nibName: nil, bundle: nil)
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "FatherColor")
                        present(vc)
                    } else if slug == "exam_application_details" {
                        let vc = ExamDetailsHomePageViewController(nibName: nil, bundle: nil)
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "FatherColor")
                        present(vc)
                    }
                } else if priority == "p6" {
                    if slug == "home" {
                        let vc = NewHomescreenVC(nibName: nil, bundle: nil)
                        vc.str = str
                        vc.strName = strName
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                        present(vc)
                    } else if slug == "feedetails" {
                        let vc = FeePaymentViewController(nibName: nil, bundle: nil)
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                        present(vc)
                    } else if slug == "voice" {
                        let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                        vc.ComunimenuId = communicationId
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                        vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                        present(vc)
                    } else if slug == "text" {
                        let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                        vc.ComunimenuId = communicationId
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                        vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                        present(vc)
                    } else if slug == "examination" {
                        let vc = SenderExmainationHomePageViewController(nibName: nil, bundle: nil)
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                        vc.examSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                        present(vc)
                    } else if slug == "attendance" {
                        let vc = SenderAttendanceVcViewController(nibName: nil, bundle: nil)
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                        vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodUnSelector")
                        present(vc)
                    } else if slug == "assignment" {
                        let vc = SenderAssigmentHomePageViewController(nibName: nil, bundle: nil)
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                        vc.assigmentSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                        present(vc)
                    } else if slug == "circular" {
                        let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
                        vc.imagePdfMenuIdType = imagePdfId
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                        vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                        present(vc)
                    } else if slug == "notice_board" {
                        let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
                        vc.menuTypessww = NoticeBoardId
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                        vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
                        present(vc)
                    } else if slug == "events" {
                        let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
                        vc.EventMenuId = EventId
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                        vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                        vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                        present(vc)
                    } else if slug == "faculty" {
                        let vc = SenderFacultyViewController(nibName: nil, bundle: nil)
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                        present(vc)
                    } else if slug == "video" {
                        let vc = SenderVideoHomePageViewController(nibName: nil, bundle: nil)
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                        vc.VideoMenuId = videoId
                        present(vc)
                    } else if slug == "chat" {
                        let vc = ChatSenderViewController(nibName: nil, bundle: nil)
                        vc.str = str
                        vc.strName = strName
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                        present(vc)
                    } else if slug == "mark_your_attendance" {
                        let vc = LocationViewController(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                        present(vc)
                    } else if slug == "attendance_report" {
                        let vc = LocationHistoryVc(nibName: nil, bundle: nil)
                        vc.is_read_enabled = read
                        vc.is_write_enabled = write
                        vc.view.backgroundColor = UIColor(named: "Teaching Staff")
                        present(vc)
                    }
                }
            }
        
        
        private func getCurrentViewController() -> UIViewController? {
                if let rootController = UIApplication.shared.keyWindow?.rootViewController {
                    var currentController: UIViewController! = rootController
                    while currentController.presentedViewController != nil {
                        currentController = currentController.presentedViewController
                    }
                    return currentController
                }
                return nil
            }

}
