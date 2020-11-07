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
        let getShopAction = DataGateway.getAction(GetShopDataGatewayAction.self, useMock: false)
        let disposeBag = DisposeBag()
        
        let viewDidLoad = PublishRelay<Void>()
        let itemSelected = PublishRelay<Int>()
        let addCart = PublishRelay<(menu: Menu, count: Int)>()
        
        let cartDictionary = BehaviorRelay<[Int: Int]>(value: [:])
        
        
        init(_ input: Input) {
            viewDidLoad.map { .init(shopId: input.shopId, tableId: input.tableId, deviceId: "aaa") }.bind(to: getShopAction.inputs).disposed(by: disposeBag)
            
            addCart.map { [cartDictionary] in
                var newCardDictionary = cartDictionary.value
                newCardDictionary[$0.menu.menuId] = $0.count
                return newCardDictionary
            }.bind(to: cartDictionary)
            .disposed(by: disposeBag)
            
        }
        
        var menus: Driver<[(Menu, Int)]> {
            return Observable.combineLatest(getShopAction.elements.map { $0.menus }, cartDictionary)
                .map { menuArray, cart in
                    return menuArray.map { menu in (menu, cart[menu.menuId] ?? 0) }
                }.asDriver(onErrorDriveWith: .empty())
        }
        
        var showMenuViewController: Driver<(Menu, Int)> {
            return itemSelected.withLatestFrom(menus) { row, menusTupleArray in
                return menusTupleArray[row]
            }.asDriver(onErrorDriveWith: .empty())
        }
    }
}
