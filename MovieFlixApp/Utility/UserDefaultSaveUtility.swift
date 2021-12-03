//
//  UserDefaultSaveUtility.swift
//  BrewAppAssignment
//
//  Created by pslmacuser on 20/11/21.
//

import Foundation
struct userDefaultUtilitySave {
    func saveUserId(userId: Int)
    {
        //UserDefaults.standard.set(userId, forKey: "userId")
    }

    func getUserId() -> Int
    {
        return UserDefaults.standard.value(forKey: "userId") as! Int
    }
}
