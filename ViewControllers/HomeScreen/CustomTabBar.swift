//
//  CustomTabBar.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 07/08/26.
//

protocol CustomTabBarDelegate: AnyObject {
    func didTapSearch()
    func didTapSideMenu()
}

import UIKit

@available(iOS 16.0, *)
class CustomTabBar: UIView {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var logoBaseview: UIView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var memberNameLbl: UILabel!
    @IBOutlet weak var RoleLbl: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var goToPriorityView: UIView!
    @IBOutlet weak var SearchBtn: UIButton!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var personIconView: UIView!
    
    weak var delegate: CustomTabBarDelegate?
    
    @IBInspectable var showSearch: Bool = true {
            didSet {
                SearchBtn.isHidden = !showSearch
            }
        }
    
    @IBInspectable var showBackButton: Bool = true {
            didSet {
                backBtn.isHidden = !showBackButton
            }
        }
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            commonInit()
        }

        private func commonInit() {

            Bundle.main.loadNibNamed("CustomTabBar", owner: self, options: nil)

            addSubview(contentView)
            contentView.frame = bounds
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            logoBaseview.layer.cornerRadius = 10
            logo.layer.cornerRadius = 10
            
            goToPriorityView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ChangeRoleBtnAct)))
            
            personIconView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showSideMenu)))
            
            contentView.backgroundColor = .priorityColor
            RoleLbl.text = .priorityRole
            memberNameLbl.text = UserDefaults.standard
                .string(forKey: DefaultsKeys.memberName)
                
            let colgImg = UserDefaults.standard.string(forKey: DefaultsKeys.colglogo) ?? ""
            logo.sd_setImage(with: URL(string: colgImg),placeholderImage: UIImage(named:"EmptyCollegeIcon"))
            
        }
    
    
    @IBAction func searchBtnAct(_ sender: UIButton) {
        
        delegate?.didTapSearch()
    }
    
    @IBAction func NotificationBtnAct(_ sender: UIButton) {
        guard let vc = parentViewController else { return }
        
        let NotificationVC = NotificationViewController(nibName: nil, bundle: nil)
        NotificationVC.modalPresentationStyle = .fullScreen
        vc.present(NotificationVC, animated: true)
        
 
    }
    
    @IBAction func showSideMenu(_ sender: Any) {
        delegate?.didTapSideMenu()
    }
    
    @IBAction func ChangeRoleBtnAct(_ sender: UIButton) {
        guard let vc = parentViewController else { return }

           let priorityVC = PriorityScreenVC(nibName: nil, bundle: nil)
           priorityVC.modalPresentationStyle = .fullScreen
           vc.present(priorityVC, animated: true)
    }
    
    @IBAction func backAct(_ sender: Any) {
        guard let vc = parentViewController else { return }
        vc.dismiss(animated: true)
    }
    
}
