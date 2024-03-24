//
//  NetworkManager.swift
//  DisneyCharacters
//
//  Created by Дарья Кобелева on 23.03.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    func fetch(from url: URL?, completion: @escaping (Result<CharactersResponse, NetworkError>) -> Void) {
        guard let url  else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data, error == nil else {
                completion(.failure(.noData))
                return
            }
            do {
                let characters = try JSONDecoder().decode(CharactersResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(characters))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
    
    func fetchImage(from url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }.resume()
    }
}

// MARK: - APIEndpoint
extension NetworkManager {
    enum APIEndpoint {
        case baseURL
        case defaultImage
        
        var url: URL {
            switch self {
            case .baseURL:
                return URL(string: "https://api.disneyapi.dev/character")!
                //Или здесь дефолтное изображение, но непонятно, как его использовать
            case .defaultImage:
                return URL(string: "https://i.pinimg.com/originals/41/2e/de/412edea874be3c4faee187d522c30088.jpg")!
            }
        }
    }
}
