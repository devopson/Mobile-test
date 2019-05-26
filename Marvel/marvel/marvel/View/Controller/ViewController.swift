//
//  ViewController.swift
//  marvel
//
//  Created by Matheus Cereja on 23/05/19.
//  Copyright © 2019 Matheus Cereja. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    
    // MARK: - let and var
    var viewControllerVM: ViewControllerViewModel!
    var characterList: [Characters] = []
    var pickerParams: [String] = []
    var lastYear: String = "1969"
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomTableView: NSLayoutConstraint!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var actBottom: UIActivityIndicatorView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var viewPicker: UIView!
    @IBOutlet weak var btPicker: UIButton!
    @IBOutlet weak var btRemoveYear: UIButton!
    @IBOutlet weak var btError: UIButton!
    
    // MARK: - IBAction
    @IBAction func selectYear(_ sender: Any) {
        pickViewHidden(hidden: true)
        self.btError.isHidden = true
        if(viewControllerVM.year.isEmpty){
            viewControllerVM.year = lastYear
            
        }
        self.btPicker.setTitle(viewControllerVM.year, for: .normal)
        
        self.btRemoveYear.isHidden = false
        viewControllerVM.searchCharacters(search: self.searchBar.text ?? "", firstTime: true)
    }
    
    @IBAction func chooseYear(_ sender: Any) {
        pickViewHidden(hidden: false)
    }
    
    @IBAction func removeYear(_ sender: Any) {
        viewControllerVM.year = ""
        self.btRemoveYear.isHidden = true
        self.btError.isHidden = true
        self.btPicker.setTitle(Constants.selection, for: .normal)
        viewControllerVM .searchCharacters(search: self.searchBar.text ?? "", firstTime: true)
    }
    
    @IBAction func errorTratament(_ sender: Any) {
        
        if(viewControllerVM.isError){
            self.btError.isHidden = true
            viewControllerVM.searchCharacters(search: self.searchBar.text ?? "", firstTime: true)
            
        }
        viewControllerVM.isError = false
        viewControllerVM.isNoResult = false
    }
    
    // MARK: - Fuction
    func initDelegateDataSource(){
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func initCell(){
        let nib = UINib.init(nibName: "ViewControllerTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
    }
    
    func initLayout(){
        initCell()
        self.viewPicker.rounder()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.dimissPicker))
        self.viewShadow.addGestureRecognizer(tap)
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(ViewController.endEditingKeyBoard))
        self.view.addGestureRecognizer(tap2)
    }
    
    func initViewModel(){
        viewControllerVM = ViewControllerViewModel()
        viewControllerVM.refactorList = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewControllerVM.isLoading ?? false
                if isLoading {
                    self?.disableUI()
                    self!.viewControllerVM.search = self?.searchBar.text ?? ""
                    self?.tableView.isHidden = true
                    self?.tableView.reloadData()
                }else {
                    self?.enableUI()
                    self?.characterList = self?.viewControllerVM.characterArray ?? []
                    self?.tableView.isHidden = false
                    self?.tableView.reloadData()
                    if(self!.viewControllerVM.countCharacters()>0){
                        let indexPath = NSIndexPath(row: 0, section: 0)
                        self?.tableView.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
                    }
                }
                
            }
            
        }
        
        viewControllerVM.updatedList = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewControllerVM.isLoadingBottom ?? false
                if isLoading {
                    self?.actBottom.startAnimating()
                    self?.bottomTableView.constant = -30
                }else {
                    self?.characterList = self?.viewControllerVM.characterArray ?? []
                    self?.actBottom.stopAnimating()
                    self?.bottomTableView.constant = 0
                    self?.tableView.reloadData()
                }
                
            }
        }
        
        viewControllerVM.errorType = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewControllerVM.isError ?? false
                if isLoading {
                    self?.btError.setImage(UIImage(named: "noConnection"), for: .normal)
                    self?.btError.isHidden = false
                    self?.view.endEditing(true)
                }
                
            }
        }
        
        viewControllerVM.noResult = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewControllerVM.isNoResult ?? false
                if isLoading {
                    self?.btError.setImage(UIImage(named: "noResult"), for: .normal)
                    self?.btError.isHidden = false
                }
                
            }
        }
        
        viewControllerVM.updateValueSearch = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewControllerVM.isUpdateValue ?? false
                if isLoading {
                    self!.viewControllerVM.search = self?.searchBar.text ?? ""
                }
                
            }
        }
        
        self.pickerParams = self.viewControllerVM.createPickerViewParameters()
        self.pickerView.reloadAllComponents()
        viewControllerVM.searchCharacters(firstTime: true)
    }
    
    func initSetup(){
        initDelegateDataSource()
        initLayout()
        initViewModel()
    }
    
    func pickViewHidden(hidden: Bool){
        self.viewShadow.isHidden = hidden
        self.viewPicker.isHidden = hidden
    }
    
    @objc func dimissPicker(){
        pickViewHidden(hidden: true)
    }
    
    @objc func endEditingKeyBoard(){
        self.view.endEditing(true)
    }
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNavBar()
        initSetup()
    }
    
}

// MARK: -  UITableView Method
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllerVM.countCharacters()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        let linha = indexPath.row
        let size = viewControllerVM.countCharacters()
        cell.cellVM = CellViewModel(character: viewControllerVM.characterArray[indexPath.row])
        cell.initCell()
        viewControllerVM.UpdateTableNewCharacter(linha: linha, size: size)
        
        return cell
    }
    
}

// MARK: - UISearchBar Method
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        self.btError.isHidden = true
        viewControllerVM.getSearch(searchText: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
}

// MARK: - UIPickerView Method
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return  1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerParams.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerParams[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewControllerVM.year = self.pickerParams[row]
        self.lastYear = viewControllerVM.year
    }
    
}



