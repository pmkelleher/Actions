import Foundation
import AppIntents

enum Constants {
	static let keychainKey_openAI = "openai-api-token"
}

func initSentry() {
	SSApp.initSentry("https://12c8785fd2924c9a9c0f6bb1d91be79e@o844094.ingest.sentry.io/6041555")
}

/*
Intent categories:
- List
- Dictionary
- Text
- Image
- Audio
- Device
- Web
- Random
= Number
- File
- Date
- URL
- Music
- Formatting
- Parse / Generate
- Math
- Location
- AI
- Meta
- Global Variable
- Miscellaneous
*/

struct ColorAppEntity: TransientAppEntity {
	static let typeDisplayRepresentation = TypeDisplayRepresentation(name: "Color")

	@Property(title: "Hex")
	var hex: String

	@Property(title: "Hex Number")
	var hexNumber: Int

	var displayRepresentation: DisplayRepresentation {
		.init(
			title: "\(hex)",
			subtitle: "", // Required to show the `image`. (iOS 16.2)
			image: color.flatMap {
				XImage.color($0, size: CGSize(width: 1, height: 1), scale: 1)
					.toDisplayRepresentationImage()
			}
		)
	}

	var color: XColor?
}

extension ColorAppEntity {
	init(_ color: XColor) {
		self.color = color
		self.hex = color.hexString
		self.hexNumber = color.hex
	}
}
