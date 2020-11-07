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
        
        init(_ input: Input) {
            viewDidLoad.map { .init(shopId: input.shopId, tableId: input.tableId, deviceId: "aaa") }.bind(to: getShopAction.inputs).disposed(by: disposeBag)
        }
        
        var menus: Driver<[Menu]> {
            return getShopAction.elements
                .debug()
                .map { $0.menus }
                .asDriver(onErrorDriveWith: .empty())
        }
    }
}
