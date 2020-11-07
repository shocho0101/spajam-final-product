//
//  MenuListViewController.swift
//  spajam-final-product
//
//  Created by 張翔 on 2020/11/07.
//

import UIKit
import RxSwift

class MenuListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var bottomBackgroundView: UIView!
    @IBOutlet var purchaseButton: UIButton!
    
    let viewModel: ViewModel
    let disposeBag = DisposeBag()
    
    init() {
        self.viewModel = ViewModel()
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.viewWillAppear.accept(())
    }
    
    func bind() {
        viewModel.menus.drive(tableView.rx.items(cellIdentifier: "Cell", cellType: MenuTableViewCell.self)) { row, element, cell in
            cell.configure(menu: element, count: 0)
        }.disposed(by: disposeBag)
    }
}
