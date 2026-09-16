//
//  FakeHTTPClient.swift
//  Sample App
//
//  Created by Andres Olguin on 25/08/2026.
//

@testable import Sample_App
import Foundation

struct FakeHTTPClient: HTTPClient {
    let payload: Data?
    let error: HTTPClientError?
    
    func get<ResponseType: Decodable & Sendable>(
        path: String,
        queryItems: [URLQueryItem]
    ) async throws -> ResponseType {
        if let error { throw error }
        
        guard let payload else { fatalError("No payload set") }
        
        return try JSONDecoder().decode(ResponseType.self, from: payload)
    }
}
