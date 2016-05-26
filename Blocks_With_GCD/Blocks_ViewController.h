//
//  Blocks_ViewController.h
//  Blocks_With_GCD
//
//  Created by Tamil_Arya on 25/05/16.
//  Copyright © 2016 Tamil_Arya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Blocks_ViewController : UIViewController
-(void)My_first_Block:(void(^)(int))completionBlock;
-(int)My_Second_Block:(int(^)(int))completionBlock;

@property(nonatomic,strong)int (^callBack)(int a);
@end
