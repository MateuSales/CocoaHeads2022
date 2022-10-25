//
//  File.swift
//  CocoaHeads2022
//
//  Created by user on 24/10/22.
//

import Foundation

final class API {
    static let shared = API()
    
    private init() { }
    
    func request(url: URL, completion: @escaping (String?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion("Mateus Sales")
        }
    }
}
