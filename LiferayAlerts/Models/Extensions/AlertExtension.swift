/**
 * Copyright (c) 2000-2014 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */

/**
 * @author Silvio Santos
 * @author Josiane Bezerra
 */
extension Alert {

	func getMessage() -> String? {
		return payload["message"] as String?
	}

	func getPollsQuestion() -> PollsQuestion {
		var json: [String: AnyObject] =
			payload["pollsQuestion"] as [String: AnyObject]

		return PollsQuestion(jsonObj:json)
	}

	func getType() -> AlertType? {
		return AlertType(rawValue: (payload["type"] as String)) as AlertType?
	}

	func getURL() -> String? {
		return payload["url"] as String?
	}

	func hasMessage() -> Bool {
		var message: String? = getMessage()

		if ((message == nil) || message!.isEmpty) {
			return false
		}

		return true
	}

	func setPollsVote(choiceId: Int) {
		var pollsQuestion: PollsQuestion = getPollsQuestion()
		pollsQuestion.setVote(choiceId)

		var payloadJsonObj: [String: AnyObject] = payload as [String: AnyObject]
		var pollsJsonObj: AnyObject = pollsQuestion.toJsonObject() as AnyObject

		payloadJsonObj["pollsQuestion"] = pollsJsonObj

		payload = payloadJsonObj
	}

}