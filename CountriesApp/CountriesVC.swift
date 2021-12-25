//
//  ViewController.swift
//  CountriesApp
//
//  Created by macbook on 10/12/2021.
//

import UIKit

class CountriesVC: UIViewController  , transferDataToCountries{
   
    
 
    @IBOutlet weak var countriesTableView: UITableView!
   
    var countries : [Country] = []
    
    let c1 = Country(name: "Palestine", image: UIImage(named: "palestine")! , id: 1, cities: ["Gaza","Jabaliya","Rafah"])
    let c2 = Country(name: "Jordan", image: UIImage(named:"jordan")!, id: 2, cities: ["Amman","Salt"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        countries.append(c1)
//        countries.append(c2)
        countries.append(contentsOf: [c1,c2])
     
    }

    @IBAction func deleteAction(_ sender: Any) {
        var alert = UIAlertController(title: "Clear countries", message: "Are you sure want to clear all countries?", preferredStyle: .alert)
        
        let okBtn = UIAlertAction(title: "Sure", style: .destructive) { okAction in
            self.countries.removeAll()
            self.countriesTableView.reloadData()
        }
        alert.addAction(okBtn)
        
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("Cancel Clear  process")
        }
        alert.addAction(cancelBtn)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func addAction(_ sender: Any) {
        let alert = UIAlertController(title: "Add countries", message: "Are you sure want to add  this to countries countries?", preferredStyle: .alert)
        alert.addTextField { textFiled in
            textFiled.delegate = self
        
        }
        let okBtn = UIAlertAction(title: "Sure", style: .default) { okAction in

            self.countriesTableView.reloadData()
        }
        alert.addAction(okBtn)
        
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("Cancel add  process")
        }
        alert.addAction(cancelBtn)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func transfer(data: Country) {
        for searchedCountry in self.countries
        {
            if searchedCountry.id == data.id {
                searchedCountry.name = data.name
                searchedCountry.image = data.image
                self.countriesTableView.reloadData()
            }
        }
    }
    
}

extension CountriesVC : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        countries.append(Country(name: textField.text ?? "", image:UIImage(named:  textField.text ?? "")!, id: 0, cities: []))
    }
}


extension CountriesVC : UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: DetialsVC =  storyboard.instantiateViewController(identifier: "DetialsId")
        vc.delegateTransfer2 = self
        vc.rec_country = countries[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
     
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Countries 1"
            
        case 1 :
            return "Countrie 2"
        default:
            return "Countries 3"
        }
        
      
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            var  cell = countriesTableView.dequeueReusableCell(withIdentifier: "mycell2")! as UITableViewCell
            cell  = UITableViewCell(style: .default, reuseIdentifier: "mycell2")
            cell.textLabel?.text = countries[indexPath.row].name
            cell.imageView?.image = countries[indexPath.row].image
            cell.accessoryType = .disclosureIndicator

            return cell
            
        case 1 :
            let myCell =  countriesTableView.dequeueReusableCell(withIdentifier: "myCell3")  as!  CountryTCell
            myCell.countryImageV.image = countries[indexPath.row].image
            myCell.countryName.text =  countries[indexPath.row].name
            return myCell
            
            
        default:
            var  cell = countriesTableView.dequeueReusableCell(withIdentifier: "mycell1")! as UITableViewCell
          
            return cell
        }

        
        
     
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 50
            
        case 1 :
            return 200
        default:
            return 100
        }
       
    }
    
    
}

