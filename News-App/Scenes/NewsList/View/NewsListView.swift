//
//  NewsListView.swift
//  News-App
//
//  Created by Ramzy on 28/07/2021.
//

import SwiftUI

struct NewsListView: View {
    
    @Environment(\.openURL) var openURL
    @StateObject var viewModel = NewsListViewModelImpl(usecase: NewsUsecaseImpl())
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .failed(let error):
                ErrorView(error: error, handler: viewModel.fetchNews)
            case .success(let articles):
                NavigationView {
                    List(articles) { article in
                        ArticleView(article: article)
                            .onTapGesture {
                                open(url: article.url)
                            }
                    }
                    .navigationTitle(Text("News"))
                }
            }
        }.onAppear(perform: viewModel.fetchNews)
    }
    
    func open(url: String?) {
        guard let url = url,
              let link = URL(string: url) else {
            return
        }
        
        openURL.callAsFunction(link)
    }
}

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView()
    }
}
