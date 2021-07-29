//
//  NewsListViewModel.swift
//  News-App
//
//  Created by Ramzy on 28/07/2021.
//

import Foundation
import Combine

protocol NewsListViewModel {
    func fetchNews()
}

class NewsListViewModelImpl: ObservableObject,NewsListViewModel{
    
    private let usecase: NewsUsecase
    
    private(set) var articles = [Article]()
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var state: ResultState = .loading
    
    init(usecase: NewsUsecase) {
        self.usecase = usecase
    }
    
    func fetchNews() {
        let cancellable = usecase
            .fetchNews(from: .getNews)
            .sink { result in
                switch result {
                case .finished:
                    self.state = .success(content: self.articles)
                case .failure(let error):
                    self.state = .failed(error: error)
                }
            } receiveValue: { response in
                self.articles = response.articles
            }
        self.cancellables.insert(cancellable)
    }
}
