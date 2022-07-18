//
//  NavigationBar.swift
//  Generic
//
//  Created by YHAN on 2022/07/15.
//  Copyright © 2022 tuist.io. All rights reserved.
//

import SwiftUI
import Introspect

// MARK: - Define NavigationBar

public struct NavigationBar<LeftContent, TitleContent, RightContent>: View where LeftContent: View, TitleContent: View, RightContent: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  @Environment(\.presentationMode) var presentationMode
  @Binding private var isStartScrollUp: Bool
  @Binding private var isShowBlur: Bool
  @State private var isShowBlurAfter: Bool = false
  private let title: String
  private let leftBarButtonItem: () -> LeftContent
  private let titleContent: () -> TitleContent
  private let rightBarButtonItem: () -> RightContent
  
  public init(
    title: String,
    isStartScrollUp: Binding<Bool>,
    isShowBlur: Binding<Bool>,
    @ViewBuilder leftBarButtonItem: @escaping () -> LeftContent,
    @ViewBuilder titleContent: @escaping () -> TitleContent,
    @ViewBuilder rightBarButtonItem: @escaping () -> RightContent
  ) {
    self._isStartScrollUp = isStartScrollUp
    self._isShowBlur = isShowBlur
    self.title = title
    self.leftBarButtonItem = leftBarButtonItem
    self.titleContent = titleContent
    self.rightBarButtonItem = rightBarButtonItem
  }
  
  public var body: some View {
    GeometryReader { proxy in
      ZStack {
//        Asset.background.color
        Color.black
          .frame(width: UIScreen.main.bounds.width, height: 55 + proxy.safeAreaInsets.top)
          .opacity(isShowBlurAfter ? 0 : 1)
        
        BlurView(style: .light)
          .frame(width: UIScreen.main.bounds.width, height: 55 + proxy.safeAreaInsets.top)
          .opacity(colorScheme == .light ? 1 : 0)
          .opacity(isShowBlur ? 1 : 0)
        
        BlurView(style: .dark)
          .frame(width: UIScreen.main.bounds.width, height: 55 + proxy.safeAreaInsets.top)
          .opacity(colorScheme == .dark ? 1 : 0)
          .opacity(isShowBlur ? 1 : 0)
        
        HStack(alignment: .center, spacing: .zero) {
          Button(action: {
            self.presentationMode.wrappedValue.dismiss()
          }) {
            leftBarButtonItem()
          }
          .padding(.leading, 20)
          
          Spacer()
          
          rightBarButtonItem()
            .padding(.trailing, 20)
        }
        .padding(.top, proxy.safeAreaInsets.top)
        
        HStack(alignment: .center, spacing: .zero) {
          titleContent()
            .scaleEffect(0.7)
            .opacity(isStartScrollUp ? 1 : 0)
        }
        .padding(.top, proxy.safeAreaInsets.top)
      }
      .frame(height: 55 + proxy.safeAreaInsets.top)
      .ignoresSafeArea(edges: .top)
      .onChange(of: isShowBlur) { newValue in
        withAnimation(.linear(duration: 0.35)) {
          isShowBlurAfter = newValue
        }
      }
    }
  }
}

// MARK: - NavigationBarModifire

struct NavigationBarModifire<LeftContent, TitleContent, RightContent>: ViewModifier where LeftContent: View, TitleContent: View, RightContent: View {
  @State private var isStartScrollUp: Bool = false
  @State private var isShowBlur: Bool = false
  @State private var scale: CGFloat = 1
  @State private var titleContentSize: CGFloat = .zero
  private let title: String
  private let leftBarButtonItem: () -> LeftContent
  private let titleContent: () -> TitleContent
  private let rightBarButtonItem: () -> RightContent
  
  public init(
    title: String,
    @ViewBuilder leftBarButtonItem: @escaping () -> LeftContent,
    @ViewBuilder titleContent: @escaping () -> TitleContent,
    @ViewBuilder rightBarButtonItem: @escaping () -> RightContent
  ) {
    self.title = title
    self.leftBarButtonItem = leftBarButtonItem
    self.titleContent = titleContent
    self.rightBarButtonItem = rightBarButtonItem
  }
  
  func body(content: Content) -> some View {
    ZStack {
      OffsettableScrollView(showsIndicator: false) { offset in
        if offset.y > .zero {
          let calcScale = (offset.y / 3500)
          if 0.05 > calcScale {
            scale = 1 + calcScale
          }
        }
        
        if offset.y < .zero {
          isStartScrollUp = true
          isShowBlur = true
        }
        
        if offset.y >= .zero {
          isStartScrollUp = false
        }
        
        if offset.y >= -UIFontMetrics.default.scaledValue(for: titleContentSize) {
          isStartScrollUp = false
        }
        
        if offset.y >= -UIFontMetrics.default.scaledValue(for: titleContentSize) - 10 {
          isShowBlur = false
        }
      } content: {
        VStack(spacing: .zero) {
          Spacer(minLength: 55)
          
          HStack {
            titleContent()
              .opacity(isStartScrollUp ? 0 : 1)
              .scaleEffect(x: scale, y: scale, anchor: .leading)
              .background(
                GeometryReader { proxy in
                  Color.clear
                    .onAppear {
                      titleContentSize = proxy.size.height
                    }
                }
              )
            Spacer()
          }
          .padding(.bottom, 10)
          
          content
        }
        .padding(.horizontal, 20)
      }
    }
    .navigationBarHidden(true)
    .navigationBarTitle(String())
    .navigationBarTitleDisplayMode(.inline)
    .navigationViewStyle(StackNavigationViewStyle())
    
    VStack {
      NavigationBar(
        title: title,
        isStartScrollUp: $isStartScrollUp,
        isShowBlur: $isShowBlur,
        leftBarButtonItem: leftBarButtonItem,
        titleContent: titleContent,
        rightBarButtonItem: rightBarButtonItem
      )
      Spacer()
    }
  }
}

// MARK: - View Extensions

extension View {
  public func navigationBar<LeftContent, TitleContent, RightContent>(
    title: String,
    @ViewBuilder leftBarButtonItem: @escaping () -> LeftContent,
    @ViewBuilder titleContent: @escaping () -> TitleContent,
    @ViewBuilder rightBarButtonItem: @escaping () -> RightContent
  ) -> some View where LeftContent: View, TitleContent: View, RightContent: View {
    modifier(
      NavigationBarModifire(
        title: title,
        leftBarButtonItem: leftBarButtonItem,
        titleContent: titleContent,
        rightBarButtonItem: rightBarButtonItem
      )
    )
  }
  
  public func navigationBar<LeftContent, TitleContent>(
    title: String,
    @ViewBuilder leftBarButtonItem: @escaping () -> LeftContent,
    @ViewBuilder titleContent: @escaping () -> TitleContent
  ) -> some View where LeftContent: View, TitleContent: View {
    modifier(
      NavigationBarModifire(
        title: title,
        leftBarButtonItem: leftBarButtonItem,
        titleContent: titleContent,
        rightBarButtonItem: { EmptyView() }
      )
    )
  }
  
  public func navigationBar<LeftContent, RightContent>(
    title: String,
    @ViewBuilder leftBarButtonItem: @escaping () -> LeftContent,
    @ViewBuilder rightBarButtonItem: @escaping () -> RightContent
  ) -> some View where LeftContent: View, RightContent: View {
    modifier(
      NavigationBarModifire(
        title: title,
        leftBarButtonItem: leftBarButtonItem,
        titleContent: {
          Text(title)
            .fontWeight(.bold)
            .font(.system(size: 24))
//            .scaledFont(size: 24)
        },
        rightBarButtonItem: rightBarButtonItem
      )
    )
  }
  
  public func navigationBar<LeftContent>(
    title: String,
    @ViewBuilder leftBarButtonItem: @escaping () -> LeftContent
  ) -> some View where LeftContent: View {
    modifier(
      NavigationBarModifire(
        title: title,
        leftBarButtonItem: leftBarButtonItem,
        titleContent: {
          Text(title)
            .fontWeight(.bold)
            .font(.system(size: 24))
//            .scaledFont(size: 24)
        },
        rightBarButtonItem: { EmptyView() }
      )
    )
  }
  
  public func navigationBar(title: String) -> some View {
    modifier(
      NavigationBarModifire(
        title: title,
        leftBarButtonItem: { EmptyView() },
        titleContent: {
          Text(title)
            .fontWeight(.bold)
            .font(.system(size: 24))
//            .scaledFont(size: 24)
        },
        rightBarButtonItem: { EmptyView() }
      )
    )
  }
  
  public func navigationBar<TitleContent>(
    @ViewBuilder titleContent: @escaping () -> TitleContent
  ) -> some View where TitleContent: View {
    modifier(
      NavigationBarModifire(
        title: String(),
        leftBarButtonItem: { EmptyView() },
        titleContent: titleContent,
        rightBarButtonItem: { EmptyView() }
      )
    )
  }
  
  public func navigationBar() -> some View {
    modifier(
      NavigationBarModifire(
        title: String(),
        leftBarButtonItem: { EmptyView() },
        titleContent: { EmptyView() },
        rightBarButtonItem: { EmptyView() }
      )
    )
  }
}

// MARK: - OffsettableScrollView

struct OffsettableScrollView<T: View>: View {
  let axes: Axis.Set
  let showsIndicator: Bool
  let onOffsetChanged: (CGPoint) -> Void
  let content: T
  
  init(axes: Axis.Set = .vertical,
       showsIndicator: Bool = true,
       onOffsetChanged: @escaping (CGPoint) -> Void = { _ in },
       @ViewBuilder content: () -> T
  ) {
    self.axes = axes
    self.showsIndicator = showsIndicator
    self.onOffsetChanged = onOffsetChanged
    self.content = content()
  }
  
  var body: some View {
    ScrollView(axes, showsIndicators: showsIndicator) {
      GeometryReader { proxy in
        Color.clear.preference(
          key: OffsetPreferenceKey.self,
          value: proxy.frame(
            in: .named("ScrollViewOrigin")
          ).origin
        )
      }
      .frame(width: 0, height: 0)
      content
    }
    .coordinateSpace(name: "ScrollViewOrigin")
    .onPreferenceChange(OffsetPreferenceKey.self,
                        perform: onOffsetChanged)
  }
}

private struct OffsetPreferenceKey: PreferenceKey {
  static var defaultValue: CGPoint = .zero
  static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) { }
}

