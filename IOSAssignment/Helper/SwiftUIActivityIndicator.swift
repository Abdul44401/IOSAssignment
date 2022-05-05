//
//  SwiftUIActivityIndicator.swift
//  IOSAssignment
//
//  Created by Abdul Razzak on 30/04/2022.
//

import SwiftUI
import NVActivityIndicatorView

struct SwiftUIActivityIndicator: UIViewRepresentable {
    
    let activityData = ActivityData()
    
    var isAnimating: Bool
    //fileprivate var configuration = { (indicator: UIView) in }
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIView { UIView() }
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Self>) {
        if isAnimating {
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
        }else {
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
        }
    }
}
