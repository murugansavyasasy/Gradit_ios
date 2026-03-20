//
//  ProfileEditVc.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 29/05/25.
//

import UIKit
import ObjectMapper

class ProfileEditVc: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, PHPickerViewControllerDelegate, Datepicker {
    func date(date: String) {
        
        let inputDate = date
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd MMM yyyy"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")

        if let date = inputFormatter.date(from: inputDate) {

            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd-MM-yyyy"

            let formattedDate = outputFormatter.string(from: date)
            dateOfBirthLbl.text = formattedDate
        }
//        DateOfBirth = date
//        dateOfBirthLbl.text = date
    }
    
    
    @IBOutlet weak var BackView: UIView!
    @IBOutlet weak var BackBtn: UIButton!
    @IBOutlet weak var DeletePictureBtn: UIButton!
    @IBOutlet weak var ProfileImg: UIImageView!
    @IBOutlet weak var CameraImage: UIImageView!
    @IBOutlet weak var NameLbl: UILabel!
    @IBOutlet weak var NameTextfield: UITextField!
    @IBOutlet weak var PhoneNoLbl: UILabel!
    @IBOutlet weak var PhoneTextfield: UITextField!
    @IBOutlet weak var EmailLbl: UILabel!
    @IBOutlet weak var EmailTextfield: UITextField!
    @IBOutlet weak var PlacementStatusLbl: UILabel!
    @IBOutlet weak var placemeNoteLbl: UILabel!
    @IBOutlet weak var placementTextfield: UITextField!
    @IBOutlet weak var Switch: UISwitch!
    @IBOutlet weak var ConsentLbl: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var Address: UILabel!
    @IBOutlet weak var AddressTextfield: UITextField!
    @IBOutlet weak var DOBview: UIView!
    @IBOutlet weak var dateOfBirthLbl: UILabel!
    @IBOutlet weak var dateOfBirthDefLbl: UILabel!
    
    
    
    
    var ProfileDetails: Profile?
    var selectedImage: UIImage?
    var collegeId : String?
    var AwsIamgePath: String?
    var IsUplaod = false
    var isEdited = false
    let defaults = UserDefaults.standard
    var memberId : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memberId = defaults.string(forKey: DefaultsKeys.memberid) ?? ""
        
        ProfileImg.layer.cornerRadius = ProfileImg.frame.width / 2
        ProfileImg.layer.borderWidth = 0.5
        ProfileImg.layer.borderColor = UIColor.systemGray.cgColor
        
        CameraImage.layer.cornerRadius = CameraImage.frame.width / 2
        
        BackBtn.setTitleFont(style: .medium, size: 18)
        DeletePictureBtn.setTitleFont(style: .regular, size: 12)
        cancelBtn.setTitleFont(style: .medium, size: 14)
        saveBtn.setTitleFont(style: .medium, size: 14)
        
        NameLbl.setFont(style: .medium, size: 15)
        PhoneNoLbl.setFont(style: .medium, size: 15)
        EmailLbl.setFont(style: .medium, size: 15)
        Address.setFont(style: .medium, size: 15)
        dateOfBirthDefLbl.setFont(style: .medium, size: 15)
        PlacementStatusLbl.setFont(style: .medium, size: 17)
        dateOfBirthLbl.setFont(style: .regular, size: FontSize.title)
       
        ConsentLbl.setFont(style: .regular, size: 14)
        
        DOBview.layer.borderWidth = 1
        DOBview.layer.borderColor = UIColor.systemGray4.cgColor
        DOBview.layer.cornerRadius = 10
        if #available(iOS 14.0, *) {
            DOBview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showDatePicker)))
        } else {
           
        }
        
        let fulltext = "Placement Status (Marked by placement officer)"
        
        let attributedString = NSMutableAttributedString(string: fulltext)
        attributedString.addAttributes([.font: UIFont(name: "Poppins-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .medium),.foregroundColor: UIColor.black], range: (fulltext as NSString).range(of: "Placement Status"))
        attributedString.addAttributes([.font: UIFont(name: "Poppins-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .regular), .foregroundColor: UIColor.darkGray] , range: (fulltext as NSString).range(of: "(Marked by placement officer)"))
        
        placemeNoteLbl.attributedText = attributedString
        
        cancelBtn.layer.cornerRadius = 10
        saveBtn.layer.cornerRadius = 10
        
        let defaults = UserDefaults.standard
        collegeId = defaults.string(forKey: DefaultsKeys.collegeid)
        
        SetData()
        
        let CameraTap = UITapGestureRecognizer(target: self, action: #selector(PickImage))
        CameraImage.addGestureRecognizer(CameraTap)
        CameraImage.isUserInteractionEnabled = true
        
        setupKeyboardObservers()
    }
    
    @available(iOS 14.0, *)
    @objc func showDatePicker() {
           let picker = DatePickerVC()
           picker.modalPresentationStyle = .overCurrentContext
           picker.delegate = self
           picker.date = dateOfBirthLbl.text
           picker.dateSelection = 2
           picker.view.backgroundColor = .black.withAlphaComponent(0.6)
          present(picker, animated: false)
       }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        BackView.applyBottomShadow()
    }
    
    func formatDate(
        _ dateString: String,
        from inputFormat: String,
        to outputFormat: String
    ) -> String {

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = inputFormat

        guard let date = formatter.date(from: dateString) else {
            return dateString   // return original string if parsing fails
        }

        formatter.dateFormat = outputFormat
        return formatter.string(from: date)
    }

    
    
    deinit {
           NotificationCenter.default.removeObserver(self)
       }

       // MARK: - Keyboard Notification Setup

       private func setupKeyboardObservers() {
           NotificationCenter.default.addObserver(self,
                                                  selector: #selector(keyboardWillShow),
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
           
           NotificationCenter.default.addObserver(self,
                                                  selector: #selector(keyboardWillHide),
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
       }

    func SetData(){
        
        let image_Url = URL(string: ProfileDetails?.memberImagePath ?? "")
        ProfileImg.sd_setImage(with: image_Url, placeholderImage: UIImage(systemName: "person.circle"))
        NameTextfield.text = ProfileDetails?.memberName
        PhoneTextfield.text = ProfileDetails?.memberPhoneNumber
        EmailTextfield.text = ProfileDetails?.memberstudentEmail
        placementTextfield.text =  ProfileDetails?.memberPlacementStatus
        Switch.setOn(ProfileDetails?.memberNotificationStatus ?? false, animated: true)
        AwsIamgePath = ProfileDetails?.memberImagePath
        dateOfBirthLbl.text = formatDate(ProfileDetails?.memberDob ?? "", from: "dd/MM/yyyy", to: "dd-MM-yyyy")
        AddressTextfield.text = "\(ProfileDetails?.memberPermanentAddress1 ?? ""), \(ProfileDetails?.memberPermanentAddressCity ?? ""), \(ProfileDetails?.memberPermanentAddressState ?? ""), \(ProfileDetails?.memberPermanentAddressPincode ?? ""), \(ProfileDetails?.memberPermanentAddressCountry ?? "")"
    }
    
    @IBAction func SaveBtnAct(_ sender: Any) {
        
//        if isEdited {
            
            AlertHelper.showOKCancelAlert(on: self, title: "Confirm", message: "Are you sure want to update Profile?",okTitle: "Yes",cancelTitle: "Cancel",okAction: {
                
                if self.IsUplaod {
                    self.uploadImageToAws{
                        
                        self.UpdateProfile()
                    }
                }else{
                    self.UpdateProfile()
                }
            },
            cancelAction: {
                
            }
            )
//        }else{
//            
//            AlertHelper.showOKAlert(on: self, title: "Alert" , message: "No Changes were made. Please modify the details before submitting.", okTitle: "ok",okAction: {
//                
//            })
//        }
    }
    
    @IBAction func DeletePicAct(_ sender: Any) {
        
        ProfileImg.image = UIImage(systemName: "person.circle")
        AwsIamgePath = ""
        IsUplaod = false
        isEdited = true
    }
    
    @IBAction func BackAct(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    @IBAction func PickImage() {
        
        let alert = UIAlertController(title: "Select Image", message: "", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: {_ in 
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {_ in 
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

               self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera() {
        
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("camera Not Available")
            return
        }
        
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    func openGallery() {
        
        if #available(iOS 14.0, *) {
            var config = PHPickerConfiguration()
            config.selectionLimit = 1
            config.filter = .images
            
            let picker = PHPickerViewController(configuration: config)
            picker.delegate = self
            self.present(picker, animated: true)
            
        }
    }
    
    @available(iOS 14.0, *)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true)
        
        guard let result = results.first else {return}
        
        if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
            
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                
                DispatchQueue.main.async {
                    
                    if let image = object as? UIImage {
                        
                        self?.ProfileImg.image = image
                        self?.selectedImage = image
                        self?.IsUplaod = true
                    }else {
                        print("Could not load image: \(error?.localizedDescription ?? "Unknown error")")
                    }
                }
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            self.ProfileImg.image = image
            self.selectedImage = image
            self.IsUplaod = true
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func UpdateProfile() {

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            var editRequest = Edit_Profile_Req()
            editRequest.idMember = Int(self.memberId ?? "")
            editRequest.memberName = self.NameTextfield.text
            editRequest.primaryMobileNo = self.PhoneTextfield.text
            editRequest.studentEmail = self.EmailTextfield.text
            editRequest.imagePath = self.AwsIamgePath
            editRequest.placementStatus = self.placementTextfield.text
            editRequest.notificationPlacement = self.Switch.isOn
            editRequest.dob = self.dateOfBirthLbl.text
            editRequest.residentialAddressLine1 = self.AddressTextfield.text

            APiCallManager.shared.callApi(
                url: APIEndpoints.profile_add_edit_profile,
                httpMethod: .post,
                isBaseUrl: false,
                queryParam: nil,
                requestBody: editRequest
            ) { [weak self] (result: Result<Edit_Profile_Response, Error>) in
                
                guard let self = self else { return }

                DispatchQueue.main.async {
                    
                    switch result {
                        
                    case .success(let response):
                        
                        if response.status == true {
                            
                            let alert = UIAlertController(
                                title: "Success",
                                message: "Profile Updated Successfully",
                                preferredStyle: .alert
                            )

                            alert.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
                                self.dismiss(animated: true)
                            })

                            self.present(alert, animated: true)
                            
                        } else {
                            
                            let alert = UIAlertController(
                                title: "Failed",
                                message: "Something went wrong",
                                preferredStyle: .alert
                            )

                            alert.addAction(UIAlertAction(title: "Ok", style: .default))
                            self.present(alert, animated: true)
                        }
                        
                    case .failure:
                        
                        let alert = UIAlertController(
                            title: "Error",
                            message: "Request failed",
                            preferredStyle: .alert
                        )

                        alert.addAction(UIAlertAction(title: "Ok", style: .default))
                        self.present(alert, animated: true)
                    }
                }
            }
        }
    }

    
    func uploadAWS(image: UIImage, collegeId: String, completion: @escaping (Result<String, Error>) -> Void) {
        // Create unique filename
        let timestamp = Int(Date().timeIntervalSince1970)
        let imageName = "vc_\(timestamp).png"
        let imageURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(imageName)

        // Save image to temp directory
        guard let data = image.jpegData(compressionQuality: 0.9) else {
            print("Failed to create image data")
            completion(.failure(NSError(domain: "ImageConversion", code: 0, userInfo: nil)))
            return
        }

        do {
            try data.write(to: imageURL)
        } catch {
            print("Error writing image data to file: \(error)")
            completion(.failure(error))
            return
        }

        // Fetch presigned URL
        AWSPreSignedURL.shared.fetchPresignedURL(
            bucket: DefaultsKeys.S3BucketName,
            fileName: imageURL,
            bucketPath: collegeId,
            fileType: "image"
        ) { result in
            switch result {
            case .success(let awsResponse):
                guard let presignedURLString = awsResponse.data?.presignedUrl,
                      let presignedURL = URL(string: presignedURLString),
                      let uploadedURL = awsResponse.data?.fileUrl else {
                    print("Invalid AWS response")
                    completion(.failure(NSError(domain: "PresignedURLError", code: 0, userInfo: nil)))
                    return
                }

                // Upload image
                AWSUploadManager.shared.uploadImageToAWS(image: image, presignedURL: presignedURLString) { result in
                    switch result {
                    case .success:
                        print("✅ Image uploaded successfully: \(uploadedURL)")
                        completion(.success(uploadedURL))
                    case .failure(let error):
                        print("❌ Failed to upload image: \(error.localizedDescription)")
                        completion(.failure(error))
                    }
                }

            case .failure(let error):
                print("❌ Error fetching presigned URL: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }


    func uploadImageToAws(completion : @escaping() -> Void) {
        
        guard let selectedImage = self.selectedImage else {
            print("No image selected.")
            return
        }
        
        uploadAWS(image: selectedImage, collegeId: collegeId ?? "") { result in
            switch result {
            case .success(let url):
                print("Image uploaded to: \(url)")
                self.AwsIamgePath = url
                self.isEdited = true
                completion()
            case .failure(let error):
                print("Upload failed: \(error)")
            }
        }
    }
}

extension ProfileEditVc: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isEdited = true
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
           guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
           let keyboardHeight = keyboardFrame.cgRectValue.height

           // Find the active field
           guard let activeField = view.findFirstResponder() as? UITextField else { return }

           // Convert field frame to view coordinates
           let fieldFrameInView = activeField.convert(activeField.bounds, to: self.view)

           let bottomOfField = fieldFrameInView.origin.y + fieldFrameInView.height
           let viewHeight = self.view.frame.height
           let visibleHeight = viewHeight - keyboardHeight

           // If field is hidden by keyboard, shift the view
           if bottomOfField > visibleHeight {
               let offset = bottomOfField - visibleHeight + 20 // Add a small padding
               self.view.frame.origin.y = CGFloat(-offset)
           }
       }

       @objc private func keyboardWillHide(notification: NSNotification) {
           self.view.frame.origin.y = 0
       }

       // Dismiss keyboard on outside tap
       override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
       }
}


import UIKit
import PhotosUI
import KRProgressHUD
import AWSS3

extension UIView {
    func applyBottomShadow(
        color: UIColor = .systemGray3,
        opacity: Float = 0.5,
        radius: CGFloat = 2,
        offset: CGSize = CGSize(width: 0, height: 2),
        shadowHeight: CGFloat = 2
    ) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius

        let width = self.bounds.width
        let height = self.bounds.height

        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: 0, y: height))
        shadowPath.addLine(to: CGPoint(x: width, y: height))
        shadowPath.addLine(to: CGPoint(x: width, y: height + shadowHeight))
        shadowPath.addLine(to: CGPoint(x: 0, y: height + shadowHeight))
        shadowPath.close()

        self.layer.shadowPath = shadowPath.cgPath
    }
}

extension UIView {
    func findFirstResponder() -> UIView? {
        if self.isFirstResponder { return self }
        for subview in self.subviews {
            if let responder = subview.findFirstResponder() {
                return responder
            }
        }
        return nil
    }
}
