//
//  ViewController.swift
//  SwiftBookNamesCompApp
//
//  Created by Роман on 11.07.2024.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var youNameTextField: UITextField!
    
    @IBOutlet weak var partnerNameTextField: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? ResultViewController else { return }
        destinationVC.firstName = youNameTextField.text
        destinationVC.secondName = partnerNameTextField.text
    }

    @IBAction func resultButtonTapped() {
        guard let firstName = youNameTextField.text, let secondName = partnerNameTextField.text else { return }
        if firstName.isEmpty || secondName.isEmpty {
            showAlert(title: "✋ Error ✋",
                      message: "You need to fill in both fields 🤌🤌🤌")
            return
        }
        performSegue(withIdentifier: "goToResult", sender: nil)
    }
    
    @IBAction func unwindSegueToFirstViewController(segue: UIStoryboardSegue) {
        youNameTextField.text = ""
        partnerNameTextField.text = ""
    }
}

extension FirstViewController {
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAlertAction)
        present(alertController, animated: true)
    }
}

extension FirstViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == youNameTextField {
            partnerNameTextField.becomeFirstResponder()
        } else {
            resultButtonTapped()
        }
        return true
    }
    
}
