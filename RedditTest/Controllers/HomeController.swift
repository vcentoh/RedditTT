//
//  ViewController.swift
//  RedditTest
//
//  Created by Magik on 21/5/23.
//

import UIKit
import RxSwift
import RxCocoa
import Combine

class HomeController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let dataModel: PublisherModel = PublisherModel()
    private var tableData: [RedditPost] = []
    private var disposeBag = DisposeBag()
    
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
        tableView.dataSource = self
        tableView.delegate = self
        loadData()
    }
    func searchData(reddit: String) {
        tableData = dataModel.searchReddit(reddit: reddit)
        tableView.reloadData()
    }
    
    func loadData() {
        tableData = dataModel.getPost()
        tableView.reloadData()
    }
    
    func bind() {
        self.searchButton.rx
            .tap
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] () in
                guard let self = self else { return }
                if !(self.searchText.text?.isEmpty ?? true) {
                    self.searchData(reddit: self.searchText.text?)
                } else {
                    self.loadData()
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCellView", for: indexPath) as! PostCellView
        cell.update(with: tableData[indexPath.item])
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
    
    override var shouldAutorotate: Bool {
        return true
    }
}

