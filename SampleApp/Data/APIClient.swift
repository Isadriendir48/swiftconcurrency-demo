//
//  APIClient.swift
//  Sample App
//
//  Created by Andres Olguin on 23/08/2026.
//

import Foundation

struct APIClient: HTTPClient {
    private let session: URLSession
    private let baseURL: URL
    private let decoder: JSONDecoder
    
    init(
        session: URLSession = .shared,
        baseURL: URL = URL(string: "https://pokeapi.co/api/v2/")!,
        decoder: JSONDecoder = .init()
    ) {
        self.session = session
        self.baseURL = baseURL
        self.decoder = decoder
    }
    
    func get<ResponseType: Decodable & Sendable>(
        path: String,
        queryItems: [URLQueryItem]
    ) async throws -> ResponseType {
        let url = baseURL
            .appending(path: path)
            .appending(queryItems: queryItems)
        
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw HTTPClientError.invalidResponse
            }
            
            if !(200..<300).contains(httpResponse.statusCode) {
                throw HTTPClientError.unsuccessfulResponse(
                    statusCode: httpResponse.statusCode,
                    data: data
                )
            }
            
            let result = try decoder.decode(ResponseType.self, from: data)
            
            return result
        } catch let error as DecodingError {
            throw HTTPClientError.decodingError(error: error)
        } catch let error as HTTPClientError {
            throw error
        } catch {
            throw HTTPClientError.transportError(error: error)
        }
    }
}
