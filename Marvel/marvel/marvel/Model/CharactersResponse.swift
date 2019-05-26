//
//  CharactersResponse.swift
//  marvel
//
//  Created by Matheus Cereja on 24/05/19.
//  Copyright © 2019 Matheus Cereja. All rights reserved.
//

import Foundation
import ObjectMapper

struct CharacterResponse: Mappable {
    
    var status : String?
    var dataResult : CharacterData?
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        status <- map["status"]
        dataResult <- map["data"]
    }
    
}

class CharacterData: Mappable {
    var offset: Int?
    var count: Int?
    var total: Int?
    var results: [Characters]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        offset <- map["offset"]
        count <- map["count"]
        results <- map["results"]
        total <- map["total"]
    }
}
