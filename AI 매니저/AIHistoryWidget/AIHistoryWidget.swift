import WidgetKit
import SwiftUI

// 1. 데이터 모델: AI 대화 정보를 담는 바구니
struct AIChatSummary: Identifiable {
    let id = UUID()
    let toolName: String
    let topic: String
    let briefSummary: String
    let lastPrompt: String
}

// 2. 타임라인 엔트리: 위젯에 전달될 "시간 + 데이터" 세트
struct SimpleEntry: TimelineEntry {
    let date: Date
    let summaries: [AIChatSummary]
}

// 3. 프로바이더: 위젯에 어떤 데이터를 언제 보여줄지 결정하는 엔진
struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), summaries: AIChatSummary.samples)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), summaries: AIChatSummary.samples)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        let entry = SimpleEntry(date: Date(), summaries: AIChatSummary.samples)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

// 4. 개별 줄(Row) 디자인: Zuki님이 말한 "한 줄 요약" 화면
struct AIChatRowView: View {
    let chat: AIChatSummary
    
    var body: some View {
        HStack(spacing: 8) {
            // AI 툴 이름 태그
            Text(chat.toolName)
                .font(.system(size: 10, weight: .bold))
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(Color.blue.opacity(0.2))
                .cornerRadius(4)
            
            // 토픽 | 요약 • 프롬프트
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
                    .foregroundColor(.secondary)
            }
            .font(.system(size: 11))
            .lineLimit(1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// 5. 위젯 메인 뷰: 전체적인 위젯 레이아웃
struct AIHistoryWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("최근 AI 대화 요약")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.secondary)
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(entry.summaries) { chat in
                    AIChatRowView(chat: chat)
                }
            }
            Spacer()
        }
        .containerBackground(.fill.tertiary, for: .widget) // iOS 17 대응 배경
    }
}

// 6. 위젯 설정: 위젯의 이름과 설명
@main
struct AIHistoryWidget: Widget {
    let kind: String = "AIHistoryWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            AIHistoryWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("AI 대화 매니저")
        .description("어떤 AI와 어떤 대화를 나눴는지 확인하세요.")
        .supportedFamilies([.systemMedium, .systemLarge]) // 한 줄 요약을 위해 Medium 이상 권장
    }
}

// 샘플 데이터
extension AIChatSummary {
    static let samples = [
        AIChatSummary(toolName: "Gemini", topic: "SwiftUI 위젯", briefSummary: "레이아웃 작성 중", lastPrompt: "HStack 사용법"),
        AIChatSummary(toolName: "GPT-4", topic: "주식 분석", briefSummary: "반도체 전망", lastPrompt: "NVDA 실적 요약"),
        AIChatSummary(toolName: "Claude", topic: "기획서 작성", briefSummary: "신규 서비스 기안", lastPrompt: "시장 분석 데이터")
    ]
}
