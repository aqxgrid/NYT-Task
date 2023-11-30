//
//  NetworkReachabilityManager.swift
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

<<<<<<< Updated upstream
#if !os(watchOS)
=======
#if !(os(watchOS) || os(Linux) || os(Windows))
>>>>>>> Stashed changes

import Foundation
import SystemConfiguration

<<<<<<< Updated upstream
/// The `NetworkReachabilityManager` class listens for reachability changes of hosts and addresses for both WWAN and
=======
/// The `NetworkReachabilityManager` class listens for reachability changes of hosts and addresses for both cellular and
>>>>>>> Stashed changes
/// WiFi network interfaces.
///
/// Reachability can be used to determine background information about why a network operation failed, or to retry
/// network requests when a connection is established. It should not be used to prevent a user from initiating a network
/// request, as it's possible that an initial request may be required to establish reachability.
open class NetworkReachabilityManager {
    /// Defines the various states of network reachability.
<<<<<<< Updated upstream
    ///
    /// - unknown:      It is unknown whether the network is reachable.
    /// - notReachable: The network is not reachable.
    /// - reachable:    The network is reachable.
    public enum NetworkReachabilityStatus {
        case unknown
        case notReachable
        case reachable(ConnectionType)
    }

    /// Defines the various connection types detected by reachability flags.
    ///
    /// - ethernetOrWiFi: The connection type is either over Ethernet or WiFi.
    /// - wwan:           The connection type is a WWAN connection.
    public enum ConnectionType {
        case ethernetOrWiFi
        case wwan
=======
    public enum NetworkReachabilityStatus {
        /// It is unknown whether the network is reachable.
        case unknown
        /// The network is not reachable.
        case notReachable
        /// The network is reachable on the associated `ConnectionType`.
        case reachable(ConnectionType)

        init(_ flags: SCNetworkReachabilityFlags) {
            guard flags.isActuallyReachable else { self = .notReachable; return }

            var networkStatus: NetworkReachabilityStatus = .reachable(.ethernetOrWiFi)

            if flags.isCellular { networkStatus = .reachable(.cellular) }

            self = networkStatus
        }

        /// Defines the various connection types detected by reachability flags.
        public enum ConnectionType {
            /// The connection type is either over Ethernet or WiFi.
            case ethernetOrWiFi
            /// The connection type is a cellular connection.
            case cellular
        }
>>>>>>> Stashed changes
    }

    /// A closure executed when the network reachability status changes. The closure takes a single argument: the
    /// network reachability status.
    public typealias Listener = (NetworkReachabilityStatus) -> Void

<<<<<<< Updated upstream
    // MARK: - Properties

    /// Whether the network is currently reachable.
    open var isReachable: Bool { return isReachableOnWWAN || isReachableOnEthernetOrWiFi }

    /// Whether the network is currently reachable over the WWAN interface.
    open var isReachableOnWWAN: Bool { return networkReachabilityStatus == .reachable(.wwan) }

    /// Whether the network is currently reachable over Ethernet or WiFi interface.
    open var isReachableOnEthernetOrWiFi: Bool { return networkReachabilityStatus == .reachable(.ethernetOrWiFi) }

    /// The current network reachability status.
    open var networkReachabilityStatus: NetworkReachabilityStatus {
        guard let flags = self.flags else { return .unknown }
        return networkReachabilityStatusForFlags(flags)
    }

    /// The dispatch queue to execute the `listener` closure on.
    open var listenerQueue: DispatchQueue = DispatchQueue.main

    /// A closure executed when the network reachability status changes.
    open var listener: Listener?

    open var flags: SCNetworkReachabilityFlags? {
        var flags = SCNetworkReachabilityFlags()

        if SCNetworkReachabilityGetFlags(reachability, &flags) {
            return flags
        }

        return nil
    }

    private let reachability: SCNetworkReachability
    open var previousFlags: SCNetworkReachabilityFlags

    // MARK: - Initialization

    /// Creates a `NetworkReachabilityManager` instance with the specified host.
    ///
    /// - parameter host: The host used to evaluate network reachability.
    ///
    /// - returns: The new `NetworkReachabilityManager` instance.
    public convenience init?(host: String) {
        guard let reachability = SCNetworkReachabilityCreateWithName(nil, host) else { return nil }
        self.init(reachability: reachability)
    }

    /// Creates a `NetworkReachabilityManager` instance that monitors the address 0.0.0.0.
    ///
    /// Reachability treats the 0.0.0.0 address as a special token that causes it to monitor the general routing
    /// status of the device, both IPv4 and IPv6.
    ///
    /// - returns: The new `NetworkReachabilityManager` instance.
    public convenience init?() {
        var address = sockaddr_in()
        address.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        address.sin_family = sa_family_t(AF_INET)

        guard let reachability = withUnsafePointer(to: &address, { pointer in
            return pointer.withMemoryRebound(to: sockaddr.self, capacity: MemoryLayout<sockaddr>.size) {
                return SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else { return nil }
=======
    /// Default `NetworkReachabilityManager` for the zero address and a `listenerQueue` of `.main`.
    public static let `default` = NetworkReachabilityManager()

    // MARK: - Properties

    /// Whether the network is currently reachable.
    open var isReachable: Bool { isReachableOnCellular || isReachableOnEthernetOrWiFi }

    /// Whether the network is currently reachable over the cellular interface.
    ///
    /// - Note: Using this property to decide whether to make a high or low bandwidth request is not recommended.
    ///         Instead, set the `allowsCellularAccess` on any `URLRequest`s being issued.
    ///
    open var isReachableOnCellular: Bool { status == .reachable(.cellular) }

    /// Whether the network is currently reachable over Ethernet or WiFi interface.
    open var isReachableOnEthernetOrWiFi: Bool { status == .reachable(.ethernetOrWiFi) }

    /// `DispatchQueue` on which reachability will update.
    public let reachabilityQueue = DispatchQueue(label: "org.alamofire.reachabilityQueue")

    /// Flags of the current reachability type, if any.
    open var flags: SCNetworkReachabilityFlags? {
        var flags = SCNetworkReachabilityFlags()

        return SCNetworkReachabilityGetFlags(reachability, &flags) ? flags : nil
    }

    /// The current network reachability status.
    open var status: NetworkReachabilityStatus {
        flags.map(NetworkReachabilityStatus.init) ?? .unknown
    }

    /// Mutable state storage.
    struct MutableState {
        /// A closure executed when the network reachability status changes.
        var listener: Listener?
        /// `DispatchQueue` on which listeners will be called.
        var listenerQueue: DispatchQueue?
        /// Previously calculated status.
        var previousStatus: NetworkReachabilityStatus?
    }

    /// `SCNetworkReachability` instance providing notifications.
    private let reachability: SCNetworkReachability

    /// Protected storage for mutable state.
    @Protected
    private var mutableState = MutableState()

    // MARK: - Initialization

    /// Creates an instance with the specified host.
    ///
    /// - Note: The `host` value must *not* contain a scheme, just the hostname.
    ///
    /// - Parameters:
    ///   - host:          Host used to evaluate network reachability. Must *not* include the scheme (e.g. `https`).
    public convenience init?(host: String) {
        guard let reachability = SCNetworkReachabilityCreateWithName(nil, host) else { return nil }

        self.init(reachability: reachability)
    }

    /// Creates an instance that monitors the address 0.0.0.0.
    ///
    /// Reachability treats the 0.0.0.0 address as a special token that causes it to monitor the general routing
    /// status of the device, both IPv4 and IPv6.
    public convenience init?() {
        var zero = sockaddr()
        zero.sa_len = UInt8(MemoryLayout<sockaddr>.size)
        zero.sa_family = sa_family_t(AF_INET)

        guard let reachability = SCNetworkReachabilityCreateWithAddress(nil, &zero) else { return nil }
>>>>>>> Stashed changes

        self.init(reachability: reachability)
    }

    private init(reachability: SCNetworkReachability) {
        self.reachability = reachability
<<<<<<< Updated upstream

        // Set the previous flags to an unreserved value to represent unknown status
        self.previousFlags = SCNetworkReachabilityFlags(rawValue: 1 << 30)
=======
>>>>>>> Stashed changes
    }

    deinit {
        stopListening()
    }

    // MARK: - Listening

    /// Starts listening for changes in network reachability status.
    ///
<<<<<<< Updated upstream
    /// - returns: `true` if listening was started successfully, `false` otherwise.
    @discardableResult
    open func startListening() -> Bool {
        var context = SCNetworkReachabilityContext(version: 0, info: nil, retain: nil, release: nil, copyDescription: nil)
        context.info = Unmanaged.passUnretained(self).toOpaque()

        let callbackEnabled = SCNetworkReachabilitySetCallback(
            reachability,
            { (_, flags, info) in
                let reachability = Unmanaged<NetworkReachabilityManager>.fromOpaque(info!).takeUnretainedValue()
                reachability.notifyListener(flags)
            },
            &context
        )

        let queueEnabled = SCNetworkReachabilitySetDispatchQueue(reachability, listenerQueue)

        listenerQueue.async {
            self.previousFlags = SCNetworkReachabilityFlags(rawValue: 1 << 30)

            guard let flags = self.flags else { return }

            self.notifyListener(flags)
        }

        return callbackEnabled && queueEnabled
=======
    /// - Note: Stops and removes any existing listener.
    ///
    /// - Parameters:
    ///   - queue:    `DispatchQueue` on which to call the `listener` closure. `.main` by default.
    ///   - listener: `Listener` closure called when reachability changes.
    ///
    /// - Returns: `true` if listening was started successfully, `false` otherwise.
    @discardableResult
    open func startListening(onQueue queue: DispatchQueue = .main,
                             onUpdatePerforming listener: @escaping Listener) -> Bool {
        stopListening()

        $mutableState.write { state in
            state.listenerQueue = queue
            state.listener = listener
        }

        let weakManager = WeakManager(manager: self)

        var context = SCNetworkReachabilityContext(
            version: 0,
            info: Unmanaged.passUnretained(weakManager).toOpaque(),
            retain: { info in
                let unmanaged = Unmanaged<WeakManager>.fromOpaque(info)
                _ = unmanaged.retain()

                return UnsafeRawPointer(unmanaged.toOpaque())
            },
            release: { info in
                let unmanaged = Unmanaged<WeakManager>.fromOpaque(info)
                unmanaged.release()
            },
            copyDescription: { info in
                let unmanaged = Unmanaged<WeakManager>.fromOpaque(info)
                let weakManager = unmanaged.takeUnretainedValue()
                let description = weakManager.manager?.flags?.readableDescription ?? "nil"

                return Unmanaged.passRetained(description as CFString)
            })
        let callback: SCNetworkReachabilityCallBack = { _, flags, info in
            guard let info = info else { return }

            let weakManager = Unmanaged<WeakManager>.fromOpaque(info).takeUnretainedValue()
            weakManager.manager?.notifyListener(flags)
        }

        let queueAdded = SCNetworkReachabilitySetDispatchQueue(reachability, reachabilityQueue)
        let callbackAdded = SCNetworkReachabilitySetCallback(reachability, callback, &context)

        // Manually call listener to give initial state, since the framework may not.
        if let currentFlags = flags {
            reachabilityQueue.async {
                self.notifyListener(currentFlags)
            }
        }

        return callbackAdded && queueAdded
>>>>>>> Stashed changes
    }

    /// Stops listening for changes in network reachability status.
    open func stopListening() {
        SCNetworkReachabilitySetCallback(reachability, nil, nil)
        SCNetworkReachabilitySetDispatchQueue(reachability, nil)
<<<<<<< Updated upstream
=======
        $mutableState.write { state in
            state.listener = nil
            state.listenerQueue = nil
            state.previousStatus = nil
        }
>>>>>>> Stashed changes
    }

    // MARK: - Internal - Listener Notification

<<<<<<< Updated upstream
    func notifyListener(_ flags: SCNetworkReachabilityFlags) {
        guard previousFlags != flags else { return }
        previousFlags = flags

        listener?(networkReachabilityStatusForFlags(flags))
    }

    // MARK: - Internal - Network Reachability Status

    func networkReachabilityStatusForFlags(_ flags: SCNetworkReachabilityFlags) -> NetworkReachabilityStatus {
        guard isNetworkReachable(with: flags) else { return .notReachable }

        var networkStatus: NetworkReachabilityStatus = .reachable(.ethernetOrWiFi)

    #if os(iOS)
        if flags.contains(.isWWAN) { networkStatus = .reachable(.wwan) }
    #endif

        return networkStatus
    }

    func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)

        return isReachable && (!needsConnection || canConnectWithoutUserInteraction)
=======
    /// Calls the `listener` closure of the `listenerQueue` if the computed status hasn't changed.
    ///
    /// - Note: Should only be called from the `reachabilityQueue`.
    ///
    /// - Parameter flags: `SCNetworkReachabilityFlags` to use to calculate the status.
    func notifyListener(_ flags: SCNetworkReachabilityFlags) {
        let newStatus = NetworkReachabilityStatus(flags)

        $mutableState.write { state in
            guard state.previousStatus != newStatus else { return }

            state.previousStatus = newStatus

            let listener = state.listener
            state.listenerQueue?.async { listener?(newStatus) }
        }
    }

    private final class WeakManager {
        weak var manager: NetworkReachabilityManager?

        init(manager: NetworkReachabilityManager?) {
            self.manager = manager
        }
>>>>>>> Stashed changes
    }
}

// MARK: -

extension NetworkReachabilityManager.NetworkReachabilityStatus: Equatable {}

<<<<<<< Updated upstream
/// Returns whether the two network reachability status values are equal.
///
/// - parameter lhs: The left-hand side value to compare.
/// - parameter rhs: The right-hand side value to compare.
///
/// - returns: `true` if the two values are equal, `false` otherwise.
public func ==(
    lhs: NetworkReachabilityManager.NetworkReachabilityStatus,
    rhs: NetworkReachabilityManager.NetworkReachabilityStatus)
    -> Bool
{
    switch (lhs, rhs) {
    case (.unknown, .unknown):
        return true
    case (.notReachable, .notReachable):
        return true
    case let (.reachable(lhsConnectionType), .reachable(rhsConnectionType)):
        return lhsConnectionType == rhsConnectionType
    default:
        return false
    }
}

=======
extension SCNetworkReachabilityFlags {
    var isReachable: Bool { contains(.reachable) }
    var isConnectionRequired: Bool { contains(.connectionRequired) }
    var canConnectAutomatically: Bool { contains(.connectionOnDemand) || contains(.connectionOnTraffic) }
    var canConnectWithoutUserInteraction: Bool { canConnectAutomatically && !contains(.interventionRequired) }
    var isActuallyReachable: Bool { isReachable && (!isConnectionRequired || canConnectWithoutUserInteraction) }
    var isCellular: Bool {
        #if os(iOS) || os(tvOS)
        return contains(.isWWAN)
        #else
        return false
        #endif
    }

    /// Human readable `String` for all states, to help with debugging.
    var readableDescription: String {
        let W = isCellular ? "W" : "-"
        let R = isReachable ? "R" : "-"
        let c = isConnectionRequired ? "c" : "-"
        let t = contains(.transientConnection) ? "t" : "-"
        let i = contains(.interventionRequired) ? "i" : "-"
        let C = contains(.connectionOnTraffic) ? "C" : "-"
        let D = contains(.connectionOnDemand) ? "D" : "-"
        let l = contains(.isLocalAddress) ? "l" : "-"
        let d = contains(.isDirect) ? "d" : "-"
        let a = contains(.connectionAutomatic) ? "a" : "-"

        return "\(W)\(R) \(c)\(t)\(i)\(C)\(D)\(l)\(d)\(a)"
    }
}
>>>>>>> Stashed changes
#endif
