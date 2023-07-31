//
//  PageModel.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 29/07/2023.
//

import Foundation

struct PageModel {
    var title: String
    var description : String
    var imageName : String
    
    init(titleName : String, descriptionName : String, imageString : String) {
        self.title = titleName
        self.description =  descriptionName
        self.imageName = imageString
    }
}
