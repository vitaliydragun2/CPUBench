import UIKit

class LogViewController: UIViewController
{
	weak var logView: LogView!
	var log = Log.shared
	
	override func viewDidLoad()
	{
		logView = view as? LogView
		
		self.loadData()
	}
	
	@IBAction func onHideButtonPress(_ sender: UIButton)
	{
		dismiss(animated: true)
	}
	
	@IBAction func onClearButtonPress(_ sender: UIButton)
	{
		log.removeAllEntries()
		logView.removeAllLines()
	}
	
	func loadData()
	{
		logView.displayLines(log.getAllDataAsArrayOfStrings())
	}
}
