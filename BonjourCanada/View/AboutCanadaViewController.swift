//
//  AboutCanadaViewController.swift
//  BonjourCanada
//
//  Created by Jyoti Saini on 24/09/20.
//  Copyright © 2020 Jyoti Saini. All rights reserved.
//

import UIKit
import Toast_Swift

class AboutCanadaViewController: UIViewController {
    
    var containerView: UIView!
    var listViewModel: AboutCanadaListViewModel!
    var tableView: UITableView!
    var refreshButton: UIBarButtonItem!
    var isNetworkAvailable: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        loadReachability()
        listViewModel.onRowUpdate = { [weak self] in
            
            DispatchQueue.main.async {
                self?.navigationItem.title = self?.listViewModel.title
                self?.tableView.reloadData()
            }
            
        }
    }
    
    func loadReachability() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.WhenOnline), name: NSNotification.Name("Online"), object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(self.WhenOffline), name: NSNotification.Name("Offline"), object: nil)
    }
    
    @objc func WhenOnline() {
        isNetworkAvailable = true
        self.view.makeToast("Network is Online")
    }
    
    @objc func WhenOffline() {
         isNetworkAvailable = false
        self.view.makeToast("Opps!!Network is Offline")
    }
    
    // Do any additional setup after loading the view.
    fileprivate func setup() {
        view.backgroundColor = .orange
       refreshButton = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(onRefresh))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(onRefresh))
        //initialise view model
        listViewModel = AboutCanadaListViewModel.init()
        
        setupContainer()
        setupTableView()
        registerTableViewCell()
    }
    
    @objc func onRefresh() {
        if isNetworkAvailable {
        listViewModel.refreshWebService()
        }
    }
    
    func setupContainer() {
        containerView = UIView()
        containerView.backgroundColor = .blue
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
    
    func setupTableView() {
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: containerView.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    func registerTableViewCell() {
        tableView.register(AboutCanadaTableViewCell.self, forCellReuseIdentifier: "AboutCanadaTableViewCell")
    }
}
extension AboutCanadaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.listViewModel == nil ? 0 : self.listViewModel.numberOfSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AboutCanadaTableViewCell", for: indexPath) as? AboutCanadaTableViewCell else {
            fatalError("AboutCanadaTableViewCell not found")
        }
        cell.indexPath = indexPath as NSIndexPath
        cell.aboutMeRowItems = self.listViewModel.rowItems[indexPath.row]
        cell.layoutIfNeeded()
        return cell
    }
}
