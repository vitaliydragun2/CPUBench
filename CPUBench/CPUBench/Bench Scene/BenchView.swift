import UIKit

class BenchView: UIView
{
	@IBOutlet private weak var numberOfThreadsPickerView: UIPickerView!
	@IBOutlet private weak var tasksPerThreadPickerView: UIPickerView!
	@IBOutlet private weak var operationTypeSegmentedCointrol: UISegmentedControl!
	@IBOutlet private weak var startTestButton: UIButton!
	@IBOutlet private weak var logButton: UIButton!
	
	var selectedOperationType: OperationType
	{
		switch operationTypeSegmentedCointrol.selectedSegmentIndex
		{
			case 0:
				return .IntegerAndFloat
			case 1:
				return .Integer
			case 2:
				return .Float
			default:
				return .IntegerAndFloat
		}
	}
	
	override func awakeFromNib()
	{
		numberOfThreadsPickerView.layer.borderWidth = 1
		numberOfThreadsPickerView.layer.borderColor = UIColor.systemBlue.cgColor
		numberOfThreadsPickerView.layer.cornerRadius = 10
		
		tasksPerThreadPickerView.layer.borderWidth = 1
		tasksPerThreadPickerView.layer.borderColor = UIColor.systemBlue.cgColor
		tasksPerThreadPickerView.layer.cornerRadius = 10
		
		startTestButton.layer.borderWidth = 1
		startTestButton.layer.borderColor = UIColor.systemBlue.cgColor
		startTestButton.layer.cornerRadius = 10
		
		logButton.layer.borderWidth = 1
		logButton.layer.borderColor = UIColor.systemBlue.cgColor
		logButton.layer.cornerRadius = 10
	}
}
