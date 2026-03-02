//
//  FilePickerHelper.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 26/12/25.
//

import UIKit
import PhotosUI
import UniformTypeIdentifiers

final class FilePickerHelper: NSObject {

    // MARK: - Public
    var onFilesPicked: (([URL]) -> Void)?

    // MARK: - Private
    private weak var presentingVC: UIViewController?

    init(presentingVC: UIViewController) {
        self.presentingVC = presentingVC
    }
}

extension FilePickerHelper {

    func showOptions() {

        let alert = UIAlertController(title: "Add File", message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Camera", style: .default) { _ in
            self.openCamera()
        })

        alert.addAction(UIAlertAction(title: "Gallery", style: .default) { _ in
            if #available(iOS 14.0, *) {
                self.openGallery()
            }
        })

        alert.addAction(UIAlertAction(title: "Files", style: .default) { _ in
            if #available(iOS 14.0, *) {
                self.openFilePicker()
            } 
        })

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        presentingVC?.present(alert, animated: true)
    }
}

@available(iOS 14.0, *)
extension FilePickerHelper: UIDocumentPickerDelegate {

    func openFilePicker() {

        let picker = UIDocumentPickerViewController(
            forOpeningContentTypes: [
                .image,
                .pdf,
                .plainText,
                .rtf
            ],
            asCopy: true
        )

        picker.delegate = self
        picker.allowsMultipleSelection = true
        presentingVC?.present(picker, animated: true)
    }

    func documentPicker(_ controller: UIDocumentPickerViewController,
                        didPickDocumentsAt urls: [URL]) {

        onFilesPicked?(urls)
    }
}

@available(iOS 14.0, *)
extension FilePickerHelper: PHPickerViewControllerDelegate {

    func openGallery() {

        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 0

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        presentingVC?.present(picker, animated: true)
    }

    func picker(_ picker: PHPickerViewController,
                didFinishPicking results: [PHPickerResult]) {

        picker.dismiss(animated: true)

        var urls: [URL] = []
        let group = DispatchGroup()

        for result in results {
            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                group.enter()
                result.itemProvider.loadObject(ofClass: UIImage.self) { object, _ in
                    defer { group.leave() }

                    guard let image = object as? UIImage,
                          let url = self.saveImage(image) else { return }
                    urls.append(url)
                }
            }
        }

        group.notify(queue: .main) {
            self.onFilesPicked?(urls)
        }
    }
}

extension FilePickerHelper: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func openCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }

        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        presentingVC?.present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        picker.dismiss(animated: true)

        guard let image = info[.originalImage] as? UIImage,
              let url = saveImage(image) else { return }

        onFilesPicked?([url])
    }
}

private extension FilePickerHelper {

    func saveImage(_ image: UIImage) -> URL? {

        let fileName = "IMG_\(UUID().uuidString).jpg"
        let url = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(fileName)

        guard let data = image.jpegData(compressionQuality: 0.9) else { return nil }
        try? data.write(to: url)
        return url
    }
}
