//
//  ViewController.swift
//  spajam-final-product
//
//  Created by 張翔 on 2020/10/17.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        guard let view = UINib(nibName: Self.className, bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view = view
    }
}
