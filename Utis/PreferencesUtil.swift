//

//
//  PreferencesUtil.swift
//  CallShoppee
//
//  Created by APPLE on 02/05/22.
//

import Foundation


class PreferencesUtil{
    
    
    static func saveToPrefs(key : String, value : String) -> Void{
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func getFromPrefs(key : String) -> String{
        return UserDefaults.standard.string(forKey: key)!
    }
    
    static func removePrefs(key : String) -> Void{
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    static func checkPrefs(key : String) -> Bool{
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    static func isObjectNotNil(object:AnyObject!) -> Bool{
        if let _:AnyObject = object{
            return true
        }
        return false
    }
    
   
}



