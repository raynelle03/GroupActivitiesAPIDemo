# GroupActivitiesAPIDemo


GroupAPI is the framework powering SharePlay.

This framework uses the FaceTime infrastructure to synchronise your app’s activities and to invite other participants to join those activities.

**How to share custom data using the Group Activity API**

- First, we have to import the **GroupActivity** framework to create an activity which conforms to the **GroupActivity protocol**. The activity defines specific parts of our shared experience like the title which gets presented when a person starts the activity and what kind of shared experience we would like to use.
- Once we have **created the activity** we need to s**tart/activate  this activity (this will be triggered on a button  click).**
- We then  need to check if  a new participant joins. The system will add a new element to the  created activity’s session ****sequence when someone joins the session.
- We then need to create a ***GroupSessionMessenger*** from the given session, which is basically responsible for receiving and sending all data.
- Once the sent message has been received from the other device , we can update the UI.

Note: **GroupSessionMessenger** is meant for smaller payloads, so if you try to stream larger assets like files or videos , an error will be thrown.

****Supporting Coordinated Media Playback****

- First, we have to import the **GroupActivity** framework to create an activity which conforms to the **GroupActivity protocol**. The activity defines specific parts of our shared experience like the title which gets presented when a person starts the activity and what kind of shared experience we would like to use.
- Create an activity.
- We then call [prepareForActivation()](https://developer.apple.com/documentation/groupactivities/groupactivity/prepareforactivation()) method, which enables the system to present an interface for the user to select  their preferred action.
- The call returns a result that indicates the appropriate action to take. A result of [GroupActivityActivationResult.activationDisabled](https://developer.apple.com/documentation/groupactivities/groupactivityactivationresult/activationdisabled)
 indicates that group playback isn’t active, or the user selects to play the movie locally only.
- A result of [GroupActivityActivationResult.activationPreferred](https://developer.apple.com/documentation/groupactivities/groupactivityactivationresult/activationpreferred) indicates that group playback is possible, and the user wants to start a group activity. When this occurs, the sample calls the activity’s activate() method, which starts a group session and shares the activity with the group.
- When the App activates a activity, the system creates a group session. It accesses the session by calling the [sessions()](https://developer.apple.com/documentation/groupactivities/groupactivity/sessions())method, which returns sessions for the activity as an asynchronous sequence.
- When the sample receives a new session, it sets it as the active group session, and then joins it, which makes the app eligible to participate in the session. Then it subscribes to the session’s activity publisher and, when it receives a new value.
- To enable group playback is to access the player’s coordinator and connect it with the group session. It does this by calling the coordinator object’s [coordinateWithSession(_:)](https://developer.apple.com/documentation/avfoundation/avplaybackcoordinator/3787796-coordinatewithsession)
 method, which connects it with the coordinators of other participants in the session.
