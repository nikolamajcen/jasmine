//
//  PackageInfoCommand.swift
//  Jasmine
//
//  Created by Nikola Majcen on 21.03.2021..
//

import Foundation

final class PackageInfoCommand {

    // MARK: - Properties

    private let packageName: String

    // MARK: - Lifecycle

    init(packageName: String) {
        self.packageName = packageName
    }

}

// MARK: - Command

extension PackageInfoCommand: Command {

    var arguments: [String] {
        return ["info", packageName]
    }

}
