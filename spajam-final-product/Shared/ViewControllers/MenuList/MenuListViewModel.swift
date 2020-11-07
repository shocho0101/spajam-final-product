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
        
        let viewWillAppear = PublishRelay<Void>()
        
        init() {
            viewWillAppear.map { .init(shopId: 1, tableId: 1, deviceId: "aaa") }.bind(to: getShopAction.inputs).disposed(by: disposeBag)
        }
        
        var menus: Driver<[Menu]> {
            return getShopAction.elements
                .debug()
                .map { $0.menus }
                .asDriver(onErrorDriveWith: .empty())
        }
    }
}
