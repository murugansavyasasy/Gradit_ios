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
        
        if let body = requestBody {
            do {
                request.httpBody = try JSONEncoder().encode(body)
            }catch {
                completion(.failure(error))
            }
        }
        
        print("🌍 URL:", url.absoluteString)
        print("📡 Method:", httpMethod.rawValue)
        print("📦 Headers:", request.allHTTPHeaderFields ?? [:])
        if let body = request.httpBody,
           let json = String(data: body, encoding: .utf8) {
            print("📤 Request Body:", json)
        }

        URLSession.shared.dataTask(with: request){ data, response, error in
            
            if let error = error {
                self.completionOnMain(.failure(error), completion: completion)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                self.completionOnMain(.failure(NetworkError.invalidResponse), completion: completion)
                return
            }
            print("📥 Status Code:", response.statusCode)
            
            guard let data = data else {
                self.completionOnMain(.failure(NetworkError.noData),completion: completion)
               
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8){
                print("📩 Response:", responseString)
            }
            
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
