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
 * @author Josiane Bzerra
 */
class BaseCardView: UIView {

	override func drawRect(rect: CGRect) {
		super.drawRect(rect)

		_setRectOrigin()

		UIColors.CARD_SHAPE_BACKGROUND.setFill()
		UIColors.CARD_SHAPE_STROKE.setStroke()

		var path: UIBezierPath = UIBezierPath()

		_drawArrow(path)
		_drawRectangle(path, rect:rect)

		path.closePath()
		path.lineWidth = UIDimensions.CARD_STROKE
		path.fill()
		path.stroke()
	}

	private func _drawArc(
		path: UIBezierPath, center: CGPoint, startAngle: CGFloat,
		endAngle: CGFloat) {

		path.addArcWithCenter(
			center, radius:UIDimensions.CARD_RADIUS, startAngle:startAngle,
			endAngle:endAngle, clockwise:true)
	}

	private func _drawArrow(path: UIBezierPath) {
		if (leftArrow) {
			_drawArrowLeft(path)
		}
		else {
			_drawArrowTop(path)
		}
	}

	private func _drawArrowLeft(path: UIBezierPath) {
		var x: CGFloat = rectOrigin!.x
		var height: CGFloat = UIDimensions.CARD_ARROW_HEIGHT
		var width: CGFloat = UIDimensions.CARD_ARROW_WIDTH

		var arrow: UIBezierPath = UIBezierPath()

		var bottom: CGPoint = CGPoint(
			x:x,
			y:(UIDimensions.CARD_ARROW_LEFT_START_Y + height))

		var left: CGPoint = CGPoint(
			x:(x - width),
			y:(UIDimensions.CARD_ARROW_LEFT_START_Y + (height / 2)))

		var top: CGPoint = CGPoint(
			x:x,
			y:UIDimensions.CARD_ARROW_LEFT_START_Y)

		arrow.moveToPoint(bottom)
		arrow.addLineToPoint(left)
		arrow.addLineToPoint(top)

		path.appendPath(arrow)
	}

	private func _drawArrowTop(path: UIBezierPath) {
		var arrow: UIBezierPath = UIBezierPath()

		var y: CGFloat = rectOrigin!.y;
		var height: CGFloat = UIDimensions.CARD_ARROW_WIDTH
		var width: CGFloat = UIDimensions.CARD_ARROW_HEIGHT

		var left: CGPoint = CGPoint(
			x:UIDimensions.CARD_ARROW_TOP_START_X,
			y:y)

		var top: CGPoint = CGPoint(
			x:(UIDimensions.CARD_ARROW_TOP_START_X + (width / 2)),
			y:(y - height))

		var right: CGPoint = CGPoint(
			x:(UIDimensions.CARD_ARROW_TOP_START_X + width),
			y:y)

		arrow.moveToPoint(left)
		arrow.addLineToPoint(top)
		arrow.addLineToPoint(right)

		path.appendPath(arrow)
	}

	private func _drawRectangle(path: UIBezierPath, rect: CGRect) {
		var x: CGFloat = rectOrigin!.x
		var y: CGFloat = rectOrigin!.y
		var width = rect.width - UIDimensions.CARD_PADDING_HORIZONTAL
		var height = rect.height - UIDimensions.CARD_PADDING_VERTICAL
		var PI: CGFloat = CGFloat(M_PI)

		var left: CGFloat = (UIDimensions.CARD_RADIUS + x)
		var top: CGFloat = (UIDimensions.CARD_RADIUS + y)
		var right: CGFloat = (width - UIDimensions.CARD_RADIUS)
		var bottom: CGFloat = (height - UIDimensions.CARD_RADIUS)

		var topLeftArcCenter = CGPoint(x:left, y:top)
		var topRightArcCenter = CGPoint(x:right, y:top)
		var bottomRightArcCenter = CGPoint(x:right, y:bottom)
		var bottomLeftArcCenter = CGPoint(x:left, y:bottom)

		if (leftArrow) {
			_drawArc(
				path, center:topLeftArcCenter, startAngle:PI, endAngle:3*PI/2)
		}

		_drawArc(
			path, center:topRightArcCenter, startAngle:3*PI/2, endAngle:2*PI)

		_drawArc(
			path, center:bottomRightArcCenter, startAngle:2*PI, endAngle:PI/2)

		_drawArc(path, center:bottomLeftArcCenter, startAngle:PI/2, endAngle:PI)

		if (!leftArrow) {
			_drawArc(
				path, center:topLeftArcCenter, startAngle:PI, endAngle:3*PI/2)
		}
	}

	private func _setRectOrigin() {
		rectOrigin = CGPoint(
			x:UIDimensions.CARD_PADDING_HORIZONTAL,
			y:UIDimensions.CARD_PADDING_VERTICAL)

		if (leftArrow) {
			rectOrigin!.x = rectOrigin!.x + UIDimensions.CARD_ARROW_WIDTH
		}
		else {
			rectOrigin!.y = rectOrigin!.y + UIDimensions.CARD_ARROW_WIDTH
		}
	}

	var leftArrow: Bool = true
	var rectOrigin: CGPoint?

}