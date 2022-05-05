//
//  CellView.swift
//  IOSAssignment
//
//  Created by Abdul Razzak on 29/04/2022.
//

import SwiftUI

struct CellView: View {
    var article: Articles
}

//MARK: - UI
extension CellView {
    var body: some View {
        ZStack {
            Color.white
                .cornerRadius(12)
                .shadow(color: Color.init(white: 0.1, opacity: 0.3), radius: 20, x: 0, y: 10)
            
            VStack {
                HStack (spacing: 10) {
                    ImageLoader(urlString: article.urlToImage ?? "")
                    
                    Text(article.title ?? "")
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                    
                    Spacer()
                }
               
                HStack {
                    Text(getDate(dateString: article.publishedAt ?? "") ?? Date(), style: .date)
                        .font(.system(size: 10))
                        .foregroundColor(.black)
                    
                    Spacer()
                }
                .padding(.bottom,5)
                
                HStack {
                    Text(article.description ?? "")
                    .font(.system(size: 12))
                    .foregroundColor(.black)
                    Spacer()
                }
                
            }
            .padding()
        }
    }
}

//MARK: - Private Function For Date
extension CellView {
    private func getDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: dateString) // replace Date String
    }
}
