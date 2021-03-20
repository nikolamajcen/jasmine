//
//  PackageSearchCommand.swift
//  Jasmine
//
//  Created by Nikola Majcen on 21.03.2021..
//

import Foundation

final class PackageSearchCommand {

    // MARK: - Properties

    private let term: String

    // MARK: - Lifecycle

    init(term: String) {
        self.term = term
    }

}

// MARK: - Command

extension PackageSearchCommand: Command {

    var arguments: [String] {
        return ["search", term]
    }

}
