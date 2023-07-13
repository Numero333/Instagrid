//
//  ViewController.swift
//  Instagrid
//
//  Created by François-Xavier on 12/06/2023.
//

import UIKit
import SwiftUI

final class InstagridViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    // MARK: Property
    @IBOutlet weak var firstPhoto: UIImageView!
    @IBOutlet weak var secondPhoto: UIImageView!
    @IBOutlet weak var thirdPhoto: UIImageView!
    @IBOutlet weak var fourthPhoto: UIImageView!
    
    @IBOutlet private var firstSelectedIcon: UIImageView!
    @IBOutlet private var secondSelectedIcon: UIImageView!
    @IBOutlet private var thirdSelectedIcon: UIImageView!
    
    @IBOutlet private var topLayout: UIView!
    @IBOutlet private var bottomLayout: UIView!
    
    @IBOutlet private var firstLayout: UIButton!
    @IBOutlet private var secondLayout: UIButton!
    @IBOutlet private var thirdLayout: UIButton!
    
    @IBOutlet private weak var photosMontageView: UIView!
    @IBOutlet private var gestureRecognizer: UIPanGestureRecognizer!
    
    // MARK: - Override
    private var selectedPhoto: UIImage?
    private var selectedButton: ButtonIdentifier?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayFirstLayout()
        gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleGesture))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    // MARK: - Action
    @IBAction private func firstPhotoButtonTapped(_ sender: UIButton) {
        selectedButton = .optionOne
        showImagePicker()
        assignPhoto(for: firstPhoto)
    }
    
    @IBAction private func secondPhotoButtonTapped(_ sender: UIButton) {
        selectedButton = .optionTwo
        showImagePicker()
        assignPhoto(for: secondPhoto)
    }
    
    @IBAction private func thirdPhotoButtonTapped(_ sender: UIButton) {
        selectedButton = .optionThree
        showImagePicker()
        assignPhoto(for: thirdPhoto)
    }
    
    @IBAction private func fourthPhotoButtonTapped(_ sender: UIButton) {
        selectedButton = .optionFour
        showImagePicker()
        assignPhoto(for: fourthPhoto)
    }
    
    @IBAction private func displayFirstLayout() {
        updateLayout(for: .first)
    }
    
    @IBAction private func displaySecondLayout() {
        updateLayout(for: .second)
    }
    
    @IBAction private func displayThirdLayout() {
        updateLayout(for: .third)
    }
    
    // MARK: - Private
    private func updateLayout(for layout: Layout) {
        
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
    
    private func showImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    private func assignPhoto(for imageView: UIImageView) {
        imageView.image = selectedPhoto
    }
    
    @objc private func handleGesture() {
        
        let loc = gestureRecognizer.translation(in: self.view)
        let size = abs(loc.y)
        
        if size > 100 {
            print("reconnu")
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            
            switch selectedButton {
            case .optionOne:
                firstPhoto.image = image
            case .optionTwo:
                secondPhoto.image = image
            case .optionThree:
                thirdPhoto.image = image
            case .optionFour:
                fourthPhoto.image = image
            case .none:
                return
            }
        }
        dismiss(animated: true)
    }
}
