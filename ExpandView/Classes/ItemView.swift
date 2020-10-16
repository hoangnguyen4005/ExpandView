//
//  ItemView.swift
//  ExpandView
//
//  Created by hoangnc on 16/10/20.
//

import UIKit

public protocol ItemViewDelegate: class {
    func didExpand(itemView: ItemView)
}

public class ItemView: UIView {
    public weak var delegate: ItemViewDelegate?

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowButton: UIButton!
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var lineView: UIView!
    var messageLabel: UILabel = UILabel()

    public var title: String? {
        get {
            return self.titleLabel.text
        }
        set(value) {
            self.titleLabel.text = value
            self.titleLabel.addInterlineSpacing(spacingValue: 4.0)
        }
    }

    public var message: String? {
        get {
            return self.messageLabel.text
        }
        set(value) {
            self.messageLabel.text = value
            self.messageLabel.addInterlineSpacing(spacingValue: 4.0)
        }
    }

    public var arrowIcon: UIImage? {
        didSet {
            let arrowImage = arrowIcon?.withRenderingMode(.alwaysTemplate)
            arrowButton.setImage(arrowImage, for: .normal)
            arrowButton.tintColor = ThemeColor.blue
        }
    }

    public var borderColor: CGColor? {
        get {
            return self.contentView.layer.borderColor
        }
        set(value) {
            self.contentView.layer.borderColor = value
        }
    }

    public var isHiddenLineView: Bool {
        get {
            return self.lineView.isHidden
        }
        set(value) {
            self.lineView.isHidden = value
        }
    }
    public var isExpand: Bool = false {
        didSet {
            if isExpand {
                self.messageLabel.removeFromSuperview()
                self.coverView.addSubview(messageLabel)
                self.messageLabel.anchor(top: self.coverView.topAnchor,
                                         leading: self.coverView.leadingAnchor,
                                         bottom: self.coverView.bottomAnchor,
                                         trailing: self.contentView.trailingAnchor,
                                         padding: UIEdgeInsets(top: 16.0,
                                                               left: 16.0,
                                                               bottom: 16.0,
                                                               right: 53.0),
                                         size: .zero)
                self.lineView.isHidden = true
            } else {
                self.lineView.isHidden = false
                self.messageLabel.removeFromSuperview()
            }
        }
    }

    public convenience init() {
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
        backgroundColor = .clear
        _ = fromNib(nibName: String(describing: ItemView.self), isInherited: true)
        contentView.backgroundColor = .clear

        titleLabel.font = UIFont.systemFont(ofSize: 16.0)
        titleLabel.textColor = ThemeColor.deepBlue
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left

        messageLabel.font = UIFont.systemFont(ofSize: 16.0)
        messageLabel.textColor = ThemeColor.darkBlueGrey
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .left

        coverView.backgroundColor = ThemeColor.lightGrey
        coverView.layer.borderWidth = 1.0
        coverView.layer.borderColor = ThemeColor.light.cgColor

        lineView.backgroundColor = ThemeColor.light
    }

    public func animateArrowDown() {
        let transform = CGAffineTransform.identity
        UIView.animate(withDuration: 0.3, animations: {
            self.arrowButton.transform = transform.rotated(by: -2 * CGFloat.pi)
            self.arrowButton.transform = transform
        })
    }

    public func animateArrowUp() {
        let transform = CGAffineTransform.identity
        UIView.animate(withDuration: 0.3, animations: {
            self.arrowButton.transform = transform.rotated(by: CGFloat.pi)
        })
    }

    @IBAction func eventClickArrowButton(_ sender: Any) {
        self.delegate?.didExpand(itemView: self)
    }
}
