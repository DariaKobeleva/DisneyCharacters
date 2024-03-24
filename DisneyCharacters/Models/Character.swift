//
//  Character.swift
//  DisneyCharacters
//
//  Created by Дарья Кобелева on 23.03.2024.
//

import Foundation

struct CharactersResponse: Decodable {
    let info: Info
    let data: [Character]
}

struct Info: Decodable {
    let totalPages: Int
    //TODO: - Add other info
}

struct Character: Decodable {
    let name: String
    let films: [String]
    let imageUrl: URL?
    
    //Не совсем понимаю, куда добавить изображение по дефолту, в assets там image, а у меня url
    static let defaultImage = "https://i.pinimg.com/originals/41/2e/de/412edea874be3c4faee187d522c30088.jpg"
    
    func filmsList() -> String {
        films.joined(separator: ", ")
    }
}
