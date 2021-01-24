//
//  DependencyProvider.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 24.01.2021.
//

import Swinject
import Foundation

class DependencyProvider {
    private static var sharedContainer: Container = {
        let container = Container()
        
        let networkDataRetriever = NetworkDataRetrieverImpl()
        
        container.register(TopStoriesViewModel.self) { _ in
            TopStoriesViewModel(networkDataRetriever: networkDataRetriever)
        }.inObjectScope(.container)
        container.register(LatestNewsViewModel.self) { _ in
            LatestNewsViewModel(networkDataRetriever: networkDataRetriever)
        }.inObjectScope(.container)
        
        return container
    }()
    
    static func getTopStoriesViewModel() -> TopStoriesViewModel! {
        return sharedContainer.resolve(TopStoriesViewModel.self)
    }
    
    static func getLatestNewsViewModel() -> LatestNewsViewModel! {
        return sharedContainer.resolve(LatestNewsViewModel.self)
    }
}
