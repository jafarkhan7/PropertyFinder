//
//  BundleExtension.swift
//  PropertyFinder
//
//  Created by Jafar khan on 11/09/2024.
//

import Foundation
import Combine

enum ErrorItem: Error {
    case failedToLocate
    case failedToLoad
    case failedToDecode
    
    var errorDescription: String {
        switch self {
        case .failedToLocate, .failedToLoad:
           return "We are having difficulties"
        case .failedToDecode:
           return "Something went wrong"
        }
    }
}

extension Bundle {
        
    func decode<T: Codable>(codable: T.Type, _ file: String) -> Future<[T],Error> {
      
      return Future { promise in
          // 1. Locate the json file
          guard let url = self.url(forResource: file, withExtension: nil) else {
             return promise(.failure(ErrorItem.failedToLocate))
          }
          
          // 2. Create a property for the data
          guard let data = try? Data(contentsOf: url) else {
             return promise(.failure(ErrorItem.failedToLoad))
          }
            
            let decoder = JSONDecoder()
              
              do {
                  let loaded = try decoder.decode([T].self, from: data)
                return promise(.success(loaded))
              }
            catch {
                print(error)
                promise(.failure(ErrorItem.failedToDecode))
            }
      }
   
  }
}
