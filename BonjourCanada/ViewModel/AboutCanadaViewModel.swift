//
//  AboutCanadaViewModel.swift
//  BonjourCanada
//
//  Created by Jyoti Saini on 24/09/20.
//  Copyright © 2020 Jyoti Saini. All rights reserved.
//

import Foundation

class AboutCanadaListViewModel {
    var title: String = ""
    var rowItems: [AboutMeRowItems] = []
    var onRowUpdate: (() -> Void)?
    
    init() {
        initiateWebService()
    }
}

extension AboutCanadaListViewModel {
  
    func initiateWebService() {
        let webService = WebService.init(urlString: AboutMeConstants.urlString)
        webService.fetchInitialDetails { [weak self] (aboutMeResponseModel, aboutMeError) in
            if aboutMeError == nil {
                self?.title = aboutMeResponseModel!.title
                self?.rowItems = aboutMeResponseModel!.rows
                self?.onRowUpdate!()
            }
        }
    }
    
    func refreshWebService(){
        self.initiateWebService()
    }
}

extension AboutCanadaListViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.rowItems.count
    }
    
    func articleAtIndex(_ index: Int) -> AboutCanadaViewModel {
        let rowItem = self.rowItems[index]
        return AboutCanadaViewModel(rowItem)
    }
    
}

struct AboutCanadaViewModel {
    
    private let aboutMeRowItems: AboutMeRowItems
  
     
}
extension AboutCanadaViewModel {
    init(_ aboutMeRowItems: AboutMeRowItems) {
        self.aboutMeRowItems = aboutMeRowItems
    }
}
