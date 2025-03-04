import AppIntents
import CoreImage

struct GetDominantColorsOfImage: AppIntent {
	static let title: LocalizedStringResource = "Get Dominant Colors of Image"

	static let description = IntentDescription(
"""
Returns the dominant colors of the image.

You could use this to make a palette of the main colors in an image.

Dominant color is the most seen color in an image, while average color is all the colors in an image mixed into one.
""",
		categoryName: "Image",
		searchKeywords: [
			"colour",
			"primary",
			"palette",
			"average"
		]
	)

	@Parameter(
		title: "Image",
		supportedTypeIdentifiers: ["public.image"]
	)
	var image: IntentFile

	@Parameter(
		title: "Count",
		description: "The number of colors to return. The colors are ordered by most dominant first. Max 128.",
		default: 5,
		inclusiveRange: (1, 128)
	)
	var count: Int

	static var parameterSummary: some ParameterSummary {
		Summary("Get \(\.$count) dominant colors of \(\.$image)")
	}

	func perform() async throws -> some IntentResult & ReturnsValue<[ColorAppEntity]> {
		guard let image = CIImage(data: image.data) else {
			throw "Invalid or unsupported image.".toError
		}

		let colors = try image.dominantColors(count: count).map { ColorAppEntity($0) }

		return .result(value: colors)
	}
}
