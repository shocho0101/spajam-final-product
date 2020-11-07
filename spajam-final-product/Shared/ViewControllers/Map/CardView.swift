//
//  CardView.swift
//  spajam-final-product
//
//  Created by 中嶋裕也 on 2020/11/07.
//

import Foundation
import UIKit

class CardView: UIView {
    
    enum ButtonType {
        case one
        case two
        case three
        case four
    }
    
    private var shop: Shop?
    var cardType: ButtonType?
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var comiLabel: UILabel!
    @IBOutlet var comiImageView: UIButton!
    @IBOutlet var shopImageView: UIImageView!

    override init(frame: CGRect){
        super.init(frame: frame)
        loadNib()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadNib()
    }
    
    func loadNib(){
        let view = Bundle.main.loadNibNamed("CardView", owner: self, options: nil)?.first as! UIView
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }
    
    func setShop(shop:Shop) {
        self.shop = shop
        nameLabel.text = shop.shopName
        
        let comiguwai = Double(shop.currentPopulation / shop.capacity)
        if comiguwai < 0.25 {
            cardType = .one
        } else if comiguwai < 0.5 {
            cardType = .two
        } else if comiguwai < 0.75 {
            cardType = .three
        } else {
            cardType = .four
        }
        setButtonType()
    }
    
    func setButtonType() {
        switch cardType {
        case .one:
            comiLabel.textColor = #colorLiteral(red: 0.4745098039, green: 0.8980392157, blue: 0.9254901961, alpha: 1)
            comiLabel.text = "非常に空いています"
            comiImageView.tintColor = #colorLiteral(red: 0.4745098039, green: 0.8980392157, blue: 0.9254901961, alpha: 1)
            comiImageView.setImage(#imageLiteral(resourceName: "one"), for: .normal)
            comiImageView.isUserInteractionEnabled = false
            comiImageView.frame.size = CGSize(width: 15, height: 15)
        case .two:
            comiLabel.textColor = #colorLiteral(red: 0.3843137255, green: 0.6156862745, blue: 0.537254902, alpha: 1)
            comiLabel.text = "空いています"
            comiImageView.tintColor = #colorLiteral(red: 0.3843137255, green: 0.6156862745, blue: 0.537254902, alpha: 1)
            comiImageView.setImage(#imageLiteral(resourceName: "two"), for: .normal)
            comiImageView.isUserInteractionEnabled = false
            comiImageView.frame.size = CGSize(width: 15, height: 15)
        case .three:
            comiLabel.textColor = #colorLiteral(red: 0.9607843137, green: 0.6588235294, blue: 0.2039215686, alpha: 1)
            comiLabel.text = "混んでいます"
            comiImageView.tintColor = #colorLiteral(red: 0.9607843137, green: 0.6588235294, blue: 0.2039215686, alpha: 1)
            comiImageView.setImage(#imageLiteral(resourceName: "three"), for: .normal)
            comiImageView.isUserInteractionEnabled = false
            comiImageView.frame.size = CGSize(width: 22, height: 15)
        case .four:
            comiLabel.textColor = #colorLiteral(red: 0.9607843137, green: 0.2039215686, blue: 0.2039215686, alpha: 1)
            comiLabel.text = "非常に混んでいます"
            comiImageView.tintColor = #colorLiteral(red: 0.9607843137, green: 0.2039215686, blue: 0.2039215686, alpha: 1)
            comiImageView.setImage(#imageLiteral(resourceName: "four"), for: .normal)
            comiImageView.isUserInteractionEnabled = false
            comiImageView.frame.size = CGSize(width: 27, height: 15)
        default: break
        }
    }
}
