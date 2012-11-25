//
//  DeveloperInfo.h
//  GreedFamily
//
//  Created by 赵 苹果 on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeveloperInfo : UIViewController<UIScrollViewDelegate>
{    
    IBOutlet UIScrollView *scrollView;
}
@property (retain, nonatomic) IBOutlet UIButton *goBack;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@end
