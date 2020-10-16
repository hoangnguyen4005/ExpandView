//
//  ExpandListView.swift
//  ExpandView
//
//  Created by hoangnc on 16/10/20.
//

import UIKit

public protocol ExpandListViewDataSource: class {
    func numberItemsOfView(expandListView: ExpandListView) -> Int
    func titleView(expandListView: ExpandListView, at index: Int) -> String
    func messageView(expandListView: ExpandListView, at index: Int) -> String
    func isExpand(expandListView: ExpandListView, at index: Int) -> Bool
    func icon(expandListView: ExpandListView, at index: Int) -> UIImage
}

public protocol ExpandListViewDelegate: class {
    func didExpand(expandListView: ExpandListView, at index: Int)
}

public class ExpandListView: UIView {
    public weak var dataSource: ExpandListViewDataSource?
    public weak var delegate: ExpandListViewDelegate?

    @IBOutlet weak var stackView: UIStackView!

    convenience init() {
        self.init(frame: CGRect.zero)
    }

    /// :nodoc:
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    /// :nodoc:
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = UIColor.clear
        _ = fromNib(nibName: String(describing: ExpandListView.self), isInherited: true)
    }

    public func reloadData() {
        self.stackView.arrangedSubviews.forEach({$0.removeFromSuperview()})
        guard let dataSource = self.dataSource else { return }
        let numberItemsOfView = dataSource.numberItemsOfView(expandListView: self)
        for index in 0..<numberItemsOfView {
            let itemView = ItemView()
            let title = dataSource.titleView(expandListView: self, at: index)
            let message = dataSource.messageView(expandListView: self, at: index)
            let isExpand = dataSource.isExpand(expandListView: self, at: index)
            let icon = dataSource.icon(expandListView: self, at: index)
            itemView.title = title
            itemView.message = message
            itemView.isExpand = isExpand
            itemView.isHiddenLineView = index == numberItemsOfView - 1 ? true : false
            itemView.arrowIcon = icon
            itemView.tag = index
            itemView.delegate = self
            self.stackView.addArrangedSubview(itemView)
        }
    }
}

extension ExpandListView: ItemViewDelegate {
    public func didExpand(itemView: ItemView) {
        let index = itemView.tag
        let newIsExpand = !itemView.isExpand
        itemView.isExpand = newIsExpand
        if newIsExpand {
            itemView.animateArrowUp()
        } else {
            itemView.animateArrowDown()
        }
        self.delegate?.didExpand(expandListView: self, at: index)
    }
}
