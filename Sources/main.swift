import Foundation

func itoa(localizedString path: String) throws -> String? {
    do {
        let contents = try String(contentsOfFile: path)
        let lines = contents.components(separatedBy: .newlines)
        var androidFormat = ""
        
        for line in lines {
            if line.hasPrefix("\"") && line.contains("=") && line.hasSuffix(";") {
                let keyValuePair = line.replacingOccurrences(of: "\"", with: "")
                    .replacingOccurrences(of: ";", with: "")
                    .components(separatedBy: "=")
                
                if keyValuePair.count == 2 {
                    let key = keyValuePair[0].trimmingCharacters(in: .whitespaces)
                    let value = keyValuePair[1].trimmingCharacters(in: .whitespaces)
                    
                    let androidKey = convertKeyFormat(key)
                    let androidValue = convertPlaceholderFormat(value)
                    androidFormat += "<string name=\"\(androidKey)\">\(androidValue)</string>\n"
                }
            }
        }
        let xmlFormat = """
                <?xml version="1.0" encoding="UTF-8"?>
                <!--
                 Project: itoa (iOS to Android Localized String)
                 Exported by: itoa Swift Package
                 Exported at: \(formattedCurrentDate())
                -->
                <resources xmlns:xliff="urn:oasis:names:tc:xliff:document:1.2">
                \(androidFormat)
                </resources>
                """
        return xmlFormat
    }
    catch {
        throw error
    }
}

func formattedCurrentDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"
    return dateFormatter.string(from: Date())
}

func convertKeyFormat(_ key: String) -> String {
    key.replacingOccurrences(of: ".", with: "_")
}

func convertPlaceholderFormat(_ value: String) -> String {
    value.replacingOccurrences(of: "%@", with: "%s")
}

guard CommandLine.arguments.count == 3 else {
    print("Usage: itoa inputFile(iOS) outputFile(Android)")
    print("itoa Localized.strings strings.xml")
    exit(1)
}

let inputFilePath = CommandLine.arguments[1]
let outputFilePath = CommandLine.arguments[2]

if let convertedString = try? itoa(localizedString: inputFilePath) {
    do {
        try convertedString.write(toFile: outputFilePath, atomically: true, encoding: .utf8)
        print("Android localized file: \(outputFilePath)")
    } catch {
        print("Failed: \(error)")
    }
}
