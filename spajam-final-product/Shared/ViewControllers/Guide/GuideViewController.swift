//
//  GuideViewController.swift
//  spajam-final-product
//
//  Created by Fumiya Tanaka on 2020/11/07.
//

import UIKit

class GuideChildViewController: UIViewController {

    @IBOutlet weak var videoPlayerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    init(index: Int) {
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
