//
//  Extension.swift
//  uLesson
//
//  Created by Oluwakamiye Akindele on 05/03/2021.
//

import UIKit

extension UIButton {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension UIImageView {
    func load(url: URL, defaultImageName: String) {
        self.image = UIImage(systemName: "arrow.triangle.2.circlepath.circle")
        self.backgroundColor = .gray
        self.tintColor = .white
        self.contentMode = .scaleAspectFit
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        self?.backgroundColor = .clear
                    }
                }
            }
        }
    }
}
