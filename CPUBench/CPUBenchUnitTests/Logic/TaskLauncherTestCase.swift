import XCTest
@testable import CPUBench

final class TaskLauncherTestCase: XCTestCase
{
	func testSuccessfulCompletion() throws
	{
		let taskMockup = TaskMockup()
		taskMockup.cycles = 1000

		let taskLauncher = TaskLauncher(threads: 1,
										cycles: 1000,
										operationType: .IntegerAndFloat,
										tasks: [taskMockup])
		
		let promise = expectation(description: "successful_finish")
		
		taskLauncher.launchTasks { _ in }
		completionHandler:
		{ isSuccessful in
			if isSuccessful
			{
				promise.fulfill()
			}
		}
		waitForExpectations(timeout: 0.1)
	}
	
	func testCancel() throws
	{
		let taskMockup = TaskMockup()
		let taskLauncher = TaskLauncher(threads: 1,
										cycles: 100,
										operationType: .IntegerAndFloat,
										tasks: [taskMockup])
		
		let promise = expectation(description: "Cancel")
		
		taskLauncher.launchTasks { _ in }
		completionHandler:
		{ isSuccessful in
			if !isSuccessful
			{
				promise.fulfill()
			}
		}
		
		taskLauncher.cancel()
		
		waitForExpectations(timeout: 10)
	}
}
