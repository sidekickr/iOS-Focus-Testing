This project was to test out different ways of enabling focus in a SwiftUI app. Specifically I wanted to figure out how to force focus on newly created TextFields
so that when they were added focus was set on them. 

The secondary objective was to enable a user to click a button next to an existing text field and return focus to that particular field. The key was that the object 
backing each text field also had a UUID associated with the backing string. This UUID is what was being used to track which field got focus.

I looked at 5 ways of accomplishing this.

1. Custom `@Environment` of type UUID (ContentViewEnvironment.swift)
2. Custom `@EnvironmentObject` wrapping a published `UUID` (ContentViewEnvironmentObject.swift)
3. Passing a `FocusState<UUID?>.Binding` variable to each view (ContentViewVariablePassing.swift)
4. Custom `@EnvironmentObejct` wrapping a focus binding `FocusState<UUID?>.Binding` (ContentViewBindingEnvironmentObject.swift)
5. Custom `@Environment` of type `FocusState<UUID?>.Binding` (ContentViewBindingEnvironment.swift)


What I found is that:
Solution #1 was able to set focus on each new `TextField` but was not able to change the focus based on the button click.

Solution #2 enabled both required features but required each `TextField` implement `onAppear` and `onReceive` for the solution to work correctly.

Solution #3 enabled both required features but required that each view store and pass the binding down to subviews even if that view didn't need the behaviors.

Solution #4 enabled both required features but did not have the detractions of #2 or #3.

Solution #5 I could not get working.
