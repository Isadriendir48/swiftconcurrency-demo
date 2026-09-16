//
//  HTTPClient.swift
//  Sample App
//
//  Created by Andres Olguin on 23/08/2026.
//

import Foundation

protocol HTTPClient: Sendable {
    func get<ResponseType: Decodable & Sendable>(
        path: String,
        queryItems: [URLQueryItem]
    ) async throws -> ResponseType
}
