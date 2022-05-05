//
//  AppViewModel.swift
//  IOSAssignment
//
//  Created by Abdul Razzak on 27/04/2022.
//

import Foundation
import Combine

final class AppViewModel: ObservableObject  {
    @Published private(set) var articles: [Articles] = []
    @Published private(set) var sticker: [StickerModel] = []
    @Published private(set) var filterArticles: [Articles] = []
    @Published private(set) var topArticles: [Articles] = []
    @Published private(set) var isActivityAnimation: Bool = false
    var emitter = RandomPriceEmitter()
    
    private let topSixArticles = 6
    
    private var cancellable: AnyCancellable?
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        showIndicator()
        loadCSVData()
        loadDataFromNews()
        
        $articles
            .sink {[weak self] articles in
                guard let `self` = self else { return }
                if articles.count > self.topSixArticles {
                    self.filterArticles = Array(articles.suffix(articles.count - self.topSixArticles))
                    self.topArticles = Array(articles.prefix(self.topSixArticles))
                }
            }
            .store(in: &subscriptions)
        
        emitter.delegate = self
    }
}

//MARK: - Server Methods
extension AppViewModel {
    private func loadDataFromNews() {
        cancellable = WebService.fetchApi()
            .sink(receiveCompletion: { completion in
                WebService.StatusCompletionHandler(completion: completion)
            }, receiveValue: {[weak self] (data: AppModel) in
                if let dataArticle = data.articles {
                    self?.articles.append(contentsOf: dataArticle)
                    self?.hideIndicator()
                }
            })
    }
    
    private func loadCSVData(random: Bool = false) {
        WebService.convertCSVIntoArray { model in
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else { return }
                    self.sticker.append(model)
                
            }
        }
    }
}

//MARK: - Delegate RandomPrice
extension AppViewModel: RandomPriceModifier {
    func price() {
        // Random selection of the price after 1000 sec
        for row in 0..<sticker.count {
            print(row)
            let randomPrice = "\(Double.random(in: 0...40))"
            sticker[row].price = randomPrice
        }
    }
}

//MARK: - Activity Indicator
extension AppViewModel {
    private func showIndicator() {
        DispatchQueue.main.async {[weak self] in
            self?.isActivityAnimation = true
        }
    }
    
    private func hideIndicator() {
        DispatchQueue.main.async {[weak self] in
            self?.isActivityAnimation = false
        }
    }
}
