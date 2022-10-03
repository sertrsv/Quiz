//
//  QuestionHeader.swift
//  Quiz
//
//  Created by Sergey Tarasov on 03.10.2022.
//

import SwiftUI

struct QuestionHeader: View {
	let title: String
	let question: String

	var body: some View {
		VStack(alignment: .leading, spacing: 16) {
			Text(title)
				.font(.headline)
			Text(question)
				.font(.title)
		}
		.padding()
	}
}

struct QuestionHeader_Previews: PreviewProvider {
    static var previews: some View {
        QuestionHeader(title: "Title", question: "Question")
			.previewLayout(.sizeThatFits)
    }
}
