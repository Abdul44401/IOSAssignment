//
//  WebService.swift
//  IOSAssignment
//
//  Created by Abdul Razzak on 27/04/2022.
//

import Combine
import Foundation

class WebService {
    
    enum ApiError: Error, LocalizedError {
        case unknown, apiError(reason: String)
    }
    
    static func fetchApi<T: Decodable>() -> AnyPublisher<T, Error> {
        let urlString = ApiLink.json.apiString
        guard let url = URL(string: urlString) else {
            fatalError("Invalid url")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

   static func StatusCompletionHandler(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .failure(let error):
            print(error)
        case .finished:
            print("Connection success")
        }
    }
    
    static func convertCSVIntoArray(_ completion: @escaping ((StickerModel) -> Void)) {
        
        let urlString = ApiLink.csv.apiString
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            // Convert Data into String
       
                let dataString = String(data: data, encoding: .utf8)
                //now split that string into an array of "rows" of data.  Each row is a string.
                var rows = dataString!.components(separatedBy: "\n")
                
                //if you have a header row, remove it here
                rows.removeFirst()
                
                //now loop around each row, and split it into each of its columns
                for row in rows {
                    let columns = row.components(separatedBy: ",")
                    
                    //check that we have enough columns
                    if columns.count == 2 {
                        let stockName = columns[0].trimmingCharacters(in: CharacterSet.init(charactersIn: "la t, \n \" ':"))
                        
                        let stockPrice = columns[1]
                        
                        let sticker = StickerModel(stock: stockName, price: stockPrice)
                        completion(sticker)
                    }
                }
            
        }.resume()
    }
}
