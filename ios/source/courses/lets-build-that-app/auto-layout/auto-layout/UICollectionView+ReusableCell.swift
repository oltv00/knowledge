import UIKit

extension UICollectionView: ReusableCell {
    func cell<T>(withReuseIdentifier identifier: String,
                 for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! T
    }
}
