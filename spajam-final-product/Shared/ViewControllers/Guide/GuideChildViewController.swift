//
//  GuideViewController.swift
//  spajam-final-product
//
//  Created by Fumiya Tanaka on 2020/11/07.
//

import UIKit

class GuideChildViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    weak var gradientLayer: CAGradientLayer?
    
    let image: URL
    let titleText: String
    let detailText: String
    
    init(image: URL, titleText: String, detailText: String) {
        self.image = image
        self.titleText = titleText
        self.detailText = detailText
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = try? Data(contentsOf: image) {
            imageView.image = UIImage(data: data)
        }
        titleLabel.text = titleText
        detailLabel.text = detailText
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addGradient()
    }
    
    private func addGradient() {
        gradientLayer?.removeFromSuperlayer()
        let layer1 = CAGradientLayer()
        layer1.colors = [
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        ]
        layer1.locations = [0, 0.46]
        layer1.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer1.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer1.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: -1, c: 1, d: 0, tx: 0, ty: 1))
        layer1.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
        layer1.position = view.center
        imageView.layer.insertSublayer(layer1, at: 1)
        self.gradientLayer = layer1
    }
}
