//
//  vimeUpload.swift
//  Vs_GradItCollege
//
//  Created by admin on 06/07/24.
//

import Foundation

import Alamofire

class VimeoUploader {
    private let accessToken: String
    private let uploadURL = "https://api.vimeo.com/me/videos"
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    func createVideoResource(fileURL: URL, completion: @escaping (Result<String, Error>) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/json",
            "Accept": "application/vnd.vimeo.*+json;version=3.4"
        ]
        
        let fileSize = getFileSize(fileURL: fileURL)
        
        let parameters: [String: Any] = [
            "upload": [
                "approach": "tus",
                "size": "\(fileSize)"
            ]
        ]
        
        AF.request(uploadURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let data):
                if let json = data as? [String: Any],
                   let uploadData = json["upload"] as? [String: Any],
                   let uploadLink = uploadData["upload_link"] as? String {
                    completion(.success(uploadLink))
                    print("sucesssss",uploadLink)
                } else {
                    completion(.failure(NSError(domain: "VimeoUploader", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid upload link in response"])))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func uploadVideo(fileURL: URL, uploadLink: String) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Tus-Resumable": "1.0.0",
            "Content-Type": "application/offset+octet-stream"
        ]
        
        var request = URLRequest(url: URL(string: uploadLink)!)
        request.method = .patch
        request.setValue("1.0.0", forHTTPHeaderField: "Tus-Resumable")
        
        let fileData = try! Data(contentsOf: fileURL)
        let uploadTask = URLSession.shared.uploadTask(with: request, from: fileData) { data, response, error in
            if let error = error {
                print("Upload failed: \(error)")
            } else {
                print("Upload successful",error)
            }
        }
        uploadTask.resume()
    }
    
    private func getFileSize(fileURL: URL) -> UInt64 {
        do {
            let resourceValues = try fileURL.resourceValues(forKeys: [.fileSizeKey])
            if let fileSize = resourceValues.fileSize {
                return UInt64(fileSize)
            } else {
                return 0
            }
        } catch {
            print("Error retrieving file size: \(error)")
            return 0
        }
    }
}





enum UploadResult {
    case success(String)
    case failure(Error)
}


//func initiateVideoUpload(accessToken: String, completion: @escaping (UploadResult) -> Void) {
//    let endpoint = "https://api.vimeo.com/me/videos"
//    let headers: HTTPHeaders = [
//        
//        
//        "Authorization": "Bearer " + "8d74d8bf6b5742d39971cc7d3ffbb51a",
//        "Content-Type": "application/json"
//        
//        
//    ]
//    
//    
//    print("endpointendpoint",endpoint)
//    print("headersheaders",headers)
//    
//    // Initiate the upload
//    
//    print("VideoSizeCount",VideoSizeCount)
//    let parameters: [String: Any] = [
//           "upload": [
//               "approach": "tus",
//               "size": VideoSizeCount! // Replace with actual video file size
//           ],
//           "name": "YOUR_VIDEO_NAME", // Replace with actual video name
//           "description": "YOUR_VIDEO_DESCRIPTION" // Replace with actual video description
//       ]
//    
//    AF.request("https://api.vimeo.com/me/videos", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
//            .responseJSON { response in
//                switch response.result {
//                case .success(let value):
//                    if let json = value as? [String: Any],
//                       let upload = json["upload"] as? [String: Any],
//                       let uploadLink = upload["upload_link"] as? String {
//                        
//                        
//                        completion(.success(uploadLink))
//                    } else {
//                        completion(.failure(NSError(domain: "com.vimeo", code: -1, userInfo: [NSLocalizedDescriptionKey: "Upload link not found"])))
//                    }
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//    
//    //        uploadTask = URLSession.shared.uploadTask(with: request, from: resultNew as Data)
//    //              uploadTask.resume()
//    
//}
//
