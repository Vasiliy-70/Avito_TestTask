//
//  QueryService.swift
//  Lessons7_URL
//
//  Created by Боровик Василий on 16.01.2020.
//

import Foundation
import UIKit

protocol IQueryService: class {
	func getDataAt(url: URL, completion: @escaping (Data, String) -> Void)
}

final class QueryService: IQueryService {
	private let defaultSession = URLSession(configuration: .default)
	private var dataTask: URLSessionDataTask?
	private var errorMessage = ""
	private var responseData = Data()
	
	typealias QueryResult = (Data, String) -> Void
	
	func getDataAt(url: URL, completion: @escaping QueryResult) {
		self.dataTask?.cancel()
		
		self.dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
			defer {
				self?.dataTask = nil
			}
			
			self?.responseData = Data()
			self?.errorMessage = ""
			
			if let error = error {
				self?.errorMessage = "Data task error: \(error.localizedDescription)\n"
			} else if let data = data,
					  let response = response as? HTTPURLResponse {
				if response.statusCode == 200 {
					self?.responseData = data
				} else {
					self?.errorMessage = "Data task error: code \(response.statusCode)\n"
				}
			}
			
			DispatchQueue.main.asyncAfter(deadline: .now()) {
				completion(self?.responseData ?? Data(), self?.errorMessage ?? "")
			}
		}
		self.dataTask?.resume()
	}
}
