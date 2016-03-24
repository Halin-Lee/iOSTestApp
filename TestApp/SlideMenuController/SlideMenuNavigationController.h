//
//  SlideMenuNavigationController.h
//  TestApp
//
//  Created by Halin on 3/17/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideMenuNavigationController : UIViewController
/**左侧菜单view*/
@property (weak, nonatomic) IBOutlet UIView *leftSideView;
/**中间显示部分*/
@property (weak, nonatomic) IBOutlet UIView *mainView;


/**目前正在展示的viewController*/
@property (weak, nonatomic ,readonly) UINavigationController *childNavigationController;

/**选中菜单某项*/
- (void)selectViewControllerWithIdentifier:(NSString *)identifier animated:(BOOL)animated;

#pragma mark - 自定义右侧菜单
/**覆盖该方法,实现自定义的左侧菜单按键*/
- (UIView *)customViewForLeftBarButtonItem;
@end
