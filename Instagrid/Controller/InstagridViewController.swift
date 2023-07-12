//
//  ViewController.swift
//  Instagrid
//
//  Created by François-Xavier on 12/06/2023.
//

import UIKit
import SwiftUI

final class InstagridViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    // MARK: Button photo
//    @IBOutlet weak var firstPhotoButton: UIButton!
//    @IBOutlet weak var secondPhotoButton: UIButton!
//    @IBOutlet weak var thirdPhotoButton: UIButton!
//    @IBOutlet weak var fourthPhotoButton: UIButton!
    
    // MARK: UIView Photo
    @IBOutlet weak var firstPhoto: UIImageView!
    @IBOutlet weak var secondPhoto: UIImageView!
    @IBOutlet weak var thirdPhoto: UIImageView!
    @IBOutlet weak var fourthPhoto: UIImageView!
    
    // MARK: Selected Icon
    @IBOutlet private var firstSelectedIcon: UIImageView!
    @IBOutlet private var secondSelectedIcon: UIImageView!
    @IBOutlet private var thirdSelectedIcon: UIImageView!
    
    // MARK: UIView Layout
    @IBOutlet private var topLayout: UIView!
    @IBOutlet private var bottomLayout: UIView!
    
    // MARK: Layout Button
    @IBOutlet private var firstLayout: UIButton!
    @IBOutlet private var secondLayout: UIButton!
    @IBOutlet private var thirdLayout: UIButton!
    
    var selectedPhoto: UIImage = UIImage()
    var selectedButton: SelectedButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeFirstLayout()
    }
    
    
    @IBAction func firstPhotoButtonTapped(_ sender: UIButton) {
        selectedButton = .first
        showImagePicker()
        assigningPhoto(for: firstPhoto)
    }
    
    @IBAction func secondPhotoButtonTapped(_ sender: UIButton) {
        selectedButton = .second
        showImagePicker()
        assigningPhoto(for: secondPhoto)
    }
    
    @IBAction func thirdPhotoButtonTapped(_ sender: UIButton) {
        selectedButton = .third
        showImagePicker()
        assigningPhoto(for: thirdPhoto)
    }
    
    @IBAction func fourthPhotoButtonTapped(_ sender: UIButton) {
        selectedButton = .fourth
        showImagePicker()
        assigningPhoto(for: fourthPhoto)
    }
    
    @IBAction private func makeFirstLayout() {
        layout(for: .first)
    }
    
    
    @IBAction private func makeSecondLayout() {
        layout(for: .second)
    }
    
    
    @IBAction private func makeThirdLayout() {
        layout(for: .third)
    }
    
    private func layout(for layout: Layout) {
        
        firstSelectedIcon.isHidden = true
        secondSelectedIcon.isHidden = true
        thirdSelectedIcon.isHidden = true
        
        topLayout.isHidden = false
        bottomLayout.isHidden = false
        
        switch layout {
            
        case .first:
            topLayout.isHidden = true
            firstSelectedIcon.isHidden = false
            
        case .second:
            bottomLayout.isHidden = true
            secondSelectedIcon.isHidden = false
            
        case .third:
            thirdSelectedIcon.isHidden = false
        }
    }
    
    private func assigningPhoto(for image: UIImageView) {
        image.image = selectedPhoto
    }
    
    private func showImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            
            switch selectedButton {
            case .first:
                firstPhoto.image = image
            case .second:
                secondPhoto.image = image
            case .third:
                thirdPhoto.image = image
            case .fourth:
                fourthPhoto.image = image
            case .none:
                return
            }
        }
        dismiss(animated: true)
    }
}
