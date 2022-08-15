//
//  AppStoreRepository.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/11.
//

import Foundation

struct ServiceRepositoryImpl {
    private let session: URLSession
    init(session: URLSession) {
        self.session = session
    }
}
extension ServiceRepositoryImpl: ServiceRepository {
    func requestAPI<T: Decodable>(api: BaseAPI, decodeType: T.Type,completion: @escaping(Result<T ,APIError>) -> Void) {
        guard let url = api.url else {
            return completion(.failure(.invalidURL))
        }
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = api.method
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = session.dataTask(with: urlRequest) { data, response, error in
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
            
            guard let decodedData = try? jsonDecode(data: data, decodeType: T.self) else {
                return completion(.failure(.decode))
            }
            completion(.success(decodedData))
        }
        task.resume()
    }
    
    private func jsonDecode<T: Decodable>(data: Data, decodeType: T.Type) throws -> T {
        guard let decodeEntity = try? JSONDecoder().decode(decodeType.self, from: data) else {
            throw APIError.decode
        }
        return decodeEntity
    }
}

protocol ServiceRepository {
    func requestAPI<T: Decodable>(api: BaseAPI, decodeType: T.Type,completion: @escaping(Result<T ,APIError>) -> Void)
}
