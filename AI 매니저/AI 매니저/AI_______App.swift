//
//  AI_______App.swift
//  AI 매니저
//
//  Created by zuki on 3/13/26.
//

import SwiftUI

@main
struct AI_______App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
import SwiftUI

// 앱을 켰을 때 보여줄 기본 화면입니다.
struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "cpu")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("AI 매니저 앱 메인 화면")
                .font(.headline)
                .padding()
            Text("위젯에서 대화 요약을 확인하세요!")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}
