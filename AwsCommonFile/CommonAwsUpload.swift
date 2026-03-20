//
//  CommonAwsUpload.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 25/12/24.

import Foundation
import ObjectMapper
class AWSUploadManager {
    static let shared = AWSUploadManager()
    
    private init() {} // Prevent external initialization

    func uploadImageToAWS(image: UIImage, presignedURL: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.9),
              let url = URL(string: presignedURL) else {
            completion(.failure(NSError(domain: "InvalidInput", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid image or URL"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        // Optional: Remove Content-Type header if needed
        request.setValue("image/jpeg", forHTTPHeaderField: "Content-Type")

        print("Uploading to:", presignedURL)
        print("Request Headers:", request.allHTTPHeaderFields ?? "No Headers")
        print("Image Data Size:", imageData.count, "bytes")

        let uploadTask = URLSession.shared.uploadTask(with: request, from: imageData) { _, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print("Status Code:", httpResponse.statusCode)

                if httpResponse.statusCode == 200 {
                    completion(.success(presignedURL))
                } else {
                    let errorDescription = "Failed with status code: \(httpResponse.statusCode)"
                    let uploadError = NSError(domain: "UploadError", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorDescription])
                    completion(.failure(uploadError))
                }
            } else {
                print("Failed to retrieve HTTP response.")
                let unknownError = NSError(domain: "UploadError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown response"])
                completion(.failure(unknownError))
            }

            if let error = error {
                print("Error:", error.localizedDescription)
                completion(.failure(error))
                return
            }
        }

        uploadTask.resume()
    }

    
    
    func uploadPDFAWSUsingPresignedURL(pdfData: Data, presignedURL: String, completion: @escaping (Result<String, Error>) -> Void) {
        // Validate URL
        guard let url = URL(string: presignedURL) else {
            completion(.failure(NSError(domain: "InvalidInput", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        // Create a URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/pdf", forHTTPHeaderField: "Content-Type")

        // Use URLSession to upload the PDF
        let uploadTask = URLSession.shared.uploadTask(with: request, from: pdfData) { _, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("PDF Upload successful!")
                completion(.success(presignedURL)) // Returning the presigned URL as confirmation
            } else {
                let uploadError = NSError(domain: "UploadError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed with an unexpected response"])
                completion(.failure(uploadError))
            }
        }

        // Start the upload task
        uploadTask.resume()
    }
}

class AWSPreSignedURL {

    static let shared = AWSPreSignedURL()

    private init() {}

    func fetchPresignedURL(
        bucket: String,
        fileName: URL,
        bucketPath: String,
        fileType: String,
        completion: @escaping (Result<AwsResps, Error>) -> Void
    ) {

        let fname = fileName.lastPathComponent
        print("fname \(fname)")

        let datePath = getCurrentDateString()
        let fullBucketPath = "\(bucketPath)/\(datePath)"

        let uniqueFileName = UUID().uuidString + "_" + fname

        let param: [String: Any] = [
            "bucket": bucket,
            "fileName": uniqueFileName,
            "bucketPath": fullBucketPath,
            "fileType": fileType
        ]

        AwsReq.call_request(param: param) { result in

            switch result {

            case .success(let awsImage):

                if awsImage.status == 1 {
                    completion(.success(awsImage))
                } else {

                    let error = NSError(
                        domain: "AWSFetchError",
                        code: 0,
                        userInfo: [NSLocalizedDescriptionKey: awsImage.message ?? "Unknown error"]
                    )

                    completion(.failure(error))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getCurrentDateString(format: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: Date())
    }
}


#if canImport(UniformTypeIdentifiers)
import UniformTypeIdentifiers
#endif
struct MimeHelper {
    
    static func mimeType(for fileUrl: URL) -> String {
        
        let ext = fileUrl.pathExtension.lowercased()
        guard !ext.isEmpty else { return "application/octet-stream" }
        
        if #available(iOS 14.0, *) {
            if let utType = UTType(filenameExtension: ext),
               let mimeType = utType.preferredMIMEType {
                return  mimeType
            }
        }
        
        // iOS 13 fallback (extension-based)
        switch ext {
            
            // Images
        case "jpg", "jpeg":
            return "image/jpeg"
        case "png":
            return "image/png"
        case "gif":
            return "image/gif"
        case "webp":
            return "image/webp"
        case "heic":
            return "image/heic"
            
            // Documents
        case "pdf":
            return "application/pdf"
        case "doc":
            return "application/msword"
        case "docx":
            return "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
        case "xls":
            return "application/vnd.ms-excel"
        case "xlsx":
            return "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
            
            // Text
        case "txt":
            return "text/plain"
            
        default:
            return "application/octet-stream"
        }
    }
}
