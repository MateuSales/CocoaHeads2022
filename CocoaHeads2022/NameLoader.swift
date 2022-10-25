//
//  NameLoader.swift
//  CocoaHeads2022
//
//  Created by user on 24/10/22.
//

public protocol NameLoader {
    func load(completion: @escaping (Result<String, Error>) -> Void)
}
