//
//  IntentHandler.swift
//  WidgetIntentTarget
//
//  Created by Ravi Tripathi on 16/08/20.
//

import Intents

class IntentHandler: INExtension, GitBrowserIntentIntentHandling {
    
    func resolveUsername(for intent: GitBrowserIntentIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        if let username = intent.username {
            completion(INStringResolutionResult.success(with: username))
        } else {
            completion(INStringResolutionResult.confirmationRequired(with: intent.username))
        }
    }
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}
