//
//  CombineSearchAPI.swift
//  SwiftDemo
//
//  Created by 崔林豪 on 2022/1/3.
//

import UIKit
import Combine
import SwiftUI

/**
 网络URLSession.dataTaskPublisher使用例子如下：
 let req = URLRequest(url: URL(string: "http://www.starming.com")!)
 let dpPublisher = URLSession.shared.dataTaskPublisher(for: req)
 */

struct CombineSearchAPI: View {
	var body: some View {
		githubSearchView()
	}
}

struct githubSearchView: View {
	@State var str: String = "Swift"
	@StateObject var ss: SearchStore = SearchStore()
	@State var repos: [GithubRepo] = []
	var body: some View {
		
		NavigationView {
			List {
				TextField("输入: ", text: $str, onCommit: fetch)
				ForEach(self.ss.repos) {
					
				}
			}
		}
		
		
	}
	
	private func fetch() {
		
	}
	
}


struct GithubRepoCell: View {
    
    let repo: GithubRepo
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(self.repo.name)
            Text(self.repo.description)
        }
    }
}

//MARK: - Github Service
struct  GithubRepo: Decodable, Identifiable {
	let id: Int
	let name: String
	let description: String
}

struct GithubResp: Decodable {
    let items: [GithubRepo]
}

final class GithubSearchManager {
    func search(str: String) -> AnyPublisher<GithubResp, Never> {
        
        guard var urlComponents = URLComponents(string: "https://api.github.com/search/repositories") else { preconditionFailure("链接无效") }
        
        urlComponents.queryItems = [URLQueryItem(name: "q", value: str)]
        
        guard let url = urlComponents.url else {
            preconditionFailure("链接无效")
        }
            
        let sch = DispatchQueue(label: "API", qos: .default, attributes: .concurrent)
        
        return URLSession.shared.dataTaskPublisher(for: url).receive(on: sch).tryMap ({ elemet in
            return elemet.data
        }).decode(type: GithubResp.self, decoder: JSONDecoder()).catch { _ in
            Empty().eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }
}

final class SearchStore: ObservableObject {
    
    @Published var query: String = ""
    @Published var repos: [GithubRepo] = []
    
    private let searchManager: GithubSearchManager
    private var cancellable = Set<AnyCancellable>()
    
    init(searchManager: GithubSearchManager = GithubSearchManager()) {
        self.searchManager = searchManager
        
        $query.debounce(for: .milliseconds(500), scheduler: RunLoop.main).flatMap { query -> AnyPublisher<[GithubRepo],Never> in
            return searchManager.search(str: query).map {
                $0.items
            }.eraseToAnyPublisher()
        }.receive(on: DispatchQueue.main).assign(to: \.repos, on: self).store(in: &cancellable)
    }
    
    func search(str: String) {
        self.query = str
    }
    
}

