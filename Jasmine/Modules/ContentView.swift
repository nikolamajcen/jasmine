//
//  ContentView.swift
//  Jasmine
//
//  Created by Nikola Majcen on 20.03.2021..
//

import SwiftUI

private struct EnvironmentKey {

    private init() {}

    static let launchPath = "SHELL"

}

class TaskManager: TaskDelegate {

    let task = Task(
        launchPath: ProcessInfo.processInfo.environment[EnvironmentKey.launchPath]!,
        command: ListAllPackagesCommand()
    )

    func executeTask() {
        task.delegate = self
        task.execute()
    }

    func taskDidTerminate(_ task: Task, statusCode: Int, output: String?, error: String?) {
        print(statusCode)
    }

}

struct ContentView: View {

    let taskManager = TaskManager()

    var body: some View {
        
        Text("Hello, world!")
            .padding()
        Button("Tap") {
            taskManager.executeTask()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
