//
//  API.swift
//  marvel
//
//  Created by Matheus Cereja on 24/05/19.
//  Copyright © 2019 Matheus Cereja. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class API {
    
    static  func searchCharacters(search: String = "", year: String = "", offset: String = "", completion: @escaping (_ response: DataResponse<CharacterResponse>) -> Void){
        let url = AppParameters.API_Endpoint + "characters"
        let ts = NSDate().timeIntervalSince1970.description
        var param: Parameters =  [String: Any]()
        if(!search.isEmpty){
            param["nameStartsWith"] = search
        }
        if(!offset.isEmpty){
            param["offset"] = offset
        }
        if(year.count > 6){
            param["modifiedSince"] = year
        }
        param["limit"] = 15
        param["apikey"] =  AppParameters.publicKey
        param["ts"] = ts
        param["hash"] = (ts + AppParameters.privateKey + AppParameters.publicKey).md5()!
        Alamofire.request(url, method: .get, parameters: param).responseObject {  (response: DataResponse<CharacterResponse>) in
            completion(response)
        }
    }
}

