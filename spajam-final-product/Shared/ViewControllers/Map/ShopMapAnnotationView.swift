//
//  ShopMapAnnotationView.swift
//  spajam-final-product
//
//  Created by Fumiya Tanaka on 2020/11/08.
//

import Foundation
import MapKit

class ShopAnnotationView: UIView {
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var shopCrowdedImageView: UIImageView!
    @IBOutlet weak var contentView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 4
        contentView.layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = .init(width: 0, height: 1)
        layer.cornerRadius = 4
        layer.masksToBounds = false        
    }
    
    func configure(with shop: Shop) {
        shopNameLabel.text = shop.shopName
        let comiguwai = Double(shop.currentPopulation / shop.capacity)
        if comiguwai < 0.25 {
            shopCrowdedImageView.image = UIImage(named: "one")
            contentView.backgroundColor = UIColor(named: "one")
        } else if comiguwai < 0.5 {
            shopCrowdedImageView.image = UIImage(named: "two")
            contentView.backgroundColor = UIColor(named: "two")
        } else if comiguwai < 0.75 {
            shopCrowdedImageView.image = UIImage(named: "three")
            contentView.backgroundColor = UIColor(named: "three")
        } else {
            shopCrowdedImageView.image = UIImage(named: "four")
            contentView.backgroundColor = UIColor(named: "four")
        }
    }
}
