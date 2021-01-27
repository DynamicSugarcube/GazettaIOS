//
//  TableSection.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 26.01.2021.
//

import Foundation

enum TableSection: Int {
    case topStories = 0, latestNews, total

    var sectionName: String {
        switch self {
        case .topStories:
            return "Top Stories"
        case .latestNews:
            return "Latest News"
        default:
            return "Unknown Section"
        }
    }

    var sectionButtonLabel: String {
        switch self {
        case .topStories:
            return "More"
        case .latestNews:
            return "See All"
        default:
            return "Unknown Button"
        }
    }
}
