//
//  BaseViewController.swift
//  marvel
//
//  Created by Matheus Cereja on 24/05/19.
//  Copyright © 2019 Matheus Cereja. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - let and var
    var viewLoadingBase: UIView = UIView()
    var labelLoading: UILabel = UILabel()
    var auntManLoading: UIImageView = UIImageView()
    var loadImageBase: Bool = false
    
    // MARK: - IBOutlet
    
    // MARK: - IBAction
    
    // MARK: - Fuction
    
    func createLoadingView(){
        viewLoadingBase.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        viewLoadingBase.alpha = 1
        view.addSubview(viewLoadingBase)
        
        labelLoading.text = Constants.loading
        labelLoading.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        labelLoading.center = view.center
        labelLoading.transform = CGAffineTransform(translationX: 0, y: 65)
        labelLoading.textAlignment = .center
        labelLoading.textColor = UIColor.red
        labelLoading.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        view.addSubview(labelLoading)
        
        let image = UIImage(named: "ant")
        auntManLoading = UIImageView(image: image!)
        auntManLoading.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
        auntManLoading.center = view.center
        view.addSubview(auntManLoading)
        
        animeteGrowup()
        enableUI()
    }
    
    private func showAct(){
        self.loadImageBase = true
        self.viewLoadingBase.isHidden = false
        self.labelLoading.isHidden = false
        self.auntManLoading.isHidden = false
        
    }
    
    private func stopAct(){
        self.viewLoadingBase.isHidden = true
        self.loadImageBase = false
        self.labelLoading.isHidden = true
        self.auntManLoading.isHidden = true
        
    }
    
    private func animeteGrowup(){
        labelLoading.alpha = 0
        auntManLoading.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
        auntManLoading.center = view.center
        UIView.animate(withDuration: 1.5, animations: {
            self.labelLoading.alpha = 1
            self.auntManLoading.frame = CGRect(x: 0, y: 0, width: 90, height: 90)
            self.auntManLoading.center = self.view.center
            
        }, completion: {(finished:Bool) in
            self.animeteGrowdown()
        })
        
    }
    private func animeteGrowdown(){
        labelLoading.alpha = 1
        self.auntManLoading.frame = CGRect(x: 0, y: 0, width: 90, height: 90)
        self.auntManLoading.center = self.view.center
        UIView.animate(withDuration: 1.5, animations: {
            self.labelLoading.alpha = 0
            self.auntManLoading.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
            self.auntManLoading.center = self.view.center
            
        }, completion: {(finished:Bool) in
            self.animeteGrowup()
        })
        
    }
    
    func hiddenNavBar(){
        navigationController?.navigationBar.isHidden = true
    }
    
    func disableUI(){
        showAct()
        navigationController?.navigationBar.layer.zPosition = -1
    }
    
    func enableUI(){
        stopAct()
        navigationController?.navigationBar.layer.zPosition = 0
    }
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        createLoadingView()
    }
    
}
