//
//  ManagerUpdateCommand.swift
//  Jasmine
//
//  Created by Nikola Majcen on 21.03.2021..
//

import Foundation

final class ManagerUpdateCommand {
}

// MARK: - Command

extension ManagerUpdateCommand: Command {

    var arguments: [String] {
        return ["update"]
    }

}
