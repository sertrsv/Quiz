//
//  MultipleAnswerQuestion.swift
//  Quiz
//
//  Created by Sergey Tarasov on 03.10.2022.
//

import SwiftUI

struct MultipleAnswerQuestion: View {
	let title: String
	let question: String
	@State var store: MultipleSelectionStore

	var body: some View {
		VStack(alignment: .leading) {
			HeaderView(title: title, subtitle: question)
			List {
				ForEach(store.options.indices, id: \.self) { index in
					Button {
						store.options[index].select()
					} label: {
						Label(store.options[index].text, systemImage: store.options[index].isSelected ? "square.inset.filled" : "square")
					}
				}
			}
			.listStyle(.plain)
			BigButton(title: "Submit", isEnabled: store.canSubmit, action: store.submit)
				.padding()
		}
	}
}

struct MultipleAnswerQuestion_Previews: PreviewProvider {
	static var previews: some View {
		MultipleAnswerQuestionTestView()
	}

	struct MultipleAnswerQuestionTestView: View {
		@State var selection: [String] = []

		var body: some View {
			VStack {
				MultipleAnswerQuestion(
					title: "1 of 2",
					question: "What's the best language?",
					store: .init(
						options: ["Java", "Swift", "English", "C++"],
						handler: { selection = $0 }
					)
				)

				Text("Selection: " + selection.joined(separator: ", "))
			}
		}
	}
}
