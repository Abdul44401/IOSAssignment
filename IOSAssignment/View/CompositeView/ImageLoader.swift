//
//  ImageLoader.swift
//  IOSAssignment
//
//  Created by Abdul Razzak on 29/04/2022.
//

import SwiftUI

struct ImageLoader: View {
    var urlString: String
    var body: some View {
        AsyncImage(
            url: URL(string: urlString),
            content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }, placeholder: {
                Color.gray
            })
        .frame(width: 50, height: 50)
    }
}
