//
//  BlurView.swift
//  Generic
//
//  Created by YHAN on 2022/07/15.
//  Copyright © 2022 tuist.io. All rights reserved.
//

import SwiftUI

public struct BlurView: UIViewRepresentable {
  
  private let style: UIBlurEffect.Style
  
  public init(style: UIBlurEffect.Style) {
    self.style = style
  }
  
  public func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
    let view = UIView(frame: .zero)
    view.backgroundColor = .clear
    let blurEffect = UIBlurEffect(style: style)
    let blurView = UIVisualEffectView(effect: blurEffect)
    blurView.translatesAutoresizingMaskIntoConstraints = false
    view.insertSubview(blurView, at: 0)
    NSLayoutConstraint.activate([
      blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
      blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
    ])
    return view
  }
  
  public func updateUIView(_ uiView: UIView,
                    context: UIViewRepresentableContext<BlurView>) { }
}
