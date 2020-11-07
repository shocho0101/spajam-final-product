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
        }
    }
}
