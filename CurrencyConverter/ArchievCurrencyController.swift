//
//  ArchievCurrencyController.swift
//  CurrencyConverter
//
//  Created by Vitaly Khryapin on 03.02.2022.
//
import Foundation
import UIKit

class ArchievCurrencyController: UITableViewController {
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    @IBOutlet weak var dateOutlet: UIBarButtonItem!
    var currencyArchiev = CurrencyArchiev()
    var dataSource = [Rate]()
    var dictionary: [String.Element : [Rate]] = [:]
    var dictKeys = [Dictionary<String.Element, [Rate]>.Keys.Element]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let micImage = UIImage(systemName: "mic.fill")
        searchBarOutlet.setImage(micImage, for: .bookmark, state: .normal)
        searchBarOutlet.showsBookmarkButton = true
        updateArchiev(date: "01.12.2014")
    }
    
    func updateArchiev (date: String) {
        let session = URLSession.shared
        let url = URL(string: "https://api.privatbank.ua/p24api/exchange_rates?json&date=\(date)")!
        let task = session.dataTask(with: url) { (data, responce, error) in
            guard error == nil else {
                print("DataTask error \(String(describing: error?.localizedDescription))")
                return
            }
            do {
                self.currencyArchiev = try JSONDecoder().decode(CurrencyArchiev.self, from: data!)
                self.dataSource = self.currencyArchiev.exchangeRate
                self.dictionary = Dictionary(grouping: self.dataSource, by:{ $0.currency.first! })
                self.dictKeys = Array(self.dictionary.keys)
                self.dictKeys.sort()
                print(self.dataSource)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dictionary.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var dictKeys = Array(dictionary.keys)
        dictKeys.sort()
        return "\(dictKeys[section])"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let character = Character("\(dictKeys[section])")
        let nameSection = dictionary[character]
        return nameSection?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let character = Character("\(dictKeys[indexPath.section])")
        let nameCell = dictionary[character]
        let buyCurrency = "\(NSString(format: "%.2f", nameCell![indexPath.row].purchaseRateNB))"
        let saleCurrency = "\(NSString(format: "%.2f", nameCell![indexPath.row].saleRateNB))"
        cell.textLabel?.text = "\(nameCell![indexPath.row].currency) buy: \(buyCurrency), sale: \(saleCurrency)"
        return cell
    }
    
    func datePicker () {
        let myDatePicker: UIDatePicker = UIDatePicker()
        myDatePicker.preferredDatePickerStyle = .wheels
        myDatePicker.datePickerMode = .date
        myDatePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
        myDatePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -8, to: Date())
        myDatePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -5, to: Date())
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .alert)
        alertController.view.addSubview(myDatePicker)
        let selectAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.getDateFromPicker(date: myDatePicker.date)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(selectAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    
    func getDateFromPicker (date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        updateArchiev(date: formatter.string(from: date))
        self.title = "Currency on \(formatter.string(from: date))"
    }
    
    @IBAction func dateActionTap(_ sender: Any) {
        datePicker()
    }
}

