//
//  CustomTabBar.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 07/08/26.
//

import UIKit

@available(iOS 16.0, *)
class CustomTabBar: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var goToPriorityView: UIView!
    @IBOutlet weak var refreshBtn: UIButton!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var personIconView: UIView!
    
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
        }
    
    
    @IBAction func refreshBtnAct(_ sender: UIButton) {
        guard let vc = parentViewController else { return }

           let priorityVC = PriorityViewController(nibName: nil, bundle: nil)
           priorityVC.modalPresentationStyle = .fullScreen
           vc.present(priorityVC, animated: true)
    }
    
    @IBAction func NotificationBtnAct(_ sender: UIButton) {
       
    }
    
    @IBAction func showSideMenu(_ sender: Any) {
        
    }
    
    @IBAction func ChangeRoleBtnAct(_ sender: UIButton) {
      
    }
}
