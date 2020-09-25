//
//  AboutCanadaTableViewCell.swift
//  BonjourCanada
//
//  Created by Jyoti Saini on 24/09/20.
//  Copyright © 2020 Jyoti Saini. All rights reserved.
//

import UIKit
import SDWebImage

class AboutCanadaTableViewCell: UITableViewCell {

    var task: URLSessionDownloadTask!
    var session: URLSession!
    var cache:NSCache<AnyObject, AnyObject>!
    var indexPath: NSIndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    
    
    
    var aboutMeRowItems: AboutMeRowItems? {
        didSet {
            guard let item = aboutMeRowItems else {return}
            
            if let name = item.title {
                title.text = name
            }
            if let description = item.description {
                descriptionLabel.text = " \(description) "
            }
            
            if let country = item.imageHref {
                countryImageView.sd_setImage(with: URL(string: country), placeholderImage: UIImage(named: "placeholder"))
            }
        }
    }
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        view.backgroundColor = .orange
        return view
    }()
    
    
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 240), for: .horizontal)
        label.numberOfLines = 0
        return label
    }()
    
    let title:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .white
        label.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let countryImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit // without this your image will shrink and looks ugly
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 13
        img.clipsToBounds = true
        return img
    }()
    
    let verticalStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.alignment = .fill
    stackView.spacing = 5
    stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let horizontalStackView: UIStackView = {
       let stackView = UIStackView()
       stackView.axis = .horizontal
       stackView.distribution = .fillEqually
       stackView.alignment = .fill
       stackView.spacing = 5
       stackView.translatesAutoresizingMaskIntoConstraints = false
           return stackView
       }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(containerView)
        
        //center horizontally
        containerView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        //center vertically
        containerView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        //Leading
        containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0).isActive = true
        //Trailing
        containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0).isActive = true
        
        //top
        containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0).isActive = true
        //bottom
        containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true
        
        
        self.containerView.addSubview(verticalStackView)
        
        //Leading
               verticalStackView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 0).isActive = true
               //Trailing
               verticalStackView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: 0).isActive = true
               
               //top
               verticalStackView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 0).isActive = true
               //bottom
               verticalStackView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: 0).isActive = true
        
        verticalStackView.addArrangedSubview(title)
        verticalStackView.addArrangedSubview(horizontalStackView)
        
        horizontalStackView.addArrangedSubview(countryImageView)
        horizontalStackView.addArrangedSubview(descriptionLabel)
        
//        containerView.addSubview(countryImageView)
//        containerView.addSubview(title)
//        containerView.addSubview(descriptionLabel)
//        self.contentView.addSubview(containerView)
//        self.contentView.addSubview(countryImageView)
//
//
//        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
//
//        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
//        containerView.heightAnchor.constraint(equalToConstant:40).isActive = true
//
//        title.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
//        title.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
//        title.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
//
//        descriptionLabel.topAnchor.constraint(equalTo:self.title.bottomAnchor).isActive = true
//        descriptionLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
//        descriptionLabel.topAnchor.constraint(equalTo:self.title.bottomAnchor).isActive = true
//        descriptionLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
//
//        countryImageView.widthAnchor.constraint(equalToConstant:26).isActive = true
//        countryImageView.heightAnchor.constraint(equalToConstant:26).isActive = true
//        countryImageView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-20).isActive = true
//        countryImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }

}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
