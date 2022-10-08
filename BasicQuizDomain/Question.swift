//
//  Question.swift
//  Quiz
//
//  Created by Sergey Tarasov on 26.09.2022.
//

public enum Question<T: Hashable>: Hashable {
	case singleAnswer(T)
	case multipleAnswer(T)
}
