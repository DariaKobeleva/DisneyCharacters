//
//  NetworkManager.swift
//  DisneyCharacters
//
//  Created by Дарья Кобелева on 23.03.2024.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchCharacters(from url: URL, completion: @escaping(Result<[Character], AFError>) -> Void){
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let characters =  Character.getCharacters(from: value)
                    completion(.success(characters))
                case .failure(let error):
                    print(error)
                    completion(.failure(error))
                }
            }
    }
    
    func fetchData(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    print(error)
                    completion(.failure(error))
                }
            }
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
                //Или здесь должно дефолтное изображение, но непонятно, как его использовать
            case .defaultImage:
                return URL(string: "https://i.pinimg.com/originals/41/2e/de/412edea874be3c4faee187d522c30088.jpg")!
            }
        }
    }
}
