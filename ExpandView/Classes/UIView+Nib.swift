//
//  UIView+Extension.swift
//  ExpandView
//
//  Created by hoangnc on 16/10/20.
//

import Foundation
import UIKit

public extension UIView {

    func fromNib<T: UIView>(nibName: String, isInherited: Bool = false) -> T? {
        let bundle = Bundle(for: type(of: self))
        guard let contentView =  bundle.loadNibNamed(nibName,
                                                     owner: self,
                                                     options: nil)?.first as? T else {
                                                        return nil
        }
        contentView.backgroundColor = .clear
        if isInherited {
            self.insertSubview(contentView, at: 0)
        } else {
            self.addSubview(contentView)
        }
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.fixConstraintsInView(self)
        return contentView
    }

    func fixConstraintsInView(_ container: UIView!) {
        NSLayoutConstraint(item: self,
                           attribute: .leading,
                           relatedBy: .equal, toItem: container,
                           attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self,
                           attribute: .trailing,
                           relatedBy: .equal, toItem: container,
                           attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self,
                           attribute: .top,
                           relatedBy: .equal, toItem: container,
                           attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self,
                           attribute: .bottom,
                           relatedBy: .equal, toItem: container,
                           attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }

    func anchor(top: NSLayoutYAxisAnchor?,
                leading: NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                trailing: NSLayoutXAxisAnchor?,
                padding: UIEdgeInsets = .zero,
                size: CGSize = .zero) {

        self.translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }

        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }

        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }

        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }

        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }

        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    
    func cornerRadius(radius: CGFloat,
                      maskedCorners: CACornerMask,
                      color: UIColor,
                      width: CGFloat) {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = maskedCorners
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }

    // swiftlint:disable superfluous_disable_command
    func applyShadow(shadowColor: CGColor,
                     opacity: Float,
                     offset: CGSize,
                     blur: CGFloat,
                     spread: CGFloat,
                     border: Bool = true) {
        clipsToBounds = false
        layer.masksToBounds = false
        layer.shadowColor = shadowColor
        layer.shadowRadius = blur / 2.0
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        if spread == 0 {
            layer.shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

