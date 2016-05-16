//
//  PageMaster.m
//  scrolly2
//
//  Created by spacehomunculus on 5/1/16.
//  Copyright © 2016 electricbaconstudios. All rights reserved.
//

#import "PageMaster.h"

typedef struct {
    NSInteger baseIndex;
    CGFloat baseDistance;
} PageMasterStruct;

@implementation PageMaster

- (NSInteger)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {

    PageMasterStruct valStruct = [self internalCalculateWithScrollViewOffset:scrollView.contentOffset edgeInsets:scrollView.contentInset];
    NSInteger targetIndex = valStruct.baseIndex;
    
    if (velocity.x > 0.1) {
        CGFloat nextSingularDistanceValue= [self valueForSize:[self.delegate sizeForItemAtIndex:valStruct.baseIndex]];
        CGFloat comboValue = valStruct.baseDistance + nextSingularDistanceValue;
        *targetContentOffset = [self pointForValue:comboValue];
        targetIndex++;
    }
    else if (velocity.x < -0.1) {
        CGFloat singleValue = valStruct.baseDistance;
        *targetContentOffset = [self pointForValue:singleValue];
    }
    else {
        CGFloat currentDistance = [self valueForPoint:scrollView.contentOffset];
        CGFloat nextSingularDistanceValue= [self valueForSize:[self.delegate sizeForItemAtIndex:valStruct.baseIndex]];
        CGFloat comboValueHalfDistance = valStruct.baseDistance + (nextSingularDistanceValue / 2.0);
        if (currentDistance >= comboValueHalfDistance) {
            CGFloat comboValue = valStruct.baseDistance + nextSingularDistanceValue;
            *targetContentOffset = [self pointForValue:comboValue];
            targetIndex++;
        }
        else {
            CGFloat singleValue = valStruct.baseDistance;
            *targetContentOffset = [self pointForValue:singleValue];
        }
    }
    
    return MIN([self.delegate numberOfItems] - 1, targetIndex);
}

- (PageMasterStruct)internalCalculateWithScrollViewOffset:(CGPoint)offset edgeInsets:(UIEdgeInsets)edgeInsets {
    PageMasterStruct valStruct = (PageMasterStruct) { .baseIndex = 0, .baseDistance = 0  };
    
    if (self.delegate) {
        NSInteger numItems = [self.delegate numberOfItems];
        CGFloat scrollViewOffsetVal = [self valueForPoint:offset];
        CGFloat currentValue = -1 * [self valueForEdgeInsets:edgeInsets];
        NSInteger index = 0;
        for (int i = 0; i < numItems - 1; i++) {
            CGFloat thermometerValue = currentValue + [self valueForSize:[self.delegate sizeForItemAtIndex:i]];
            if (thermometerValue > scrollViewOffsetVal) {
                break;
            }
            currentValue = thermometerValue;
            index = index + 1;
        }
        if (index < numItems) {
            valStruct.baseIndex = index;
            valStruct.baseDistance = currentValue;
            return valStruct;
        }
    }

    return valStruct;
}

- (CGFloat)valueForEdgeInsets:(UIEdgeInsets)edgeInsets {
    CGFloat val = 0;
    switch (self.orientation) {
        case Horizontal :
            val = edgeInsets.left;
            break;
        case Vertical :
            val = edgeInsets.top;
            break;
        default:
            break;
    };
    return val;
}

- (CGFloat)valueForPoint:(CGPoint)point {
    CGFloat val = 0;
    switch (self.orientation) {
        case Horizontal :
            val = point.x;
            break;
        case Vertical :
            val = point.y;
            break;
        default:
            break;
    };
    return val;
}

- (CGFloat)valueForSize:(CGSize)size {
    CGFloat val = 0;
    switch (self.orientation) {
        case Horizontal :
            val = size.width;
            break;
        case Vertical :
            val = size.height;
            break;
        default:
            break;
    };
    return val;
}

- (CGPoint)pointForValue:(CGFloat)value {
    switch (self.orientation) {
        case Horizontal :
            return CGPointMake(value, 0);
            break;
        case Vertical :
            return CGPointMake(0, value);
            break;
        default:
            break;
    };
    
    return CGPointZero;
}

@end
