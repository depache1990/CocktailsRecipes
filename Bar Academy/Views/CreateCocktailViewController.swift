//
//  CreateCocktailViewController.swift
//  Bar Academy
//
//  Created by Anton Duplin on 11/9/22.
//

import UIKit

class CreateCocktailViewController: UIViewController {
    
    var delegate: CreateCocktailViewControllerDelegate!
    
    @IBOutlet weak var myCocktailsImage: UIImageView!
    
    @IBOutlet weak var ingridientsText: UITextView!
    
    @IBOutlet weak var instructionText: UITextView!
    
    @IBOutlet weak var cocktailName: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func takePhotoAction() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            imagePicker.delegate = self
            present(imagePicker, animated: true)
            
        }
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
        guard let textIngridients = ingridientsText.text else { return }
        guard let textInstruction = instructionText.text else { return }
        guard let textNameCocktail = cocktailName.text else { return }
        
        let cocktails = MakeCocktails(ingridients: textIngridients, instruction: textInstruction, nameCocktail: textNameCocktail)
        StorageManager.shared.save(cocktail: cocktails)
        delegate.saveCocktail(cocktails)
        dismiss(animated: true)
    }
}

extension CreateCocktailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        myCocktailsImage.image = image
        
        
    }
}
