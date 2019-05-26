//
//  Heroes.swift
//  marvel
//
//  Created by Matheus Cereja on 24/05/19.
//  Copyright © 2019 Matheus Cereja. All rights reserved.
//

import Foundation
import ObjectMapper

class Characters: Mappable {
    
    var name: String?
    var  description: String?
    var  modified: String?
    var  thumbnail: CharactersThumbnail?
    var  series: CharactersMidia?
    var  comics: CharactersMidia?
    var  stories: CharactersMidia?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        description <- map["description"]
        modified <- map["modified"]
        thumbnail <- map["thumbnail"]
        series <- map["series"]
        comics <- map["comics"]
        stories <- map["stories"]
    }
    
}

class CharactersThumbnail: Mappable {
    
    var path: String?
    var extensionImage: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        path <- map["path"]
        extensionImage <- map["extension"]
    }
    
}

class CharactersMidia: Mappable {
    
    var avalible: Int?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        avalible <- map["available"]
    }
}



