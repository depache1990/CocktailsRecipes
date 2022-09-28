//
//  CreateCocktailViewController.swift
//  Bar Academy
//
//  Created by Anton Duplin on 11/9/22.
//

import UIKit

class CreateCocktailViewController: UIViewController {
    
//    var cocktail = CocktailModel()
    
    var delegate: CreateCocktailViewControllerDelegate?
    
    @IBOutlet weak var myCocktailsImage: UIImageView!
    
    @IBOutlet weak var ingridientsText: UITextView!
    
    @IBOutlet weak var instructionText: UITextView!
    
    @IBOutlet weak var cocktailNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func takePhotoAction() {
       presentPhoto()
    }
    
    @IBAction func savePhotoAction() {
        
    }
    
    @IBAction func doneButtonPressed() {
        saveAndExit()
    }
    
    @IBAction func canceButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    private func saveAndExit() {
        guard let textIngridient = ingridientsText.text?.trimmingCharacters(in: .whitespacesAndNewlines)  else { return }
        guard let textInstruction = instructionText.text?.trimmingCharacters(in: .whitespacesAndNewlines)  else { return }
        guard let textNameCocktail = cocktailNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)  else { return }
        
        let cocktail = CocktailModel(ingridients: textIngridient, instruction: textInstruction, nameCocktail: textNameCocktail)

        delegate?.saveCocktail(with: cocktail, ingridients: textIngridient, instruction: textInstruction, nameCocktail: textNameCocktail)

        dismiss(animated: true)
    }
}

extension CreateCocktailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func presentPhoto() {
        let actionSheet = UIAlertController(
            title: "Cocktail Picture",
            message: "How would you like select a picture",
            preferredStyle: .actionSheet
        )
        actionSheet.addAction(UIAlertAction(
            title: "Cansel",
            style: .cancel)
        )
        actionSheet.addAction(UIAlertAction(
            title: "Take picture",
            style: .default,
            handler: { [weak self] _ in
                self?.presentCamera()
            })
        )
        actionSheet.addAction(UIAlertAction(
            title: "Choose Photo",
            style: .default,
            handler: { [weak self] _ in
                self?.presentPhotoPicker()
            })
        )
        present(actionSheet, animated: true)
        
    }
    
    private func presentCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    private func presentPhotoPicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        myCocktailsImage.image = image
        
        
    }
}

extension CreateCocktailViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    

}
