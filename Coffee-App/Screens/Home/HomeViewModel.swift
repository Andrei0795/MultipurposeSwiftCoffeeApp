//
//  HomeViewModel.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 09/06/2021.
//

import Foundation

struct NewsItem: Codable {
    var title: String
    var description: String
}

struct NewsItems: Codable {
    var updates: [NewsItem]
}

protocol HomeViewModelDelegate: class {
    func homeViewModelDidLoadNewCafes(viewModel: HomeViewModel, newCafes: [Cafe])
    func homeViewModelDidLoadNews(viewModel: HomeViewModel)
}

class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
    var newCafesDatasource = [Cafe]()
    var newsItems = [NewsItem]()
    var currentNewsItem = 0
    
    func loadCafeData() {
        let service = FirebaseService()
        service.dataLoaded = { newCafes in
            self.newCafesDatasource = newCafes
            self.delegate?.homeViewModelDidLoadNewCafes(viewModel: self, newCafes: newCafes)
        }
        service.loadData()
    }
    
    func getNewsItem() -> NewsItem {
        currentNewsItem += 1
        if currentNewsItem >= newsItems.count {
            currentNewsItem = 0
        }
        return newsItems[currentNewsItem]
    }
    
    func loadNewsData() {
        guard let url = URL(string:"https://api.jsonbin.io/b/60c9cd3b5ed58625fd11adba/2") else {
            return
        }
        let urlReq = URLRequest(url: url)
        let queue = OperationQueue()

        NSURLConnection.sendAsynchronousRequest(urlReq, queue: queue, completionHandler: { (response: URLResponse!, data: Data!, error: Error!) -> Void in
                DispatchQueue.main.async{
                    if error != nil {
                        print("API error")
                    } else if let jsonData = data {
                        self.parse(json: jsonData)
                    } else {
                        print("Error")
                    }
            }
            })
        
//        let urlString = "https://api.jsonbin.io/b/60c9cd3b5ed58625fd11adba/2"
//        if let url = URL(string: urlString) {
//            if let data = try? Data(contentsOf: url) {
//                parse(json: data)
//            }
//        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonNewsItems = try? decoder.decode(NewsItems.self, from: json) {
            newsItems = jsonNewsItems.updates
            if newsItems.count > 0 {
                delegate?.homeViewModelDidLoadNews(viewModel: self)
            }
        }
    }
}
