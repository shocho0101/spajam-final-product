//
//  GuidePageViewController.swift
//  spajam-final-product
//
//  Created by Fumiya Tanaka on 2020/11/07.
//

import UIKit
import Pageboy

class GuidePageViewController: PageboyViewController, PageboyViewControllerDataSource {
    
    private let viewControllers: [GuideChildViewController]
    
    let images: [URL]
    
    init(images: [URL]) {
        self.images = images
        viewControllers = images.map {
            GuideChildViewController(image: $0, titleText: "姫路城の歴史", detailText: "1956年に行われた「昭和の大修理」まで、姫路城はずっと傾いて建っていました。")
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        3
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        nil
    }
}
