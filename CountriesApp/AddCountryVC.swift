//
//  AddCountryVC.swift
//  CountriesApp
//
//  Created by macbook on 17/12/2021.
//

import UIKit
  
protocol transferData {
    func transfer(data: Country)
}



class AddCountryVC: UIViewController, UITextFieldDelegate {

    
    
    @IBOutlet weak var nameTF: UITextField!
    
    var delegateTransfer: transferData?
    
    var recv_country: Country?
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTF.delegate = self
        nameTF.text =  recv_country?.name
        
    
    }
   
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        recv_country?.name = nameTF.text
        self.nameTF.endEditing(true)
        return true
    }
  
    
    @IBAction func saveACtion(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegateTransfer?.transfer(data: self.recv_country!)
        }
        
        
    }
    @IBAction func dissmissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
