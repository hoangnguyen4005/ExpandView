//
//  UILabel+Extension.swift
//  ExpandView
//
//  Created by hoangnc on 16/10/20.
//

import UIKit

public extension UILabel {
    
    func addInterlineSpacing(spacingValue: CGFloat = 2) {
        guard let textString = text else { return }
        let attributedString = NSMutableAttributedString(string: textString)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacingValue
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                       value: paragraphStyle,
                                       range: NSMakeRange(0, attributedString.length))
        attributedText = attributedString
    }
}
