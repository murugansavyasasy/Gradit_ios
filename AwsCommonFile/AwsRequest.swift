//
//  AwsRequest.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 24/12/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import Foundation
import KRProgressHUD

class AwsReq {

    static func call_request(
        param: [String: Any],
        completion_handler: @escaping (Result<AwsResps, Error>) -> Void
    ) {

        KRProgressHUD.show()

        guard var components = URLComponents(string: get_url()) else {
            DispatchQueue.main.async { KRProgressHUD.dismiss() }
            completion_handler(.failure(NetworkError.invalidURL))
            return
        }

        // ✅ Convert params → query items
        components.queryItems = param.map {
            URLQueryItem(name: $0.key, value: "\($0.value)")
        }

        guard let url = components.url else {
            DispatchQueue.main.async { KRProgressHUD.dismiss() }
            completion_handler(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        print("🌍 AWS URL:", url.absoluteString)

        URLSession.shared.dataTask(with: request) { data, response, error in

            DispatchQueue.main.async {
                KRProgressHUD.dismiss()
            }

            if let error = error {
                completion_handler(.failure(error))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completion_handler(.failure(NetworkError.invalidResponse))
                return
            }

            print("📥 AWS Status Code:", response.statusCode)

            guard let data = data else {
                completion_handler(.failure(NetworkError.noData))
                return
            }

            if let responseString = String(data: data, encoding: .utf8) {
                print("📩 AWS Response:", responseString)
            }

            do {
                let decoded = try JSONDecoder().decode(AwsResps.self, from: data)
                completion_handler(.success(decoded))
            } catch {
                completion_handler(.failure(error))
            }

        }.resume()
    }

    private static func get_url() -> String {
        return "\(Constant.Aws_baseUrl)get-s3-presigned-url"
    }
}
