//
//  Extensions.swift
//  Recipe Master
//
//  Created by Nisitha on 1/9/23.
//

import Foundation

extension String {
    func capitalizeFirstLetter()->String {
        return self.prefix(1).uppercased()+self.lowercased().dropFirst()
    }
}
