import AppIntents

struct ShuffleList: AppIntent, CustomIntentMigratedAppIntent {
	static let intentClassName = "ShuffleListIntent"

	static let title: LocalizedStringResource = "Shuffle List"

	static let description = IntentDescription(
"""
Shuffles the input list.

Note: If you get the error “The operation failed because Shortcuts couldn't convert from Text to NSString.”, just change the preview to show a list view instead. This is a bug in the Shortcuts app.
""",
		categoryName: "List"
	)

	@Parameter(
		title: "List",
		description: "Tap and hold the parameter to select a variable to a list. Don't quick tap it.",
		supportedTypeIdentifiers: ["public.item"]
	)
	var list: [IntentFile]

	@Parameter(title: "Limit", default: false)
	var shouldLimit: Bool

	@Parameter(
		title: "Maximum Results",
		default: 10,
		controlStyle: .field,
		inclusiveRange: (0, 9_999_999_999)
	)
	var limit: Int

	static var parameterSummary: some ParameterSummary {
		When(\.$shouldLimit, .equalTo, true) {
			Summary("Shuffle \(\.$list)") {
				\.$shouldLimit
				// TODO: FB - It would be nice if you could use an if-statement here instead of having two summaries.
				\.$limit
			}
		} otherwise: {
			Summary("Shuffle \(\.$list)") {
				\.$shouldLimit
			}
		}
	}

	func perform() async throws -> some IntentResult & ReturnsValue<[IntentFile]> {
		var list = list.shuffled()

		if shouldLimit {
			list = Array(list.prefix(limit))
		}

		return .result(value: list)
	}
}
