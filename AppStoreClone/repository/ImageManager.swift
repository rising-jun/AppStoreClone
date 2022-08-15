//
//  ImageManager.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/11.
//

import Foundation

final class ImageManager { }
extension ImageManager: ImageManagable {
    func fetchImage(from url: String, completion: @escaping (Result<Data, APIError>) -> Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                return completion(.failure(.notConnect))
            }
            
            guard let httpURLResponse = response as? HTTPURLResponse else {
                return completion(.failure(.httpResponse))
            }
            
            guard (200...299) ~= httpURLResponse.statusCode else {
                return completion(.failure(.httpURLResponse))
            }
            
            guard let data = data else {
                return completion(.failure(.nilData))
            }
            completion(.success(data))
        }.resume()
    }
}
protocol ImageManagable {
    func fetchImage(from url: String, completion: @escaping (Result<Data, APIError>) -> Void)
}
