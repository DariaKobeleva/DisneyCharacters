//
//  NetworkManager.swift
//  DisneyCharacters
//
//  Created by Дарья Кобелева on 23.03.2024.
//

import Foundation
import Alamofire

enum APIEndpoint {
    case baseURL
    
    var url: URL {
        switch self {
        case .baseURL:
            return URL(string: "https://api.disneyapi.dev/character")!
        }
    }
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func fetchCharacters(_ completion: @escaping (Result<[Character], AFError>) -> Void){
        AF.request(APIEndpoint.baseURL.url)
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

