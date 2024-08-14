//
//  BPHostingConfiguration.swift
//
//
//  Created by Igor Rudenko on 14.08.2024.
//

import UIKit
import SwiftUI

struct BPHostingConfiguration<Content: View>: UIContentConfiguration {
    fileprivate let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    func makeContentView() -> any UIView & UIContentView {
        HostingView<Content>(configuration: self)
    }

    func updated(for state: any UIConfigurationState) -> BPHostingConfiguration {
        return self
    }
}

fileprivate final class HostingView<Content: View>: UIView, UIContentView {
    private let hostingController: UIHostingController<Content>
    private var _configuration: BPHostingConfiguration<Content>

    var configuration: any UIContentConfiguration {
        @storageRestrictions(initializes: _configuration, hostingController)
        init(newValue) {
            let configuration: BPHostingConfiguration<Content> = newValue as! BPHostingConfiguration<Content>
            _configuration = configuration as! BPHostingConfiguration
            hostingController = .init(rootView: configuration.content)
        }
        get {
            _configuration
        }
        set {
            let configuration: BPHostingConfiguration<Content> = newValue as! BPHostingConfiguration<Content>
            _configuration = configuration
            hostingController.rootView = configuration.content
        }
    }


    init(configuration: any UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .null)

        let hostingView: UIView = hostingController.view
        hostingView.translatesAutoresizingMaskIntoConstraints = false
//        hostingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(hostingView)
        NSLayoutConstraint.activate([
            hostingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            hostingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            hostingView.topAnchor.constraint(equalTo: topAnchor),
            hostingView.bottomAnchor.constraint(equalTo: bottomAnchor),
            hostingView.heightAnchor.constraint(equalTo: heightAnchor),
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
