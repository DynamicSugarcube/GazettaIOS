//
//  NewsEntity.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 14.01.2021.
//

import Foundation

class NewsEntity {
    
    let author: String
    let label: String
    let when: String
    let content: String
    
    init(author: String, label: String, when: String, content: String) {
        self.author = author
        self.label = label
        self.when = when
        self.content = content
    }
}
