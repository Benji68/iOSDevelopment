//
//  ConnectionHandler.swift
//  SampleProject
//
//  Created by benjamin.chrysostom on 28/05/22.
//

import Foundation
import UIKit

class ConnectionHandler {
    
    static let imageCache = NSCache<NSURL, UIImage>()
    
    static func getFeedResponse(url: URL, success: @escaping((Response) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            let urlRequest = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if error == nil, let data_ = data {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .useDefaultKeys
                    jsonDecoder.dateDecodingStrategy = .secondsSince1970
                    do {
                        let response = try jsonDecoder.decode(Response.self, from: data_)
                        success(response)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            task.resume()
        }
        
    }
    
    static func getImageFromUrl(src: URL, success: @escaping((UIImage) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            if let image = ConnectionHandler.imageCache.object(forKey: src as NSURL) {
                success(image)
            } else {
                let  urlRequest = URLRequest(url: src)
                let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                    if error == nil, let data_ = data {
                        if let image = UIImage(data: data_) {
                            ConnectionHandler.imageCache.setObject(image, forKey: src as NSURL)
                            success(image)
                        } else {
                            // Where could not form image from data
                            if let image = UIImage(named: "no-image-available") {
                                ConnectionHandler.imageCache.setObject(image, forKey: src as NSURL)
                                success(image)
                            }
                        }
                    }
                    // Where data is not available or error occurs
                    else if error != nil || data == nil {
                        if let image = UIImage(named: "no-image-available") {
                            ConnectionHandler.imageCache.setObject(image, forKey: src as NSURL)
                            success(image)
                        }
                    }
                }
                task.resume()
            }
        }
        
    }

}
