import ReSwift

// all of the actions that can be applied to the state
struct StatusActionStart: Action {}
struct StatusActionStopping: Action {}
struct StatusActionStopped: Action {}

struct EditTextAction: Action {
	let payload: String
}
