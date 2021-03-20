//
//  Task.swift
//  Jasmine
//
//  Created by Nikola Majcen on 20.03.2021..
//

import Foundation

protocol TaskDelegate: class {

    func taskDidTerminate(_ task: Task, statusCode: Int, output: String?, error: String?)

}

final class Task {

    // MARK: - Properties

    weak var delegate: TaskDelegate?

    private let process = Process()
    private let errorPipe = Pipe()
    private let errorFileHandle: FileHandle
    private var errorData = Data()
    private let outputPipe = Pipe()
    private let outputFileHandle: FileHandle
    private var outputData = Data()

    private var errorObserver: Any?
    private var outputObserver: Any?
    private var terminateObserver: Any?


    // MARK: - Lifecycle

    init(launchPath: String, command: Command) {
        process.arguments = Task.processArguments(from: command.arguments)
        process.launchPath = launchPath
        process.standardError = errorPipe
        process.standardOutput = outputPipe
        errorFileHandle = errorPipe.fileHandleForReading
        outputFileHandle = outputPipe.fileHandleForReading
    }

    // MARK: - Public methods

    func execute() {
        guard !process.isRunning else { return }
        initializeObservers()
        runProcess()
    }

}

// MARK: - Private methods

private extension Task {

    // MARK: - Observer configuration

    func initializeObservers() {
        initializeErrorObserver()
        initializeOutputObserver()
        initializeTerminateObserver()
    }

    func initializeErrorObserver() {
        errorFileHandle.waitForDataInBackgroundAndNotify()
        errorObserver = NotificationCenter.default.addObserver(
            forName: NSNotification.Name.NSFileHandleDataAvailable,
            object: errorFileHandle,
            queue: nil,
            using: { [weak self] in self?.handleErrorDataAvailable($0) }
        )
    }

    func initializeOutputObserver() {
        outputFileHandle.waitForDataInBackgroundAndNotify()
        outputObserver = NotificationCenter.default.addObserver(
            forName: NSNotification.Name.NSFileHandleDataAvailable,
            object: outputFileHandle,
            queue: nil,
            using: { [weak self] in self?.handleOutputDataAvailable($0) }
        )
    }

    func initializeTerminateObserver() {
        terminateObserver = NotificationCenter.default.addObserver(
            forName: Process.didTerminateNotification,
            object: nil,
            queue: nil,
            using: { [weak self] in self?.handleProcessDidTerminate($0)  }
        )
    }

    // MARK: - Process events

    func runProcess() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            try? self.process.run()
            self.process.waitUntilExit()
        }
    }

    func handleErrorDataAvailable(_ notification: Notification) {
        guard let fileHandle = notification.object as? FileHandle else { return }
        handleFileHandleDataAvailable(fileHandle, data: &errorData)
    }

    func handleOutputDataAvailable(_ notification: Notification) {
        guard let fileHandle = notification.object as? FileHandle else { return }
        handleFileHandleDataAvailable(fileHandle, data: &outputData)
    }

    func handleProcessDidTerminate(_ notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let process = notification.object as? Process else { return }
            self.removeObserverIfNeeded(self.terminateObserver)
            self.delegate?.taskDidTerminate(
                self,
                statusCode: Int(process.terminationStatus),
                output: Task.string(from: self.outputData),
                error: Task.string(from: self.errorData)
            )
        }
    }

    func handleFileHandleDataAvailable(_ fileHandle: FileHandle, data: inout Data) {
        if fileHandle.availableData.isEmpty {
            removeObserverIfNeeded(fileHandle)
        } else {
            data.append(fileHandle.readDataToEndOfFile())
        }
    }

    func removeObserverIfNeeded(_ observer: Any?) {
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }

}

// MARK: - Static methods

private extension Task {

    static func processArguments(from arguments: [String]) -> [String] {
        #warning("TODO: Inject brew path via init method.")
        return ["-c", "usr/local/bin/brew \(arguments.joined(separator: " "))"]
    }

    static func string(from data: Data?) -> String? {
        guard let data = data, data.count > 0, let string = String(data: data, encoding: .utf8) else {
            return nil
        }
        return string
    }

}
