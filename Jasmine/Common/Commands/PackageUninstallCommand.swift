//
//  PackageUninstallCommand.swift
//  Jasmine
//
//  Created by Nikola Majcen on 21.03.2021..
//

import Foundation

final class PackageUninstallCommand {

    // MARK: - Properties

    private let packageName: String

    // MARK: - Lifecycle

    init(packageName: String) {
        self.packageName = packageName
    }

}

// MARK: - Command

extension PackageUninstallCommand: Command {

    var arguments: [String] {
        return ["uninstall", packageName]
    }

}
