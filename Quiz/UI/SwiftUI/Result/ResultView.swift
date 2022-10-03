//
//  ResultView.swift
//  Quiz
//
//  Created by Sergey Tarasov on 03.10.2022.
//

import SwiftUI

struct ResultView: View {
	let title: String
	let summary: String
	@State var answers: [PresentableAnswer]
	let playAgain: () -> Void

    var body: some View {
		VStack(alignment: .leading) {
			HeaderView(title: title, subtitle: summary)

			List(answers, id: \.question) { model in 
				ResultAnswerCell(model: model)
			}
			.listStyle(.plain)

			BigButton(title: "Play again", action: playAgain)
		}
	}
}

struct ResultView_Previews: PreviewProvider {
	static var previews: some View {
		ResultTestView()
	}

	struct ResultTestView: View {
		@State var playAgainCount = 0

		var body: some View {
			VStack {
				ResultView(
					title: "Result",
					summary: "You got 5/8 correct",
					answers: [
						.init(
							question: "What's the answer to question #001?",
							answer: "A correct answer",
							wrongAnswer: "A wrong answer"),
						.init(
							question: "What's the answer to question #002?",
							answer: "A correct answer",
							wrongAnswer: nil),
						.init(
							question: "What's the answer to question #003?",
							answer: "A correct answer",
							wrongAnswer: "A wrong answer"),
						.init(
							question: "What's the answer to question #004?",
							answer: "A correct answer",
							wrongAnswer: nil),
						.init(
							question: "What's the answer to question #005?",
							answer: "A correct answer",
							wrongAnswer: "A wrong answer"),
						.init(
							question: "What's the answer to question #006?",
							answer: "A correct answer",
							wrongAnswer: "A wrong answer"),
						.init(
							question: "What's the answer to question #007?",
							answer: "A correct answer",
							wrongAnswer: nil),
						.init(
							question: "What's the answer to question #008?",
							answer: "A correct answer",
							wrongAnswer: "A wrong answer")
					],
				playAgain: { playAgainCount += 1 })

				Text("Play again count: \(playAgainCount)")
			}
		}
	}
}
