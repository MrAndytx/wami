//
//  EScrollerView.h
//  icoiniPad
//
//  Created by Ethan on 12-11-24.
//
//

#import <UIKit/UIKit.h>

@protocol EScrollerViewDelegate <NSObject>
@optional
-(void)EScrollerViewDidClicked:(NSUInteger)index;
@end

@interface EScrollerView : UIView<UIScrollViewDelegate> {
	CGRect viewSize;
	UIScrollView *imageScrollView;
	NSArray *imageArray;
    UIPageControl *pageControl;
    id<EScrollerViewDelegate> delegate;
    int selectPage;
    
}
@property(nonatomic,retain)id<EScrollerViewDelegate> delegate;
- (id)initWithFrameRect:(CGRect)rect ImageArray:(NSArray *)imgArr ;
@end
