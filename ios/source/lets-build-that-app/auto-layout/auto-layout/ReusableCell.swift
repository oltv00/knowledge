import struct Foundation.IndexPath

protocol ReusableCell {
    func cell<T>(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> T
}
