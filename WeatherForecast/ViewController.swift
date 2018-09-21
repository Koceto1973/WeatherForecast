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
            // https://www.weather-forecast.com/locations/London/forecasts/latest
            www = "https://www.weather-forecast.com/locations/"
            www += cityTextField.text ?? "London"
            www += "/forecasts/latest"
            
            // continue
            if let url = URL(string: www) {
                let urlRequest = URLRequest(url: url )
                
                let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) { data, response, error in
                    if error != nil {  // might be error
                        self.label.text = error! as? String
                    } else {
                        if let unwrappedData = data {  // might be no data          // use format to get the data
                            let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                            let separator = "(1&ndash;3 days)</span><p class=\"b-forecast__table-description-content\"><span class=\"phrase\">"
                            if let dataArray = dataString?.components(separatedBy: separator){
                                if dataArray.count>1 { // text beginning is found successfully
                                    let text = dataArray[1].components(separatedBy: "</span>")[0]
                                                                       
                                    DispatchQueue.main.sync(execute: {
                                        // Update UI
                                        self.label.text = text.replacingOccurrences(of: "&deg;", with: "º")
                                    })
                                }
                            }
                        }
                    }
                }
                
                task.resume()
                
                
            } else {
                label.text = "Invalid URL, improper symbols used in city name"
            }
        } else {
            label.text = "Provide your city name"
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

    


