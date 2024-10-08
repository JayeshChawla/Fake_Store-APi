//
//  ViewController.swift
//  FakeSoreApiCalling
//
//  Created by Quick tech  on 12/09/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var viewModel = productViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.configuration()
    }
    @IBAction func addProduct(_ sender: Any) {
        let product = AddProduct(title: "iPhone")
        viewModel.addProduct(parameters: product)
    }
}

extension ViewController {
    
    func setupTableView() {
        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configuration() {
        initViewModel()
        observeValue()
    }
    
    func initViewModel() {
        viewModel.fetchProducts()
    }
    
    func observeValue() {
        viewModel.eventHandlet = { [weak self] event in
            guard let self else { return }
            
            switch event {
            case .loading:
                print("Loading....")
            case .stoploading:
                print("Stop Loading ....")
            case .dataloaded:
                print("Data Loaded ...")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .error(let error):
                print(error)
            case .newProduct(let product):
                print(product)
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        let product = viewModel.products[indexPath.row]
        cell.product = product
        return cell
    }
    
    
}

