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
    
    /// initialises the url and set the url session
    /// - Parameters:
    ///   - urlString: pass the url stored in constant file
    ///   - urlSession: by default the urlsession is shared
    init(urlString: String, urlSession: URLSession = .shared) {
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    /// fetch the detail of the only web service ie About Canada
    /// - Parameter completionHadler: returns the about me resonse model and custom error
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
            let dutf8 = String(decoding: data!, as: UTF8.self).data(using: .utf8)
            if let dataExtracted = dutf8, let aboutMeResponseModel = try? JSONDecoder().decode(AboutMeResponseModel.self, from: dataExtracted) {
            completionHadler(aboutMeResponseModel, nil)
            }else {
                completionHadler(nil , AboutMeError.invalidResponseModel)
            }
        }
        dataTask.resume()
    }
}
