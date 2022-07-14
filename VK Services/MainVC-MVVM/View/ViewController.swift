//
//  ViewController.swift
//  VK Services
//
//  Created by Сергей Коньков on 14.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.backgroundColor = .black
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    private var viewModel = TableViewViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "customCell")
        viewModel.fetchServices { services in
            DispatchQueue.main.async {
                self.viewModel.services = services
                self.tableView.reloadData()
            }
        }
        viewModel.dataImages.bind { data in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = "Сервисы VK"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 22)]
    }
}

//MARK: - Configuration
extension ViewController {
    private func configureView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - Table View Data Source
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as? TableViewCell else {
            return UITableViewCell()
        }
        guard let cellViewModel = viewModel.tableViewCellViewModel(forIndexPath: indexPath) else {
            return TableViewCell()
        }
        cell.viewModel = cellViewModel
        return cell
    }
}

//MARK: - Table View Delegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let url = viewModel.getServiceUrl(forIndexPath: indexPath) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
