import XCTest
@testable import CPUBench

final class OverrallProgressTrackerTestCase: XCTestCase
{
    func testProgressCalculation() throws
	{
		let numberOfTasks = 2
		let onePercentProgress = 0.01
		let correctProgress = onePercentProgress / Double(numberOfTasks)
		let updateHandle =
		{ (progress: Double) in
			XCTAssert(progress == correctProgress)
		}
		let tracker = TaskLauncher.TotalProgressTracker(numberOfTasks, updateHandle)
		tracker.singleTaskMadeOnePercentMoreProgress()
    }
}
