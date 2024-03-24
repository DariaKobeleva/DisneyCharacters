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
}
