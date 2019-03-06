//
//  APIManager.swift
//  AjHW
//
//  Created by 劉芳瑜 on 2019/3/5.
//  Copyright © 2019 Fang-Yu. Liu. All rights reserved.
//

import Foundation

enum ApiResponseError: Error {
    case requestError
    case responseError
}

class APIManager {
    static let shared = APIManager()
    
    let host: String = "https://api.flickr.com"
    
    func getPhotos(_ text: String, _ perPage: Int, _ page: Int = 1,
                   _ completion: @escaping (Photos?, Error?) -> Void) {
        
        guard let url = URL(string: "\(host)/services/rest/?method=flickr.photos.search&api_key=\(Secret.flickrKey)&text=\(text)&per_page=\(perPage)&format=json&nojsoncallback=1&page=\(page)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(nil, ApiResponseError.requestError)
                return
            }
            
            guard let data = data else {
                completion(nil, ApiResponseError.responseError)
                return
            }
            
            let photos = self.decode(PhotoResponse.self, with: data)
            completion(photos?.photos, nil)
        }
        task.resume()
    }
    
    private func decode<T: Codable>(_ type: T.Type, with data: Data) -> T? {
        do {
            let decoder = JSONDecoder()
            
            return try decoder.decode(T.self, from: data)
            
        } catch (let error) {
            print("Decode failed", error.localizedDescription)
            return nil
        }
    }
}
