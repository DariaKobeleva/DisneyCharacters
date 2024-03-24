//
//  Character.swift
//  DisneyCharacters
//
//  Created by Дарья Кобелева on 23.03.2024.
//

import Foundation

//Не смогла разобраться, как получить массив Character из поля data

//struct CharactersResponse: Decodable {
//    let data: [Character]
//    
//    init(charactersResponseDetails: [String: Any]) {
//        data = Character.getCharacters(from: charactersResponseDetails["data"] ?? [])
//        print(data)
//    }
//    
//    static func getCharactersResponse(from value: Any) -> CharactersResponse {
//        guard let charactersResponseDetails = value as? [String: Any] else { return []}
//        
//        return CharactersResponse(charactersResponseDetails: charactersResponseDetails)
//    }
//}


struct Character: Decodable {
    let name: String
    let films: [String]
    let imageUrl: String
    
    //Не совсем понимаю, куда добавить изображение по дефолту, в assets там image, а у меня url
    static let defaultImage = "https://i.pinimg.com/originals/41/2e/de/412edea874be3c4faee187d522c30088.jpg"
    
    func filmsList() -> String {
        films.joined(separator: ", ")
    }
    
    init(name: String, films: [String], imageUrl: String) {
        self.name = name
        self.films = films
        self.imageUrl = imageUrl
    }
    
    init(characterDetails: [String: Any]) {
        name = characterDetails["name"] as? String ?? ""
        films = characterDetails["films"] as? [String] ?? []
        imageUrl = characterDetails["imageUrl"] as? String ?? ""
    }
    
    static func getCharacters(from value: Any) -> [Character] {
        guard let charactersDetails = value as? [[String: Any]] else { return []}
        
        return charactersDetails.map { Character(characterDetails: $0)}
    }
}
