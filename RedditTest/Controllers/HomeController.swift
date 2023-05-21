//
//  ViewController.swift
//  RedditTest
//
//  Created by Magik on 21/5/23.
//

import UIKit

class HomeController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let apiCaller =  APICaller()
    private var trueTableData: [RedditPost] = []
    private var tableData: [String] = []

    @IBOutlet private weak var tableView: UITableView! = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        APICaller.shared.fecthRedditData(completion:{ result in
            switch result {
                case .success(let response):
                    self.trueTableData = response
                case .failure(let error):
                    print(error)
            }
            
        })
        tableData = apiCaller.mockData
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCellView", for: indexPath) as! PostCellView
        cell.update(with: tableData[indexPath.item].description)
     //   cell.update(with: trueTableData[indexPath.item])
        return cell
    }
    
    func registerCell(){
        self.tableView.register(PostCellView.self, forCellReuseIdentifier: "PostCellView")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

