import XCTest
@testable import CPUBench
import Foundation

final class LogTestCase: XCTestCase
{
	let currentTime = Date()
	let timeInSeconds = 1.0
	let numberOfThreads = 1
	let numberOfCycles = 1000
	let operationType = "Integer"
	
    func testAddingItem() throws
	{
		let defaults = UserDefaultsMock(suiteName: "Test")!
		let log = Log(defaults: defaults)
		log.testHasStarted()
		log.addLogEntryWith(numberOfThreads: numberOfThreads,
							numberOfCycles: numberOfCycles,
							operationType: operationType)
		
		let savedLogEntries = try! JSONDecoder().decode([Log.LogEntry].self,
														from: defaults.rawData)
		if let logEntry = savedLogEntries.first
		{
			XCTAssert(logEntry.testFinishDate > currentTime &&
					  logEntry.testTimeInSeconds > 0 &&
					  logEntry.numberOfThreads == numberOfThreads &&
					  logEntry.numberOfCycles == numberOfCycles &&
					  logEntry.operationType == operationType)
		}
		else
		{
			XCTAssert(false)
		}
	}
     
	func testRemovingItems() throws
	{
		let defaults = UserDefaultsMock(suiteName: "Test")!
		let log = Log(defaults: defaults)
		
		log.removeAllEntries()
		
		XCTAssert(defaults.rawData == nil)
	}
}
