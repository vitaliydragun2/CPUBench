import XCTest
@testable import CPUBench

class TaskMockup: Task
{
	init()
	{
		let mockupTracker = TaskLauncher.TotalProgressTracker(0, {_ in })
		super.init(cycles: 0, operationType: .IntegerAndFloat, progressTracker: mockupTracker)
	}
	
	var cycles = 1_000_000_000_000_000
	
	override func doSomeWork()
	{
		while cycles > 0
		{
			if isCanceled
			{
				break
			}
			cycles -= 1
		}
		completionHandler?()
	}
}

class UserDefaultsMock: UserDefaults
{
	var rawData: Data!
	
	override init?(suiteName suitename: String?)
	{
		UserDefaults().removePersistentDomain(forName: suitename!)
		super.init(suiteName: suitename)
	}
	
	override func set(_ value: Any?, forKey defaultName: String)
	{
		rawData = value as? Data
	}
	
	override func object(forKey defaultName: String) -> Any?
	{
		return rawData
	}
	
	override func removeObject(forKey defaultName: String)
	{
		rawData = nil
	}
}

class LogViewMockup: LogView
{
	var lines: [String]! = nil
	
	override func displayLines(_ lines: [String])
	{
		self.lines = lines
	}
}

class LogMockup: Log
{
	var entries: [String]!
	
	override func getAllDataAsArrayOfStrings() -> [String]
	{
		return entries
	}
}
