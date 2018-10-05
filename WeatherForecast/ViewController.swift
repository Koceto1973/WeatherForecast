//
//  ViewController.swift
//  WeatherForecast
//
//  Created by К.К. on 20.09.18.
//  Copyright © 2018 TeamK. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    var www:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        cityTextField.delegate = self
        
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2.0
        
    }

    @IBAction func SubmitCity(_ sender: UIButton) {
        if  cityTextField.text != ""  {
            www = "https://api.openweathermap.org/data/2.5/weather?q="
            www += cityTextField.text?.replacingOccurrences(of: " ", with: "-") ?? "London"
            www += ",uk&appid=f965d898b4167e6331f06bd6764ea088"
            
            let url = URL(string: www)!
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil { print(error!) } else {
                    if let urlContent = data { // data in JSON format
                        do {
                            let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            print(jsonResult)
                            if let description = ((jsonResult["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String {
                                DispatchQueue.main.sync(execute: {  self.label.text = description  } )
                            }
                        } catch { print("JSON Processing Failed")        }
                   }
                }
            }
            task.resume()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

    


