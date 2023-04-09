import UIKit

fileprivate let ToLogSegue = "ToLog"

class BenchViewController: UIViewController, ProgressDialogDelegate
{
	private weak var benchView: BenchView!
	
	@IBOutlet private var threads: PickerViewDelegateAndDataSource!
	@IBOutlet private var cycles: PickerViewDelegateAndDataSource!
	
	private var taskLauncher: TaskLauncher!
	private var log: Log = Log.shared
	
	override func viewDidLoad()
	{
		benchView = self.view as? BenchView
		
		threads.options = AppData.threadOptions
		cycles.options = AppData.cycleOptions
	}
	
	@IBAction func onStartTestButtonPress(_ sender: UIButton)
	{
		log.testHasStarted()
		
		let progressDialog = ProgressDialog.instance()
		progressDialog.delegate = self
		progressDialog.show()
		
		taskLauncher = TaskLauncher(threads: threads.selectedOption,
									cycles: cycles.selectedOption,
									operationType: benchView.selectedOperationType)
		
		taskLauncher.launchTasks(progressHandler:
		{progress in
			progressDialog.set(progress: progress)
		},
		completionHandler:
		{isSuccessful in
			progressDialog.hide()
			if isSuccessful
			{
				self.log.addLogEntryWith(numberOfThreads: self.threads.selectedOption,
										 numberOfCycles: self.cycles.selectedOption,
										 operationType: self.benchView.selectedOperationType.rawValue)
				
				self.performSegue(withIdentifier: ToLogSegue, sender: nil)
			}
		})
	}
	
	func onCancel(sender: ProgressDialog)
	{
		taskLauncher.cancel()
	}
}
