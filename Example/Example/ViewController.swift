//
//  ViewController.swift
//  ExpandView
//
//  Created by hoangnc on 16/10/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var isReloadData: Bool = false
    var listTitle: [String] = ["1 What is a FAQ page?",
                               "2 What is a FAQ page?",
                               "3 What is a FAQ page?",
                               "4 What is a FAQ page?"]
    var listMessage: [String] = ["1 FAQ page reduces the overall anxiety of purchasing online—and that goes a long way in getting on-the-fence customers to buy from you",
                                 "2 FAQ page reduces the overall anxiety of purchasing online—and that goes a long way in getting on-the-fence customers to buy from you",
                                 "3 FAQ page reduces the overall anxiety of purchasing online—and that goes a long way in getting on-the-fence customers to buy from you",
                                 "4 a FAQ page reduces the overall anxiety of purchasing online—and that goes a long way in getting on-the-fence customers to buy from you"]
    var listExpand: [Bool] = [false, false, false, false]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        let name = String(describing: ItemTableViewCell.self)
        self.tableView.register(UINib(nibName: name,
                                      bundle: nil),
                                forCellReuseIdentifier: name)
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        self.tableView.isScrollEnabled = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 86.0
        self.tableView.reloadData()
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource, ItemTableViewCellDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
            String(describing: ItemTableViewCell.self)) as? ItemTableViewCell else { return UITableViewCell() }
        if !isReloadData {
            cell.setData(listTitle: listTitle, listMessage: listMessage, listExpand: listExpand)
        }
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func expandCell(cell: ItemTableViewCell) {
        self.isReloadData = true
        self.tableView.reloadData()
    }
}
