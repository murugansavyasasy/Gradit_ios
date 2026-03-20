//
//  APiCallManager.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 03/03/26.
//
import Foundation

final class APiCallManager {
    
    static let shared = APiCallManager()
    
    private init() {}
    
    let defaultHeaders: [String: String] = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]
    
    func callApi<T:Decodable> (
        url: String,
        httpMethod: HTTPMethod,
        isBaseUrl: Bool? = true,
        queryParam: [String:Any]?,
        requestBody: Encodable?,
        completion: @escaping (Result<T,Error>) -> Void
    ){
        var logOutput = "\n================ API CALL START ================\n"
        
        let baseUrl = (isBaseUrl ?? false) ? Constant.baseUrl : Constant.Resume_baseUrl
        
        var componets = URLComponents(string: baseUrl+url)
        
        if let queryParams = queryParam {
            componets?.queryItems = queryParams.map {
                URLQueryItem(name: $0.key, value: String(describing: $0.value))
            }
        }
        
        guard let url = componets?.url else {
            completionOnMain(.failure(NetworkError.invalidURL), completion: completion)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        logOutput += "🌍 URL: \(url.absoluteString)\n"
        logOutput += "📡 Method: \(httpMethod.rawValue)\n"
        logOutput += "📦 Headers: \(request.allHTTPHeaderFields ?? [:])\n"
        
        if let body = requestBody {
            do {
                request.httpBody = try JSONEncoder().encode(body)
            }catch {
                completion(.failure(error))
            }
        }
        
        if let body = request.httpBody,
           let json = String(data: body, encoding: .utf8) {
            logOutput += "📤 Request Body: \(json)\n"
        }

        URLSession.shared.dataTask(with: request){ data, response, error in
            
            if let error = error {
                logOutput += "❌ Error: \(error.localizedDescription)\n"
                logOutput += "================ API CALL END ================\n"
                print(logOutput)
                
                self.completionOnMain(.failure(error), completion: completion)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                logOutput += "❌ Invalid Response\n"
                logOutput += "================ API CALL END ================\n"
                print(logOutput)
                
                self.completionOnMain(.failure(NetworkError.invalidResponse), completion: completion)
                return
            }
            
            logOutput += "📥 Status Code: \(response.statusCode)\n"
            
            guard let data = data else {
                logOutput += "❌ No Data Received\n"
                logOutput += "================ API CALL END ================\n"
                print(logOutput)
                
                self.completionOnMain(.failure(NetworkError.noData),completion: completion)
               
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8){
                logOutput += "📩 Response: \(responseString)\n"
            }
            
            logOutput += "================ API CALL END ================\n"
            
            print(logOutput)
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
               
                self.completionOnMain(.success(decoded),completion: completion)
                
            }catch{
               
                self.completionOnMain(.failure(error), completion: completion)
                
            }
        }.resume()
        
    }
    
    func completionOnMain<T>(
        _ result : Result<T,Error>,
        completion: @escaping (Result<T,Error>) -> Void
    ) {
        DispatchQueue.main.async {
            completion(result)
        }
        
    }
}


enum HTTPMethod: String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum NetworkError: Error {
    
    case invalidURL
    case noInternet
    case serverError(statusCode: Int)
    case decodingError
    case invalidResponse
    case noData
    case encodingError
}

extension NetworkError: LocalizedError {
    
    var errorDescription: String? {
        
        switch self {
            
        case .invalidURL:
            return "Invalid request. Please try again."
            
        case .noInternet:
            return "No internet connection. Please check your network."
            
        case .serverError(let code):
            return "Server error (\(code)). Please try again later."
            
        case .decodingError:
            return "Unexpected response from server."
            
        case .invalidResponse:
            return "Invalid response from server."
            
        case .noData:
            return "No data received from server."
            
        case .encodingError:
            return "Failed to send request."
        }
    }
}


//final class APiCallManager {
//    
//    static let shared = APiCallManager()
//    
//    private init() {}
//    
//    func ApiCall<T:Decodable> (
//        urlString: String,
//        method: HTTPMethod = .get,
//        headers:[String:String]? = nil,
//        body: Data? = nil,
//        completion : @escaping (Result<T,Error>) -> Void
//    ){
//        guard let url = URL(string: urlString) else {
//            completion(.failure(NetworkError.invalidURL))
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = method.rawValue
//        request.httpBody = body
//        if let headers = headers {
//            headers.forEach {key, value in
//                request.setValue(value, forHTTPHeaderField: key)
//            }
//        }
//        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse else {
//                completion(.failure(NetworkError.invalidResponse))
//                return
//            }
//            
//            guard (200...299).contains(response.statusCode) else {
//                completion(.failure(NetworkError.serverError(statusCode: response.statusCode)))
//                return
//            }
//            
//            guard let data = data else {
//                completion(.failure(NetworkError.serverError(statusCode: response.statusCode)))
//                return
//            }
//            do {
//                 let result = try JSONDecoder().decode(T.self, from: data)
//                    DispatchQueue.main.async {
//                        completion(.success(result))
//                    }
//                
//            } catch {
//                
//                completion(.failure(NetworkError.decodingError))
//            }
//            
//        }.resume()
//        
//    }
//}
//
//
//
//enum HTTPMethod: String {
//    case get = "GET"
//    case post = "POST"
//    case put = "PUT"
//    case delete = "DELETE"
//}
//
//enum NetworkError: Error {
//    case invalidURL
//    case noInternet
//    case serverError(statusCode: Int)
//    case decodingError
//    case invalidResponse
//}
//
//
//

final class MultipartManager {
    
    static let shared = MultipartManager()
    private init() {}
    
    func uploadVoice(
        url: String,
        fileURL: URL,
        infoJSONString: String,
        completion: @escaping (Result<[String: Any], Error>) -> Void
    ) {
        
        guard let requestURL = URL(string: url) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let boundary = UUID().uuidString
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        do {
            // ✅ FILE DATA
            let fileData = try Data(contentsOf: fileURL)
            print("📦 File size:", fileData.count)
            
            // ---------------------------
            // ✅ INFO PART (IMPORTANT)
            // ---------------------------
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"Info\"\r\n")
            body.append("Content-Transfer-Encoding: binary\r\n")
            body.append("Content-Type: multipart/form-data; charset=utf-8\r\n\r\n")
            body.append(infoJSONString)
            body.append("\r\n")
            
            // ---------------------------
            // ✅ FILE PART (IMPORTANT)
            // ---------------------------
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"voice\"; filename=\"voice.mp3\"\r\n")
            body.append("Content-Type: multipart/form-data\r\n\r\n")
            body.append(fileData)
            body.append("\r\n")
            
            // ---------------------------
            // ✅ CLOSE BOUNDARY
            // ---------------------------
            body.append("--\(boundary)--\r\n")
            
        } catch {
            completion(.failure(error))
            return
        }
        
        request.httpBody = body
        
        print("🌍 URL:", url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.noData))
                }
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("📩 Response:", responseString)
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                DispatchQueue.main.async {
                    completion(.success(json ?? [:]))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
