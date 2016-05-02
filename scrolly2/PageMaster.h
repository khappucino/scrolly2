//
//  PageMaster.h
//  scrolly2
//
//  Created by spacehomunculus on 5/1/16.
//  Copyright © 2016 electricbaconstudios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, PageMasterOrientation)
{
    Horizontal = 0,
    Vertical
};

@protocol PageMasterDelegate <NSObject>
- (CGSize)sizeForItemAtIndex:(NSInteger)index;
- (NSInteger)numberOfItems;
@end

@interface PageMaster : NSObject
@property (nonatomic, weak) id<PageMasterDelegate> delegate;
@property (nonatomic, assign) enum PageMasterOrientation orientation;
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;
@end
