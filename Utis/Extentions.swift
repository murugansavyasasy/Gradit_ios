//
//  Extentions.swift
//  Vs_GradItCollege
//
//  Created by Chandhru on 21/09/26.
//

import Foundation
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
