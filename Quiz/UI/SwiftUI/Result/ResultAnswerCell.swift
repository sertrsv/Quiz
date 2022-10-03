//
//  ResultAnswerCell.swift
//  Quiz
//
//  Created by Sergey Tarasov on 04.10.2022.
//

import SwiftUI

struct ResultAnswerCell: View {
	let model: PresentableAnswer

	var body: some View {
		VStack(alignment: .leading, spacing: 2) {
			Text(model.question)
				.font(.title3)
			Text(model.answer)
				.foregroundColor(.green)
			if let wrongAnswer = model.wrongAnswer {
				Text(wrongAnswer)
					.foregroundColor(.red)
			}
		}
		.padding(.vertical, 6)
	}
}

struct ResultAnswerCell_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			ResultAnswerCell(
				model: PresentableAnswer(
					question: "A question",
					answer: "A correct answer",
					wrongAnswer: "A wrong answer")
			)
			.previewLayout(.sizeThatFits)
			ResultAnswerCell(
				model: PresentableAnswer(
					question: "A question",
					answer: "A correct answer",
					wrongAnswer: nil)
			)
			.previewLayout(.sizeThatFits)
		}
	}
}
