//
//  ParameterEncoding.swift
//
<<<<<<< Updated upstream
//  Copyright (c) 2014 Alamofire Software Foundation (http://alamofire.org/)
=======
//  Copyright (c) 2014-2018 Alamofire Software Foundation (http://alamofire.org/)
>>>>>>> Stashed changes
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

<<<<<<< Updated upstream
/// HTTP method definitions.
///
/// See https://tools.ietf.org/html/rfc7231#section-4.3
public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

// MARK: -

=======
>>>>>>> Stashed changes
/// A dictionary of parameters to apply to a `URLRequest`.
public typealias Parameters = [String: Any]

/// A type used to define how a set of parameters are applied to a `URLRequest`.
public protocol ParameterEncoding {
<<<<<<< Updated upstream
    /// Creates a URL request by encoding parameters and applying them onto an existing request.
    ///
    /// - parameter urlRequest: The request to have parameters applied.
    /// - parameter parameters: The parameters to apply.
    ///
    /// - throws: An `AFError.parameterEncodingFailed` error if encoding fails.
    ///
    /// - returns: The encoded request.
=======
    /// Creates a `URLRequest` by encoding parameters and applying them on the passed request.
    ///
    /// - Parameters:
    ///   - urlRequest: `URLRequestConvertible` value onto which parameters will be encoded.
    ///   - parameters: `Parameters` to encode onto the request.
    ///
    /// - Returns:      The encoded `URLRequest`.
    /// - Throws:       Any `Error` produced during parameter encoding.
>>>>>>> Stashed changes
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest
}

// MARK: -

/// Creates a url-encoded query string to be set as or appended to any existing URL query string or set as the HTTP
/// body of the URL request. Whether the query string is set or appended to any existing URL query string or set as
/// the HTTP body depends on the destination of the encoding.
///
/// The `Content-Type` HTTP header field of an encoded request with HTTP body is set to
/// `application/x-www-form-urlencoded; charset=utf-8`.
///
/// There is no published specification for how to encode collection types. By default the convention of appending
/// `[]` to the key for array values (`foo[]=1&foo[]=2`), and appending the key surrounded by square brackets for
/// nested dictionary values (`foo[bar]=baz`) is used. Optionally, `ArrayEncoding` can be used to omit the
/// square brackets appended to array keys.
///
/// `BoolEncoding` can be used to configure how boolean values are encoded. The default behavior is to encode
/// `true` as 1 and `false` as 0.
public struct URLEncoding: ParameterEncoding {
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
    // MARK: Helper Types

    /// Defines whether the url-encoded query string is applied to the existing query string or HTTP body of the
    /// resulting URL request.
<<<<<<< Updated upstream
    ///
    /// - methodDependent: Applies encoded query string result to existing query string for `GET`, `HEAD` and `DELETE`
    ///                    requests and sets as the HTTP body for requests with any other HTTP method.
    /// - queryString:     Sets or appends encoded query string result to existing query string.
    /// - httpBody:        Sets encoded query string result as the HTTP body of the URL request.
    public enum Destination {
        case methodDependent, queryString, httpBody
    }

    /// Configures how `Array` parameters are encoded.
    ///
    /// - brackets:        An empty set of square brackets is appended to the key for every value.
    ///                    This is the default behavior.
    /// - noBrackets:      No brackets are appended. The key is encoded as is.
    public enum ArrayEncoding {
        case brackets, noBrackets

        func encode(key: String) -> String {
=======
    public enum Destination {
        /// Applies encoded query string result to existing query string for `GET`, `HEAD` and `DELETE` requests and
        /// sets as the HTTP body for requests with any other HTTP method.
        case methodDependent
        /// Sets or appends encoded query string result to existing query string.
        case queryString
        /// Sets encoded query string result as the HTTP body of the URL request.
        case httpBody

        func encodesParametersInURL(for method: HTTPMethod) -> Bool {
            switch self {
            case .methodDependent: return [.get, .head, .delete].contains(method)
            case .queryString: return true
            case .httpBody: return false
            }
        }
    }

    /// Configures how `Array` parameters are encoded.
    public enum ArrayEncoding {
        /// An empty set of square brackets is appended to the key for every value. This is the default behavior.
        case brackets
        /// No brackets are appended. The key is encoded as is.
        case noBrackets
        /// Brackets containing the item index are appended. This matches the jQuery and Node.js behavior.
        case indexInBrackets
        /// Provide a custom array key encoding with the given closure.
        case custom((_ key: String, _ index: Int) -> String)

        func encode(key: String, atIndex index: Int) -> String {
>>>>>>> Stashed changes
            switch self {
            case .brackets:
                return "\(key)[]"
            case .noBrackets:
                return key
<<<<<<< Updated upstream
=======
            case .indexInBrackets:
                return "\(key)[\(index)]"
            case let .custom(encoding):
                return encoding(key, index)
>>>>>>> Stashed changes
            }
        }
    }

    /// Configures how `Bool` parameters are encoded.
<<<<<<< Updated upstream
    ///
    /// - numeric:         Encode `true` as `1` and `false` as `0`. This is the default behavior.
    /// - literal:         Encode `true` and `false` as string literals.
    public enum BoolEncoding {
        case numeric, literal
=======
    public enum BoolEncoding {
        /// Encode `true` as `1` and `false` as `0`. This is the default behavior.
        case numeric
        /// Encode `true` and `false` as string literals.
        case literal
>>>>>>> Stashed changes

        func encode(value: Bool) -> String {
            switch self {
            case .numeric:
                return value ? "1" : "0"
            case .literal:
                return value ? "true" : "false"
            }
        }
    }

    // MARK: Properties

<<<<<<< Updated upstream
    /// Returns a default `URLEncoding` instance.
    public static var `default`: URLEncoding { return URLEncoding() }

    /// Returns a `URLEncoding` instance with a `.methodDependent` destination.
    public static var methodDependent: URLEncoding { return URLEncoding() }

    /// Returns a `URLEncoding` instance with a `.queryString` destination.
    public static var queryString: URLEncoding { return URLEncoding(destination: .queryString) }

    /// Returns a `URLEncoding` instance with an `.httpBody` destination.
    public static var httpBody: URLEncoding { return URLEncoding(destination: .httpBody) }
=======
    /// Returns a default `URLEncoding` instance with a `.methodDependent` destination.
    public static var `default`: URLEncoding { URLEncoding() }

    /// Returns a `URLEncoding` instance with a `.queryString` destination.
    public static var queryString: URLEncoding { URLEncoding(destination: .queryString) }

    /// Returns a `URLEncoding` instance with an `.httpBody` destination.
    public static var httpBody: URLEncoding { URLEncoding(destination: .httpBody) }
>>>>>>> Stashed changes

    /// The destination defining where the encoded query string is to be applied to the URL request.
    public let destination: Destination

    /// The encoding to use for `Array` parameters.
    public let arrayEncoding: ArrayEncoding

    /// The encoding to use for `Bool` parameters.
    public let boolEncoding: BoolEncoding

    // MARK: Initialization

<<<<<<< Updated upstream
    /// Creates a `URLEncoding` instance using the specified destination.
    ///
    /// - parameter destination: The destination defining where the encoded query string is to be applied.
    /// - parameter arrayEncoding: The encoding to use for `Array` parameters.
    /// - parameter boolEncoding: The encoding to use for `Bool` parameters.
    ///
    /// - returns: The new `URLEncoding` instance.
    public init(destination: Destination = .methodDependent, arrayEncoding: ArrayEncoding = .brackets, boolEncoding: BoolEncoding = .numeric) {
=======
    /// Creates an instance using the specified parameters.
    ///
    /// - Parameters:
    ///   - destination:   `Destination` defining where the encoded query string will be applied. `.methodDependent` by
    ///                    default.
    ///   - arrayEncoding: `ArrayEncoding` to use. `.brackets` by default.
    ///   - boolEncoding:  `BoolEncoding` to use. `.numeric` by default.
    public init(destination: Destination = .methodDependent,
                arrayEncoding: ArrayEncoding = .brackets,
                boolEncoding: BoolEncoding = .numeric) {
>>>>>>> Stashed changes
        self.destination = destination
        self.arrayEncoding = arrayEncoding
        self.boolEncoding = boolEncoding
    }

    // MARK: Encoding

<<<<<<< Updated upstream
    /// Creates a URL request by encoding parameters and applying them onto an existing request.
    ///
    /// - parameter urlRequest: The request to have parameters applied.
    /// - parameter parameters: The parameters to apply.
    ///
    /// - throws: An `Error` if the encoding process encounters an error.
    ///
    /// - returns: The encoded request.
=======
>>>>>>> Stashed changes
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()

        guard let parameters = parameters else { return urlRequest }

<<<<<<< Updated upstream
        if let method = HTTPMethod(rawValue: urlRequest.httpMethod ?? "GET"), encodesParametersInURL(with: method) {
=======
        if let method = urlRequest.method, destination.encodesParametersInURL(for: method) {
>>>>>>> Stashed changes
            guard let url = urlRequest.url else {
                throw AFError.parameterEncodingFailed(reason: .missingURL)
            }

            if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
                let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + query(parameters)
                urlComponents.percentEncodedQuery = percentEncodedQuery
                urlRequest.url = urlComponents.url
            }
        } else {
<<<<<<< Updated upstream
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            }

            urlRequest.httpBody = query(parameters).data(using: .utf8, allowLossyConversion: false)
=======
            if urlRequest.headers["Content-Type"] == nil {
                urlRequest.headers.update(.contentType("application/x-www-form-urlencoded; charset=utf-8"))
            }

            urlRequest.httpBody = Data(query(parameters).utf8)
>>>>>>> Stashed changes
        }

        return urlRequest
    }

<<<<<<< Updated upstream
    /// Creates percent-escaped, URL encoded query string components from the given key-value pair using recursion.
    ///
    /// - parameter key:   The key of the query component.
    /// - parameter value: The value of the query component.
    ///
    /// - returns: The percent-escaped, URL encoded query string components.
    public func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
        var components: [(String, String)] = []

        if let dictionary = value as? [String: Any] {
            for (nestedKey, value) in dictionary {
                components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
            }
        } else if let array = value as? [Any] {
            for value in array {
                components += queryComponents(fromKey: arrayEncoding.encode(key: key), value: value)
            }
        } else if let value = value as? NSNumber {
            if value.isBool {
                components.append((escape(key), escape(boolEncoding.encode(value: value.boolValue))))
            } else {
                components.append((escape(key), escape("\(value)")))
            }
        } else if let bool = value as? Bool {
            components.append((escape(key), escape(boolEncoding.encode(value: bool))))
        } else {
            components.append((escape(key), escape("\(value)")))
        }

        return components
    }

    /// Returns a percent-escaped string following RFC 3986 for a query string key or value.
    ///
    /// RFC 3986 states that the following characters are "reserved" characters.
    ///
    /// - General Delimiters: ":", "#", "[", "]", "@", "?", "/"
    /// - Sub-Delimiters: "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="
    ///
    /// In RFC 3986 - Section 3.4, it states that the "?" and "/" characters should not be escaped to allow
    /// query strings to include a URL. Therefore, all "reserved" characters with the exception of "?" and "/"
    /// should be percent-escaped in the query string.
    ///
    /// - parameter string: The string to be percent-escaped.
    ///
    /// - returns: The percent-escaped string.
    public func escape(_ string: String) -> String {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")

        var escaped = ""

        //==========================================================================================================
        //
        //  Batching is required for escaping due to an internal bug in iOS 8.1 and 8.2. Encoding more than a few
        //  hundred Chinese characters causes various malloc error crashes. To avoid this issue until iOS 8 is no
        //  longer supported, batching MUST be used for encoding. This introduces roughly a 20% overhead. For more
        //  info, please refer to:
        //
        //      - https://github.com/Alamofire/Alamofire/issues/206
        //
        //==========================================================================================================

        if #available(iOS 8.3, *) {
            escaped = string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? string
        } else {
            let batchSize = 50
            var index = string.startIndex

            while index != string.endIndex {
                let startIndex = index
                let endIndex = string.index(index, offsetBy: batchSize, limitedBy: string.endIndex) ?? string.endIndex
                let range = startIndex..<endIndex

                let substring = string[range]

                escaped += substring.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? String(substring)

                index = endIndex
            }
        }

        return escaped
=======
    /// Creates a percent-escaped, URL encoded query string components from the given key-value pair recursively.
    ///
    /// - Parameters:
    ///   - key:   Key of the query component.
    ///   - value: Value of the query component.
    ///
    /// - Returns: The percent-escaped, URL encoded query string components.
    public func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
        var components: [(String, String)] = []
        switch value {
        case let dictionary as [String: Any]:
            for (nestedKey, value) in dictionary {
                components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
            }
        case let array as [Any]:
            for (index, value) in array.enumerated() {
                components += queryComponents(fromKey: arrayEncoding.encode(key: key, atIndex: index), value: value)
            }
        case let number as NSNumber:
            if number.isBool {
                components.append((escape(key), escape(boolEncoding.encode(value: number.boolValue))))
            } else {
                components.append((escape(key), escape("\(number)")))
            }
        case let bool as Bool:
            components.append((escape(key), escape(boolEncoding.encode(value: bool))))
        default:
            components.append((escape(key), escape("\(value)")))
        }
        return components
    }

    /// Creates a percent-escaped string following RFC 3986 for a query string key or value.
    ///
    /// - Parameter string: `String` to be percent-escaped.
    ///
    /// - Returns:          The percent-escaped `String`.
    public func escape(_ string: String) -> String {
        string.addingPercentEncoding(withAllowedCharacters: .afURLQueryAllowed) ?? string
>>>>>>> Stashed changes
    }

    private func query(_ parameters: [String: Any]) -> String {
        var components: [(String, String)] = []

        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += queryComponents(fromKey: key, value: value)
        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }
<<<<<<< Updated upstream

    private func encodesParametersInURL(with method: HTTPMethod) -> Bool {
        switch destination {
        case .queryString:
            return true
        case .httpBody:
            return false
        default:
            break
        }

        switch method {
        case .get, .head, .delete:
            return true
        default:
            return false
        }
    }
=======
>>>>>>> Stashed changes
}

// MARK: -

/// Uses `JSONSerialization` to create a JSON representation of the parameters object, which is set as the body of the
/// request. The `Content-Type` HTTP header field of an encoded request is set to `application/json`.
public struct JSONEncoding: ParameterEncoding {
<<<<<<< Updated upstream
=======
    public enum Error: Swift.Error {
        case invalidJSONObject
    }
>>>>>>> Stashed changes

    // MARK: Properties

    /// Returns a `JSONEncoding` instance with default writing options.
<<<<<<< Updated upstream
    public static var `default`: JSONEncoding { return JSONEncoding() }

    /// Returns a `JSONEncoding` instance with `.prettyPrinted` writing options.
    public static var prettyPrinted: JSONEncoding { return JSONEncoding(options: .prettyPrinted) }
=======
    public static var `default`: JSONEncoding { JSONEncoding() }

    /// Returns a `JSONEncoding` instance with `.prettyPrinted` writing options.
    public static var prettyPrinted: JSONEncoding { JSONEncoding(options: .prettyPrinted) }
>>>>>>> Stashed changes

    /// The options for writing the parameters as JSON data.
    public let options: JSONSerialization.WritingOptions

    // MARK: Initialization

<<<<<<< Updated upstream
    /// Creates a `JSONEncoding` instance using the specified options.
    ///
    /// - parameter options: The options for writing the parameters as JSON data.
    ///
    /// - returns: The new `JSONEncoding` instance.
=======
    /// Creates an instance using the specified `WritingOptions`.
    ///
    /// - Parameter options: `JSONSerialization.WritingOptions` to use.
>>>>>>> Stashed changes
    public init(options: JSONSerialization.WritingOptions = []) {
        self.options = options
    }

    // MARK: Encoding

<<<<<<< Updated upstream
    /// Creates a URL request by encoding parameters and applying them onto an existing request.
    ///
    /// - parameter urlRequest: The request to have parameters applied.
    /// - parameter parameters: The parameters to apply.
    ///
    /// - throws: An `Error` if the encoding process encounters an error.
    ///
    /// - returns: The encoded request.
=======
>>>>>>> Stashed changes
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()

        guard let parameters = parameters else { return urlRequest }

<<<<<<< Updated upstream
        do {
            let data = try JSONSerialization.data(withJSONObject: parameters, options: options)

            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
=======
        guard JSONSerialization.isValidJSONObject(parameters) else {
            throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: Error.invalidJSONObject))
        }

        do {
            let data = try JSONSerialization.data(withJSONObject: parameters, options: options)

            if urlRequest.headers["Content-Type"] == nil {
                urlRequest.headers.update(.contentType("application/json"))
>>>>>>> Stashed changes
            }

            urlRequest.httpBody = data
        } catch {
            throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
        }

        return urlRequest
    }

<<<<<<< Updated upstream
    /// Creates a URL request by encoding the JSON object and setting the resulting data on the HTTP body.
    ///
    /// - parameter urlRequest: The request to apply the JSON object to.
    /// - parameter jsonObject: The JSON object to apply to the request.
    ///
    /// - throws: An `Error` if the encoding process encounters an error.
    ///
    /// - returns: The encoded request.
=======
    /// Encodes any JSON compatible object into a `URLRequest`.
    ///
    /// - Parameters:
    ///   - urlRequest: `URLRequestConvertible` value into which the object will be encoded.
    ///   - jsonObject: `Any` value (must be JSON compatible` to be encoded into the `URLRequest`. `nil` by default.
    ///
    /// - Returns:      The encoded `URLRequest`.
    /// - Throws:       Any `Error` produced during encoding.
>>>>>>> Stashed changes
    public func encode(_ urlRequest: URLRequestConvertible, withJSONObject jsonObject: Any? = nil) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()

        guard let jsonObject = jsonObject else { return urlRequest }

<<<<<<< Updated upstream
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonObject, options: options)

            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
=======
        guard JSONSerialization.isValidJSONObject(jsonObject) else {
            throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: Error.invalidJSONObject))
        }

        do {
            let data = try JSONSerialization.data(withJSONObject: jsonObject, options: options)

            if urlRequest.headers["Content-Type"] == nil {
                urlRequest.headers.update(.contentType("application/json"))
>>>>>>> Stashed changes
            }

            urlRequest.httpBody = data
        } catch {
            throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
        }

        return urlRequest
    }
}

<<<<<<< Updated upstream
// MARK: -

/// Uses `PropertyListSerialization` to create a plist representation of the parameters object, according to the
/// associated format and write options values, which is set as the body of the request. The `Content-Type` HTTP header
/// field of an encoded request is set to `application/x-plist`.
public struct PropertyListEncoding: ParameterEncoding {

    // MARK: Properties

    /// Returns a default `PropertyListEncoding` instance.
    public static var `default`: PropertyListEncoding { return PropertyListEncoding() }

    /// Returns a `PropertyListEncoding` instance with xml formatting and default writing options.
    public static var xml: PropertyListEncoding { return PropertyListEncoding(format: .xml) }

    /// Returns a `PropertyListEncoding` instance with binary formatting and default writing options.
    public static var binary: PropertyListEncoding { return PropertyListEncoding(format: .binary) }

    /// The property list serialization format.
    public let format: PropertyListSerialization.PropertyListFormat

    /// The options for writing the parameters as plist data.
    public let options: PropertyListSerialization.WriteOptions

    // MARK: Initialization

    /// Creates a `PropertyListEncoding` instance using the specified format and options.
    ///
    /// - parameter format:  The property list serialization format.
    /// - parameter options: The options for writing the parameters as plist data.
    ///
    /// - returns: The new `PropertyListEncoding` instance.
    public init(
        format: PropertyListSerialization.PropertyListFormat = .xml,
        options: PropertyListSerialization.WriteOptions = 0)
    {
        self.format = format
        self.options = options
    }

    // MARK: Encoding

    /// Creates a URL request by encoding parameters and applying them onto an existing request.
    ///
    /// - parameter urlRequest: The request to have parameters applied.
    /// - parameter parameters: The parameters to apply.
    ///
    /// - throws: An `Error` if the encoding process encounters an error.
    ///
    /// - returns: The encoded request.
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()

        guard let parameters = parameters else { return urlRequest }

        do {
            let data = try PropertyListSerialization.data(
                fromPropertyList: parameters,
                format: format,
                options: options
            )

            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/x-plist", forHTTPHeaderField: "Content-Type")
            }

            urlRequest.httpBody = data
        } catch {
            throw AFError.parameterEncodingFailed(reason: .propertyListEncodingFailed(error: error))
        }

        return urlRequest
=======
extension JSONEncoding.Error {
    public var localizedDescription: String {
        """
        Invalid JSON object provided for parameter or object encoding. \
        This is most likely due to a value which can't be represented in Objective-C.
        """
>>>>>>> Stashed changes
    }
}

// MARK: -

extension NSNumber {
<<<<<<< Updated upstream
    fileprivate var isBool: Bool { return CFBooleanGetTypeID() == CFGetTypeID(self) }
=======
    fileprivate var isBool: Bool {
        // Use Obj-C type encoding to check whether the underlying type is a `Bool`, as it's guaranteed as part of
        // swift-corelibs-foundation, per [this discussion on the Swift forums](https://forums.swift.org/t/alamofire-on-linux-possible-but-not-release-ready/34553/22).
        String(cString: objCType) == "c"
    }
>>>>>>> Stashed changes
}
