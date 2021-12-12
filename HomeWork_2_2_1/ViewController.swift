//
//  ViewController.swift
//  HomeWork_2_2_1
//
//  Created by Aliaksandr Rauko on 10.12.21.
//

import UIKit

class ViewController: UIViewController {

 
    @IBOutlet var mainView: UIView!
    
    @IBOutlet var firstColourLabel: UILabel!
    @IBOutlet var secondColourLabel: UILabel!
    @IBOutlet var thirdColourLabel: UILabel!
    
    @IBOutlet var firstValueLabel: UILabel!
    @IBOutlet var secondValueLabel: UILabel!
    @IBOutlet var thirdValueLabel: UILabel!
    
    @IBOutlet var firstSlider: UISlider!
    @IBOutlet var secondSlider: UISlider!
    @IBOutlet var thridSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemBlue
        mainView.layer.cornerRadius = 30
        mainView.backgroundColor = UIColor.gray
        
        firstColourLabel.text = "Red"
        firstColourLabel.textColor = UIColor.white
        secondColourLabel.text = "Green"
        secondColourLabel.textColor = UIColor.white
        thirdColourLabel.text = "Blue"
        thirdColourLabel.textColor = UIColor.white

        firstValueLabel.text = String(firstSlider.value)
        firstValueLabel.textColor = UIColor.white
        secondValueLabel.text = String(secondSlider.value)
        secondValueLabel.textColor = UIColor.white
        thirdValueLabel.text = String(thridSlider.value)
        thirdValueLabel.textColor = UIColor.white
        
        firstSlider.tintColor = UIColor.red
        secondSlider.tintColor = UIColor.green
        thridSlider.tintColor = UIColor.blue

    }

    @IBAction func firstSliderAction() {
        let redValue = round(firstSlider.value * 100) / 100
        firstValueLabel.text = String(redValue)
        changeColour()
    }
    
    @IBAction func secondSliderAction() {
        let greenValue = round(secondSlider.value * 100) / 100
        secondValueLabel.text = String(greenValue)
        changeColour()
    }
    
    
    @IBAction func thirdSliderAction() {
        let blueValue = round(thridSlider.value * 100) / 100
        thirdValueLabel.text = String(blueValue)
        changeColour()
    }
    
}

//MARK: -
extension ViewController {
    private  func changeColour(){
        mainView.backgroundColor = UIColor(red: CGFloat(firstSlider.value), green: CGFloat(secondSlider.value), blue: CGFloat(thridSlider.value), alpha: 1)
    }
}
