import XCTest
@testable import CPUBench

final class TaskTestCase: XCTestCase
{
	private let mockupTracker = TaskLauncher.TotalProgressTracker(0, {_ in })
	
    func testSuccessfulCompletion() throws
	{
		let task = Task(cycles: 1000,
						operationType: .IntegerAndFloat,
						progressTracker: mockupTracker)
		task.completionHandler =
		{
			XCTAssert(true)
		}
		task.doSomeWork()
    }
	
	func testCancel() throws
	{
		let expectedTimeout = 10.0
		let promise = expectation(description: "Just wait \(expectedTimeout) second(s)")
		let tooMuchToFinishInExpectedTimeout = 1_000_000_000
		let task = Task(cycles: tooMuchToFinishInExpectedTimeout,
						operationType: .IntegerAndFloat,
						progressTracker: mockupTracker)
		task.completionHandler =
		{
			promise.fulfill()
		}
		
		let testQueue = DispatchQueue(label: "test.queue")
		testQueue.async
		{
			task.doSomeWork()
		}
		task.isCanceled = true
		
		waitForExpectations(timeout: expectedTimeout)
	}
}
