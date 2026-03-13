//
//  AIHistoryWidgetLiveActivity.swift
//  AIHistoryWidget
//
//  Created by zuki on 3/13/26.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct AIHistoryWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct AIHistoryWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: AIHistoryWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension AIHistoryWidgetAttributes {
    fileprivate static var preview: AIHistoryWidgetAttributes {
        AIHistoryWidgetAttributes(name: "World")
    }
}

extension AIHistoryWidgetAttributes.ContentState {
    fileprivate static var smiley: AIHistoryWidgetAttributes.ContentState {
        AIHistoryWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: AIHistoryWidgetAttributes.ContentState {
         AIHistoryWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: AIHistoryWidgetAttributes.preview) {
   AIHistoryWidgetLiveActivity()
} contentStates: {
    AIHistoryWidgetAttributes.ContentState.smiley
    AIHistoryWidgetAttributes.ContentState.starEyes
}
