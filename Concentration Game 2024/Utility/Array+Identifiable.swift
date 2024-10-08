//
//  Array+Identifiable.swift
//  Concentration Game 2024
//
//  Created by Stephen Liddle on 10/8/24.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching targetElement: Element) -> Int? {
        for index in self.indices {
            if self[index].id == targetElement.id {
                return index
            }
        }

        return nil
    }
}
