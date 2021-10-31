//
//  RegistrationViewController.swift
//  Messenger
//
//  Created by Kevin Lagat on 27/10/2021.
//

import UIKit
import FirebaseAuth

class RegistrationViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var firstNAme: UITextField!
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var imagePicker = UIImagePickerController()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
    }
    
    
    @IBAction func createAccount(_ sender: Any) {
        
        guard let userEmail =  email.text else { return }
        guard let userPassword = password.text else { return }
        
     
        FirebaseAuth.Auth.auth().createUser(withEmail: userEmail, password: userPassword) { authResult, error in
            
            guard let result = authResult, error == nil else {
                print("Error in creatung user")
                return
            }
            let user = result.user
            print("Created User: \(user)")
            
        }
        
        
    }
    
    
    @IBAction func presentPhotos(_ sender: Any) {
        
        presentPhotoActionSheet()
        
    }
    
}

extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func presentPhotoActionSheet(){
            let actionSheet = UIAlertController(title: "Profile Picture", message: "How would you like to select a picture?", preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { [weak self] _ in
                self?.presentCamera()
            }))
            actionSheet.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { [weak self] _ in
                self?.presentPhotoPicker()
            }))
            
            present(actionSheet, animated: true)
        }
        func presentCamera() {
            let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.delegate = self
            vc.allowsEditing = true
            present(vc, animated: true)
        }
        func presentPhotoPicker() {
            let vc = UIImagePickerController()
            vc.sourceType = .photoLibrary
            vc.delegate = self
            vc.allowsEditing = true
            present(vc, animated: true)
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // take a photo or select a photo
            
            // action sheet - take photo or choose photo
            picker.dismiss(animated: true, completion: nil)
            print(info)
            
            guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
                return
            }
            
            self.profileImage.image = selectedImage
            
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
}
