//
//  ReportViewController.swift
//  Viewable
//
//  Created by deokwon on 27/12/2019.
//  Copyright © 2019 Yeaeun. All rights reserved.
//

import Foundation

class ReportViewController: UIViewController {
    
    // MARK:- Property
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentImageView: UIImageView!
    @IBOutlet var contentTextView: UIReportTextView!
    @IBOutlet var confrimView: UIView!
    var selectedBuilding: Int?
    var selectedBuildingName: String = ""
    
    private let pickerController: UIImagePickerController = {
        let result = UIImagePickerController()
        result.allowsEditing = false
        result.sourceType = .photoLibrary
        result.mediaTypes = ["public.image"]
        return result
    }()
    
    // MARK:- Method
    @IBAction func didClickedContentImage(_ sender: Any) {
        present(pickerController, animated: true, completion: nil)
    }
    @IBAction func didClickedDismiss(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func didClickedSubmit(_ sender: Any) {
        confrimView.isHidden = false
    }

    @IBAction func didClickedRealSubmit(_ sender: Any) {
        confrimView.isHidden = true
        guard let buildingIdx = selectedBuilding else { return }
        if let title = titleTextField.text, let content = contentTextView.text {
            ReportService.shareInstance.sendReport(url: "\(APIService.BaseURL)/building/\(buildingIdx)/report", title: title, contents: content)
            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func didClickedNoSubmit(_ sender: Any) {
        confrimView.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerController.delegate = self
        touchToHideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationLabel.text = selectedBuildingName
    }
}

extension ReportViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            imageView.contentMode = .scaleAspectFit
            contentImageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
}
