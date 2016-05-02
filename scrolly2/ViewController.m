//
//  ViewController.m
//  scrolly2
//
//  Created by spacehomunculus on 5/1/16.
//  Copyright © 2016 electricbaconstudios. All rights reserved.
//

#import "ViewController.h"
#import "PageMaster.h"

@interface ViewController () <UIScrollViewDelegate>
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (assign) NSInteger numViews;
@property (assign) NSInteger size;
@property (nonatomic, strong) PageMaster *pageMaster;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.pageMaster = [[PageMaster alloc] init];
    self.pageMaster.orientation = Horizontal;
    self.pageMaster.delegate = self;
    
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

    [self.pageMaster scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];

}



#pragma mark - PageMasterDelegate
- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(self.size, 0);
}

- (NSInteger)numberOfItems {
    return 20;
}

@end
