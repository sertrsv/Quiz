//
//  HeaderView.swift
//  Quiz
//
//  Created by Sergey Tarasov on 03.10.2022.
//

import SwiftUI

struct HeaderView: View {
	let title: String
	let subtitle: String

	var body: some View {
		VStack(alignment: .leading, spacing: 16) {
			Text(title)
				.font(.headline)
			Text(subtitle)
				.font(.title)
		}
		.padding()
	}
}

struct QuestionHeader_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Title", subtitle: "Question")
			.previewLayout(.sizeThatFits)
    }
}
