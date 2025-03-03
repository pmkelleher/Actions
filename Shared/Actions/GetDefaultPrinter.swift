#if canImport(AppKit)
import AppIntents

@available(iOS, unavailable)
struct GetDefaultPrinter: AppIntent {
	static let title: LocalizedStringResource = "Get Default Printer (macOS-only)"

	static let description = IntentDescription(
		"Returns the default printer.",
		categoryName: "Device",
		searchKeywords: [
			"printers",
			"print"
		]
	)

	static var parameterSummary: some ParameterSummary {
		Summary("Get default printer")
	}

	func perform() async throws -> some IntentResult & ReturnsValue<PrinterAppEntity> {
		guard let defaultPrinter = Printer.defaultPrinter else {
			throw "No default printer.".toError
		}

		return .result(value: .init(defaultPrinter))
	}
}
#endif
