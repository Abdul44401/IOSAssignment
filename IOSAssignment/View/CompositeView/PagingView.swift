//
//  PagingView.swift
//  IOSAssignment
//
//  Created by Abdul Razzak on 27/04/2022.
//

import SwiftUI

struct PagingView<Content: View>: View {
    let pageCount: Int
    @Binding var currentIndex: Int
    let content: Content
    private let cardWidth: CGFloat = 40
    private let cardHeight: CGFloat = 100
    private let hSpacing: CGFloat = 10
    
    @GestureState private var translation: CGFloat = 0
    
    init(pageCount: Int, currentIndex: Binding<Int>, @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self.content = content()
    }
}

//MARK: - UI
extension PagingView {
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                HStack(spacing: hSpacing) {
                    self.content.frame(width: abs(geometry.size.width - cardWidth))
                }
                .frame(width: geometry.size.width, alignment: .leading)
                .offset(x: -CGFloat(self.currentIndex) * (geometry.size.width - (cardWidth - hSpacing)))
                .offset(x: self.translation)
                .gesture(
                    DragGesture().updating(self.$translation) { value, state, _ in
                        state = value.translation.width
                    }
                        .onEnded { value in
                            let offset = value.translation.width / (geometry.size.width - cardWidth)
                            
                            let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
                            self.currentIndex = min(max(Int(newIndex), 0), self.pageCount - 1)
                        }
                )
            }
            .padding(.horizontal)
        }
        .frame( height: cardHeight)
    }
}
