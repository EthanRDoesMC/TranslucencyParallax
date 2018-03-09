#import <UIKit/UIKit.h>
#import <UIKit/UIApplication+Private.h>


//@interface UIApplication (Private)
//- (void)_setBackgroundStyle:(long long)style;
//@end


%hook UIViewController


- (void)viewDidAppear {
    %orig;
 //[[UIApplication sharedApplication] _setBackgroundStyle:3];
 [[UIApplication sharedApplication] _setBackgroundStyle:UIBackgroundStyleLightBlur];
}
%end

%hook UIApplication
-(void)_setBackgroundStyle:(UIBackgroundStyle)backgroundStyle {
    %orig(UIBackgroundStyleLightBlur);
}
%end
%hook UIView
-(void)setBackgroundColor:(UIColor *)color {
    %orig([UIColor clearColor]);
    //[[UIApplication sharedApplication] _setBackgroundStyle:3];
    [[UIApplication sharedApplication] _setBackgroundStyle:UIBackgroundStyleLightBlur];
}
%end

