#import <UIKit/UIKit.h>

%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application {
    %orig;
    
    // 延迟显示弹窗，确保界面加载完毕
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self showVisionProStyleAlert];
    });
}

- (void)showVisionProStyleAlert {
    // 创建根视图控制器
    UIViewController *viewController = [[UIViewController alloc] init];

    // 弹窗的背景视图
    UIView *popupView = [[UIView alloc] initWithFrame:CGRectMake(50, 200, self.view.frame.size.width - 100, 200)];
    popupView.backgroundColor = [UIColor clearColor]; // 透明背景

    // 创建毛玻璃效果视图
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = popupView.bounds;
    blurEffectView.layer.cornerRadius = 20;  // 设置圆角
    blurEffectView.layer.masksToBounds = YES; // 确保圆角生效

    // 添加毛玻璃效果视图到弹窗
    [popupView addSubview:blurEffectView];

    // 添加标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, popupView.frame.size.width, 40)];
    titleLabel.text = @"Vision Pro 风格弹窗";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:24 weight:UIFontWeightBold];
    [popupView addSubview:titleLabel];

    // 添加内容信息
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, popupView.frame.size.width, 40)];
    messageLabel.text = @"这是一个示例弹窗，具有毛玻璃效果。";
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont systemFontOfSize:16];
    messageLabel.textColor = [UIColor darkGrayColor];
    [popupView addSubview:messageLabel];

    // 添加确定按钮
    UIButton *okButton = [UIButton buttonWithType:UIButtonTypeSystem];
    okButton.frame = CGRectMake(0, 140, popupView.frame.size.width, 40);
    [okButton setTitle:@"确定" forState:UIControlStateNormal];
    [okButton addTarget:self action:@selector(dismissPopup) forControlEvents:UIControlEventTouchUpInside];
    [popupView addSubview:okButton];

    // 将弹窗添加到根视图控制器的视图中
    [viewController.view addSubview:popupView];

    // 显示弹窗
    [self.window.rootViewController presentViewController:viewController animated:YES completion:nil];
}

// 关闭弹窗
- (void)dismissPopup {
    [self.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

%end
