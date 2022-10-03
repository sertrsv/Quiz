//
//  SingleAnswerQuestion.swift
//  Quiz
//
//  Created by Sergey Tarasov on 03.10.2022.
//

import SwiftUI

struct SingleAnswerQuestion: View {

	let title: String
	let question: String
	let options: [String]
	let selection: (String) -> Void

    var body: some View {
		VStack(alignment: .leading) {
			VStack(alignment: .leading, spacing: 16) {
				Text(title)
					.font(.headline)
				Text(question)
				 .font(.title)
			}
			.padding()

			List {
				ForEach(options, id: \.self) { option in
					Label(option, systemImage: "circle")
				}
			}
			.listStyle(.plain)
		}
		.border(.red)
	}
}

struct SingleAnswerQuestion_Previews: PreviewProvider {
	static var previews: some View {
		SingleAnswerQuestion(
			title: "1 of 2",
			question: "What's the best language?",
			options: [
				"Java", "Swift", "English", "C++"
			],
			selection: { _ in }
		)
	}
}
