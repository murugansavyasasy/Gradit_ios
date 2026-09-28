//
//  Extentions.swift
//  Vs_GradItCollege
//
//  Created by Chandhru on 21/09/26.
//

import Foundation
import UIKit
extension String{
    func dateFormater(input:String? = "dd-MM-yyyy",output:String? = " dd MMM yyyy")->String?{
        let formater = DateFormatter()
        formater.dateFormat = input
        formater.locale = Locale(identifier: "en_US_POSIX")
        let date = formater.date(from: self) ?? Date()
        formater.dateFormat = output
        return formater.string(from: date )
    }
}
extension Int {
    func durationFormat() -> String {
        let minutes = self / 60
        let seconds = self % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
extension UIColor {
    
    static var priorityColor: UIColor {
        let priority = UserDefaults.standard
            .string(forKey: DefaultsKeys.priority)?
            .lowercased()
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
 
extension String {
    
    static var priorityRole: String {
        let priority = UserDefaults.standard
            .string(forKey: DefaultsKeys.priority)?
            .lowercased()
        
        switch priority {
        case "p1":
            return "Principal"
            
        case "p2":
            return "Hod"
            
        case "p3":
            return "Teacher"
            
        case "p4":
            return "Student"
            
        case "p5":
            return "Father"
            
        case "p6":
            return "Non Teaching"
            
        case "p7":
            return "University Head"
        default:
            return ""
        }
    }
}
extension UIViewController {

    func showAlert(_ message: String) {
        let alert = UIAlertController(
            title: "",
            message: message,
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(title: "OK", style: .default)
        )

        present(alert, animated: true)
    }

    func presentFullScreen(_ vc: UIViewController) {
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
