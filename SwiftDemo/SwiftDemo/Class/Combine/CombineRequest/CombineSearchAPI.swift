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

struct  GithubRepo: Decodable, Identifiable {
	let id: Int
	let name: String
	let description: String
}

final class SearchStore: ObservableObject {
	
}
