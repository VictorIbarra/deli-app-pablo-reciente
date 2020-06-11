import UIKit
import Presentr

extension UIViewController {
    public func customPresent(viewController: UIViewController, animated: Bool, presentr: Presentr? = nil, completion: (() -> Void)? = nil) {
        let minimumVersion = OperatingSystemVersion(majorVersion: 13, minorVersion: 0, patchVersion: 0)
        
        if ProcessInfo().isOperatingSystemAtLeast(minimumVersion) || presentr == nil {
            present(viewController, animated: animated, completion: completion)
        } else {
            customPresentViewController(presentr!, viewController: viewController, animated: animated, completion: completion)
        }
    }
}
