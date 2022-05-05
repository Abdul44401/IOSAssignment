//
//  CardView.swift
//  IOSAssignment
//
//  Created by Abdul Razzak on 29/04/2022.
//

import SwiftUI

struct CardView: View {
    var sticker: StickerModel
}

//MARK: - UI
extension CardView {
    var body: some View {
        ZStack {
            Color.white
                .cornerRadius(12)
                .shadow(color: Color.init(white: 0.1, opacity: 0.3), radius: 20, x: 0, y: 10)
            
            VStack {
                HStack {
                    Text(sticker.stock)
                        .font(.system(size: 14))
                    Spacer()
                }
                .foregroundColor(.black)
                
                HStack {
                    Text("$")
                        .font(.system(size: 12))
                    + Text(sticker.price)
                        .font(.system(size: 12))
                    Spacer()
                }
                .foregroundColor(.black)
                
                Spacer()
            }
            .padding()
        }
    }
}
