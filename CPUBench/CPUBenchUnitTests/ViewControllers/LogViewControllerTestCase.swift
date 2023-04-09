import XCTest
@testable import CPUBench

//A dummy test just to show that it's possible to unit test view controller
//although in most cases it won't be needed since view controller doesn't contain any logic

final class LogViewControllerTestCase: XCTestCase
{
    func testLoadingItems() throws
	{
		let logMockup = LogMockup()
		logMockup.entries = ["Entry1", "Entry2"]
		let viewMockup = LogViewMockup()
		
		let viewController = LogViewController()
		viewController.log = logMockup
		viewController.logView = viewMockup
		viewController.loadData()
		XCTAssert(viewMockup.lines == logMockup.entries)
    }
}
