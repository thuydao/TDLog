//
//  UIView+TDDragg.h
//  TDFloatIcon
//
//  Created by sa vincent on 3/23/16.
//  Copyright © 2016 sa vincent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TDDragg)

/** The pan gestures that handles the view dragging
 *
 * @param panGesture The tint color of the blurred view. Set to nil to reset.
 */
@property (nonatomic) UIPanGestureRecognizer *panGesture;

/**
 A caging area such that the view can not be moved outside
 of this frame.
 
 If @c cagingArea is not @c CGRectZero, and @c cagingArea does not contain the
 view's frame then this does nothing (ie. if the bounds of the view extend the
 bounds of @c cagingArea).
 
 Optional. If not set, defaults to @c CGRectZero, which will result
 in no caging behavior.
 */
@property (nonatomic) CGRect cagingArea;

/**
 Restricts the area of the view where the drag action starts.
 
 Optional. If not set, defaults to self.view.
 */
@property (nonatomic) CGRect handle;

/**
 Restricts the movement along the X axis
 */
@property (nonatomic) BOOL shouldMoveAlongX;

/**
 Restricts the movement along the Y axis
 */
@property (nonatomic) BOOL shouldMoveAlongY;

/**
 Notifies when dragging started
 */
@property (nonatomic, copy) void (^draggingStartedBlock)();

/**
 Notifies when dragging has moved
 */
@property (nonatomic, copy) void (^draggingMovedBlock)();

/**
 Notifies when dragging ended
 */
@property (nonatomic, copy) void (^draggingEndedBlock)();

/** Enables the dragging
 *
 * Enables the dragging state of the view
 */
- (void)enableDragging;

/** Disable or enable the view dragging
 *
 * @param draggable The boolean that enables or disables the draggable state
 */
- (void)setDraggable:(BOOL)draggable;

@end
