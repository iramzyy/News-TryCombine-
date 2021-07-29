//
//  ArticleView.swift
//  News-App
//
//  Created by Ramzy on 28/07/2021.
//

import SwiftUI
import URLImage

struct ArticleView: View {
    
    let article: Article
    
    var body: some View {
        HStack {
            if let imageURL = article.image,
               let url = URL(string: imageURL) {
                URLImage(url,
                         failure: { error, _ in
                            PlaceholderImagerView()
                         },
                         content: { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                         })
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                    
            } else {
                PlaceholderImagerView()
            }
            VStack(alignment: .leading, spacing: 5, content: {
                Text(article.title)
                    .foregroundColor(.black)
                    .font(.system(size: 18,weight: .semibold))
                Text(article.source)
                    .foregroundColor(.gray)
                    .font(.footnote)
                
            })
        }
    }
}

struct PlaceholderImagerView: View {
    var body: some View {
        Image(systemName: "photo.fill")
            .foregroundColor(.white)
            .background(Color.gray)
            .frame(width: 100, height: 100)
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(article: Article.dummyData)
            .previewLayout(.sizeThatFits)
    }
}
