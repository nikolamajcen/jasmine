//
//  ManagerConfigCommand.swift
//  Jasmine
//
//  Created by Nikola Majcen on 21.03.2021..
//

import Foundation

final class ManagerConfigCommand {
}

// MARK: - Command

extension ManagerConfigCommand: Command {

    var arguments: [String] {
        return ["config"]
    }

}
