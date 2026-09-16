//
//  URL+QueryItemValue.swift
//  Sample App
//
//  Created by Andres Olguin on 23/08/2026.
//

import Foundation

extension URL {
    func queryItemValue(for key: String) -> String? {
        guard
            let url = URLComponents(url: self, resolvingAgainstBaseURL: false)
        else { return nil }
        
        return url.queryItems?.first(where: { $0.name == key })?.value
    }
}
