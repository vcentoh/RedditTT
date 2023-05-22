//
//  ViewController.swift
//  RedditTest
//
//  Created by Magik on 21/5/23.
//

import UIKit

class HomeController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let apiCaller = APICaller()
    private var trueTableData: [RedditPost] = []
    private var mockData: [RedditPost] = []

    @IBOutlet private weak var tableView: UITableView! = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        return tableView
    }()
    
    @IBOutlet private weak var searchText: UITextField! = {
        let textField = UITextField()
        return textField
    }()
    
    @IBOutlet private weak var searchButton: UIButton! = {
        let button = UIButton()
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        trueTableData = apiCaller.fetchData()
        dump(trueTableData)
        mockData = apiCaller.getMock()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCellView", for: indexPath) as! PostCellView
        cell.update(with: mockData[indexPath.item])
        return cell
    }
    
    func registerCell(){
        self.tableView.register(PostCellView.self, forCellReuseIdentifier: "PostCellView")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
}

