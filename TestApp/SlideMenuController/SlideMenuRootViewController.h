//
//  SlideMenuRootViewController.h
//  Demo
//
//  Created by Halin on 2/26/16.
//  Copyright © 2016 Halin. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 带左侧菜单的ViewController模型
 实现方式,
 1.将主Controller定义成 SlideMenuRootViewController 或其子类
 2.继承MenuViewController
 3.将左侧菜单Controller定义成MenuViewController的子类
 4.当menu有菜单项点击时,调用selectViewControllerWithIdentifier更换菜单
 5.默认实现一个Menu的菜单,如需自定义,继承customViewForLeftBarButtonItem方法
 6.通过在stroyBoard中定义storeBoard ID实现页面切换,默认的ViewController storeBoard ID必须和Restore ID必须相同,否则会导致默认ViewController存在两个实例
 
 */
@interface SlideMenuRootViewController : UIViewController

/**左侧菜单view*/
@property (weak, nonatomic) IBOutlet UIView *leftSideView;
/**中间显示部分*/
@property (weak, nonatomic) IBOutlet UIView *mainView;


/**目前正在展示的viewController*/
@property (weak, nonatomic ,readonly) UIViewController *currentViewController;

/**选中菜单某项*/
- (void)selectViewControllerWithIdentifier:(NSString *)identifier animated:(BOOL)animated;

#pragma mark - 自定义右侧菜单
/**覆盖该方法,实现自定义的左侧菜单按键*/
- (UIView *)customViewForLeftBarButtonItem;


@end
