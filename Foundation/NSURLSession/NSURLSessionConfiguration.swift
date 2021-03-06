// Foundation/NSURLSession/NSURLSessionConfiguration.swift - NSURLSession Configuration
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2016 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
// -----------------------------------------------------------------------------
///
/// URLSession API code.
/// - SeeAlso: NSURLSession.swift
///
// -----------------------------------------------------------------------------



/// Configuration options for an URLSession.
///
/// When a session is
/// created, a copy of the configuration object is made - you cannot
/// modify the configuration of a session after it has been created.
///
/// The shared session uses the global singleton credential, cache
/// and cookie storage objects.
///
/// An ephemeral session has no persistent disk storage for cookies,
/// cache or credentials.
///
/// A background session can be used to perform networking operations
/// on behalf of a suspended application, within certain constraints.
open class URLSessionConfiguration : NSObject, NSCopying {
    public override init() {
        self.requestCachePolicy = NSURLRequest.CachePolicy.useProtocolCachePolicy
        self.timeoutIntervalForRequest = 60
        self.timeoutIntervalForResource = 604800
        self.networkServiceType = .default
        self.allowsCellularAccess = true
        self.discretionary = false
        self.httpShouldUsePipelining = false
        self.httpShouldSetCookies = true
        self.httpCookieAcceptPolicy = .onlyFromMainDocumentDomain
        self.httpMaximumConnectionsPerHost = 6
        self.httpCookieStorage = nil
        self.urlCredentialStorage = nil
        self.urlCache = nil
        self.shouldUseExtendedBackgroundIdleMode = false
        super.init()
    }
    
    private init(identifier: String?,
                 requestCachePolicy: NSURLRequest.CachePolicy,
                 timeoutIntervalForRequest: TimeInterval,
                 timeoutIntervalForResource: TimeInterval,
                 networkServiceType: NSURLRequest.NetworkServiceType,
                 allowsCellularAccess: Bool,
                 discretionary: Bool,
                 connectionProxyDictionary: [AnyHashable:Any]?,
                 httpShouldUsePipelining: Bool,
                 httpShouldSetCookies: Bool,
                 httpCookieAcceptPolicy: HTTPCookie.AcceptPolicy,
                 httpAdditionalHeaders: [AnyHashable:Any]?,
                 httpMaximumConnectionsPerHost: Int,
                 httpCookieStorage: HTTPCookieStorage?,
                 urlCredentialStorage: URLCredentialStorage?,
                 urlCache: URLCache?,
                 shouldUseExtendedBackgroundIdleMode: Bool,
                 protocolClasses: [AnyClass]?)
    {
        self.identifier = identifier
        self.requestCachePolicy = requestCachePolicy
        self.timeoutIntervalForRequest = timeoutIntervalForRequest
        self.timeoutIntervalForResource = timeoutIntervalForResource
        self.networkServiceType = networkServiceType
        self.allowsCellularAccess = allowsCellularAccess
        self.discretionary = discretionary
        self.connectionProxyDictionary = connectionProxyDictionary
        self.httpShouldUsePipelining = httpShouldUsePipelining
        self.httpShouldSetCookies = httpShouldSetCookies
        self.httpCookieAcceptPolicy = httpCookieAcceptPolicy
        self.httpAdditionalHeaders = httpAdditionalHeaders
        self.httpMaximumConnectionsPerHost = httpMaximumConnectionsPerHost
        self.httpCookieStorage = httpCookieStorage
        self.urlCredentialStorage = urlCredentialStorage
        self.urlCache = urlCache
        self.shouldUseExtendedBackgroundIdleMode = shouldUseExtendedBackgroundIdleMode
        self.protocolClasses = protocolClasses
    }
    
    open override func copy() -> Any {
        return copy(with: nil)
    }
    
    open func copy(with zone: NSZone?) -> Any {
        return URLSessionConfiguration(
            identifier: identifier,
            requestCachePolicy: requestCachePolicy,
            timeoutIntervalForRequest: timeoutIntervalForRequest,
            timeoutIntervalForResource: timeoutIntervalForResource,
            networkServiceType: networkServiceType,
            allowsCellularAccess: allowsCellularAccess,
            discretionary: discretionary,
            connectionProxyDictionary: connectionProxyDictionary,
            httpShouldUsePipelining: httpShouldUsePipelining,
            httpShouldSetCookies: httpShouldSetCookies,
            httpCookieAcceptPolicy: httpCookieAcceptPolicy,
            httpAdditionalHeaders: httpAdditionalHeaders,
            httpMaximumConnectionsPerHost: httpMaximumConnectionsPerHost,
            httpCookieStorage: httpCookieStorage,
            urlCredentialStorage: urlCredentialStorage,
            urlCache: urlCache,
            shouldUseExtendedBackgroundIdleMode: shouldUseExtendedBackgroundIdleMode,
            protocolClasses: protocolClasses)
    }
    
    open class var `default`: URLSessionConfiguration {
        return URLSessionConfiguration()
    }
    open class var ephemeral: URLSessionConfiguration { NSUnimplemented() }

    open class func background(withIdentifier identifier: String) -> URLSessionConfiguration { NSUnimplemented() }
    
    /* identifier for the background session configuration */
    open var identifier: String?
    
    /* default cache policy for requests */
    open var requestCachePolicy: NSURLRequest.CachePolicy
    
    /* default timeout for requests.  This will cause a timeout if no data is transmitted for the given timeout value, and is reset whenever data is transmitted. */
    open var timeoutIntervalForRequest: TimeInterval
    
    /* default timeout for requests.  This will cause a timeout if a resource is not able to be retrieved within a given timeout. */
    open var timeoutIntervalForResource: TimeInterval
    
    /* type of service for requests. */
    open var networkServiceType: NSURLRequest.NetworkServiceType
    
    /* allow request to route over cellular. */
    open var allowsCellularAccess: Bool
    
    /* allows background tasks to be scheduled at the discretion of the system for optimal performance. */
    open var discretionary: Bool
    
    /* The identifier of the shared data container into which files in background sessions should be downloaded.
     * App extensions wishing to use background sessions *must* set this property to a valid container identifier, or
     * all transfers in that session will fail with NSURLErrorBackgroundSessionRequiresSharedContainer.
     */
    open var sharedContainerIdentifier: String? { return nil }
    
    /*
     * Allows the app to be resumed or launched in the background when tasks in background sessions complete
     * or when auth is required. This only applies to configurations created with +backgroundSessionConfigurationWithIdentifier:
     * and the default value is YES.
     */
    
    /* The proxy dictionary, as described by <CFNetwork/CFHTTPStream.h> */
    open var connectionProxyDictionary: [AnyHashable : Any]? = nil
    
    // TODO: We don't have the SSLProtocol type from Security
    /*
     /* The minimum allowable versions of the TLS protocol, from <Security/SecureTransport.h> */
     open var TLSMinimumSupportedProtocol: SSLProtocol
     
     /* The maximum allowable versions of the TLS protocol, from <Security/SecureTransport.h> */
     open var TLSMaximumSupportedProtocol: SSLProtocol
     */
    
    /* Allow the use of HTTP pipelining */
    open var httpShouldUsePipelining: Bool
    
    /* Allow the session to set cookies on requests */
    open var httpShouldSetCookies: Bool
    
    /* Policy for accepting cookies.  This overrides the policy otherwise specified by the cookie storage. */
    open var httpCookieAcceptPolicy: HTTPCookie.AcceptPolicy
    
    /* Specifies additional headers which will be set on outgoing requests.
     Note that these headers are added to the request only if not already present. */
    open var httpAdditionalHeaders: [AnyHashable : Any]? = nil
    
    /* The maximum number of simultanous persistent connections per host */
    open var httpMaximumConnectionsPerHost: Int
    
    /* The cookie storage object to use, or nil to indicate that no cookies should be handled */
    open var httpCookieStorage: HTTPCookieStorage?
    
    /* The credential storage object, or nil to indicate that no credential storage is to be used */
    open var urlCredentialStorage: URLCredentialStorage?
    
    /* The URL resource cache, or nil to indicate that no caching is to be performed */
    open var urlCache: URLCache?
    
    /* Enable extended background idle mode for any tcp sockets created.    Enabling this mode asks the system to keep the socket open
     *  and delay reclaiming it when the process moves to the background (see https://developer.apple.com/library/ios/technotes/tn2277/_index.html)
     */
    open var shouldUseExtendedBackgroundIdleMode: Bool
    
    /* An optional array of Class objects which subclass NSURLProtocol.
     The Class will be sent +canInitWithRequest: when determining if
     an instance of the class can be used for a given URL scheme.
     You should not use +[NSURLProtocol registerClass:], as that
     method will register your class with the default session rather
     than with an instance of URLSession.
     Custom NSURLProtocol subclasses are not available to background
     sessions.
     */
     open var protocolClasses: [AnyClass]?

}
