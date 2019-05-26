//
//  CellViewModel.swift
//  marvel
//
//  Created by Matheus Cereja on 25/05/19.
//  Copyright © 2019 Matheus Cereja. All rights reserved.
//

import Foundation
import UIKit

class CellViewModel {
    
    // MARK: - let and var
    private var character: Characters?
    
    // MARK: - Fuction
    func getImgUrl() -> String{
        return character!.thumbnail!.path! + AppParameters.extensionImg + character!.thumbnail!.extensionImage!
    }
    
    func getTitle() -> String{
        return character!.name!
    }
    
    func getDescription() -> String{
        if(character!.description!.isEmpty){
            return Constants.noCharacter
        }
        return character!.description!
    }
    
    func getModifiedDate() -> String{
        return String(character!.modified!.prefix(4))
    }
    
    func getCountSeries() -> String{
        return String(character!.series!.avalible!)
    }
    
    func getCountComics() -> String{
        return String(character!.comics!.avalible!)
    }
    
    func getCountStories() -> String{
        return String(character!.stories!.avalible!)
    }
    
    // MARK: - Request
    
    
    // MARK: - init
    init(character: Characters){
        self.character = character
    }
    
}
