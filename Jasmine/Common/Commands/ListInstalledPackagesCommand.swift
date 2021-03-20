//
//  ListInstalledPackagesCommand.swift
//  Jasmine
//
//  Created by Nikola Majcen on 21.03.2021..
//

import Foundation

final class ListInstalledPackagesCommand {
}

// MARK: - Command

extension ListInstalledPackagesCommand: Command {

    var arguments: [String] {
        return ["list"]
    }

}
