//
//  ViewController.swift
//  spajam-final-product
//
//  Created by 張翔 on 2020/10/17.
//

import UIKit
import RxSwift
import RxMoya
import Moya

class ViewController: UIViewController {
    
    let action = DataGateway.getAction(ZipCodeDataAction.self)
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        action.execute(1010001)
            .subscribe(onNext: { zipCode in
                print(zipCode)
            }, onError: { error in
                print(error)
            }).disposed(by: bag)
    }


}

