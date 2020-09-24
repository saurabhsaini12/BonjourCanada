//
//  WebService.swift
//  BonjourCanada
//
//  Created by Jyoti Saini on 24/09/20.
//  Copyright © 2020 Jyoti Saini. All rights reserved.
//
import Foundation
class WebService {
    
    private var urlSession: URLSession
    private var urlString: String
    
    init(urlString: String, urlSession: URLSession = .shared) {
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    func fetchInitialDetails(completionHadler:@escaping(AboutMeResponseModel?, AboutMeError?)-> Void) {
        guard let url = URL(string: urlString) else {
            completionHadler(nil,AboutMeError.invalidRequestUrlString)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = urlSession.dataTask(with: request) { (data, reposne, error) in
            if let requestError = error {
                completionHadler(nil, AboutMeError.failedRequest(description: requestError.localizedDescription))
                return
            }
            
            if let data = data, let aboutMeResponseModel = try? JSONDecoder().decode(AboutMeResponseModel.self, from: data) {
            completionHadler(aboutMeResponseModel, nil)
            }else {
                completionHadler(nil , AboutMeError.invalidResponseModel)
            }
        }
        dataTask.resume()
    }
}
