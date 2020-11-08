//
//  GuidePageViewController.swift
//  spajam-final-product
//
//  Created by Fumiya Tanaka on 2020/11/07.
//

import UIKit
import Pageboy
import RxSwift

class GuidePageViewController: PageboyViewController, PageboyViewControllerDataSource, PageboyViewControllerDelegate {
    let stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var viewControllers: [GuideChildViewController] = []
    private let action = DataGateway.getAction(GetShopGuideDataGatewayAction.self)
    private let disposeBag: DisposeBag = DisposeBag()
    
    init(shopId: Int) {
        super.init(nibName: nil, bundle: nil)
        transition = .init(style: .fade, duration: 2.0)
        let uuid = UIDevice.current.identifierForVendor?.uuidString ?? ""
        action.execute(.init(shopId: shopId, deviceId: uuid))
            .catchError { error in
                print(error)
                return .just(ShopGuide.mock)
            }
            .subscribe(onNext: { [weak self] (shop: ShopGuide) in
                self?.viewControllers = shop.guides.map { (guide: ShopGuide.Guide) in
                    GuideChildViewController(image: URL(string: guide.imageUrl)!, titleText: guide.title, detailText: guide.description)
                }                
                self?.configureStackView(subviewsCount: shop.guides.count)
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
        delegate = self
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            stackView.heightAnchor.constraint(equalToConstant: 4),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
    
    private func configureStackView(subviewsCount: Int) {
        let views = (0..<subviewsCount).map { _ -> UIView in
            let view = UIView()
            view.layer.cornerRadius = 2
            view.layer.masksToBounds = true
            view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            return view
        }
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        stackView.arrangedSubviews.forEach { stackView.removeArrangedSubview($0) }
        views.forEach { stackView.addArrangedSubview($0) }
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
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, willScrollToPageAt index: PageboyViewController.PageIndex, direction: PageboyViewController.NavigationDirection, animated: Bool) {
        stackView.arrangedSubviews
            .forEach { $0.backgroundColor = UIColor.white.withAlphaComponent(0.5) }
        let view = stackView.arrangedSubviews[index]
        view.backgroundColor = UIColor.white.withAlphaComponent(1.0)
    }
    
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollToPageAt index: PageboyViewController.PageIndex, direction: PageboyViewController.NavigationDirection, animated: Bool) {
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollTo position: CGPoint, direction: PageboyViewController.NavigationDirection, animated: Bool) {
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didReloadWith currentViewController: UIViewController, currentPageIndex: PageboyViewController.PageIndex) {
    }
}
