//
//  Extensions.swift
//  NetflixClone
//
//  Created by Akın Aksoy on 20.04.2022.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
