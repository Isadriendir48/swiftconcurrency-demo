//
//  PokemonListItem.swift
//  Sample App
//
//  Created by Andres Olguin on 23/08/2026.
//

import Foundation

struct PokemonListItem: Identifiable {
    let id: Int
    let name: String
    let detailURL: URL
    let spriteURL: URL?
}
