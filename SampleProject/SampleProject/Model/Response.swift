//
//  Response.swift
//  SampleProject
//
//  Created by benjamin.chrysostom on 28/05/22.
//

import Foundation

enum ResponseKeys: String, CodingKey {
    case status
    case articles
}

struct Response: Codable {
    // Response Keys
    var status: String = ""
    var articles: [Article] = []
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ResponseKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status) ?? ""
        articles = try values.decodeIfPresent([Article].self, forKey: .articles) ?? []
    }
}
