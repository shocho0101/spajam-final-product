//
//  MenuTableViewCell.swift
//  spajam-final-product
//
//  Created by 張翔 on 2020/11/07.
//

import UIKit
import Kingfisher

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var contentImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        contentImageView.layer.cornerRadius = 8
        contentImageView.clipsToBounds = true
    }
    
    func configure(menu: Menu, count: Int) {
        nameLabel.text = menu.menuName
        priceLabel.text = "¥\(menu.price)"
        numberLabel.text = count != 0 ? "\(count)枚" : ""
        contentImageView.kf.setImage(with: URL(string: menu.imageUrl))
        
    }
    
}
