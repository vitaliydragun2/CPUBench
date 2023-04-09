import Foundation

class Task
{
	private var cycles: Int
	private var isInteger = false, isFloat = false
	private let onePercentWork: Int
	var isCanceled = false
	private let progressTracker: TaskLauncher.TotalProgressTracker
	var completionHandler: (() -> Void)? = nil
	
	init(cycles: Int,
		 operationType:OperationType,
		 progressTracker: TaskLauncher.TotalProgressTracker)
	{
		self.cycles = cycles
		self.progressTracker = progressTracker
		
		switch operationType
		{
			case .Integer:
				isInteger = true
			case .Float:
				isFloat = true
			case .IntegerAndFloat:
				isInteger = true
				isInteger = true
		}
		
		onePercentWork = cycles / 100
	}
	
	@objc func doSomeWork()
	{
		while cycles > 0
		{
			if isInteger
			{
				var addRes = 0, addArg1 = 10, addArg2 = 100,
					subRes = 0, subArg1 = 10, subArg2 = 100,
					multRes = 0, multArg1 = 10, multArg2 = 100,
					divRes = 0, divArg1 = 10, divArg2 = 100
				
				addRes = addArg1 + addArg2
				subRes = subArg1 - subArg2
				multRes = multArg1 * multArg2
				divRes = divArg1 / divArg2
			}
			if isFloat
			{
				var addRes = 0.0, addArg1 = 10.0, addArg2 = 100.0,
					subRes = 0.0, subArg1 = 10.0, subArg2 = 100.0,
					multRes = 0.0, multArg1 = 10.0, multArg2 = 100.0,
					divRes = 0.0, divArg1 = 10.0, divArg2 = 100.0
				
				addRes = addArg1 + addArg2
				subRes = subArg1 - subArg2
				multRes = multArg1 * multArg2
				divRes = divArg1 / divArg2
			}
		
			self.cycles -= 1
			
			if (cycles % onePercentWork) == 0
			{
				self.progressTracker.singleTaskMadeOnePercentMoreProgress()
				if isCanceled
				{
					break
				}
			}
		}
		
		completionHandler?()
	}
}
