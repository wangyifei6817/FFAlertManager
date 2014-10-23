//
//  FFAlertController.h
//  useHome
//
//  Created by 王一飞 on 14/10/23.
//  Copyright (c) 2014年 Autohome Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
#define IOS8_SDK_AVAILABLE 1
#endif

#define iOS8 ([[[UIDevice currentDevice] systemVersion]floatValue]>=8.0?YES:NO)

typedef void (^alertBlock)(NSInteger idx);

@interface FFAlertManager : NSObject



-(id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle confirmButtonTitle:(NSString *)confirmButtonTitle delegate:(id)delegate block:(alertBlock)block ;

-(void)show;
@end
