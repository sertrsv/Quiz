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
	var selection: (String) -> Void

    var body: some View {
		VStack(alignment: .leading) {
			HeaderView(title: title, subtitle: question)
			List {
				ForEach(options, id: \.self) { option in
					Button {
						selection(option)
					} label: {
						Label(option, systemImage: "circle")
					}
				}
			}
			.listStyle(.plain)
		}
	}
}

struct SingleAnswerQuestion_Previews: PreviewProvider {
	static var previews: some View {
		SingleAnswerQuestionTestView()
	}

	struct SingleAnswerQuestionTestView: View {
		@State var selection: String = ""

		var body: some View {
			VStack {
				SingleAnswerQuestion(
					title: "1 of 2",
					question: "What's the best language?",
					options: [
						"Java", "Swift", "English", "C++"
					],
					selection: { selection = $0 }
				)

				Text("Last selection: " + selection)
			}
		}
	}
}
