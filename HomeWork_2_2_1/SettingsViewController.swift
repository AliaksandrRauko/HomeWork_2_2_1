//
//  ViewController.swift
//  HomeWork_2_2_1
//
//  Created by Aliaksandr Rauko on 10.12.21.
//

import UIKit


class SettingsViewController: UIViewController {

    @IBOutlet var mainView: UIView!
    
    @IBOutlet var firstColorLabel: UILabel!
    @IBOutlet var secondColorLabel: UILabel!
    @IBOutlet var thirdColorLabel: UILabel!
    
    @IBOutlet var firstValueLabel: UILabel!
    @IBOutlet var secondValueLabel: UILabel!
    @IBOutlet var thirdValueLabel: UILabel!
    
    @IBOutlet var firstSlider: UISlider!
    @IBOutlet var secondSlider: UISlider!
    @IBOutlet var thridSlider: UISlider!
    
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var thirdTextField: UITextField!
    
    var colorHomeScreen: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.layer.cornerRadius = 30
        
        changeValueSlider(someColor: colorHomeScreen)
        changeColour()        
            //setValue(for: colorLabels)
        
    }

    @IBAction func sliderAction(_ sender: UISlider) {
        
        changeColour()
        
        switch sender {
        case firstSlider: setValue(for: firstColorLabel)
        case secondSlider: setValue(for: secondColorLabel)
        default:
            setValue(for: thirdColorLabel)
        }
    }
    
    @IBAction func textFieldAction(_ sender: UITextField) {
        
        switch sender {
        case firstTextField: setValue(for: firstColorLabel)
        case secondTextField: setValue(for: secondColorLabel)
        default:
            setValue(for: thirdColorLabel)
        }
        changeColour()
    }
    
    @IBAction func doneButtonPressed() {
        delegate.setNewBackgroundColor(colorSettingScreen: mainView.backgroundColor
                                       ?? UIColor.white)
        dismiss(animated: true)
    }
}


//MARK: -

extension SettingsViewController: UITextFieldDelegate {
    
    private  func changeColour() {
        mainView.backgroundColor = UIColor(red: CGFloat(firstSlider.value),
                                           green: CGFloat(secondSlider.value),
                                           blue: CGFloat(thridSlider.value),
                                           alpha: 1)
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case firstColorLabel:
                firstValueLabel.text = string(from: firstSlider)
                firstTextField.text = string(from: firstSlider)
            case secondColorLabel:
                secondValueLabel.text = string(from: secondSlider)
                secondTextField.text = string(from: secondSlider)
            default:
                thirdValueLabel.text = string(from: thridSlider)
                thirdTextField.text = string(from: thridSlider)
            }
        }
    }

    private func string(from slider: UISlider) -> String {
        String(round(slider.value * 100) / 100)
    }
    
    
    private func changeValueSlider(someColor: UIColor) {
        
        let ciColor = CIColor(color: someColor)
        firstSlider.value = Float(ciColor.red)
        secondSlider.value = Float(ciColor.green)
        thridSlider.value = Float(ciColor.blue)

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField {
        case firstTextField: setValue(for: firstColorLabel)
        case secondTextField: setValue(for: secondColorLabel)
        default:
            setValue(for: thirdColorLabel)
        }
        changeColour()
    }
}

