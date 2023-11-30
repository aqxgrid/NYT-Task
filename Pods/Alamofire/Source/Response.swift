//
//  Response.swift
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
/// Used to store all data associated with an non-serialized response of a data or upload request.
public struct DefaultDataResponse {
=======
/// Default type of `DataResponse` returned by Alamofire, with an `AFError` `Failure` type.
public typealias AFDataResponse<Success> = DataResponse<Success, AFError>
/// Default type of `DownloadResponse` returned by Alamofire, with an `AFError` `Failure` type.
public typealias AFDownloadResponse<Success> = DownloadResponse<Success, AFError>

/// Type used to store all values associated with a serialized response of a `DataRequest` or `UploadRequest`.
public struct DataResponse<Success, Failure: Error> {
>>>>>>> Stashed changes
    /// The URL request sent to the server.
    public let request: URLRequest?

    /// The server's response to the URL request.
    public let response: HTTPURLResponse?

    /// The data returned by the server.
    public let data: Data?

<<<<<<< Updated upstream
    /// The error encountered while executing or validating the request.
    public let error: Error?

    /// The timeline of the complete lifecycle of the request.
    public let timeline: Timeline

    var _metrics: AnyObject?

    /// Creates a `DefaultDataResponse` instance from the specified parameters.
    ///
    /// - Parameters:
    ///   - request:  The URL request sent to the server.
    ///   - response: The server's response to the URL request.
    ///   - data:     The data returned by the server.
    ///   - error:    The error encountered while executing or validating the request.
    ///   - timeline: The timeline of the complete lifecycle of the request. `Timeline()` by default.
    ///   - metrics:  The task metrics containing the request / response statistics. `nil` by default.
    public init(
        request: URLRequest?,
        response: HTTPURLResponse?,
        data: Data?,
        error: Error?,
        timeline: Timeline = Timeline(),
        metrics: AnyObject? = nil)
    {
        self.request = request
        self.response = response
        self.data = data
        self.error = error
        self.timeline = timeline
    }
}

// MARK: -

/// Used to store all data associated with a serialized response of a data or upload request.
public struct DataResponse<Value> {
    /// The URL request sent to the server.
    public let request: URLRequest?

    /// The server's response to the URL request.
    public let response: HTTPURLResponse?

    /// The data returned by the server.
    public let data: Data?

    /// The result of response serialization.
    public let result: Result<Value>

    /// The timeline of the complete lifecycle of the request.
    public let timeline: Timeline

    /// Returns the associated value of the result if it is a success, `nil` otherwise.
    public var value: Value? { return result.value }

    /// Returns the associated error value if the result if it is a failure, `nil` otherwise.
    public var error: Error? { return result.error }

    var _metrics: AnyObject?

    /// Creates a `DataResponse` instance with the specified parameters derived from response serialization.
    ///
    /// - parameter request:  The URL request sent to the server.
    /// - parameter response: The server's response to the URL request.
    /// - parameter data:     The data returned by the server.
    /// - parameter result:   The result of response serialization.
    /// - parameter timeline: The timeline of the complete lifecycle of the `Request`. Defaults to `Timeline()`.
    ///
    /// - returns: The new `DataResponse` instance.
    public init(
        request: URLRequest?,
        response: HTTPURLResponse?,
        data: Data?,
        result: Result<Value>,
        timeline: Timeline = Timeline())
    {
        self.request = request
        self.response = response
        self.data = data
        self.result = result
        self.timeline = timeline
=======
    /// The final metrics of the response.
    ///
    /// - Note: Due to `FB7624529`, collection of `URLSessionTaskMetrics` on watchOS is currently disabled.`
    ///
    public let metrics: URLSessionTaskMetrics?

    /// The time taken to serialize the response.
    public let serializationDuration: TimeInterval

    /// The result of response serialization.
    public let result: Result<Success, Failure>

    /// Returns the associated value of the result if it is a success, `nil` otherwise.
    public var value: Success? { result.success }

    /// Returns the associated error value if the result if it is a failure, `nil` otherwise.
    public var error: Failure? { result.failure }

    /// Creates a `DataResponse` instance with the specified parameters derived from the response serialization.
    ///
    /// - Parameters:
    ///   - request:               The `URLRequest` sent to the server.
    ///   - response:              The `HTTPURLResponse` from the server.
    ///   - data:                  The `Data` returned by the server.
    ///   - metrics:               The `URLSessionTaskMetrics` of the `DataRequest` or `UploadRequest`.
    ///   - serializationDuration: The duration taken by serialization.
    ///   - result:                The `Result` of response serialization.
    public init(request: URLRequest?,
                response: HTTPURLResponse?,
                data: Data?,
                metrics: URLSessionTaskMetrics?,
                serializationDuration: TimeInterval,
                result: Result<Success, Failure>) {
        self.request = request
        self.response = response
        self.data = data
        self.metrics = metrics
        self.serializationDuration = serializationDuration
        self.result = result
>>>>>>> Stashed changes
    }
}

// MARK: -

extension DataResponse: CustomStringConvertible, CustomDebugStringConvertible {
    /// The textual representation used when written to an output stream, which includes whether the result was a
    /// success or failure.
    public var description: String {
<<<<<<< Updated upstream
        return result.debugDescription
    }

    /// The debug textual representation used when written to an output stream, which includes the URL request, the URL
    /// response, the server data, the response serialization result and the timeline.
    public var debugDescription: String {
        let requestDescription = request.map { "\($0.httpMethod ?? "GET") \($0)"} ?? "nil"
        let requestBody = request?.httpBody.map { String(decoding: $0, as: UTF8.self) } ?? "None"
        let responseDescription = response.map { "\($0)" } ?? "nil"
        let responseBody = data.map { String(decoding: $0, as: UTF8.self) } ?? "None"

        return """
        [Request]: \(requestDescription)
        [Request Body]: \n\(requestBody)
        [Response]: \(responseDescription)
        [Response Body]: \n\(responseBody)
        [Result]: \(result)
        [Timeline]: \(timeline.debugDescription)
=======
        "\(result)"
    }

    /// The debug textual representation used when written to an output stream, which includes (if available) a summary
    /// of the `URLRequest`, the request's headers and body (if decodable as a `String` below 100KB); the
    /// `HTTPURLResponse`'s status code, headers, and body; the duration of the network and serialization actions; and
    /// the `Result` of serialization.
    public var debugDescription: String {
        guard let urlRequest = request else { return "[Request]: None\n[Result]: \(result)" }

        let requestDescription = DebugDescription.description(of: urlRequest)

        let responseDescription = response.map { response in
            let responseBodyDescription = DebugDescription.description(for: data, headers: response.headers)

            return """
            \(DebugDescription.description(of: response))
                \(responseBodyDescription.indentingNewlines())
            """
        } ?? "[Response]: None"

        let networkDuration = metrics.map { "\($0.taskInterval.duration)s" } ?? "None"

        return """
        \(requestDescription)
        \(responseDescription)
        [Network Duration]: \(networkDuration)
        [Serialization Duration]: \(serializationDuration)s
        [Result]: \(result)
>>>>>>> Stashed changes
        """
    }
}

// MARK: -

extension DataResponse {
    /// Evaluates the specified closure when the result of this `DataResponse` is a success, passing the unwrapped
    /// result value as a parameter.
    ///
    /// Use the `map` method with a closure that does not throw. For example:
    ///
    ///     let possibleData: DataResponse<Data> = ...
    ///     let possibleInt = possibleData.map { $0.count }
    ///
    /// - parameter transform: A closure that takes the success value of the instance's result.
    ///
    /// - returns: A `DataResponse` whose result wraps the value returned by the given closure. If this instance's
    ///            result is a failure, returns a response wrapping the same failure.
<<<<<<< Updated upstream
    public func map<T>(_ transform: (Value) -> T) -> DataResponse<T> {
        var response = DataResponse<T>(
            request: request,
            response: self.response,
            data: data,
            result: result.map(transform),
            timeline: timeline
        )

        response._metrics = _metrics

        return response
=======
    public func map<NewSuccess>(_ transform: (Success) -> NewSuccess) -> DataResponse<NewSuccess, Failure> {
        DataResponse<NewSuccess, Failure>(request: request,
                                          response: response,
                                          data: data,
                                          metrics: metrics,
                                          serializationDuration: serializationDuration,
                                          result: result.map(transform))
>>>>>>> Stashed changes
    }

    /// Evaluates the given closure when the result of this `DataResponse` is a success, passing the unwrapped result
    /// value as a parameter.
    ///
<<<<<<< Updated upstream
    /// Use the `flatMap` method with a closure that may throw an error. For example:
    ///
    ///     let possibleData: DataResponse<Data> = ...
    ///     let possibleObject = possibleData.flatMap {
=======
    /// Use the `tryMap` method with a closure that may throw an error. For example:
    ///
    ///     let possibleData: DataResponse<Data> = ...
    ///     let possibleObject = possibleData.tryMap {
>>>>>>> Stashed changes
    ///         try JSONSerialization.jsonObject(with: $0)
    ///     }
    ///
    /// - parameter transform: A closure that takes the success value of the instance's result.
    ///
    /// - returns: A success or failure `DataResponse` depending on the result of the given closure. If this instance's
    ///            result is a failure, returns the same failure.
<<<<<<< Updated upstream
    public func flatMap<T>(_ transform: (Value) throws -> T) -> DataResponse<T> {
        var response = DataResponse<T>(
            request: request,
            response: self.response,
            data: data,
            result: result.flatMap(transform),
            timeline: timeline
        )

        response._metrics = _metrics

        return response
=======
    public func tryMap<NewSuccess>(_ transform: (Success) throws -> NewSuccess) -> DataResponse<NewSuccess, Error> {
        DataResponse<NewSuccess, Error>(request: request,
                                        response: response,
                                        data: data,
                                        metrics: metrics,
                                        serializationDuration: serializationDuration,
                                        result: result.tryMap(transform))
>>>>>>> Stashed changes
    }

    /// Evaluates the specified closure when the `DataResponse` is a failure, passing the unwrapped error as a parameter.
    ///
    /// Use the `mapError` function with a closure that does not throw. For example:
    ///
    ///     let possibleData: DataResponse<Data> = ...
    ///     let withMyError = possibleData.mapError { MyError.error($0) }
    ///
    /// - Parameter transform: A closure that takes the error of the instance.
<<<<<<< Updated upstream
    /// - Returns: A `DataResponse` instance containing the result of the transform.
    public func mapError<E: Error>(_ transform: (Error) -> E) -> DataResponse {
        var response = DataResponse(
            request: request,
            response: self.response,
            data: data,
            result: result.mapError(transform),
            timeline: timeline
        )

        response._metrics = _metrics

        return response
=======
    ///
    /// - Returns: A `DataResponse` instance containing the result of the transform.
    public func mapError<NewFailure: Error>(_ transform: (Failure) -> NewFailure) -> DataResponse<Success, NewFailure> {
        DataResponse<Success, NewFailure>(request: request,
                                          response: response,
                                          data: data,
                                          metrics: metrics,
                                          serializationDuration: serializationDuration,
                                          result: result.mapError(transform))
>>>>>>> Stashed changes
    }

    /// Evaluates the specified closure when the `DataResponse` is a failure, passing the unwrapped error as a parameter.
    ///
<<<<<<< Updated upstream
    /// Use the `flatMapError` function with a closure that may throw an error. For example:
    ///
    ///     let possibleData: DataResponse<Data> = ...
    ///     let possibleObject = possibleData.flatMapError {
=======
    /// Use the `tryMapError` function with a closure that may throw an error. For example:
    ///
    ///     let possibleData: DataResponse<Data> = ...
    ///     let possibleObject = possibleData.tryMapError {
>>>>>>> Stashed changes
    ///         try someFailableFunction(taking: $0)
    ///     }
    ///
    /// - Parameter transform: A throwing closure that takes the error of the instance.
    ///
    /// - Returns: A `DataResponse` instance containing the result of the transform.
<<<<<<< Updated upstream
    public func flatMapError<E: Error>(_ transform: (Error) throws -> E) -> DataResponse {
        var response = DataResponse(
            request: request,
            response: self.response,
            data: data,
            result: result.flatMapError(transform),
            timeline: timeline
        )

        response._metrics = _metrics

        return response
    }
}

// MARK: -

/// Used to store all data associated with an non-serialized response of a download request.
public struct DefaultDownloadResponse {
    /// The URL request sent to the server.
    public let request: URLRequest?

    /// The server's response to the URL request.
    public let response: HTTPURLResponse?

    /// The temporary destination URL of the data returned from the server.
    public let temporaryURL: URL?

    /// The final destination URL of the data returned from the server if it was moved.
    public let destinationURL: URL?

    /// The resume data generated if the request was cancelled.
    public let resumeData: Data?

    /// The error encountered while executing or validating the request.
    public let error: Error?

    /// The timeline of the complete lifecycle of the request.
    public let timeline: Timeline

    var _metrics: AnyObject?

    /// Creates a `DefaultDownloadResponse` instance from the specified parameters.
    ///
    /// - Parameters:
    ///   - request:        The URL request sent to the server.
    ///   - response:       The server's response to the URL request.
    ///   - temporaryURL:   The temporary destination URL of the data returned from the server.
    ///   - destinationURL: The final destination URL of the data returned from the server if it was moved.
    ///   - resumeData:     The resume data generated if the request was cancelled.
    ///   - error:          The error encountered while executing or validating the request.
    ///   - timeline:       The timeline of the complete lifecycle of the request. `Timeline()` by default.
    ///   - metrics:        The task metrics containing the request / response statistics. `nil` by default.
    public init(
        request: URLRequest?,
        response: HTTPURLResponse?,
        temporaryURL: URL?,
        destinationURL: URL?,
        resumeData: Data?,
        error: Error?,
        timeline: Timeline = Timeline(),
        metrics: AnyObject? = nil)
    {
        self.request = request
        self.response = response
        self.temporaryURL = temporaryURL
        self.destinationURL = destinationURL
        self.resumeData = resumeData
        self.error = error
        self.timeline = timeline
=======
    public func tryMapError<NewFailure: Error>(_ transform: (Failure) throws -> NewFailure) -> DataResponse<Success, Error> {
        DataResponse<Success, Error>(request: request,
                                     response: response,
                                     data: data,
                                     metrics: metrics,
                                     serializationDuration: serializationDuration,
                                     result: result.tryMapError(transform))
>>>>>>> Stashed changes
    }
}

// MARK: -

/// Used to store all data associated with a serialized response of a download request.
<<<<<<< Updated upstream
public struct DownloadResponse<Value> {
=======
public struct DownloadResponse<Success, Failure: Error> {
>>>>>>> Stashed changes
    /// The URL request sent to the server.
    public let request: URLRequest?

    /// The server's response to the URL request.
    public let response: HTTPURLResponse?

<<<<<<< Updated upstream
    /// The temporary destination URL of the data returned from the server.
    public let temporaryURL: URL?

    /// The final destination URL of the data returned from the server if it was moved.
    public let destinationURL: URL?
=======
    /// The final destination URL of the data returned from the server after it is moved.
    public let fileURL: URL?
>>>>>>> Stashed changes

    /// The resume data generated if the request was cancelled.
    public let resumeData: Data?

<<<<<<< Updated upstream
    /// The result of response serialization.
    public let result: Result<Value>

    /// The timeline of the complete lifecycle of the request.
    public let timeline: Timeline

    /// Returns the associated value of the result if it is a success, `nil` otherwise.
    public var value: Value? { return result.value }

    /// Returns the associated error value if the result if it is a failure, `nil` otherwise.
    public var error: Error? { return result.error }

    var _metrics: AnyObject?

    /// Creates a `DownloadResponse` instance with the specified parameters derived from response serialization.
    ///
    /// - parameter request:        The URL request sent to the server.
    /// - parameter response:       The server's response to the URL request.
    /// - parameter temporaryURL:   The temporary destination URL of the data returned from the server.
    /// - parameter destinationURL: The final destination URL of the data returned from the server if it was moved.
    /// - parameter resumeData:     The resume data generated if the request was cancelled.
    /// - parameter result:         The result of response serialization.
    /// - parameter timeline:       The timeline of the complete lifecycle of the `Request`. Defaults to `Timeline()`.
    ///
    /// - returns: The new `DownloadResponse` instance.
    public init(
        request: URLRequest?,
        response: HTTPURLResponse?,
        temporaryURL: URL?,
        destinationURL: URL?,
        resumeData: Data?,
        result: Result<Value>,
        timeline: Timeline = Timeline())
    {
        self.request = request
        self.response = response
        self.temporaryURL = temporaryURL
        self.destinationURL = destinationURL
        self.resumeData = resumeData
        self.result = result
        self.timeline = timeline
=======
    /// The final metrics of the response.
    ///
    /// - Note: Due to `FB7624529`, collection of `URLSessionTaskMetrics` on watchOS is currently disabled.`
    ///
    public let metrics: URLSessionTaskMetrics?

    /// The time taken to serialize the response.
    public let serializationDuration: TimeInterval

    /// The result of response serialization.
    public let result: Result<Success, Failure>

    /// Returns the associated value of the result if it is a success, `nil` otherwise.
    public var value: Success? { result.success }

    /// Returns the associated error value if the result if it is a failure, `nil` otherwise.
    public var error: Failure? { result.failure }

    /// Creates a `DownloadResponse` instance with the specified parameters derived from response serialization.
    ///
    /// - Parameters:
    ///   - request:               The `URLRequest` sent to the server.
    ///   - response:              The `HTTPURLResponse` from the server.
    ///   - fileURL:               The final destination URL of the data returned from the server after it is moved.
    ///   - resumeData:            The resume `Data` generated if the request was cancelled.
    ///   - metrics:               The `URLSessionTaskMetrics` of the `DownloadRequest`.
    ///   - serializationDuration: The duration taken by serialization.
    ///   - result:                The `Result` of response serialization.
    public init(request: URLRequest?,
                response: HTTPURLResponse?,
                fileURL: URL?,
                resumeData: Data?,
                metrics: URLSessionTaskMetrics?,
                serializationDuration: TimeInterval,
                result: Result<Success, Failure>) {
        self.request = request
        self.response = response
        self.fileURL = fileURL
        self.resumeData = resumeData
        self.metrics = metrics
        self.serializationDuration = serializationDuration
        self.result = result
>>>>>>> Stashed changes
    }
}

// MARK: -

extension DownloadResponse: CustomStringConvertible, CustomDebugStringConvertible {
    /// The textual representation used when written to an output stream, which includes whether the result was a
    /// success or failure.
    public var description: String {
<<<<<<< Updated upstream
        return result.debugDescription
    }

    /// The debug textual representation used when written to an output stream, which includes the URL request, the URL
    /// response, the temporary and destination URLs, the resume data, the response serialization result and the
    /// timeline.
    public var debugDescription: String {
        let requestDescription = request.map { "\($0.httpMethod ?? "GET") \($0)"} ?? "nil"
        let requestBody = request?.httpBody.map { String(decoding: $0, as: UTF8.self) } ?? "None"
        let responseDescription = response.map { "\($0)" } ?? "nil"

        return """
        [Request]: \(requestDescription)
        [Request Body]: \n\(requestBody)
        [Response]: \(responseDescription)
        [TemporaryURL]: \(temporaryURL?.path ?? "nil")
        [DestinationURL]: \(destinationURL?.path ?? "nil")
        [ResumeData]: \(resumeData?.count ?? 0) bytes
        [Result]: \(result)
        [Timeline]: \(timeline.debugDescription)
=======
        "\(result)"
    }

    /// The debug textual representation used when written to an output stream, which includes the URL request, the URL
    /// response, the temporary and destination URLs, the resume data, the durations of the network and serialization
    /// actions, and the response serialization result.
    public var debugDescription: String {
        guard let urlRequest = request else { return "[Request]: None\n[Result]: \(result)" }

        let requestDescription = DebugDescription.description(of: urlRequest)
        let responseDescription = response.map(DebugDescription.description(of:)) ?? "[Response]: None"
        let networkDuration = metrics.map { "\($0.taskInterval.duration)s" } ?? "None"
        let resumeDataDescription = resumeData.map { "\($0)" } ?? "None"

        return """
        \(requestDescription)
        \(responseDescription)
        [File URL]: \(fileURL?.path ?? "None")
        [Resume Data]: \(resumeDataDescription)
        [Network Duration]: \(networkDuration)
        [Serialization Duration]: \(serializationDuration)s
        [Result]: \(result)
>>>>>>> Stashed changes
        """
    }
}

// MARK: -

extension DownloadResponse {
    /// Evaluates the given closure when the result of this `DownloadResponse` is a success, passing the unwrapped
    /// result value as a parameter.
    ///
    /// Use the `map` method with a closure that does not throw. For example:
    ///
    ///     let possibleData: DownloadResponse<Data> = ...
    ///     let possibleInt = possibleData.map { $0.count }
    ///
    /// - parameter transform: A closure that takes the success value of the instance's result.
    ///
    /// - returns: A `DownloadResponse` whose result wraps the value returned by the given closure. If this instance's
    ///            result is a failure, returns a response wrapping the same failure.
<<<<<<< Updated upstream
    public func map<T>(_ transform: (Value) -> T) -> DownloadResponse<T> {
        var response = DownloadResponse<T>(
            request: request,
            response: self.response,
            temporaryURL: temporaryURL,
            destinationURL: destinationURL,
            resumeData: resumeData,
            result: result.map(transform),
            timeline: timeline
        )

        response._metrics = _metrics

        return response
=======
    public func map<NewSuccess>(_ transform: (Success) -> NewSuccess) -> DownloadResponse<NewSuccess, Failure> {
        DownloadResponse<NewSuccess, Failure>(request: request,
                                              response: response,
                                              fileURL: fileURL,
                                              resumeData: resumeData,
                                              metrics: metrics,
                                              serializationDuration: serializationDuration,
                                              result: result.map(transform))
>>>>>>> Stashed changes
    }

    /// Evaluates the given closure when the result of this `DownloadResponse` is a success, passing the unwrapped
    /// result value as a parameter.
    ///
<<<<<<< Updated upstream
    /// Use the `flatMap` method with a closure that may throw an error. For example:
    ///
    ///     let possibleData: DownloadResponse<Data> = ...
    ///     let possibleObject = possibleData.flatMap {
=======
    /// Use the `tryMap` method with a closure that may throw an error. For example:
    ///
    ///     let possibleData: DownloadResponse<Data> = ...
    ///     let possibleObject = possibleData.tryMap {
>>>>>>> Stashed changes
    ///         try JSONSerialization.jsonObject(with: $0)
    ///     }
    ///
    /// - parameter transform: A closure that takes the success value of the instance's result.
    ///
    /// - returns: A success or failure `DownloadResponse` depending on the result of the given closure. If this
    /// instance's result is a failure, returns the same failure.
<<<<<<< Updated upstream
    public func flatMap<T>(_ transform: (Value) throws -> T) -> DownloadResponse<T> {
        var response = DownloadResponse<T>(
            request: request,
            response: self.response,
            temporaryURL: temporaryURL,
            destinationURL: destinationURL,
            resumeData: resumeData,
            result: result.flatMap(transform),
            timeline: timeline
        )

        response._metrics = _metrics

        return response
=======
    public func tryMap<NewSuccess>(_ transform: (Success) throws -> NewSuccess) -> DownloadResponse<NewSuccess, Error> {
        DownloadResponse<NewSuccess, Error>(request: request,
                                            response: response,
                                            fileURL: fileURL,
                                            resumeData: resumeData,
                                            metrics: metrics,
                                            serializationDuration: serializationDuration,
                                            result: result.tryMap(transform))
>>>>>>> Stashed changes
    }

    /// Evaluates the specified closure when the `DownloadResponse` is a failure, passing the unwrapped error as a parameter.
    ///
    /// Use the `mapError` function with a closure that does not throw. For example:
    ///
    ///     let possibleData: DownloadResponse<Data> = ...
    ///     let withMyError = possibleData.mapError { MyError.error($0) }
    ///
    /// - Parameter transform: A closure that takes the error of the instance.
<<<<<<< Updated upstream
    /// - Returns: A `DownloadResponse` instance containing the result of the transform.
    public func mapError<E: Error>(_ transform: (Error) -> E) -> DownloadResponse {
        var response = DownloadResponse(
            request: request,
            response: self.response,
            temporaryURL: temporaryURL,
            destinationURL: destinationURL,
            resumeData: resumeData,
            result: result.mapError(transform),
            timeline: timeline
        )

        response._metrics = _metrics

        return response
=======
    ///
    /// - Returns: A `DownloadResponse` instance containing the result of the transform.
    public func mapError<NewFailure: Error>(_ transform: (Failure) -> NewFailure) -> DownloadResponse<Success, NewFailure> {
        DownloadResponse<Success, NewFailure>(request: request,
                                              response: response,
                                              fileURL: fileURL,
                                              resumeData: resumeData,
                                              metrics: metrics,
                                              serializationDuration: serializationDuration,
                                              result: result.mapError(transform))
>>>>>>> Stashed changes
    }

    /// Evaluates the specified closure when the `DownloadResponse` is a failure, passing the unwrapped error as a parameter.
    ///
<<<<<<< Updated upstream
    /// Use the `flatMapError` function with a closure that may throw an error. For example:
    ///
    ///     let possibleData: DownloadResponse<Data> = ...
    ///     let possibleObject = possibleData.flatMapError {
=======
    /// Use the `tryMapError` function with a closure that may throw an error. For example:
    ///
    ///     let possibleData: DownloadResponse<Data> = ...
    ///     let possibleObject = possibleData.tryMapError {
>>>>>>> Stashed changes
    ///         try someFailableFunction(taking: $0)
    ///     }
    ///
    /// - Parameter transform: A throwing closure that takes the error of the instance.
    ///
    /// - Returns: A `DownloadResponse` instance containing the result of the transform.
<<<<<<< Updated upstream
    public func flatMapError<E: Error>(_ transform: (Error) throws -> E) -> DownloadResponse {
        var response = DownloadResponse(
            request: request,
            response: self.response,
            temporaryURL: temporaryURL,
            destinationURL: destinationURL,
            resumeData: resumeData,
            result: result.flatMapError(transform),
            timeline: timeline
        )

        response._metrics = _metrics

        return response
    }
}

// MARK: -

protocol Response {
    /// The task metrics containing the request / response statistics.
    var _metrics: AnyObject? { get set }
    mutating func add(_ metrics: AnyObject?)
}

extension Response {
    mutating func add(_ metrics: AnyObject?) {
        #if !os(watchOS)
            guard #available(iOS 10.0, macOS 10.12, tvOS 10.0, *) else { return }
            guard let metrics = metrics as? URLSessionTaskMetrics else { return }

            _metrics = metrics
        #endif
    }
}

// MARK: -

@available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
extension DefaultDataResponse: Response {
#if !os(watchOS)
    /// The task metrics containing the request / response statistics.
    public var metrics: URLSessionTaskMetrics? { return _metrics as? URLSessionTaskMetrics }
#endif
}

@available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
extension DataResponse: Response {
#if !os(watchOS)
    /// The task metrics containing the request / response statistics.
    public var metrics: URLSessionTaskMetrics? { return _metrics as? URLSessionTaskMetrics }
#endif
}

@available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
extension DefaultDownloadResponse: Response {
#if !os(watchOS)
    /// The task metrics containing the request / response statistics.
    public var metrics: URLSessionTaskMetrics? { return _metrics as? URLSessionTaskMetrics }
#endif
}

@available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
extension DownloadResponse: Response {
#if !os(watchOS)
    /// The task metrics containing the request / response statistics.
    public var metrics: URLSessionTaskMetrics? { return _metrics as? URLSessionTaskMetrics }
#endif
=======
    public func tryMapError<NewFailure: Error>(_ transform: (Failure) throws -> NewFailure) -> DownloadResponse<Success, Error> {
        DownloadResponse<Success, Error>(request: request,
                                         response: response,
                                         fileURL: fileURL,
                                         resumeData: resumeData,
                                         metrics: metrics,
                                         serializationDuration: serializationDuration,
                                         result: result.tryMapError(transform))
    }
}

private enum DebugDescription {
    static func description(of request: URLRequest) -> String {
        let requestSummary = "\(request.httpMethod!) \(request)"
        let requestHeadersDescription = DebugDescription.description(for: request.headers)
        let requestBodyDescription = DebugDescription.description(for: request.httpBody, headers: request.headers)

        return """
        [Request]: \(requestSummary)
            \(requestHeadersDescription.indentingNewlines())
            \(requestBodyDescription.indentingNewlines())
        """
    }

    static func description(of response: HTTPURLResponse) -> String {
        """
        [Response]:
            [Status Code]: \(response.statusCode)
            \(DebugDescription.description(for: response.headers).indentingNewlines())
        """
    }

    static func description(for headers: HTTPHeaders) -> String {
        guard !headers.isEmpty else { return "[Headers]: None" }

        let headerDescription = "\(headers.sorted())".indentingNewlines()
        return """
        [Headers]:
            \(headerDescription)
        """
    }

    static func description(for data: Data?,
                            headers: HTTPHeaders,
                            allowingPrintableTypes printableTypes: [String] = ["json", "xml", "text"],
                            maximumLength: Int = 100_000) -> String {
        guard let data = data, !data.isEmpty else { return "[Body]: None" }

        guard
            data.count <= maximumLength,
            printableTypes.compactMap({ headers["Content-Type"]?.contains($0) }).contains(true)
        else { return "[Body]: \(data.count) bytes" }

        return """
        [Body]:
            \(String(decoding: data, as: UTF8.self)
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .indentingNewlines())
        """
    }
}

extension String {
    fileprivate func indentingNewlines(by spaceCount: Int = 4) -> String {
        let spaces = String(repeating: " ", count: spaceCount)
        return replacingOccurrences(of: "\n", with: "\n\(spaces)")
    }
>>>>>>> Stashed changes
}
