//
//  BalloonView.swift
//  spajam-final-product
//
//  Created by 中嶋裕也 on 2020/11/07.
//

import UIKit
//
//class BalloonView: UIView {
//
//    let triangleSideLength: CGFloat = 20
//    let triangleHeight: CGFloat = 17.3
//
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//
//        let context = UIGraphicsGetCurrentContext()
//        context!.setFillColor(UIColor.green.cgColor)
//        contextBalloonPath(context: context!, rect: rect)
//    }
//
//    func contextBalloonPath(context: CGContext, rect: CGRect) {
//        let triangleRightCorner = (x: (rect.size.width + triangleSideLength) / 2, y: rect.maxY - triangleHeight)
//        let triangleBottomCorner = (x: rect.size.width / 2, y: rect.maxY)
//        let triangleLeftCorner = (x: (rect.size.width - triangleSideLength) / 2, y: rect.maxY - triangleHeight)
//
//        // 塗りつぶし
//        context.addRect(CGRect(x: 0, y: 0, width: 280, height: rect.size.height - triangleHeight))
//        context.fillPath()
//        context.move(to: CGPoint(x: triangleLeftCorner.x, y: triangleLeftCorner.y))
//        context.addLine(to: CGPoint(x: triangleBottomCorner.x, y: triangleBottomCorner.y))
//        context.addLine(to: CGPoint(x: triangleRightCorner.x, y: triangleRightCorner.y))
//        context.fillPath()
//    }
//
//}



class BalloonView: UIView {
    
    let triangleSideLength: CGFloat = 20
    let triangleHeight: CGFloat = 17.3

    @IBOutlet var backgroundView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    var buttonType: ButtonType!
    
    enum ButtonType {
        case one
        case two
        case three
        case four
    }
    
    override init(frame: CGRect){
            super.init(frame: frame)
            loadNib()
        }

        required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)!
            loadNib()
        }

        func loadNib(){
            let view = Bundle.main.loadNibNamed("BalloonView", owner: self, options: nil)?.first as! UIView
            view.frame = self.bounds
            self.addSubview(view)
        }
    

    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(UIColor.green.cgColor)
        contextBalloonPath(context: context!, rect: rect)
    }
    
    func contextBalloonPath(context: CGContext, rect: CGRect) {
        let triangleRightCorner = (x: (rect.size.width + triangleSideLength) / 2, y: rect.maxY - triangleHeight)
        let triangleBottomCorner = (x: rect.size.width / 2, y: rect.maxY)
        let triangleLeftCorner = (x: (rect.size.width - triangleSideLength) / 2, y: rect.maxY - triangleHeight)
        
        //        // 塗りつぶし
        //        context.addRect(CGRect(x: 0, y: 0, width: 280, height: rect.size.height - triangleHeight))
        //        context.fillPath()
        context.move(to: CGPoint(x: triangleLeftCorner.x, y: triangleLeftCorner.y))
        context.addLine(to: CGPoint(x: triangleBottomCorner.x, y: triangleBottomCorner.y))
        context.addLine(to: CGPoint(x: triangleRightCorner.x, y: triangleRightCorner.y))
        context.fillPath()
    }
    
}
