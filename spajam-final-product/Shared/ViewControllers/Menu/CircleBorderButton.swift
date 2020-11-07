//
//  CircleBorderButton.swift
//  spajam-final-product
//
//  Created by Fumiya Tanaka on 2020/11/07.
//

import Foundation
import UIKit

@IBDesignable
class CircleBorderButton: UIButton {
    @IBInspectable var borderWidth: CGFloat = 1
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderColor = UIColor(named: "BorderGrey")?.cgColor
        layer.masksToBounds = true
        layer.cornerRadius = frame.width / 2
        layer.borderWidth = borderWidth
    }
}
