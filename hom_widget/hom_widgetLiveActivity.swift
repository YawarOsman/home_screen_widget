//
//  hom_widgetLiveActivity.swift
//  hom_widget
//
//  Created by yara on 9/14/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct hom_widgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct hom_widgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: hom_widgetAttributes.self) { context in
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

extension hom_widgetAttributes {
    fileprivate static var preview: hom_widgetAttributes {
        hom_widgetAttributes(name: "World")
    }
}

extension hom_widgetAttributes.ContentState {
    fileprivate static var smiley: hom_widgetAttributes.ContentState {
        hom_widgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: hom_widgetAttributes.ContentState {
         hom_widgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: hom_widgetAttributes.preview) {
   hom_widgetLiveActivity()
} contentStates: {
    hom_widgetAttributes.ContentState.smiley
    hom_widgetAttributes.ContentState.starEyes
}
