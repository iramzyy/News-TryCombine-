//
//  NewsResponse.swift
//  News-App
//
//  Created by Ramzy on 28/07/2021.
//

import Foundation

struct NewsResponse: Codable {
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable, Identifiable {
    let id = UUID()
    let author: String?
    let url: String
    let source, title: String
    let articleDescription: String?
    let image: String?
    let date: Date

    enum CodingKeys: String, CodingKey {
        case author, url, source, title
        case articleDescription = "description"
        case image, date
    }
}
extension Article {
    static var dummyData: Article {
        .init(author: "Eli Rosenberg",
              url: "https://www.washingtonpost.com/business/2021/07/27/biden-vaccine-mandate-federal-employees/",
              source: "The Washington Post",
              title: "Biden says White House exploring vaccine mandate for federal employees - The Washington Post",
              articleDescription: "Such a push would mark a significant expansion of effort to vaccinate Americans as delta variant spreads.",
              image: "https://www.washingtonpost.com/wp-apps/imrs.php?src=https://d1i4t8bqe7zgj6.cloudfront.net/07-27-2021/t_e975312ffb6945939e4ec2c6e8904d7e_name_960cee9c_ef13_11eb_81b2_9b7061a582d8_scaled.jpg&w=1440", date: Date())
    }
    
}
