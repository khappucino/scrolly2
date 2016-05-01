//
//  ViewController.m
//  scrolly2
//
//  Created by spacehomunculus on 5/1/16.
//  Copyright © 2016 electricbaconstudios. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (assign) NSInteger numViews;
@property (assign) NSInteger size;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view;
    self.numViews = 20;
    self.size = 100;
    for (int i = 0; i < self.numViews; i++) {
        view = [[UIView alloc] initWithFrame:CGRectMake(i * self.size, 0, self.size, CGRectGetWidth(self.scrollView.frame))];
        if (i % 2 == 0) {
            view.backgroundColor = [UIColor redColor];
        } else {
            view.backgroundColor = [UIColor yellowColor];
        }
        [self.scrollView addSubview:view];
    }

    [self.scrollView setContentSize:CGSizeMake(self.numViews * self.size, CGRectGetHeight(self.scrollView.frame))];

    self.scrollView.delegate = self;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    CGFloat slack = (NSInteger)scrollView.contentOffset.x % self.size; // remainder
    CGFloat halfSize = (CGFloat)self.size/2.0;
    NSInteger index = scrollView.contentOffset.x / self.size;
    if (velocity.x > 0.1) {
        *targetContentOffset = CGPointMake((index + 1) * self.size, 0);
    } else if (velocity.x < -0.1) {
        *targetContentOffset = CGPointMake((index)* self.size, 0);
    } else {
        // if we are dragging snap based on what is most on the screen
        if (slack >= halfSize) {
            index = scrollView.contentOffset.x / self.size + 1;
        }
        *targetContentOffset = CGPointMake(index * self.size, 0);
    }
    
   
}


@end
