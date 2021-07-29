//
//  NewsUsecase.swift
//  News-App
//
//  Created by Ramzy on 28/07/2021.
//

import Foundation
import Combine

protocol NewsUsecase {
    func fetchNews(from endpoint: NewsAPI) -> AnyPublisher<NewsResponse,APIError>
}


struct NewsUsecaseImpl: NewsUsecase {
    func fetchNews(from endpoint: NewsAPI) -> AnyPublisher<NewsResponse, APIError> {
        
        return URLSession
            .shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError{ _ in APIError.unknown}
            .flatMap{data,response -> AnyPublisher<NewsResponse,APIError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                if (200...299).contains(response.statusCode) {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    return Just(data)
                        .decode(type: NewsResponse.self, decoder: jsonDecoder)
                        .mapError { _ in APIError.decodingError }
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }

}
