//
//  PokemonListDTO.swift
//  Sample App
//
//  Created by Andres Olguin on 23/08/2026.
//

import Foundation

struct PokemonListDTO: Decodable {
    let count: Int
    let next: URL?
    let previous: URL?
    let results: [PokemonListItemDTO]
}

struct PokemonListItemDTO: Decodable {
    let name: String
    let url: URL
}
