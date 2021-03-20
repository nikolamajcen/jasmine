//
//  ListAllPackagesCommand.swift
//  Jasmine
//
//  Created by Nikola Majcen on 20.03.2021..
//

import Foundation

final class ListAllPackagesCommand {
}

// MARK: - Command

extension ListAllPackagesCommand: Command {

    var arguments: [String] {
        return ["formulae"]
    }

}
