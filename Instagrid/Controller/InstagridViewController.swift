//
//  ViewController.swift
//  Instagrid
//
//  Created by François-Xavier on 12/06/2023.
//

import UIKit

final class InstagridViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    // MARK: Property
    @IBOutlet private var firstPhoto: UIImageView!
    @IBOutlet private var secondPhoto: UIImageView!
    @IBOutlet private var thirdPhoto: UIImageView!
    @IBOutlet private var fourthPhoto: UIImageView!
    
    @IBOutlet private var firstSelectedIcon: UIImageView!
    @IBOutlet private var secondSelectedIcon: UIImageView!
    @IBOutlet private var thirdSelectedIcon: UIImageView!
    
    @IBOutlet private var topLayout: UIView!
    @IBOutlet private var bottomLayout: UIView!
    
    @IBOutlet private var firstLayout: UIButton!
    @IBOutlet private var secondLayout: UIButton!
    @IBOutlet private var thirdLayout: UIButton!
    
    @IBOutlet private weak var photosMontageView: UIView!
    
    private var selectedImageView: UIImageView?
    private let swipeGesture = UISwipeGestureRecognizer()
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayFirstLayout()
        self.setupGesture()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        switch UIDevice.current.orientation {
        case .portrait, .faceUp, .faceDown, .portraitUpsideDown: self.swipeGesture.direction = .up
        case .landscapeLeft, .landscapeRight: self.swipeGesture.direction = .left
        case .unknown: break
        @unknown default: break
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.selectedImageView?.image = nil
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.selectedImageView?.image = image
        }
        self.selectedImageView = nil
        dismiss(animated: true)
    }
    
    // MARK: - Action
    @IBAction private func firstPhotoButtonTapped(_ sender: UIButton) {
        self.selectedImageView = self.firstPhoto
        showImagePicker()
    }
    
    @IBAction private func secondPhotoButtonTapped(_ sender: UIButton) {
        self.selectedImageView = self.secondPhoto
        showImagePicker()
    }
    
    @IBAction private func thirdPhotoButtonTapped(_ sender: UIButton) {
        self.selectedImageView = self.thirdPhoto
        showImagePicker()
    }
    
    @IBAction private func fourthPhotoButtonTapped(_ sender: UIButton) {
        self.selectedImageView = self.fourthPhoto
        showImagePicker()
    }
    
    @IBAction private func displayFirstLayout() {
        updateMontageLayout(for: .first)
    }
    
    @IBAction private func displaySecondLayout() {
        updateMontageLayout(for: .second)
    }
    
    @IBAction private func displayThirdLayout() {
        updateMontageLayout(for: .third)
    }
    
    // MARK: - Private
    private func setupGesture() {
        self.swipeGesture.addTarget(self, action: #selector(self.handleShareGesture))
        self.view.addGestureRecognizer(self.swipeGesture)
    }
    
    private func updateMontageLayout(for montageLayout: MontageLayout) {
        firstSelectedIcon.isHidden = true
        secondSelectedIcon.isHidden = true
        thirdSelectedIcon.isHidden = true
        
        topLayout.isHidden = false
        bottomLayout.isHidden = false
        
        switch montageLayout {
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
    
    private func captureMontageViewAsImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: photosMontageView.bounds.size)
        let image = renderer.image { ctx in
            photosMontageView.drawHierarchy(in: photosMontageView.bounds, afterScreenUpdates: true)
        }
        return image
    }
    
    // MARK: - Selector
    @objc private func handleShareGesture() {
        let capturedPhotoMontage = captureMontageViewAsImage()
        let activity = UIActivityViewController(activityItems: [capturedPhotoMontage], applicationActivities: nil)
        present(activity, animated: true)
    }
}
