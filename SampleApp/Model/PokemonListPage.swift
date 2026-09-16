//
//  PokemonListPage.swift
//  Sample App
//
//  Created by Andres Olguin on 23/08/2026.
//

struct PokemonListPage {
    let items: [PokemonListItem]
    let nextOffset: Int?
    var hasMore: Bool { nextOffset != nil }
}
