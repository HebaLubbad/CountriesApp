//
//  Country.swift
//  CountriesApp
//
//  Created by macbook on 17/12/2021.
//

import UIKit

class Country: NSObject {
    
    var name:String?
    var image: UIImage?
    var id:Int?
    var cities:[String] = []
    
    
    init(name:String,image:UIImage,id:Int,cities:[String]) {
        
        self.name = name
        self.image = image
        self.id = id
        self.cities.append(contentsOf: cities)
    }

}
