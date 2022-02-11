//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Vitaly Khryapin on 27.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var backgoundLabel: UILabel!
    @IBOutlet weak var buyButtonOutlet: UIButton!
    @IBOutlet weak var sellButtonOutlet: UIButton!
    @IBOutlet weak var timeUpdateOutlet: UILabel!
    @IBOutlet var textFieldCollection: [UITextField]!
    @IBOutlet weak var buttonResetOutlet: UIButton!
    @IBOutlet weak var tfUSDOutlet: UITextField!
    @IBOutlet weak var tfEUROutlet: UITextField!
    @IBOutlet weak var tfRUBOutlet: UITextField!
    
    var checkLoadData = false
    var timer: Timer?
    let refreshManager = RefreshManager.shared
    let networkManager = NetworkManager()
    let dateFormatter = DateFormatter()
    let defaults = UserDefaults.standard
    var saleUsd: Float?
    var saleEuro: Float?
    var saleRub: Float?
    var buyUsd: Float?
    var buyEuro: Float?
    var buyRub: Float?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView()
        createTimer()
        tfUSDOutlet.text = "\(1)"
        dateFormatter.dateFormat = "d MMM yyyy, h:mm a"
        loadData()
        buttonView()
        identifier ()
    }
    
    func identifier () {
        tfUSDOutlet.accessibilityIdentifier = "tfUSDOutlet"
        tfEUROutlet.accessibilityIdentifier = "tfEUROutlet"
        tfRUBOutlet.accessibilityIdentifier = "tfRUBOutlet"
        buttonResetOutlet.accessibilityIdentifier = "buttonResetOutlet"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
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
                currency()
                print ("Данные обноволены")
            } else {
                let date = defaults.value(forKey: "lastRefresh")
                timeUpdateOutlet.text = "Last Updated\n \(dateFormatter.string(from: date as! Date))"
                print ("Данные не обновлены")
                checkLoadData = true
                changedUSD()
            }
        }
    }
    
    func backgroundView () {
        ShadowLabel().labelBackground(view, backgoundLabel)
        Ellipse().ellipseVeryLightBlue(view)
        Ellipse().ellipseLightBlue(view)
        Ellipse().ellipseBlue(view)
        ButtonView().buttonView(buttonResetOutlet)
        for tf in textFieldCollection {
            tf.borderStyle = .none
            tf.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
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
    
    func changedExcludeLetterTF (_ sender: UITextField) {
        if let lastSymbol = sender.text?.last {
            if !lastSymbol.isNumber && lastSymbol != "."{
                sender.text?.removeLast()
            }
        }
        if let text = sender.text {
            sender.text = text.filter{$0.isNumber || $0 == "."}
        }
    }
    
    func currency () {
        networkManager.currency { [self] (result) in
            switch result {
            case .success(currency: let posts):
                print("INFO \(posts)")
                saleUsd = Float(posts[0].sale)
                buyUsd = Float(posts[0].buy)
                defaults.set(saleUsd, forKey: "saleUsd")
                defaults.set(buyUsd, forKey: "buyUsd")
                if saleUsd != nil, Float(posts[1].sale) != nil, Float(posts[2].sale) != nil, Float(posts[1].buy) != nil,  Float(posts[2].buy) != nil {
                    saleEuro = saleUsd! / Float(posts[1].sale)!
                    saleRub = saleUsd! / Float(posts[2].sale)!
                    buyEuro = buyUsd! / Float(posts[1].buy)!
                    buyRub = buyUsd! / Float(posts[2].buy)!
                    defaults.set(buyUsd! / Float(posts[1].buy)!, forKey: "buyEuro")
                    defaults.set(saleUsd! / Float(posts[1].sale)!, forKey: "saleEuro")
                    defaults.set(saleUsd! / Float(posts[2].sale)!, forKey: "saleRub")
                    defaults.set(buyUsd! / Float(posts[2].buy)!, forKey: "buyRub")
                    defaults.synchronize()
                    checkLoadData = true
                    changedUSD()
                }
            case .failer(error: let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func changedUSD () {
        if checkLoadData {
            
            saleEuro = defaults.value(forKey: "saleEuro") as? Float
            saleRub = defaults.value(forKey: "saleRub") as? Float
            buyEuro = defaults.value(forKey: "buyEuro") as? Float
            buyRub = defaults.value(forKey: "buyRub") as? Float
            if saleEuro == nil || saleRub == nil || buyEuro == nil || buyRub == nil {
                currency()
                return
            }
            if sellButtonOutlet.isSelected {
                if let changedUSD = Float(tfUSDOutlet.text!) {
                    self.tfEUROutlet.text = "\(NSString(format: "%.2f", (changedUSD * saleEuro!)))"
                    self.tfRUBOutlet.text = "\(NSString(format: "%.2f", (changedUSD * saleRub!)))"
                }
            } else {
                if let changedUSD = Float(tfUSDOutlet.text!)  {
                    self.tfEUROutlet.text = "\(NSString(format: "%.2f", (changedUSD * buyEuro!)))"
                    self.tfRUBOutlet.text = "\(NSString(format: "%.2f", (changedUSD * buyRub!)))"
                }
            }
        } else {
            currency()
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
    
    @IBAction func sellButtonTapped(_ sender: UIButton) {
        sender.isSelected = true
        buyButtonOutlet.isSelected = false
        buttonView()
        changedUSD()
    }
    
    @IBAction func buyButtonTapped(_ sender: UIButton) {
        sender.isSelected = true
        sellButtonOutlet.isSelected = false
        buttonView()
        changedUSD()
    }
    
    @IBAction func tfUSDChanged(_ sender: UITextField) {
        changedExcludeLetterTF(sender)
        changedUSD()
    }
    
    @IBAction func tfUSDDidBegin(_ sender: UITextField) {
        tfUSDOutlet.layer.borderWidth = 1
        tfUSDOutlet.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    @IBAction func tfUSDEnd(_ sender: UITextField) {
        tfUSDOutlet.layer.borderWidth = 0
    }
    @IBAction func shareAction(_ sender: UIButton) {
        let shareController = UIActivityViewController(activityItems:
                                                        ["Exchange rates:",
                                                         "cost \(tfUSDOutlet.text!) USD\n",
                                                         "\(tfEUROutlet.text!) EURO,\n",
                                                         "\(tfRUBOutlet.text!) RUB.\n",
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


