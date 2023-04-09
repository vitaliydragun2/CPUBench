import UIKit

protocol ProgressDialogDelegate: AnyObject
{
	func onCancel(sender: ProgressDialog)
}

class ProgressDialog: UIView
{
	@IBOutlet private weak var progressLabel: UILabel!
	@IBOutlet private weak var cancelButton: UIButton!
	@IBOutlet private weak var progressView: UIProgressView!
	@IBOutlet private weak var dialogWindow: UIView!
	
	weak var delegate: ProgressDialogDelegate?
	{
		didSet
		{
			cancelButton.addTarget(self, action: #selector(callDelegate), for: .touchUpInside)
		}
	}
	
	override func awakeFromNib()
	{
		dialogWindow.layer.shadowOffset = CGSize(width: 2, height: 2)
		dialogWindow.layer.shadowOpacity = 0.5
	}
	
	static func instance() -> ProgressDialog
	{
		let bundle = Bundle(for: self)
		let nib = bundle.loadNibNamed("\(Self.self)", owner: self)
		return nib!.first as! Self
	}
	
	func show()
	{
		if case let window?? = UIApplication.shared.delegate?.window
		{
			window.addSubview(self)
			self.translatesAutoresizingMaskIntoConstraints = false
			
			NSLayoutConstraint.activate([self.topAnchor.constraint(equalTo: window.topAnchor),
										 self.bottomAnchor.constraint(equalTo: window.bottomAnchor),
										 self.leadingAnchor.constraint(equalTo: window.leadingAnchor),
										 self.trailingAnchor.constraint(equalTo: window.trailingAnchor)])
		}
	}
	
	func set(progress: Double)
	{
		progressView.setProgress(Float(progress), animated: true)
		progressLabel.text = "\(Int(progress*100))%"
	}
	
	func hide()
	{
		self.removeFromSuperview()
	}
	
	@objc private func callDelegate()
	{
		delegate?.onCancel(sender: self)
	}
}
