import UIKit
class PickerViewDelegateAndDataSource: NSObject, UIPickerViewDelegate, UIPickerViewDataSource
{
	var options: [Int]!
	{
		didSet
		{
			selectedOption = options[0]
		}
	}
	private(set) var selectedOption: Int!
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int
	{
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
	{
		return options.count
	}

	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
	{
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		return formatter.string(from: NSNumber(integerLiteral: options[row]))
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
	{
		selectedOption = options[row]
	}
}
