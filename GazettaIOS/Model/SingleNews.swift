//
//  SingleNews.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 18.01.2021.
//

import Foundation

struct SingleNews {
    var label: String
    var content: String
    var publisher: String
    var when: String
    
    var publisherAndDate: String {
        return publisher + " • " + when
    }
}
