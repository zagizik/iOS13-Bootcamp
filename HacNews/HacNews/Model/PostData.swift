//
//  PostData.swift
//  HacNews
//
//  Created by Александр Банников on 18.07.2020.
//  Copyright © 2020 Александр Банников. All rights reserved.
//

import Foundation
 
struct Results: Decodable {
    let hits: [Post]
}

struct Post: Decodable, Identifiable {
    var id: String {
        return objectID
    }
    let objectID: String
    let title: String
    let points: Int
    let url: String?
}
