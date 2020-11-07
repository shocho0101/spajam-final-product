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
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var totalCountLabel: UILabel!
    
    let menu: Menu
    
    private let countRelay: BehaviorRelay<Int>
    
    private let disposeBag: DisposeBag = .init()
    private let addCartRelay: BehaviorRelay<(menu: Menu, count: Int)>
    private let isFirstAddCart: Bool
    var addCart: Observable<(menu: Menu, count: Int)> {
        addCartRelay.asObservable()
    }
    
    init(menu: Menu, count: Int) {
        self.menu = menu
        self.countRelay = .init(value: count)
        self.addCartRelay = .init(value: (menu, count))
        isFirstAddCart = count == 0 ? true : false
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCartButton.rx.tap
            .subscribe(onNext: {[navigationController] in navigationController?.popViewController(animated: true)}).disposed(by: disposeBag)
        
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
        priceLabel.text = "¥\(formatter.string(from: NSNumber(value: menu.price)) ?? "999")"
        imageView.kf.setImage(with: URL(string: menu.imageUrl))
        Observable.merge(
            addCountButton.rx.tap.map { 1 },
            subtractCountButton.rx.tap.map { -1 }
        )
        .withLatestFrom(countRelay) { diff, value in
            value + diff
        }
        .map { $0 >= 0 ? $0 : 0}
        .bind(to: countRelay)
        .disposed(by: disposeBag)
        countRelay
            .map { [isFirstAddCart] in
                if isFirstAddCart {
                    return "\($0)枚をカートに追加"
                } else {
                    return "カートを更新"
                }
            }.bind(to: totalCountLabel.rx.text)
            .disposed(by: disposeBag)
        countRelay.map { [menu] in String($0 * menu.price) }
            .map { "¥" + $0 }
            .bind(to: totalPriceLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bottomAddCartView.layer.cornerRadius = 16
        bottomAddCartView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bottomAddCartView.layer.masksToBounds = true
    }
}
