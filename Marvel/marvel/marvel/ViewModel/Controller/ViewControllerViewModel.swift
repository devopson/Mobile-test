//
//  ViewControllerViewModel.swift
//  marvel
//
//  Created by Matheus Cereja on 24/05/19.
//  Copyright © 2019 Matheus Cereja. All rights reserved.
//

import Foundation

public typealias updateLoadingStatus = () -> ()
public typealias updateValueSearchStatus = () -> ()
public typealias refactorLoadingStatus = () -> ()
public typealias errorTypeStatus = () -> ()
public typealias noResultStatus = () -> ()

class ViewControllerViewModel {
    
    // MARK: - let and var
    public var updatedList:updateLoadingStatus?
    public var updateValueSearch:updateValueSearchStatus?
    public var refactorList:refactorLoadingStatus?
    public var errorType:errorTypeStatus?
    public var noResult:noResultStatus?
    var isLoading: Bool = false {
        didSet {
            self.refactorList?()
        }
    }
    var isLoadingBottom: Bool = false {
        didSet {
            self.updatedList?()
        }
    }
    var isError: Bool = false {
        didSet {
            self.errorType?()
        }
    }
    var isNoResult: Bool = false {
        didSet {
            self.noResult?()
        }
    }
    var isUpdateValue: Bool = false {
        didSet {
            self.updateValueSearch?()
        }
    }
    var characterArray: [Characters] = []
    var search: String = ""
    var oldSearch: String = ""
    var newSearch: String = ""
    var date: String = ""
    var offset: String = ""
    var year: String = ""
    var total: Int = 0
    var searchStatus: Bool = false
    var pickerParams: [String] = []
    
    // MARK: - Fuction
    func createPickerViewParameters() -> [String] {
        for n in 1969...2019 {
            pickerParams.append(String(n))
        }
        
        return pickerParams
    }
    
    func countCharacters() -> Int {
        return characterArray.count
    }
    
    func getCharacterByRow(row: Int) -> Characters {
        return self.characterArray[row]
    }
    
    // MARK: - Request
    func UpdateTableNewCharacter(linha: Int, size: Int){
        if(linha==(size-1)  && size%15==0 && !isLoadingBottom && total>countCharacters()) {
            searchCharacters(search: search, date: date,  firstTime: false)
        }
    }
    
    func getSearch(searchText: String){
        
        if(searchStatus){
            return
        }else{
            if(isLoadingBottom){
                return
            }
            if(searchText.isEmpty){
                searchStatus = true
                searchCharacters(firstTime: true)
            }else{
                searchStatus = true
                searchCharactersSearchBar(search: searchText, firstTime: true)
            }
        }
    }
    
    func searchCharacters(search: String = "", date: String = "", firstTime: Bool) {
        if(firstTime){
            isLoading = true
            isUpdateValue = true
            characterArray = []
        }else{
            isLoadingBottom = true
        }
        var offset = ""
        if(countCharacters()>0){
            offset = String(characterArray.count)
        }
        let yearDate = year + "-01-01"
        
        API.searchCharacters(search: search, year: yearDate, offset: offset, completion:  { response in
            switch response.result {
            case .success:
                self.isUpdateValue = true
                let characters : CharacterResponse =  response.result.value!
                if let offsetTotal = response.result.value?.dataResult?.total!{
                    self.total = offsetTotal
                }
                if let data = characters.dataResult?.results {
                    self.characterArray.append(contentsOf:  data)
                    if(self.characterArray.count==0){
                        self.isNoResult = true
                    }
                    if(firstTime){
                        self.isLoading = false
                    }else{
                        self.isLoadingBottom = false
                    }
                }
                self.searchStatus = false
            case .failure(_):
                self.isUpdateValue = true
                self.searchStatus = false
                if(firstTime){
                    self.isError = true
                    self.isLoading = false
                }else{
                    self.isLoadingBottom = false
                }
            }
        })
    }
    
    func searchCharactersSearchBar(search: String = "", date: String = "", firstTime: Bool){
        
        isLoading = true
        isUpdateValue = true
        characterArray = []
        var offset = ""
        if(countCharacters()>0){
            offset = String(characterArray.count)
        }
        let yearDate = year + "-01-01"
        
        API.searchCharacters(search: search, year: yearDate, offset: offset, completion:  { response in
            switch response.result {
            case .success:
                let characters : CharacterResponse =  response.result.value!
                if let data = characters.dataResult?.results {
                    self.isUpdateValue = true
                    self.newSearch = self.search
                    if(self.newSearch != self.oldSearch){
                        self.searchStatus = true
                        self.oldSearch = self.newSearch
                        self.searchCharactersSearchBar(search: self.search, date: date,  firstTime: true)
                    }else{
                        if(self.newSearch.isEmpty){
                            self.searchStatus = true
                            self.searchCharacters(search: self.search, date: date,  firstTime: true)
                        }else{
                            self.searchStatus = false
                            self.characterArray = []
                            self.characterArray.append(contentsOf:  data)
                            if(self.characterArray.count==0){
                                self.isNoResult = true
                            }
                            self.isLoading = false
                        }
                    }
                }
            case .failure(_):
                self.isUpdateValue = true
                self.isError = true
                self.searchStatus = false
                self.isLoading = false
            }
        })
    }
    
    // MARK: - init
    init(){
    }
    
}
