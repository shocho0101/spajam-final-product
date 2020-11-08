//
//  MenuListViewModel.swift
//  spajam-final-product
//
//  Created by 張翔 on 2020/11/07.
//

import Foundation
import RxSwift
import RxCocoa

extension MenuListViewController {
    class ViewModel {
        let getShopAction = DataGateway.getAction(GetShopDataGatewayAction.self, useMock: true)
        let disposeBag = DisposeBag()
        
        let viewDidLoad = PublishRelay<Void>()
        let itemSelected = PublishRelay<Int>()
        let purchaseButtonTapped = PublishRelay<Void>()
        let addCart = PublishRelay<(menu: Menu, count: Int)>()
        let didFinishPurchase = PublishRelay<Void>()
        
        let cartDictionary = BehaviorRelay<[Int: Int]>(value: [:])
        
        
        init(_ input: Input) {
            viewDidLoad.map { .init(shopId: input.shopId, deviceId: "aaa") }.bind(to: getShopAction.inputs).disposed(by: disposeBag)
            
            addCart.map { [cartDictionary] in
                var newCardDictionary = cartDictionary.value
                newCardDictionary[$0.menu.menuId] = $0.count
                return newCardDictionary
            }.bind(to: cartDictionary)
            .disposed(by: disposeBag)
            
        }
        
        var shop: Driver<Shop> {
            return getShopAction.elements
                .asDriver(onErrorDriveWith: .empty())
        }
        
        var menus: Driver<[(menu: Menu, count: Int)]> {
            return Observable.combineLatest(getShopAction.elements.map { $0.menus }, cartDictionary)
                .map { menuArray, cart in
                    return menuArray.map { menu in (menu, cart[menu.menuId] ?? 0) }
                }.asDriver(onErrorDriveWith: .empty())
        }
        
        var price: Driver<Int> {
            return menus.map { tupleArray in tupleArray.reduce(into: 0) { $0 += $1.menu.price * $1.count}}
                .asSharedSequence(onErrorDriveWith: .empty())
        }
        
        var showMenuViewController: Driver<(Menu, Int)> {
            return itemSelected.withLatestFrom(menus) { row, menusTupleArray in
                return menusTupleArray[row]
            }.asDriver(onErrorDriveWith: .empty())
        }
        
        var startApplePay: Driver<([(menu: Menu, count: Int)], Shop)> {
            return purchaseButtonTapped
                .withLatestFrom(menus.map { tupleArray in return tupleArray.filter { $0.count > 0 }})
                .withLatestFrom(shop, resultSelector: { menu, shop in
                    return (menu, shop)
                })
                .asDriver(onErrorDriveWith: .empty())
        }
        
        var showPurchaseFinishViewController: Driver<[(menu: Menu, count: Int)]> {
            return didFinishPurchase.withLatestFrom(menus)
                .map { tupleArray in
                    return tupleArray.filter { $0.count > 0 }
                }
                .asDriver(onErrorDriveWith: .empty())
        }
    }
}
