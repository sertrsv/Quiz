//
//  BigButton.swift
//  Quiz
//
//  Created by Sergey Tarasov on 03.10.2022.
//

import SwiftUI

struct BigButton: View {
	let title: String
	let isEnabled: Bool
	let action: () -> Void

	init(title: String, isEnabled: Bool = true, action: @escaping () -> Void) {
		self.title = title
		self.isEnabled = isEnabled
		self.action = action
	}

	var body: some View {
		Button {
			action()
		} label: {
			Text(title)
				.font(.headline)
				.foregroundColor(.white)
				.padding()
				.frame(maxWidth: .infinity)
				.background(Color.accentColor)
				.cornerRadius(10)
		}
		.disabled(!isEnabled)
		.padding()
	}
}

struct BigButton_Previews: PreviewProvider {
    static var previews: some View {
		VStack {
			BigButton(title: "Enabled", isEnabled: true, action: {})
			BigButton(title: "Disabled", isEnabled: false, action: {})
		}
		.previewLayout(.sizeThatFits)
    }
}
