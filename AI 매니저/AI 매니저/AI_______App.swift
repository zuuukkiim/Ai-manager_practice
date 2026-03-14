import SwiftUI
import WidgetKit // 위젯 데이터 모델 공유를 위해 필요

// 1. 데이터 모델 정의 (여기서 한 번만 정의!)
struct AIChatSummary: Identifiable {
    let id = UUID()
    let toolName: String
    let topic: String
    let briefSummary: String
    let lastPrompt: String
    
    // 샘플 데이터
    static let samples = [
        AIChatSummary(toolName: "Gemini", topic: "SwiftUI 위젯", briefSummary: "레이아웃 작성 중", lastPrompt: "HStack 사용법"),
        AIChatSummary(toolName: "GPT-4", topic: "주식 분석", briefSummary: "반도체 전망", lastPrompt: "NVDA 실적 요약"),
        AIChatSummary(toolName: "Claude", topic: "기획서 작성", briefSummary: "신규 서비스 기안", lastPrompt: "시장 분석 데이터")
    ]
}

@main
struct AI_Manager_App: App {
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
}

// 2. 보석 당근 로고 화면
struct SplashScreenView: View {
    @State private var isActive = false
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                Color(red: 0.1, green: 0.01, blue: 0.02).ignoresSafeArea()
                VStack(spacing: 20) {
                    HStack(spacing: -10) {
                        Image(systemName: "diamond.fill").resizable().frame(width: 30, height: 50).rotationEffect(.degrees(-10))
                        Image(systemName: "diamond.fill").resizable().frame(width: 35, height: 60)
                        Image(systemName: "diamond.fill").resizable().frame(width: 30, height: 50).rotationEffect(.degrees(10))
                    }
                    .foregroundStyle(LinearGradient(colors: [.orange, .yellow], startPoint: .top, endPoint: .bottom))
                    .shadow(color: .orange.opacity(0.8), radius: 15)
                    Text("AI 매니저").font(.system(size: 34, weight: .bold, design: .rounded)).foregroundColor(.white)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation { self.isActive = true }
                }
            }
        }
    }
}

// --- 여기서부터 파일 끝까지 교체하세요 ---

// 3. 애플 감성 하단 메뉴 & 밝은 테마 메인 화면
struct ContentView: View {
    // 샘플 데이터
    let histories = AIChatSummary.samples

    var body: some View {
        TabView {
            // 첫 번째 탭: 메인 히스토리
            NavigationStack {
                ZStack {
                    Color(red: 0.98, green: 0.98, blue: 1.0).ignoresSafeArea()
                    
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            headerCell("AI 툴", width: 80)
                            headerCell("대화 주제", width: 120)
                            headerCell("마지막 프롬프트 요약", width: nil)
                        }
                        .background(Color.white)
                        .overlay(Rectangle().stroke(Color.gray.opacity(0.1), lineWidth: 1))
                        
                        ScrollView {
                            VStack(spacing: 0) {
                                ForEach(histories) { history in
                                    HStack(spacing: 0) {
                                        toolCell(history.toolName, width: 80)
                                        Text(history.topic).font(.system(size: 13, weight: .medium)).foregroundColor(.primary).frame(width: 120, alignment: .leading).padding(.leading, 10)
                                        Text(history.lastPrompt).font(.system(size: 12)).foregroundColor(.secondary).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10).lineLimit(1)
                                    }
                                    .frame(height: 55)
                                    .overlay(Rectangle().stroke(Color.gray.opacity(0.1), lineWidth: 0.5))
                                }
                            }
                        }
                        .background(Color.white)
                    }
                    .cornerRadius(10)
                    .padding()
                }
                .navigationTitle("AI 히스토리")
                .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Image(systemName: "person.crop.circle.fill")
                Text("프로필")
            }

            // 두 번째 탭: 대화 시작
            Text("대화 시작 화면")
            .tabItem {
                Image(systemName: "bubble.right.fill")
                Text("대화 시작")
            }

            // 세 번째 탭: 검색
            Text("검색 화면")
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("검색")
            }
        }
        .accentColor(.blue)
    }

    func headerCell(_ title: String, width: CGFloat?) -> some View {
        Text(title)
            .font(.system(size: 12, weight: .bold))
            .foregroundColor(.gray)
            .frame(width: width, height: 40)
            .frame(maxWidth: width == nil ? .infinity : width)
            .background(Color.white)
            .overlay(Rectangle().stroke(Color.gray.opacity(0.1), lineWidth: 0.5))
    }

    func toolCell(_ name: String, width: CGFloat) -> some View {
        Text(name)
            .font(.system(size: 11, weight: .heavy))
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(Color.orange.opacity(0.1))
            .cornerRadius(4)
            .foregroundColor(.orange)
            .frame(width: width)
            .overlay(Rectangle().stroke(Color.gray.opacity(0.1), lineWidth: 0.5))
    }
}
