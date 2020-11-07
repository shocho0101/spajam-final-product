//
//  MenuViewController.swift
//  spajam-final-product
//
//  Created by 張翔 on 2020/11/07.
//

import UIKit
import RxSwift
import RxCocoa

class MenuViewController: UIViewController {
    
    @IBOutlet weak var addCartButton: UIButton!
    @IBOutlet weak var bottomAddCartView: UIView!
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addCountButton: UIButton!
    @IBOutlet weak var subtractCountButton: UIButton!
    
    let menu: Menu
    
    private let countRelay: BehaviorRelay<Int>
    
    private let disposeBag: DisposeBag = .init()
    private let addCartRelay: BehaviorRelay<(menu: Menu, count: Int)>
    var addCart: Observable<(menu: Menu, count: Int)> {
        addCartRelay.asObservable()
    }
    
    init(menu: Menu, count: Int) {
        self.menu = menu
        self.countRelay = .init(value: count)
        self.addCartRelay = .init(value: (menu, count))
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCartButton.rx.tap
            .map { _ in self.menu }
            .withLatestFrom(countRelay) { menu, count in
                (menu, count)
            }
            .bind(to: addCartRelay)
            .disposed(by: disposeBag)
        
        let formatter = NumberFormatter()
        menuLabel.text = menu.menuName
        countRelay
            .map { (count: Int) -> String in
                return formatter.string(from: NSNumber(value: count)) ?? "\(count)"
            }
            .bind(to: countLabel.rx.text)
            .disposed(by: disposeBag)
        priceLabel.text = formatter.string(from: NSNumber(value: menu.price))
        Observable.merge(
            addCountButton.rx.tap.map { 1 },
            subtractCountButton.rx.tap.map { -1 }
        )
        .withLatestFrom(countRelay) { diff, value in
            value + diff
        }
        .bind(to: countRelay)
        .disposed(by: disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bottomAddCartView.layer.cornerRadius = 16
        bottomAddCartView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bottomAddCartView.layer.masksToBounds = true
    }
}
