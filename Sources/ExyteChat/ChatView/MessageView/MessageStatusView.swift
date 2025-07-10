//
//  Created by Alex.M on 07.07.2022.
//

import SwiftUI

struct MessageStatusView: View {

    @Environment(\.chatTheme) private var theme

    let status: Message.Status
    let onRetry: () -> Void

    var body: some View {
        Group {
            switch status {
            case .sending:
                theme.images.message.sending
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(theme.colors.grayStatus)
            case .sent:
                theme.images.message.singleCheckmark
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(theme.colors.grayStatus)
            case .read:
                theme.images.message.doubleCheckmarks
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(theme.colors.myMessage)
            case .error:
                Button {
                    onRetry()
                } label: {
                    theme.images.message.error
                        .resizable()
                }
                .foregroundColor(theme.colors.errorStatus)
            }
        }
        .viewSize(MessageView.statusViewSize)
        .padding(.trailing, MessageView.horizontalStatusPadding)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MessageStatusView(status: .sending, onRetry: {})
            MessageStatusView(status: .sent, onRetry: {})
            MessageStatusView(status: .read, onRetry: {})
        }
    }
}
