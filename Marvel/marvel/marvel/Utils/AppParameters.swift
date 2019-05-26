//
//  AppParameters.swift
//  marvel
//
//  Created by Matheus Cereja on 24/05/19.
//  Copyright © 2019 Matheus Cereja. All rights reserved.
//

import Foundation

class AppParameters{
    
    static let publicKey = "86f358735fa38d66b61ea32ce1478e45"
    static let privateKey = "8018af9faed849c9462c6cb14d0c6c9e79557cb7"
    static var API_Endpoint : String {
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            return NSDictionary(contentsOfFile: path)?["URL"] as! String
        }
        return ""
    }
    static let extensionImg = "/portrait_xlarge."
    
}
