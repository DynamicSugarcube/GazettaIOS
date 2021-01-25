//
//  NetworkDataRetrieverImpl.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 21.01.2021.
//

import Alamofire
import Foundation

class NetworkDataRetrieverImpl: NetworkDataRetriever {
    func getNewsArticles(on request: DataRequestProtocol, onComplete: @escaping ([NewsArticle]) -> Void) {
        guard let newsApiRequest = request as? NetworkRequestProtocol else {
            print("Couldn't obtain network response on provided request")
            return
        }
        getNewsApiResponse(newsApiRequest) { response in
            onComplete(response?.articles ?? [])
        }
    }
    
    private func getNewsApiResponse(_ request: NetworkRequestProtocol, onComplete: @escaping (NewsApiResponse?) -> Void) {
        let url = request.build()
        
        AF.request(url, method: .get).responseJSON { rawResponse in
            guard let data = rawResponse.data else {
                print("Couldn't obtain network response data")
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let response = try decoder.decode(NewsApiResponse.self, from: data)
                onComplete(response)
            } catch let error {
                print("Error occurred while retrieving data over network. Error message: \(error)")
            }
        }
    }
}
