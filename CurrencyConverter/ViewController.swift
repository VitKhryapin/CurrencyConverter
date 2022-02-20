//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Vitaly Khryapin on 27.01.2022.
//

import UIKit


var currencyViewArray = [Currency]()

class ViewController: UIViewController {
    
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var buyButtonOutlet: UIButton!
    @IBOutlet weak var sellButtonOutlet: UIButton!
    @IBOutlet weak var timeUpdateOutlet: UILabel!
    @IBOutlet weak var buttonResetOutlet: UIButton!
    @IBOutlet weak var addCurrencyOutlet: UIButton!
    
    static let shared = ViewController()
    let idCell = "Cell"
    var checkLoadData = false
    var timer: Timer?
    let refreshManager = RefreshManager.shared
    let networkManager = NetworkManager()
    let dateFormatter = DateFormatter()
    let defaults = UserDefaults.standard
    var baseValue = 100.0
    let UAH = Currency(currency: "UAH", baseCurrency: "1.0", buy: "1.0", sale: "1.0")
    var currencyArray: [Currency]{
        get {
            if let data = defaults.value(forKey: "currencyArray") as? Data {
                let array = try! PropertyListDecoder().decode([Currency].self, from: data)
                createViewArray(array: array)
                return array
            } else {
                return [Currency]()
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: "currencyArray")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Ellipse().createEllipse(view)
        createTimer()
        dateFormatter.dateFormat = "d MMM yyyy, h:mm a"
        identifier ()
        tabelView.dataSource = self
        tabelView.delegate = self
        tabelView.register(UINib(nibName: "CurrencyCell", bundle: nil), forCellReuseIdentifier: idCell)
        tabelView.bounces = false
        buttonView()
        loadData()
    }
    
    func identifier () {
        tabelView.accessibilityIdentifier = "tabelView"
        addCurrencyOutlet.accessibilityIdentifier = "addCurrencyOutlet"
        buttonResetOutlet.accessibilityIdentifier = "buttonResetOutlet"
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        tabelView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc func loadData () {
        refreshManager.loadDataIfNeeded() { success in
            if success {
                let date = Date()
                timeUpdateOutlet.text = "Last Updated\n \(dateFormatter.string(from: date))"
                checkLoadData = false
                updateCurrency()
                print ("Данные обноволены")
            } else {
                let date = defaults.value(forKey: "lastRefresh")
                timeUpdateOutlet.text = "Last Updated\n \(dateFormatter.string(from: date as! Date))"
                print ("Данные не обновлены")
                checkLoadData = true
            }
        }
    }
    
    func addCurrency(currency: Currency) {
        currencyViewArray.append(currency)
    }
    
    func createViewArray (array: [Currency]) {
        if currencyViewArray.count == 0 {
            currencyViewArray[0...] = array[0...1]
            if currencyViewArray[0].currency != UAH.currency {
                currencyViewArray.insert(UAH, at: 0)
            }
        }
    }
    
    func buttonView () {
        if sellButtonOutlet.isSelected {
            sellButtonOutlet.backgroundColor = .systemBlue
            sellButtonOutlet.titleLabel?.textColor = .white
            buyButtonOutlet.backgroundColor = .white
            buyButtonOutlet.titleLabel?.textColor = .systemBlue
        } else {
            sellButtonOutlet.backgroundColor = .white
            sellButtonOutlet.titleLabel?.textColor = .systemBlue
            buyButtonOutlet.backgroundColor = .systemBlue
            buyButtonOutlet.titleLabel?.textColor = .white
        }
    }
    
    func updateCurrency () {
        networkManager.currency { [self] (result) in
            switch result {
            case .success(currency: let posts):
                print("INFO \(posts)")
                currencyArray = posts
                tabelView.reloadData()
                checkLoadData = true
            case .failer(error: let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func createTimer() {
        timer?.invalidate()
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 5,
                                         target: self,
                                         selector: #selector(loadData),
                                         userInfo: nil,
                                         repeats: true)
        }
    }
    
    func createMessage() -> String {
        var message = ""
        for i in currencyViewArray {
            if i.currency == "UAH" {
                message += "Cost \(baseValue) \(i.currency): \n"
            }else{
                message += " Sale price: \(NSString(format: "%.2f",  baseValue / Double(i.sale)!)) \(i.currency), \n Buy price: \(NSString(format: "%.2f",  baseValue / Double(i.buy)!)) \(i.currency). \n\n"
            }
        }
        return message
    }
    
    @IBAction func sellButtonTapped(_ sender: UIButton) {
        sender.isSelected = true
        buyButtonOutlet.isSelected = false
        tabelView.reloadData()
        buttonView()
    }
    
    @IBAction func buyButtonTapped(_ sender: UIButton) {
        sender.isSelected = true
        sellButtonOutlet.isSelected = false
        tabelView.reloadData()
        buttonView()
    }
    
    @IBAction func shareAction(_ sender: UIButton) {
        let shareController = UIActivityViewController(activityItems:
                                                        [createMessage(),
                                                         "\(timeUpdateOutlet.text!)"],
                                                       applicationActivities: nil)
        shareController.completionWithItemsHandler = { _, bool, _, _ in
            if bool {
                print("Успешно")
            }
        }
        present(shareController, animated: true, completion: nil)
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate, CurrencyCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currencyViewArray.count > 3 {
            return currencyViewArray.count
        }else{
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell) as! CurrencyCell
        guard currencyArray.count != 0  else {return cell}
        if buyButtonOutlet.isSelected {
            let currency = currencyViewArray[indexPath.item]
            cell.setupValueBuyCell(value: currency, indexPath: indexPath, baseValue: baseValue)
        }else{
            let currency = currencyViewArray[indexPath.item]
            cell.setupValueSaleCell(value: currency, indexPath: indexPath, baseValue: baseValue)
        }
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
    
    func editTextField(sender: CurrencyCell, countCurrency: Double) {
        baseValue = countCurrency
        tabelView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if currencyViewArray.count < 5 {
            return 44
        }else{
            return 34
        }
    }
}
