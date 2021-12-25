//
//  DetialsVC.swift
//  CountriesApp
//
//  Created by macbook on 17/12/2021.
//

import UIKit

protocol transferDataToCountries {
  func transfer(data: Country)
}
class DetialsVC: UIViewController , transferData {
  
    

    @IBOutlet weak var nameLBl: UILabel!
    @IBOutlet weak var imageV: UIImageView!
    
    
    var delegateTransfer2: transferDataToCountries?
    var rec_country:Country?
    var imagePicker:UIImagePickerController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLBl.text = rec_country?.name
        imageV.image = rec_country?.image
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changeImageAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Change country Image", message: "", preferredStyle: .actionSheet)
        let cameraBtn = UIAlertAction(title: "Camera", style: .default) { _ in
            self.changeImageUsingCamera()
        }
        let libraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
            self.changeImageUsingPhotoLibrary()
        }
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(cameraBtn)
        alert.addAction(libraryAction)
        alert.addAction(cancelBtn)
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func changeImageUsingCamera(){
        
        if UIImagePickerController.isCameraDeviceAvailable(.front) ||  UIImagePickerController.isCameraDeviceAvailable(.rear) {
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        imagePicker?.sourceType = .camera
        imagePicker?.mediaTypes = ["public.image","public.movie"]
        imagePicker?.allowsEditing = true
        self.present(imagePicker!, animated: true, completion: nil)
        }
        else{
            NoCamera()
        }
    
    }
    
    func NoCamera()
    {
        let alert = UIAlertController(title: "Sorry no available camera", message: "", preferredStyle: .alert)
        
        let okBtn = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okBtn)
        self.present(alert, animated: true, completion: nil)
    }
    func changeImageUsingPhotoLibrary ()
    {
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        imagePicker?.sourceType = .photoLibrary
        imagePicker?.mediaTypes = ["public.image"]
        imagePicker?.allowsEditing = true
        self.present(imagePicker!, animated: true, completion: nil)
    }
    
    
    @IBAction func presentAddCountryAction(_ sender: Any) {
        let st = UIStoryboard(name: "Main", bundle: nil)
        let vc: AddCountryVC = st.instantiateViewController(identifier: "AddCountryId")
        vc.delegateTransfer = self
        vc.recv_country = rec_country
        self.present(vc, animated: true) {
            print("Presented Successfully")
        }
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        self.delegateTransfer2?.transfer(data: self.rec_country!)
        self.navigationController?.popViewController(animated: true)
    }
    
    func transfer(data: Country) {
        nameLBl.text = data.name
    }

}



extension DetialsVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image:UIImage =   info[.editedImage] as! UIImage
        self.imageV.image = image
        self.rec_country?.image = image
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
