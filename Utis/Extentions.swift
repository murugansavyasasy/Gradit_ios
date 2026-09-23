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
enum Colour {
    static func backgroundColor(for priority: String) -> UIColor? {
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
            return nil
        }
    }
}
enum Role: String {
    case principal = "p1"
    case teachingStaffP2 = "p2"
    case teachingStaffP3 = "p3"
    case student = "p4"
    case father = "p5"
    case teachingStaffP6 = "p6"
    case university = "p7"

    var roleName: String {
        switch self {
        case .principal:
            return "Principal"
        case .teachingStaffP2,
             .teachingStaffP3,
             .teachingStaffP6:
            return "Teaching Staff"
        case .student:
            return "Student"
        case .father:
            return "Father"
        case .university:
            return "University"
        }
    }
}
