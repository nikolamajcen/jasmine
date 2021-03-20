//
//  PackageInstallCommand.swift
//  Jasmine
//
//  Created by Nikola Majcen on 20.03.2021..
//

import Foundation

final class PackageInstallCommand {

    // MARK: - Properties

    private let packageName: String

    // MARK: - Lifecycle

    init(packageName: String) {
        self.packageName = packageName
    }

}

// MARK: - Command

extension PackageInstallCommand: Command {

    var arguments: [String] {
        return ["install", packageName]
    }

}
