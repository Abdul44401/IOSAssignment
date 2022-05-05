//
//  TopSixNews.swift
//  IOSAssignment
//
//  Created by Abdul Razzak on 29/04/2022.
//

import SwiftUI

struct TopSixNews: View {
    @ObservedObject var vm: AppViewModel
    var columns: Int
    
}

//MARK: - UI
extension TopSixNews {
    var body: some View {
        VStack (alignment:.leading, spacing: 0) {
            
            ForEach(Array(zip(0..<3, self.vm.topArticles)), id: \.0) { row, item in
                // index and item are both safe to use here
                // print(row)
                //  [(i * 2) + j]
                
                HStack {
                    let Index = (columns*3) + row
                    HStack (spacing: 0) {
                        ImageLoader(urlString: vm.articles[Index].urlToImage ?? "")
                        .padding(.leading, 32)
                        
                        Text(vm.topArticles[Index].title ?? "")
                            .font(.system(size: 12))
                            .padding()
                        Spacer()
                    }
                }
                .frame(width: UIScreen.main.bounds.width, height: 80)
            }
        }
    }
}


