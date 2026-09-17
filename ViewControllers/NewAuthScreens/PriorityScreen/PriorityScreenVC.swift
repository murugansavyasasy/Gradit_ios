//
//  PriorityScreenVC.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 25/08/26.
//

struct UserPrioritySection {
    let priority : String
    var users : [datalogin]
    var isExpanded : Bool = true
}

import UIKit

@available(iOS 16.0, *)
class PriorityScreenVC: UIViewController {

    
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var logoutBtn: UIButton!
    
    var LoginData : [datalogin] = []
    var prioritySections : [UserPrioritySection] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        logoutBtn.layer.cornerRadius = 20
        logoutBtn.backgroundColor = UIColor.systemRed.withAlphaComponent(0.1)
        
        loadLoginData()
        
        tv.register(UINib(nibName: "PriorityProfileCell", bundle: nil), forCellReuseIdentifier: "PriorityProfileCell")
        tv.register(UINib(nibName: "PriorityCollegeDetailsCell", bundle: nil), forCellReuseIdentifier: "PriorityCollegeDetailsCell")
        tv.delegate = self
        tv.dataSource = self
        tv.showsVerticalScrollIndicator = false
        tv.showsHorizontalScrollIndicator = false
      
    }

    func loadLoginData() {
        
        if let data = UserDefaults.standard.data(forKey: DefaultsKeys.loginDataList) {
            
            do {
                LoginData = try JSONDecoder().decode([datalogin].self, from: data)
            } catch {
                print("Decoding profiles failed:", error)
            }
        }
        
        for user in LoginData {
            
            guard let priority = user.priority else {
                continue
            }
            
            if let sectionIndex = prioritySections.firstIndex(where: { $0.priority == priority}) {
                prioritySections[sectionIndex].users.append(user)
            }else{
                prioritySections.append(
                    UserPrioritySection(
                        priority: priority,
                        users: [user]
                    )
                )
            }
        }
        
//        let groupedUsers = Dictionary(grouping: LoginData, by: { $0.priority ?? ""})
//        prioritySections = groupedUsers.map {
//            UserPrioritySection(
//                priority: $0.key,
//                users: $0.value
//            )
//        }.sorted{ $0.priority < $1.priority }
    }
    
    @IBAction func logoutAct(_ sender: Any) {
        let alert = UIAlertController(
            title: "",
            message: "Are you sure you want to logout?",
            preferredStyle: .alert
        )

        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
            UserDefaults.standard.removeObject(forKey: DefaultsKeys.mobileNumber)

            let vc = MobileNumberVC(nibName: nil, bundle: nil)
            vc.modalPresentationStyle = .fullScreen

            self?.present(vc, animated: true)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alert.addAction(yesAction)
        alert.addAction(cancelAction)

        present(alert, animated: true)
    }
    
}

@available(iOS 16.0, *)
extension PriorityScreenVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return section == 0 ? 1 : prioritySections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return ""
        }else{
            return "PROFILES BY ROLE"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tv.dequeueReusableCell(withIdentifier: "PriorityCollegeDetailsCell", for: indexPath) as? PriorityCollegeDetailsCell
            else { return UITableViewCell() }
            
            let college = prioritySections.first?.users.first
            let url = URL(string: college?.colglogo ?? "")
            cell.collegeLogo.sd_setImage(with: url,placeholderImage: UIImage(systemName: "building.columns.fill"))
            cell.collegeNameLbl.text = college?.colgname
            cell.collegeAddressLbl.text = college?.colgcity
            
            return cell
            
        }else{
            
            guard let cell = tv.dequeueReusableCell(withIdentifier: "PriorityProfileCell", for: indexPath) as? PriorityProfileCell else {
                return UITableViewCell()
            }
            
            let attributeString = NSMutableAttributedString(string: prioritySections[indexPath.row].users.first?.loginas ?? "", attributes: [.font:UIFont(name: "Poppins-SemiBold", size: 17.0)!])
            attributeString.append(
                NSAttributedString(
                    string: " (\(prioritySections[indexPath.row].users.count))",
                    attributes: [
                        .font: UIFont(name: "Poppins-SemiBold", size: 14.0)!,
                        .foregroundColor: UIColor.gray
                    ]
                )
            )
            cell.roleLbl.attributedText = attributeString
            cell.profileImageBaseView.backgroundColor = priorityColor(priority: prioritySections[indexPath.row].priority).withAlphaComponent(0.1)
            cell.profileImage.tintColor = priorityColor(priority: prioritySections[indexPath.row].priority)
            
            if prioritySections[indexPath.row].priority == "p4" || prioritySections[indexPath.row].priority == "p5" {
                cell.profileImage.image = UIImage(systemName: "graduationcap")
            }else{
                cell.profileImage.image = UIImage(systemName: "person.badge.shield.checkmark")
            }
            
            cell.configureCell(users: prioritySections[indexPath.row].users, isExpanded: prioritySections[indexPath.row].isExpanded)
            
            cell.onHeightChange = { [weak self] in
                guard let self = self else { return }
                UIView.performWithoutAnimation {
                    self.view.layoutIfNeeded()
                    self.tv.layoutIfNeeded()
                    self.tv.beginUpdates()
                    self.tv.endUpdates()
                }
            }
            
            cell.onUserSelected = { [weak self] in
                let vc = NewHomescreenVC()
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: true)
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard indexPath.section == 1 else { return }
        
        prioritySections[indexPath.row].isExpanded.toggle()
        //tv.reloadData()
        tv.reloadRows(at: [indexPath], with: .fade)
    }
    
    func priorityColor(priority: String) -> UIColor{
        
        switch priority {
        case "p1":
            return UIColor(named: "Principal") ?? .systemBackground

        case "p2", "p3", "p6":
            return UIColor(named: "Teaching Staff") ?? .systemBackground

        case "p4":
            return UIColor(named: "studentViewColors") ?? .systemBackground

        case "p5":
            return UIColor(named: "FatherColor") ?? .systemBackground

        case "p7":
            return UIColor(named: "univercityColorCod") ?? .systemBackground

        default:
            return UIColor(named: "Principal") ?? .systemBackground
        }
    }
}
