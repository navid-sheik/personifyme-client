//
//  ViewController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 24/07/2023.
//

import UIKit

struct ResponseData : Codable{
    let message : String
}



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("Something ")
        
        let url  = URL(string: "http://localhost:4050/")!
        let task  = URLSession.shared.dataTask(with: url){ (data, response, error) in
            if let error =  error{
                print("Error : \(error)")
            }else  if let data =  data{
               
                let decoder  =  JSONDecoder()
                if let responseData  =  try? decoder.decode(ResponseData.self, from: data){
                    print("Result : \(responseData.message)")
                }else{
                    print("Unable to decode the json response")
                    
                }
            
            }
            
            
            
        }
        
        task.resume()
        
     
    }


}

