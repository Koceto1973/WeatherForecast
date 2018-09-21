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
            www = "https://www.weather-forecast.com/locations/"
            www += cityTextField.text ?? "London"
            www += "/forecasts/latest"
            label.text = www
            
            // continue
            
            
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

    


