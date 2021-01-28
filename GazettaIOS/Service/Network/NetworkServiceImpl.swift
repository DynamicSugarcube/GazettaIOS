//
//  NetworkDataRetrieverImpl.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 21.01.2021.
//

import Alamofire
import Foundation

class NetworkServiceImpl: NetworkService {
    func getNewsArticles(on request: NetworkRequest, onComplete: @escaping ([NewsArticle]) -> Void) {
        getNewsApiResponse(request) { response in
            onComplete(response?.articles ?? [])
        }
    }

    private func getNewsApiResponse(_ request: NetworkRequest, onComplete: @escaping (NetworkResponse?) -> Void) {
        let url = request.build()

        AF.request(url, method: .get).responseJSON { rawResponse in
            guard let data = rawResponse.data else {
                print("Couldn't obtain network response data")
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let response = try decoder.decode(NetworkResponse.self, from: data)
                onComplete(response)
            } catch let error {
                print("Error occurred while retrieving data over network. Error message: \(error)")
            }
        }
    }
}
