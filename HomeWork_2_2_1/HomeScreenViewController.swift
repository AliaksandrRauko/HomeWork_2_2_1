//
//  HomeScreenViewController.swift
//  HomeWork_2_2_1
//
//  Created by Aliaksandr Rauko on 24.12.21.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setNewBackgroundColor(colorSettingScreen: UIColor)
}

class HomeScreenViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        guard let navigationSettingVS = segue.destination as? SettingsViewController else { return }
        navigationSettingVS.colorHomeScreen = view.backgroundColor
        navigationSettingVS.delegate = self
    }

}

extension HomeScreenViewController: SettingsViewControllerDelegate {
    func setNewBackgroundColor(colorSettingScreen: UIColor) {
        view.backgroundColor = colorSettingScreen
    }
}
