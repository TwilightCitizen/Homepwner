#  Homepwner

Homepwner is a non-trivial iOS app written in Objective-C for homeowner's to keep track of their personal belonging and the costs of these items for insurance claim purposes.  It is not an original app of mine.  Rather, it was developed and presented in _iOS Programming: The Big Nerd Ranch Guide_ by Christien Keur, Aaron Hillegass, and Joe Conway.  In it, the authors develop the application across nine chapters, and it increases in sophistication and complexity as they do.

Since Homepwner is not my original app, it will not be published to the App Store, at least not as presented in their book.  Rather, this project exists as a portfolio piece to showcase my understanding of Objective-C, as all my previous iOS applications were authored in Swift.

My code deviates from the book where necessary to account for changes in Apple's APIs that occurred after _iOS Programming: The Big Nerd Ranch Guide_ was published.  Over the course of working through the point at this point—at the time of this writing—three major API changes have warranted such deviations:

- Scene Delegates take on the responsibility of displaying iOS apps' UI instead of the App Delegate.  This allows for multiple instances of an app's UI to be created as separate instances in the application switcher.  Where the book attaches views and viewcontrollers to the main application window in the App Delegate, it should now be attached to a scene associated with the main application window in the Scene Delegate.
- The notification API used in the book thus far—not yet in _this_ app, at the time of this writing—is deprecated in favor of a new one.  Any notifications Homepwner may display will use the new API.
- Objective-C now allows for class properties and unavailable initializers which can provide for a move convenient syntax and semantics for singleton objects like ItemStore.
- ViewWillTransitionToSize replaces the deprecated *AnimateRotationToInterfaceOrientation methods.  Strangely, the orientation is not made available in the replacement method.  Instead, it needs to be determined by examining other objects.
- UIPopoverController and its associated delegate are no longer needed to display popovers.  Now, popovers are easily displayed by simply changing a view controllers modal presentation style and associating a source view or bar button. 
