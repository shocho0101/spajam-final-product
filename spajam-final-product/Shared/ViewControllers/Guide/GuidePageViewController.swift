//
//  GuidePageViewController.swift
//  spajam-final-product
//
//  Created by Fumiya Tanaka on 2020/11/07.
//

import UIKit
import Pageboy
import RxSwift

class GuidePageViewController: PageboyViewController, PageboyViewControllerDataSource {
    
    private var viewControllers: [GuideChildViewController] = []
    private let action = DataGateway.getAction(GetShopDataGatewayAction.self)
    private let disposeBag: DisposeBag = DisposeBag()
    
    var images: [URL] = []
    
    init(shopId: Int) {
        super.init(nibName: nil, bundle: nil)
        transition = .init(style: .fade, duration: 2.0)
        let uuid = UIDevice.current.identifierForVendor?.uuidString ?? ""
        action.execute(.init(shopId: shopId, tableId: 1, deviceId: uuid)).subscribe(onNext: { [weak self] shop in
            self?.viewControllers = [GuideChildViewController(
                image: URL(string: shop.imageUrl!)!,
                titleText: "姫路城の歴史",
                detailText: "1956年に行われた「昭和の大修理」まで、姫路城はずっと傾いて建っていました。"
            )
            ]
            self?.reloadData()
        })
        .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        if viewControllers.isEmpty || index >= viewControllers.count {
            return nil
        }
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        nil
    }
}
