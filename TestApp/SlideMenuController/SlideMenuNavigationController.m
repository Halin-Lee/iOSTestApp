//
//  SlideMenuRootViewController.m
//  Demo
//
//  Created by 17track on 2/26/16.
//  Copyright © 2016 17track. All rights reserved.
//

#import "SlideMenuNavigationController.h"
#import "MenuViewController.h"

@interface SlideMenuNavigationController()

/**左侧菜单controller*/
@property (weak, nonatomic) MenuViewController *menuViewController;

/**目前正在展示的viewController*/
@property (weak, nonatomic) UINavigationController *childNavigationController;

/**保存viewController的字典*/
@property (nonatomic,strong) NSMutableDictionary *viewControllerDictionary;

#pragma mark 手势

/**关闭菜单手势(菜单打开的时候点击mainView)*/
@property (strong,nonatomic) UITapGestureRecognizer *closeGestureRecognizer;

/**主view的左边侧滑手势*/
@property (strong, nonatomic) IBOutlet UIScreenEdgePanGestureRecognizer *mainViewEdgePanGestureRecognizer;

/**菜单栏打开后主view的拖动手势*/
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panGestureRecognizer;

#pragma mark 切换动画临时保存参数
/** 滑动手势识别器点击初始位置*/
@property (nonatomic,assign) CGPoint panGestureStartLocation;

/**侧滑时偏移量(其实也就是侧滑开始的时候菜单状态是打开还是关闭)*/
@property (nonatomic,assign) CGFloat panGestureStartOffset;

#pragma mark view位置

/**左侧菜单水平位置(左侧菜单右边距对齐底层view左侧位置)*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lcLeftSideViewLeadingSpace;
/**主View高度*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lcMainViewHeight;
/**主View水平位置*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lcMainViewCenterX;

@end

@implementation SlideMenuNavigationController


- (void)viewDidLoad{
    
    //初始化参数
    _viewControllerDictionary = [NSMutableDictionary dictionary];
    _closeGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMenuClick)];
    
    //匹配viewController
    [self findViewController];
    
}


/**根据子View寻找菜单ViewController和现在正在显示的Main ViewController*/
- (void)findViewController{
    for (UIViewController *viewController in self.childViewControllers) {
        if (viewController.view == _leftSideView.subviews.firstObject) {
            //匹配菜单栏,获得菜单栏controller
            _menuViewController = (MenuViewController *)viewController;
        }else if(viewController.view == _mainView.subviews.firstObject){
            _childNavigationController = (UINavigationController *)viewController;
            //将第一个view的id存入数组,避免两次重构这个view
            
            
            UIViewController *rootViewController = _childNavigationController.viewControllers.firstObject;
            //为当前正在显示的viewController添加menu按键
            _viewControllerDictionary[rootViewController.restorationIdentifier] = rootViewController;
            
            //添加Menu按键
            [self setMenuButton];
            
        }
    }
    
    
}


/**拖动触发*/
- (IBAction)panGestureRecognized:(id)sender {
    UIPanGestureRecognizer *gestureRecognizer = sender;
    UIGestureRecognizerState state = gestureRecognizer.state;
    
    CGPoint location = [gestureRecognizer locationInView:self.view];
    
    
    if (state == UIGestureRecognizerStateBegan) {
        //推动开始,记录下当前点击位置和当前menu偏移量,返回
        _panGestureStartLocation = location;
        if(sender == _panGestureRecognizer){
            _panGestureStartOffset = 1;
        }else{
            _panGestureStartOffset = 0;
        }
        return;
    }
    
    //计算当前偏移百分比
    CGFloat delta = location.x - _panGestureStartLocation.x;
    CGFloat percentage = delta/200 + _panGestureStartOffset;
    
    switch (state) {
            
        case UIGestureRecognizerStateChanged:{
            //拖动中,播放动画到当前位置
            [self updateMenuStateWithPercentage:percentage];
        }
            break;
            
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:{
            //推动结束,根据当前便宜百分比确定菜单状态
            if (percentage > 0.5) {
                [self showLeftSideMenuWithAnimated:YES];
            }else{
                [self hideLeftSideMenuWithAnimated:YES];
            }
            
        }   break;
    }
}

/**为UINavigationController添加Menu按键*/
- (void)setMenuButton{
    
    UIView *view = [self customViewForLeftBarButtonItem];
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuButtonClick)];
    [view addGestureRecognizer:gestureRecognizer];
    view.userInteractionEnabled = YES;
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:view];
    _childNavigationController.topViewController.navigationItem.leftBarButtonItem = leftBarButton;
}

/**获得左侧菜单按键*/
- (UIView *)customViewForLeftBarButtonItem{
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Menu";
    label.frame = CGRectMake(0, 0, 100, 100);
    return label;
}

/**Navigation的菜单点击事件*/
- (void)menuButtonClick{
    [self showLeftSideMenuWithAnimated:YES];
}

/**菜单打开时Main的点击事件*/
- (void)hideMenuClick{
    [self hideLeftSideMenuWithAnimated:YES];
}

/**显示菜单*/
- (void)showLeftSideMenuWithAnimated:(BOOL)animated{
    
    if (animated) {
        //播放动画
        [UIView animateWithDuration:0.3
                              delay:0
             usingSpringWithDamping:0.5
              initialSpringVelocity:0.1
                            options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             [self updateMenuStateWithPercentage:1];
                         } completion:^(BOOL finished) {
                             if (finished) {
                                 //动画播放成功,修改监听手势
                                 [self setGestureRecognizerToState:YES];
                             }
                         }];
    }else{
        //不播放动画,直接将view状态更新到隐藏状态
        [self updateMenuStateWithPercentage:1];
        [self setGestureRecognizerToState:YES];
        
    }
}

/**根据百分比刷新UI*/
- (void)updateMenuStateWithPercentage:(CGFloat)percentage{
    
    //限制百分比在0-1之间
    if(percentage > 1){
        percentage = 1;
    }else if(percentage < 0){
        percentage = 0;
    }
    
    //计算最大偏移量(菜单栏最多偏移一个菜单栏宽度)
    CGFloat maxXTransit = _leftSideView.frame.size.width;
    CGFloat maxHeightTransit = -self.view.frame.size.height * 0.2;
    
    //获得当前偏移量
    CGFloat xTransit = maxXTransit * percentage;
    CGFloat heightTransit = maxHeightTransit * percentage;
    
    //设置值
    _lcLeftSideViewLeadingSpace.constant = xTransit;
    _lcMainViewHeight.constant = heightTransit;
    _lcMainViewCenterX.constant = xTransit;
    
    //刷新UI
    [self.view layoutIfNeeded];
}



/**隐藏菜单*/
- (void)hideLeftSideMenuWithAnimated:(BOOL)animated{
    
    if(animated){
        
        //播放动画
        [UIView animateWithDuration:0.3
                              delay:0
             usingSpringWithDamping:0.5
              initialSpringVelocity:0.1
                            options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionBeginFromCurrentState animations:^{
                                [self updateMenuStateWithPercentage:0];
                            } completion:^(BOOL finished) {
                                if (finished) {
                                    //播放动画成功,更新手势监听
                                    [self setGestureRecognizerToState:NO];
                                }
                            }];
    }else{
        //不播动画,直接将菜单切换到该百分比,修改监听手势
        [self updateMenuStateWithPercentage:0];
        [self setGestureRecognizerToState:NO];
    }
}

/**根据状态设置手势监听
 @param:state 手势状态,YES为打开,NO为关闭
 
 */
- (void)setGestureRecognizerToState:(BOOL)state{
    
    if (state) {
        //设置菜单打开时的手势监听
        [_mainView addGestureRecognizer:_closeGestureRecognizer];
        [_mainView addGestureRecognizer:_panGestureRecognizer];
        [_childNavigationController.view removeGestureRecognizer:_mainViewEdgePanGestureRecognizer];
        _mainView.subviews.firstObject.userInteractionEnabled = NO;
    }else{
        //设置菜单关闭时的手势监听
        [_mainView removeGestureRecognizer:_closeGestureRecognizer];
        [_mainView removeGestureRecognizer:_panGestureRecognizer];
        [_mainView.subviews.firstObject addGestureRecognizer:_mainViewEdgePanGestureRecognizer];
        _mainView.subviews.firstObject.userInteractionEnabled = YES;
        
    }
    
    
}

/**跳转到viewController*/
- (void)selectViewControllerWithIdentifier:(NSString *)identifier animated:(BOOL)animated{
    
    UIViewController *viewController = [self viewControllerWithIdentifier:identifier];
    BOOL needToChangeViewController = viewController != _childNavigationController;
    
    if (!needToChangeViewController) {
        //不需要更换viewController,直接调用隐藏,返回
        [self hideLeftSideMenuWithAnimated:animated];
        return;
    }else if(!animated && needToChangeViewController){
        //需要换viewController,但不需要动画
        [self updateCurrentViewControllerToViewController:viewController];
        [self hideLeftSideMenuWithAnimated:animated];
    }else{
        
        //需要播放动画,又需要换viewController,需要先弹出mainView在更换回来
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionBeginFromCurrentState animations:^{
            //播放隐藏mainView动画
            _lcMainViewHeight.constant = - _mainView.frame.size.height * 0.4;
            _lcMainViewCenterX.constant = _mainView.frame.size.width;
            [self.view layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            //修改ViewController,弹出
            [self updateCurrentViewControllerToViewController:viewController];
            [self hideLeftSideMenuWithAnimated:animated];
        }];
    }
}

/**将ViewController设置为当前的ViewController*/
- (void)updateCurrentViewControllerToViewController:(UIViewController *)viewController{
    [_childNavigationController setViewControllers:@[viewController]];

    [self setMenuButton];
}


/**根据identifier找到ViewController*/
- (UIViewController *)viewControllerWithIdentifier:(NSString *)identifier{
    UIViewController *controller = _viewControllerDictionary[identifier];
    if (!controller) {
        controller = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
        _viewControllerDictionary[identifier] = controller;
    }
    return controller;
}




@end
