//
//  EScrollerView.m
//  icoiniPad
//
//  Created by Ethan on 12-11-24.
//
//

#import "EScrollerView.h"
#import "UIImageView+WebCache.h"
@implementation EScrollerView
@synthesize delegate;


-(id)initWithFrameRect:(CGRect)rect ImageArray:(NSArray *)imgArr
{
   
	if ((self=[super initWithFrame:rect])) {
        self.userInteractionEnabled=YES;
        viewSize = rect;
		imageArray=[NSArray arrayWithArray:imgArr];
		
        NSUInteger pageCount=[imageArray count];
        imageScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, viewSize.size.width, viewSize.size.height)];
        imageScrollView.pagingEnabled = YES;
        imageScrollView.showsHorizontalScrollIndicator = NO;
        imageScrollView.showsVerticalScrollIndicator = NO;
        imageScrollView.bounces = NO;
        imageScrollView.delegate = self;
        imageScrollView.contentSize = CGSizeMake(viewSize.size.width * pageCount, viewSize.size.height);
        
        
        imageScrollView.contentOffset = CGPointMake(viewSize.size.width, 0);
        
        if(imgArr.count <2)
        {
            imageScrollView.contentSize = CGSizeMake(viewSize.size.width, viewSize.size.height);
            
        }else
        {
            imageScrollView.contentSize = CGSizeMake(viewSize.size.width*(imgArr.count+2), viewSize.size.height);
        }
        //首页展示
//        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageArray[(imgArr.count-1)]]];
        UIImageView *imageView = [[UIImageView alloc]init];
        [imageView sd_setImageWithURL:imageArray[(imgArr.count-1)] placeholderImage:[UIImage imageNamed:@"ic_topbg"]];
        imageView.frame = CGRectMake(0, 0, viewSize.size.width, viewSize.size.height);
       
        imageView.tag=imgArr.count-1;
        UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed:)];
        imageView.userInteractionEnabled=YES;
        [imageView addGestureRecognizer:Tap];
        
        
        [imageScrollView addSubview:imageView];

        
        //全部放进去
        for (int i=0; i<imageArray.count; i++) {
//            UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageArray[i]]];
            UIImageView *imageView = [[UIImageView alloc]init];
            [imageView sd_setImageWithURL:imageArray[i] placeholderImage:[UIImage imageNamed:@"ic_topbg"]];
            imageView.frame = CGRectMake(viewSize.size.width*(i+1), 0, viewSize.size.width, rect.size.height);
            imageView.tag=i;
            UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed:)];
            imageView.userInteractionEnabled=YES;
            [imageView addGestureRecognizer:Tap];
            [imageScrollView addSubview:imageView];
        }
        
        //尾页
        
        imageView = [[UIImageView alloc]init];
        [imageView sd_setImageWithURL:imageArray[0] placeholderImage:[UIImage imageNamed:@"ic_topbg"]];
//        imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageArray[0]]];
        imageView.frame = CGRectMake(viewSize.size.width*(imageArray.count+1), 0, viewSize.size.width, viewSize.size.height);
        imageView.tag=0;
        Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed:)];
        imageView.userInteractionEnabled=YES;
        [imageView addGestureRecognizer:Tap];
        [imageScrollView addSubview:imageView];
        [self addSubview:imageScrollView];

        
//        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed:)];
//        [imageScrollView addGestureRecognizer:tapGestureRecognizer];
      
//        pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake((320-pageControlWidth)/2,viewSize.size.height-20, pageControlWidth, pagecontrolHeight)];
        
        pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(125, 100, 70, 25)];
        pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.7 alpha:0.6];
        pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        pageControl.numberOfPages = imageArray.count;
        pageControl.currentPage = 0;
        
        [pageControl addTarget:self action:@selector(pageAction) forControlEvents:UIControlEventTouchUpInside];
        if(pageCount ==1)
        {
            pageControl.hidden = YES;
        }
        [self addSubview:pageControl];
        
	}
	return self;
}







- (void)scrollViewDidScroll:(UIScrollView *)sender
{

   CGFloat pagewidth = imageScrollView.frame.size.width;
    int page = floor((imageScrollView.contentOffset.x - pagewidth/([imageArray count]+2))/pagewidth)+1;
    page --;  // 默认从第二页开始
    pageControl.currentPage = page;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView

{

    
    CGFloat pagewidth = imageScrollView.frame.size.width;
     int currentPage = floor((imageScrollView.contentOffset.x - pagewidth/ ([imageArray count]+2)) / pagewidth) + 1;
    selectPage = currentPage;
    
    if (currentPage==0)
    {
        [scrollView scrollRectToVisible:CGRectMake(320 * [imageArray count],0,viewSize.size.width,viewSize.size.height) animated:NO]; // 序号0 最后1页
    }
    else if (currentPage==([imageArray count]+1))
    {
        [scrollView scrollRectToVisible:CGRectMake(viewSize.size.width,0,viewSize.size.width,viewSize.size.height) animated:NO]; // 最后+1,循环第1页
    }
}
-(void)pageAction
{
    //    int page = pageControl.currentPage; // 获取当前的page
    //    [_scrollView scrollRectToVisible:CGRectMake(320*(page+1),0,320,128) animated:NO];
    int page = pageControl.currentPage; // 获取当前的page
    [imageScrollView scrollRectToVisible:CGRectMake(viewSize.size.width*(page+1),0,viewSize.size.width,viewSize.size.height) animated:NO];
}

- (void)imagePressed:(UITapGestureRecognizer *)sender
{
    if ([delegate respondsToSelector:@selector(EScrollerViewDidClicked:)]) {
        [delegate EScrollerViewDidClicked:sender.view.tag];
    }
}
@end
