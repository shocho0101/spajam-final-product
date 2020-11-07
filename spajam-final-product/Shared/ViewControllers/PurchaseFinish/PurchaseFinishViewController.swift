//
//  PurchaseFinishViewController.swift
//  spajam-final-product
//
//  Created by 張翔 on 2020/11/08.
//

import UIKit

class PurchaseFinishViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }
    
    let data: [(menu: Menu, count: Int)]
    
    init(data: [(menu: Menu, count: Int)]) {
        self.data = data
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 124
        
        title = "購入済み"
        navigationItem.hidesBackButton = true
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
    }
}

extension PurchaseFinishViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MenuTableViewCell
        cell.configure(menu: data[indexPath.row].menu, count: data[indexPath.row].count)
        return cell
    }
}
