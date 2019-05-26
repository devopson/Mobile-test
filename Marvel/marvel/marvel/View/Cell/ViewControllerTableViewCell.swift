//
//  ViewControllerTableViewCell.swift
//  marvel
//
//  Created by Matheus Cereja on 24/05/19.
//  Copyright © 2019 Matheus Cereja. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {
    
    // MARK: - let and var
    var cellVM: CellViewModel?
    
    // MARK: - IBOutlet
    @IBOutlet weak var img: DownloadImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionChar: UILabel!
    @IBOutlet weak var dateModified: UILabel!
    @IBOutlet weak var countSeries: UILabel!
    @IBOutlet weak var countComics: UILabel!
    @IBOutlet weak var countStories: UILabel!
    @IBOutlet weak var viewBody: UIView!
    
    
    // MARK: - Fuction
    func initCell(){
        if let _ = cellVM {
        self.img.setUrl(cellVM!.getImgUrl())
        self.title.text = cellVM!.getTitle()
        self.descriptionChar.text = cellVM!.getDescription()
        self.dateModified.text = cellVM!.getModifiedDate()
        self.countSeries.text = cellVM!.getCountSeries()
        self.countComics.text = cellVM!.getCountComics()
        self.countStories.text = cellVM!.getCountStories()
        }
    }
    // MARK: - Override
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
