#import <UIKit/UIKit.h>
#import <UIKit/UIApplication+Private.h>

/*NSMutableDictionary *settingsCompass = [NSMutableDictionary dictionaryWithContentsOfFile:
                                    [NSString stringWithFormat:@"%@/Library/Preferences/%@", NSHomeDirectory(), @"tk.ethanrdoesmc.translucencyprefs.plist"]];
    NSNumber* compassActive = [settingsCompass objectForKey:@"compassActive"];
//all that for ONE KEY*/

@interface FBSystemService : NSObject
+(id)sharedInstance;
-(void)exitAndRelaunch:(bool)arg1;
-(void)exitAndRelaunch:(BOOL)arg1 withOptions:(unsigned long long)arg2;
-(void)prepareForExitAndRelaunch:(BOOL)arg1;
-(void)_performExitTasksForRelaunch:(BOOL)arg1;
-(void)shutdownAndReboot:(BOOL)arg1;
-(void)exitAndRelaunch:(BOOL)arg1 withOptions:(unsigned long long)arg2;
@end

@interface _UIBackgroundHitTestWindow : UIWindow
+(BOOL)_isSystemWindow;
@end


@interface UIApplication (Private)
- (void)_setBackgroundStyle:(long long)style;
-(void)_fixupBackgroundHitTestWindow;
@end

//@interface UIWindow (Private)
//+(BOOL)_isSystemWindow;
//@end
//@interface UIWindow : UIView
//-(void)sendSubviewToBack;
//-(void)addSubview;
//@end
NSString* hasSetBGStyle;
NSString* isAppleApp;

//good ol' setBackgroundStyle

NSString *bundleID = [[NSBundle mainBundle] bundleIdentifier];
NSString *yes = @"YES";
NSString *no = @"NO";



%hook UIView

UIWindow* window = [UIApplication sharedApplication].keyWindow;


-(NSString*)isAppleApp {
    NSString* returnVal;
    if ([bundleID hasPrefix:@"com.apple.springboard"])
    {
        returnVal = yes;
    }
    else {
        returnVal = no;
    }
    return returnVal;
}

- (void)viewDidAppear {
    %orig;
    
    
    /*if ([compassActive boolValue] == YES && [bundleID isEqualToString:@"com.apple.Compass"])
			{*/
        [[UIApplication sharedApplication] _setBackgroundStyle:3];
    

    if (!window) {
        window = [[UIApplication sharedApplication].windows lastObject];
    }
   /* _UIBackgroundHitTestWindow* bgHit = [[alloc] init];
    bgHit.frame = [[UIScreen mainScreen] bounds];
    bgHit.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [window addSubview:bgHit];
    [window sendSubviewToBack:bgHit];
    [[UIApplication sharedApplication] _fixupBackgroundHitTestWindow];*/
//[[UIApplication] _setBackgroundStyle:3];
        [UIView animateWithDuration:0.3
                              delay:0.6
                            options:0
                         animations:^{
                             self.alpha = 0.65;
                             //self.superview.backgroundColor = [UIColor clearColor];
                             //self.tint = [UIColor clearColor];
                             //self.opaque = 0;
                             }
                         completion:nil];
    if (isAppleApp == no && hasSetBGStyle != yes) {

        UIVisualEffectView *blurBG;
        blurBG = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        blurBG.frame = [[UIScreen mainScreen] bounds];
        blurBG.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [window addSubview:blurBG];
        [window sendSubviewToBack:blurBG];
        hasSetBGStyle = yes;
    }
   // }
}
/*- (void)setTintColor:(UIColor *)color {
    if (![self isKindOfClass:[UIVisualEffectView class]]) {
    %orig([UIColor clearColor]);
    } else { %orig; }
   [[UIApplication sharedApplication] _setBackgroundStyle:3];
    if (isAppleApp == no && hasSetBGStyle != yes) {
        
        UIVisualEffectView *blurBG;
        blurBG = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        blurBG.frame = [[UIScreen mainScreen] bounds];
        blurBG.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:blurBG];
        [self sendSubviewToBack:blurBG];
        hasSetBGStyle = yes;
    }
}*/

-(void)setBackgroundColor:(UIColor *)color {
    if (!window) {
        window = [[UIApplication sharedApplication].windows lastObject];
    }
    if (![self isKindOfClass:[UIVisualEffectView class]] || ![self isKindOfClass:[UIBlurEffect class]]) {
    %orig([UIColor clearColor]);
        }
        else { %orig; }
    [[UIApplication sharedApplication] _setBackgroundStyle:3];
    if (isAppleApp == no && hasSetBGStyle != yes) {
        
        UIVisualEffectView *blurBG;
        blurBG = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        blurBG.frame = [[UIScreen mainScreen] bounds];
        blurBG.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [window addSubview:blurBG];
        [window sendSubviewToBack:blurBG];
        hasSetBGStyle = yes;
    }
}
%end
//%hook UIScrollView
//-(void)viewDidAppear {
    
//}
/*
%hook UIView
- (void) _didScroll {
    %orig;
    if ([allui boolValue] == YES)
			{
        [[UIApplication sharedApplication] _setBackgroundStyle:3];
        [UIView animateWithDuration:0.3
                              delay:0.6
                            options:0
                         animations:^{
                             self.alpha = 0.65;
                             self.superview.backgroundColor = [UIColor clearColor];
                             }
                         completion:nil];
    }
}
%end	
 
%hook _UIWebViewScrollView
- (void)setBackgroundColor:(UIColor *)color {
    for (UIWebBrowserView *view in self.subviews) {
        if ([view isKindOfClass:%c(UIWebBrowserView)]) {
			if ([active boolValue] == YES)
			{
            %orig([UIColor clearColor]);
            return;
        }
		}
		}
    %orig;
}
%end

%hook UIScrollView
- (void)setBackgroundColor:(UIColor *)color {
    for (UIView *view in self.subviews) {
        if ([allui boolValue] == YES)
			{
            %orig([UIColor clearColor]);
            return;
        }
		}
    %orig;
}
%end
*/
static void respring(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    [[%c(FBSystemService) sharedInstance] exitAndRelaunch:YES];
}

%ctor {
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                    NULL,
                                    (CFNotificationCallback)respring,
                                    CFSTR("respringDevice"),
                                    NULL,
                                    CFNotificationSuspensionBehaviorDeliverImmediately);
    
}

