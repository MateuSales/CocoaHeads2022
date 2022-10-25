//
//  File.swift
//  CocoaHeads2022
//
//  Created by user on 24/10/22.
//

import Foundation

final class LoadNameFromRemote: NameLoader {
    
    func load(completion: @escaping (Result<String, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion(.success("Mateus Sales"))
        }
    }
}
