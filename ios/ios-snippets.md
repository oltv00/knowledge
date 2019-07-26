# Snippets
- [Snippets](#snippets)
  - [syncOnMainThread](#synconmainthread)
  - [Child view controllers](#child-view-controllers)

## syncOnMainThread
```swift
func syncOnMainThread<T>(execute block: () throws -> T) rethrows -> T {
    if Thread.isMainThread {
        return try block()
    }
    return try DispatchQueue.main.sync(execute: block)
}
```

## Child view controllers

```swift
In order to add a child view controller, we need to do the following:

// Add the view controller as a child
addChildViewController(child)

// Move the child view controller's view to the parent's view
view.addSubview(child.view)

// Notify the child that it was moved to a parent
child.didMove(toParentViewController: self)

Then, to remove a child view controller, we also need to perform 3 different steps:

// Notify the child that it's about to be moved away from its parent
child.willMove(toParentViewController: nil)

// Remove the child
child.removeFromParentViewController()

// Remove the child view controller's view from its parent
child.view.removeFromSuperview()
```
