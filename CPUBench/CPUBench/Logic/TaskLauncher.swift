import Foundation

class TaskLauncher
{
	private var tasks: [Task]
	private var isCancelled = false
	private var progressTracker: TotalProgressTracker!
	
	init(threads: Int,
		 cycles: Int,
		 operationType: OperationType,
		 tasks:[Task] = [Task](),
		 progressTracker: TotalProgressTracker = TotalProgressTracker(-1, {_ in }))
	{
		self.tasks = tasks
		self.progressTracker = progressTracker
		self.progressTracker.numberOfTasks = threads
		
		if tasks.isEmpty
		{
			let task = Task(cycles: cycles,
							operationType: operationType,
							progressTracker: progressTracker)
			self.tasks.append(task)
		}
	}
	
	func launchTasks(progressHandler: @escaping (Double) -> Void,
					 completionHandler: @escaping (Bool) -> Void)
	{
		progressTracker.updateHandler = progressHandler
		
		let group = DispatchGroup()
		
		for task in tasks
		{
			group.enter()
			task.completionHandler =
			{
				group.leave()
			}
			
			let thread = Thread(target: task,
								selector: #selector(task.doSomeWork),
								object: nil)
			thread.start()
		}
		group.notify(queue: .main)
		{
			completionHandler(!self.isCancelled)
		}
	}
	
	func cancel()
	{
		isCancelled = true
		for task in tasks
		{
			task.isCanceled = true
		}
	}
	
	class TotalProgressTracker
	{
		var numberOfTasks: Int
		var updateHandler: (Double) -> Void
		
		private var totalProgress = 0.0
		
		init(_ numberOfTasks: Int,
			 _ updateHandler: @escaping (Double) -> Void)
		{
			self.numberOfTasks = numberOfTasks
			self.updateHandler = updateHandler
		}
		
		func singleTaskMadeOnePercentMoreProgress()
		{
			totalProgress = totalProgress + 0.01 / Double(numberOfTasks)
			DispatchQueue.main.async
			{
				self.updateHandler(self.totalProgress)
			}
		}
	}
}
