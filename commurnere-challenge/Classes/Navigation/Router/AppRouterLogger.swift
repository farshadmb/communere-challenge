//
//  AppRouterLogger.swift
//  commurnere-challenge
//
//  Created by Farshad Mousalou on 6/12/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import RouteComposer

/// `AppRouterLogger` Class, log every navigation step which navigate into.
struct AppRouterLogger: RouteComposer.Logger {
    
    /// Logs a message
    ///
    /// - Parameter message: - message: The `LogMessage` instance
    func log(_ message: LogMessage) {
        switch message {
        case .warning(let message):
            Logger.warnLog("Router Logger => \(message)", tag: "AppRouterLogger")
        case .info(let message):
            Logger.infoLog("Router Logger => \(message)", tag: "AppRouterLogger")
        case .error(let error):
            Logger.errorLog("Router Logger => \(error)", tag: "AppRouterLogger")
        }
    }
    
}
