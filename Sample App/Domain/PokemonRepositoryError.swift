//
//  PokemonRepositoryError.swift
//  Sample App
//
//  Created by Andres Olguin on 23/08/2026.
//

import Foundation

enum PokemonRepositoryError: Error {
    case unexpectedResponseShape(context: String)
}
