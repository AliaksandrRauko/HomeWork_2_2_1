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
    
    @IBAction func doneButtonPressed() {
        delegate.setNewBackgroundColor(colorSettingScreen: mainView.backgroundColor
                                       ?? UIColor.white)
        dismiss(animated: true)
    }
}


//MARK: - PRIVATE
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
        return strValue == ""
        ? true
        : Double(strValue) != nil
     }
}


//MARK: - USE PROTOKOL UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }

        if textField == firstTextField {
            if !isStringAnDouble(for: newValue) {
                showAlert(title: "Error",
                          message: "Please enter correct value",
                          textField: firstTextField)
                firstSlider.value = 0
                firstValueLabel.text = "0.00"
                return
            }
            firstSlider.value = Float(newValue) ?? 0
            firstValueLabel.text = newValue
        } else if textField == secondTextField {
            if !isStringAnDouble(for: newValue) {
                showAlert(title: "Error",
                          message: "Please enter correct value",
                          textField: secondTextField)
                secondSlider.value = 0
                secondValueLabel.text = "0.00"
                return
            }
            secondSlider.value = Float(newValue) ?? 0
            secondValueLabel.text = newValue
        } else if textField == thirdTextField {
            if !isStringAnDouble(for: newValue) {
                showAlert(title: "Error",
                          message: "Please enter correct value",
                          textField: thirdTextField)
                thridSlider.value = 0
                thirdValueLabel.text = "0.00"
                return
            }
            thridSlider.value = Float(newValue) ?? 0
            thirdValueLabel.text = newValue
        }
        setColor()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch string {
        case "0","1","2","3","4","5","6","7","8","9":
            return textField.text?.count ?? 0 > 3 ? false : true
        case ".":
            return textField.text?.components(separatedBy: ".").count ?? 0 > 1
            ? false
            : true
        default:
            //т.к. задание было с ALERT, то закомментируем, хотя можно просто запретить ввод ненужных символов
            //return string.count == 0 ? true : false
            return true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstTextField {
            secondTextField.becomeFirstResponder()
        } else if textField == secondTextField {
            thirdTextField.becomeFirstResponder()
        } else {
            firstTextField.becomeFirstResponder()
        }
        return true
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
