import Foundation

class Log
{
	static let shared = Log()
	
	private let defaults: UserDefaults
	private var logEntries: [LogEntry]
	
	private let LogEntriesKey: String = "LogEntries"
	
	private var startTime: Date!
	
	init(defaults: UserDefaults = UserDefaults.standard)
	{
		self.defaults = defaults
		
		if let data = defaults.object(forKey: LogEntriesKey) as? Data
		{
			logEntries = try! JSONDecoder().decode([LogEntry].self, from: data)
		}
		else
		{
			logEntries = [LogEntry]()
		}
	}
	
	func testHasStarted()
	{
		startTime = Date()
	}
	
	func addLogEntryWith(numberOfThreads: Int,
						 numberOfCycles:Int,
						 operationType:String)
	{
		let finishTime = Date()
		let timePassed = finishTime.timeIntervalSince(startTime)
		let newEntry = LogEntry(testTimeInSeconds: timePassed,
								testFinishDate: finishTime,
								numberOfThreads: numberOfThreads,
								numberOfCycles: numberOfCycles,
								operationType: operationType)
		logEntries.append(newEntry)
		let encoded = try! JSONEncoder().encode(logEntries)
		defaults.set(encoded, forKey: LogEntriesKey)
		
		startTime = nil
	}
	
	func removeAllEntries()
	{
		logEntries.removeAll()
		defaults.removeObject(forKey: LogEntriesKey)
	}
	
	func getAllDataAsArrayOfStrings() -> [String]
	{
		var strings = [String]()
		for entry in logEntries
		{
			let timeInSeconds = String(format: "%.2f", entry.testTimeInSeconds) + " seconds"
			strings.append(timeInSeconds)
			
			let cyclesPerSecond = Double(entry.numberOfCycles * entry.numberOfThreads) / entry.testTimeInSeconds
			let cyclesPerSecondString = String(format: "%.2f", cyclesPerSecond / 1_000_000_000) + " billion cycles per seconds"
			strings.append(cyclesPerSecondString)
			
			let numberOfThreads = "\(entry.numberOfThreads) thread(s)"
			strings.append(numberOfThreads)
			
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
			let date = dateFormatter.string(from: entry.testFinishDate)
			strings.append(date)
			
			let numberOfCycles = "\(entry.numberOfCycles/1_000_000_000) billion cycles"
			strings.append(numberOfCycles)
			
			strings.append(entry.operationType)
			
			strings.append("-----------")
		}
		return strings
	}
	
	struct LogEntry: Codable
	{
		var testTimeInSeconds: Double
		var testFinishDate: Date
		var numberOfThreads: Int
		var numberOfCycles: Int
		var operationType: String
		
		enum CodingKeys: String, CodingKey
		{
	  		case testTimeInSeconds = "TestTimeInSeconds"
			case testFinishDate = "TestFinishDate"
			case numberOfThreads = "NumberOfThreads"
			case numberOfCycles = "NumberOfCycles"
			case operationType = "OperationType"
  		}
	}
}
