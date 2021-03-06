//
//  MenuListViewController.swift
//  spajam-final-product
//
//  Created by 張翔 on 2020/11/07.
//

import UIKit
import RxSwift

class MenuListViewController: UIViewController {
    
    struct Input {
        var shopId: Int
        var tableId: Int
    }
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var bottomBackgroundView: UIView!
    @IBOutlet var purchaseButton: UIButton!
    @IBOutlet var priceLabel: UILabel!
    
    let viewModel: ViewModel
    let disposeBag = DisposeBag()
    
    var payService: PayService?
    
    
    init(_ input: Input) {
        self.viewModel = ViewModel(input)
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        bottomBackgroundView.layer.cornerRadius = 16
        bottomBackgroundView.clipsToBounds = true
        purchaseButton.layer.cornerRadius = 16
        
        title = "入場券一覧"
        
        tableView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 124
        bind()
        viewModel.viewDidLoad.accept(())
        tableView.tableFooterView = UIView()
    }
    
    func bind() {
        viewModel.menus.drive(tableView.rx.items(cellIdentifier: "Cell", cellType: MenuTableViewCell.self)) { row, element, cell in
            cell.configure(menu: element.0, count: element.1)
        }.disposed(by: disposeBag)
        viewModel.showMenuViewController.drive(onNext: { [weak self] menuTuple in
            guard let self = self else { return }
            let menuViewController = MenuViewController(menu: menuTuple.0, count: menuTuple.1)
            menuViewController.addCart.bind(to: self.viewModel.addCart).disposed(by: self.disposeBag)
            self.navigationController?.pushViewController(menuViewController, animated: true)
        }).disposed(by: disposeBag)
        viewModel.startApplePay.drive(onNext: { [weak self] tupleArray, shop in
            guard let self = self else { return }
            self.payService = PayService()
            self.payService?.showPaymentViewController(on: self, items: tupleArray, shop: shop)
            self.payService?.didSuccessPaymentService.bind(to: self.viewModel.didFinishPurchase).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
        viewModel.price.map { "¥\($0)"}.drive(priceLabel.rx.text).disposed(by: disposeBag)
        viewModel.showPurchaseFinishViewController.drive(onNext: { [weak self] in
            let viewController = PurchaseFinishViewController(data: $0)
            self?.navigationController?.pushViewController(viewController, animated: true)
        }).disposed(by: disposeBag)
        
        
        tableView.rx.itemSelected.map { $0.row }.bind(to: viewModel.itemSelected).disposed(by: disposeBag)
        tableView.rx.itemSelected.subscribe(onNext: { [tableView] in tableView?.deselectRow(at: $0, animated: true)}).disposed(by: disposeBag)
        purchaseButton.rx.tap.bind(to: viewModel.purchaseButtonTapped).disposed(by: disposeBag)
    }
}
