import UIKit

extension UIView {
    
    func addSubview(_ subview: UIView, constraints: Bool = true) {
        
        subview.translatesAutoresizingMaskIntoConstraints = !constraints
        addSubview(subview)
    }
    
    func addSubviews(_ subviews: [UIView], constraints: Bool = true) {
        
        for subview in subviews {
        
            subview.translatesAutoresizingMaskIntoConstraints = !constraints
            addSubview(subview)
        }
    }
    
}
