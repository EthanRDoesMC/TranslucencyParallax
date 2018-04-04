#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, UIBackgroundStyle) {
    UIBackgroundStyleDefault,
    UIBackgroundStyleTransparent,
    UIBackgroundStyleLightBlur,
    UIBackgroundStyleDarkBlur,
    UIBackgroundStyleDarkTranslucent,
    UIBackgroundStyleExtraDarkBlur,
    UIBackgroundStyleBlur
};


@interface UIApplication (UIBackground)
-(void)_setBackgroundStyle:(UIBackgroundStyle)style;
@end


%group ParallaxMain

static UIWindow *TPLXwindow = nil;
//TPLXwindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
%hook UIViewController


- (void)viewDidLoad {
    %orig;
    //[[UIApplication sharedApplication] _setBackgroundStyle:3];
    [[UIApplication sharedApplication] _setBackgroundStyle:UIBackgroundStyleTransparent];
}
-(void)viewDidLayoutSubviews {
    if (!TPLXwindow) {
        TPLXwindow = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        TPLXwindow.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        TPLXwindow.hidden = NO;
        TPLXwindow.windowLevel = UIWindowLevelNormal - 1;

        
        
        UIBlurEffect *TPLXblurEffect;
        TPLXblurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
        
        
        UIVisualEffectView *TPLXvisualEffectView;
        TPLXvisualEffectView = [[UIVisualEffectView alloc]initWithEffect:TPLXblurEffect];

        TPLXvisualEffectView.frame = TPLXwindow.bounds;
        TPLXvisualEffectView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        TPLXvisualEffectView.opaque = 0;
        [TPLXwindow addSubview:TPLXvisualEffectView];
        
        %orig;
        [[UIApplication sharedApplication] _setBackgroundStyle:UIBackgroundStyleTransparent];
        self.view.backgroundColor = [UIColor clearColor];
    }
}
%end

%hook UIApplication
-(void)_setBackgroundStyle:(UIBackgroundStyle)backgroundStyle {
//-(void)_setBackgroundStyle:(long long)style {
    %orig(UIBackgroundStyleTransparent);
    //%orig(3);
}
%end
%hook UIView
-(void)setBackgroundColor:(UIColor *)color {
    %orig([UIColor clearColor]);
    //[[UIApplication sharedApplication] _setBackgroundStyle:3];
    [[UIApplication sharedApplication] _setBackgroundStyle:UIBackgroundStyleTransparent];
}
%end

//%hook AppDelegate
//
//- (void) applicationDidBecomeActive:(UIApplication *) application
//{
//    static dispatch_once_t once;
//    dispatch_once(&once, ^{
//
//        //NSDictionary *applications = [[ALApplicationList sharedApplicationList] applicationsFilteredUsingPredicate:[NSPredicate predicateWithFormat:@"isSystemApplication = TRUE"]];
//
//        //NSString *identifier = [NSBundle mainBundle].bundleIdentifier;
//
//        //if (![applications containsObject:identifier])
//        //{
//
//
//
//        TPLXwindow.backgroundColor = [UIColor clearColor];
//        TPLXwindow.windowLevel = UIWindowLevelNormal - 1.0;
//
//            UIVisualEffect *TPLXblurEffect;
//            TPLXblurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//
//            UIVisualEffectView *TPLXvisualEffectView;
//            TPLXvisualEffectView = [[UIVisualEffectView alloc] initWithEffect:TPLXblurEffect];
//
//            TPLXvisualEffectView.frame = TPLXwindow.bounds;
//            [TPLXwindow addSubview:TPLXvisualEffectView];
//        [TPLXwindow setHidden:NO];
//
//        //}
//
//
//
//    });
//
//    %orig;
//}
//
//%end


%end

%ctor {
    
    NSString *identifier = [NSBundle mainBundle].bundleIdentifier;
    NSString *sbBundle = @"com.apple.springboard";
    NSString *plistPath = @"/User/Library/Preferences/tk.ethanrdoesmc.parallaxpreferences.plist";
    NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    if ([[plistDict objectForKey:identifier] boolValue]) {
    if (![identifier isEqualToString:sbBundle]) {
        %init(ParallaxMain);
    }
    }
    
}

