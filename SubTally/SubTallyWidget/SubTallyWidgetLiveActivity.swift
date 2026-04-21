//
//  SubTallyWidgetLiveActivity.swift
//  SubTallyWidget
//
//  Created by MacMini4 on 2026/4/21.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct SubTallyWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct SubTallyWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: SubTallyWidgetAttributes.self) { context in
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

extension SubTallyWidgetAttributes {
    fileprivate static var preview: SubTallyWidgetAttributes {
        SubTallyWidgetAttributes(name: "World")
    }
}

extension SubTallyWidgetAttributes.ContentState {
    fileprivate static var smiley: SubTallyWidgetAttributes.ContentState {
        SubTallyWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: SubTallyWidgetAttributes.ContentState {
         SubTallyWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: SubTallyWidgetAttributes.preview) {
   SubTallyWidgetLiveActivity()
} contentStates: {
    SubTallyWidgetAttributes.ContentState.smiley
    SubTallyWidgetAttributes.ContentState.starEyes
}
