//
//  TableViewCell.swift
//  VK Services
//
//  Created by Сергей Коньков on 14.07.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    private lazy var serviceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.image = UIImage(named: "nosign")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var serviceNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.text = "Please, wait..."
        label.textColor = .white
        label.backgroundColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var serviceDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Please, wait..."
        label.numberOfLines = 0
        label.textColor = .white
        label.backgroundColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var serviceInfoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillProportionally
        stack.spacing = 0
        stack.addArrangedSubview(serviceNameLabel)
        stack.addArrangedSubview(serviceDescriptionLabel)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var goForwardLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.text = ">"
        label.textColor = .gray
        label.backgroundColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var viewModel: TableViewCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            serviceNameLabel.text = viewModel.serviceName
            serviceDescriptionLabel.text = viewModel.serviceDescription
            let imageData = viewModel.serviceImageData
            serviceImageView.image = (imageData != nil) ? UIImage(data: imageData!) : UIImage(named: "nosign")
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

//MARK: - Configuration
extension TableViewCell {
    
    private func configureContentView() {
        contentView.backgroundColor = .black
        contentView.addSubview(serviceImageView)
        contentView.addSubview(serviceInfoStackView)
        contentView.addSubview(goForwardLabel)
        
        let indentSize: CGFloat = 10
        NSLayoutConstraint.activate([
            serviceImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: indentSize),
            serviceImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -indentSize),
            serviceImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: indentSize),
            serviceImageView.widthAnchor.constraint(equalTo: serviceImageView.heightAnchor),
            
            goForwardLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            goForwardLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -indentSize),
            goForwardLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            goForwardLabel.widthAnchor.constraint(equalToConstant: indentSize),
            
            serviceInfoStackView.topAnchor.constraint(equalTo: serviceImageView.topAnchor),
            serviceInfoStackView.leadingAnchor.constraint(equalTo: serviceImageView.trailingAnchor, constant: indentSize),
            serviceInfoStackView.trailingAnchor.constraint(equalTo: goForwardLabel.leadingAnchor, constant: -indentSize / 2),
            serviceInfoStackView.bottomAnchor.constraint(equalTo: serviceImageView.bottomAnchor)
        ])
    }
}
