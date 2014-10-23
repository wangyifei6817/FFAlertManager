//
//  FFAlertController.m
//  useHome
//
//  Created by 王一飞 on 14/10/23.
//  Copyright (c) 2014年 Autohome Inc. All rights reserved.
//

#import "FFAlertController.h"
#import <objc/runtime.h>



@interface BlockAlertView : UIAlertView<UIAlertViewDelegate>
- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
   confirmButtonTitle:(NSString*)confirmButtonTitle
              block:(alertBlock)block;
@end

@implementation BlockAlertView

static char alertViewTag;

-(id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle confirmButtonTitle:(NSString *)confirmButtonTitle block:(alertBlock)block{
    self = [super initWithTitle:title
                        message:message
                       delegate:self
              cancelButtonTitle:cancelButtonTitle
              otherButtonTitles:confirmButtonTitle, nil];
    
    objc_setAssociatedObject(self, &alertViewTag, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return self;
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{


    alertBlock aBlock = objc_getAssociatedObject(self, &alertViewTag);
    aBlock(buttonIndex);
}
-(void)dealloc{

    objc_removeAssociatedObjects(self);
}

@end

@interface FFAlertController()
{

    id alertView;
    id superVC;//use for present UIAlertController
}


@end

@implementation FFAlertController

-(id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle confirmButtonTitle:(NSString *)confirmButtonTitle delegate:(id)delegate block:(alertBlock)block {

    self = [super init];
    
    if (self) {
        if (iOS8) {
            superVC   = delegate;
            alertView = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            int index = 0;
            if (cancelButtonTitle != nil) {
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:cancelButtonTitle
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:^(UIAlertAction *action) {
                                                                     block(0);
                                                                 }];
                [alertView addAction:cancleAction];
                index ++;
            }
            if (confirmButtonTitle != nil) {
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:confirmButtonTitle
                                                                       style:UIAlertActionStyleDefault
                                                                     handler:^(UIAlertAction *action) {
                                                                         block(index);
                                                                     }];
                [alertView addAction:otherAction];
            }
            

        }else{
            alertView = [[BlockAlertView alloc]initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle confirmButtonTitle:confirmButtonTitle block:block];
        }
    }
    
    return self;
}

-(void)show{
    
    if (iOS8) {
        if (alertView && [alertView isKindOfClass:[UIAlertController class]]) {

            if (superVC && [superVC isKindOfClass:[UIViewController class]]) {
                UIViewController *someViewController = superVC;
                [someViewController presentViewController:alertView animated:YES completion:nil];
            }
        }
    }else{
        BlockAlertView *alert = alertView;
        [alert show];
    }
    
}

-(void)dealloc{

    superVC = nil;
    alertView = nil;
    
}
@end
