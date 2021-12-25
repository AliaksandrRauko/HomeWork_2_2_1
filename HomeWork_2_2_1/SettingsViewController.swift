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
        firstTextField.delegate = self
        secondTextField.delegate = self
        thirdTextField.delegate = self
        
        setValueSliderFromHomeScreeen(someColor: colorHomeScreen)
        setValue(for: firstColorLabel)
        setValue(for: secondColorLabel)
        setValue(for: thirdColorLabel)
        setColor()
    }

    @IBAction func sliderAction(_ sender: UISlider) {
        
        setColor()
        
        switch sender {
        case firstSlider: setValue(for: firstColorLabel)
        case secondSlider: setValue(for: secondColorLabel)
        default:
            setValue(for: thirdColorLabel)
        }
    }
    
    @IBAction func textFieldAction(_ sender: UITextField) {
        
        switch sender.tag {
        case 0:
            guard let newValue = firstTextField.text else { return }
            if !isStringAnDouble(for: newValue) {
                showAlert(title: "Error",
                          message: "Please, enter correct value",
                          textField: firstTextField)
                return
            }
        case 1:
            guard let newValue = secondTextField.text else { return }
            if !isStringAnDouble(for: newValue) {
                showAlert(title: "Error",
                          message: "Please, enter correct value",
                          textField: secondTextField)
                return
            }
        default:
            guard let newValue = secondTextField.text else { return }
            if !isStringAnDouble(for: newValue) {
                showAlert(title: "Error",
                          message: "Please, enter correct value",
                          textField: thirdTextField)
                return
            }
        }

    }
    
    @IBAction func doneButtonPressed() {
        delegate.setNewBackgroundColor(colorSettingScreen: mainView.backgroundColor
                                       ?? UIColor.white)
        dismiss(animated: true)
    }
}


//MARK: - SET SCREEN SETTINGS
extension SettingsViewController {
    private  func setColor() {
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
        String(format: "%.2f", slider.value)
    }
    
    
    private func setValueSliderFromHomeScreeen(someColor: UIColor) {
        let ciColor = CIColor(color: someColor)
        firstSlider.value = Float(ciColor.red)
        secondSlider.value = Float(ciColor.green)
        thridSlider.value = Float(ciColor.blue)
    }
    
    private func isStringAnDouble(for strValue: String) -> Bool {
         return Double(strValue) != nil
     }
}


//MARK: - SET PROTOKOL UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let numberValue = Float(newValue) else { return }
        
        if textField == firstTextField {
            firstSlider.value = numberValue
            firstValueLabel.text = newValue
        } else if textField == secondTextField {
            secondSlider.value = numberValue
            secondValueLabel.text = newValue
        } else if textField == thirdTextField {
            thridSlider.value = numberValue
            thirdValueLabel.text = newValue
        }
        setColor()
    }
}

//MARK: - ALERT CONTROLLER
extension SettingsViewController {
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
