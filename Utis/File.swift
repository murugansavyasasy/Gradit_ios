//
//  File.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 06/07/23.
//

import Alamofire

struct VideoUploadResponse: Decodable {
    // Define the response structure here
}

@discardableResult
private func videoUpload(jsonObject: [String: Any]?, head: String?, completion: @escaping (Result<VideoUploadResponse, Error>) -> Void) -> DataRequest? {
    let url = "https://api.vimeo.com/me/videos"
    let headers: HTTPHeaders = [
        "Content-Type": "application/json",
        "Accept": "application/vnd.vimeo.*+json;version=3.4",
        "Authorization": head ?? ""
    ]
    
    return AF.request(url, method: .post, parameters: jsonObject, encoding: JSONEncoding.default, headers: headers)
        .responseDecodable(of: VideoUploadResponse.self) { response in
            switch response.result {
            case .success(let videoUploadResponse):
                completion(.success(videoUploadResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
}

@discardableResult
private func patchVimeoVideoMetaData(ticketid: String?, videoid: String?, signatureid: String?, v6id: String?, redirecturl: String?, file: Data?, completion: @escaping (Result<Data, Error>) -> Void) -> DataRequest? {
    let url = "upload"
    let headers: HTTPHeaders = [
        "Tus-Resumable": "1.0.0",
        "Upload-Offset": "0",
        "Content-Type": "application/offset+octet-stream",
        "Accept": "application/vnd.vimeo.*+json;version=3.4"
    ]
    
    var queryParams = Parameters()
    queryParams["ticket_id"] = ticketid
    queryParams["video_file_id"] = videoid
    queryParams["signature"] = signatureid
    queryParams["v6"] = v6id
    queryParams["redirect_url"] = redirecturl
    
    return AF.request(url, method: .put, parameters: queryParams, encoding: URLEncoding.default, headers: headers)
        .uploadProgress { progress in
            // Handle upload progress updates here
            print("Upload Progress: \(progress.fractionCompleted)")
        }
        .responseData { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
}

