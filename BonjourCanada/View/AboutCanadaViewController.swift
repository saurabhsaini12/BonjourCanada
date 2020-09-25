//
//  AboutCanadaViewController.swift
//  BonjourCanada
//
//  Created by Jyoti Saini on 24/09/20.
//  Copyright © 2020 Jyoti Saini. All rights reserved.
//

import UIKit

class AboutCanadaViewController: UIViewController {

    var containerView: UIView!
    var listViewModel: AboutCanadaListViewModel!
    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        // Do any additional setup after loading the view.
        
        //initialise view model
        listViewModel = AboutCanadaListViewModel.init()

        setupContainer()
        setupTableView()
        registerTableViewCell()
        
        listViewModel.onRowUpdate = { [unowned self] in
            
            DispatchQueue.main.async {
                self.navigationItem.title = self.listViewModel.title
                 self.tableView.reloadData()
            }
           
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
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
             //  let articleVM = self.listViewModel.articleAtIndex(indexPath.row)
               cell.indexPath = indexPath as NSIndexPath
              cell.aboutMeRowItems = self.listViewModel.rowItems[indexPath.row]
//               cell.titleLabel.text = articleVM.title
//               cell.descriptionLabel.text = articleVM.description
               return cell
    }
    
    
}
