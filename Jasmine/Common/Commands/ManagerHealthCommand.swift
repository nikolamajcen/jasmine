//
//  ManagerHealthCommand.swift
//  Jasmine
//
//  Created by Nikola Majcen on 21.03.2021..
//

import Foundation

final class ManagerHealthCommand {
}

// MARK: - Command

extension ManagerHealthCommand: Command {

    var arguments: [String] {
        return ["doctor"]
    }

}
