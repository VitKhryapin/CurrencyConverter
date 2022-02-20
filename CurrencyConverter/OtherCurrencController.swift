//
//  OtherCurrencController.swift
//  CurrencyConverter
//
//  Created by Vitaly Khryapin on 18.02.2022.
//

import UIKit

class OtherCurrencController: UIViewController {
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView?.delegate = self
            tableView?.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
}

extension OtherCurrencController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return ViewController.shared.currencyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        if let dCell  = tableView.dequeueReusableCell(withIdentifier: "dCell") {
            cell = dCell
        }else{
         cell = UITableViewCell()
        }
        cell.textLabel!.text = ViewController.shared.currencyArray[indexPath.row].currency
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ViewController.shared.addCurrency(currency: ViewController.shared.currencyArray[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
}
