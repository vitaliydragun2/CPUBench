import UIKit

class LogView: UIView
{
	@IBOutlet private weak var hideButton: UIButton!
	@IBOutlet private weak var scrollView: UIScrollView!
	@IBOutlet private weak var stackView: UIStackView!
	@IBOutlet private weak var clearButton: UIButton!
	
	override func awakeFromNib()
	{
		hideButton.layer.borderWidth = 1
		hideButton.layer.borderColor = UIColor.systemBlue.cgColor
		hideButton.layer.cornerRadius = 10
		
		clearButton.layer.borderWidth = 1
		clearButton.layer.borderColor = UIColor.systemBlue.cgColor
		clearButton.layer.cornerRadius = 10
	}
	
	func displayLines(_ lines: [String])
	{
		if lines.count == 0
		{
			self.addNoEntriesLabel()
			return
		}
		
		for line in lines
		{
			let label = UILabel()
			label.text = line
			label.numberOfLines = 0
			label.translatesAutoresizingMaskIntoConstraints = false
			
			stackView.addArrangedSubview(label)
		}
	}
	
	func removeAllLines()
	{
		for subview in stackView.arrangedSubviews
		{
			subview.removeFromSuperview()
		}
		self.addNoEntriesLabel()
	}
	
	private func addNoEntriesLabel()
	{
		let label = UILabel()
		label.text = "No entries"
		label.numberOfLines = 1
		label.textColor = .black
		scrollView.addSubview(label)
		label.translatesAutoresizingMaskIntoConstraints = false
		
		label.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
		label.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
	}
}
