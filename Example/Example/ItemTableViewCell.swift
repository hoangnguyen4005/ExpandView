//
//  ItemTableViewCell.swift
//  Example
//
//  Created by Chi Hoang on 30/4/20.
//  Copyright © 2020 Hoang Nguyen Chi. All rights reserved.
//


import UIKit
import ExpandView

protocol ItemTableViewCellDelegate: class {
    func expandCell(cell: ItemTableViewCell)
}

class ItemTableViewCell: UITableViewCell {
    weak var delegate: ItemTableViewCellDelegate?

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var expandView: ExpandListView!
    var listTitle: [String] = []
    var listMessage: [String] = []
    var listExpand: [Bool] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        self.expandView.cornerRadius(radius: 8.00,
                                      maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner,
                                                      .layerMinXMaxYCorner, .layerMaxXMaxYCorner],
                                      color: ThemeColor.light,
                                      width: 1.0)
        self.expandView.applyShadow(shadowColor: UIColor.black.cgColor,
                                     opacity: 0.08,
                                     offset: CGSize(width: 0.0, height: 2.0),
                                     blur: 4.0,
                                     spread: 0.0)
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = ThemeColor.deepBlue
        label.text = "Test Expand view"
    }

    func setData(listTitle: [String],
                 listMessage: [String],
                 listExpand: [Bool]) {
        self.listTitle = listTitle
        self.listMessage = listMessage
        self.listExpand = listExpand
        expandView.dataSource = self
        expandView.delegate = self
        expandView.reloadData()
    }
}

extension ItemTableViewCell: ExpandListViewDataSource, ExpandListViewDelegate {
    func icon(expandListView: ExpandListView, at index: Int) -> UIImage {
        return UIImage(named: "down")!
    }
    func titleView(expandListView: ExpandListView, at index: Int) -> String {
        self.listTitle[index]
    }

    func messageView(expandListView: ExpandListView, at index: Int) -> String {
        self.listMessage[index]
    }

    func isExpand(expandListView: ExpandListView, at index: Int) -> Bool {
        self.listExpand[index]
    }

    func numberItemsOfView(expandListView: ExpandListView) -> Int {
        self.listExpand.count
    }

    func didExpand(expandListView: ExpandListView, at index: Int) {
        let newIsExpand = !self.listExpand[index]
        self.listExpand[index] = newIsExpand
        self.delegate?.expandCell(cell: self)
    }
}
