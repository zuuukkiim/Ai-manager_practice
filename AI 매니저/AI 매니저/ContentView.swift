import Foundation

struct AIChatSummary: Identifiable {
    let id = UUID()
    let toolName: String     // AI 툴 이름 (예: Gemini, ChatGPT)
    let topic: String        // 나누고 있던 토픽
    let briefSummary: String // 한 구절 요약
    let lastPrompt: String   // 마지막 프롬프트 요약
}

// 샘플 데이터
extension AIChatSummary {
    static let samples = [
        AIChatSummary(toolName: "Gemini", topic: "SwiftUI 위젯", briefSummary: "레이아웃 코드 작성 중", lastPrompt: "HStack 사용법 질문"),
        AIChatSummary(toolName: "GPT-4", topic: "주식 분석", briefSummary: "반도체 섹터 전망", lastPrompt: "NVDA 실적 요약 요청")
    ]
}
import SwiftUI

struct AIChatRowView: View {
    let chat: AIChatSummary
    
    var body: some View {
        HStack(spacing: 8) {
            // AI 툴 이름 (태그 스타일)
            Text(chat.toolName)
                .font(.system(size: 10, weight: .bold))
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(Color.blue.opacity(0.2))
                .cornerRadius(4)
            
            // 토픽 및 요약 (한 줄로 결합)
            HStack(spacing: 4) {
                Text(chat.topic)
                    .fontWeight(.semibold)
                Text("|")
                    .foregroundColor(.secondary)
                Text(chat.briefSummary)
                Text("•")
                    .foregroundColor(.secondary)
                Text(chat.lastPrompt)
                    .italic()
            }
            .font(.system(size: 11))
            .lineLimit(1) // 한 줄 유지
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
import WidgetKit

// 1. SimpleEntry 구조체 정의 (이게 없어서 에러가 난 거예요!)
struct SimpleEntry: TimelineEntry {
    let date: Date
    // 여기에 위젯에 표시할 추가 데이터를 넣을 수 있습니다.
}
struct AIHistoryWidgetEntryView : View {
    var entry: SimpleEntry // WidgetKit에서 제공하는 기본 Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("최근 AI 대화 요약")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.secondary)
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(AIChatSummary.samples.prefix(3)) { chat in
                    AIChatRowView(chat: chat)
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

