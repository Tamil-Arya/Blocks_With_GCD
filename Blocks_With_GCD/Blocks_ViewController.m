//
//  Blocks_ViewController.m
//  Blocks_With_GCD
//
//  Created by Tamil_Arya on 25/05/16.
//  Copyright © 2016 Tamil_Arya. All rights reserved.
//

#import "Blocks_ViewController.h"

@interface Blocks_ViewController ()

@end

@implementation Blocks_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
#pragma Blocks
    
   //What is block : Blocks are an Apple extension to the Objective-C language that were motivated by the desire to pass small pieces of code in API calls to the Grand Central Dispatch multithreading system. Grand Central Dispatch works by making use of queues containing such small pieces of code, each representing a task or unit of work to be done. Blocks have been available in iOS since version 4.
    
    //Use :The basic idea of a block is to treat a small piece of code as if it were a value. The piece of code can then be passed as a parameter in messages or assigned to a variable. Eventually, at some future time, the code will be executed.
    
   // The most basic form of a block, known as a "block literal", consists of a caret character ("^"), followed by a set of curly braces that contain the actual code, as shown below:
  //ex:
    void (^sample)(void)=^{
        NSLog(@"Hi, I'm a block literal.");
    };
    sample();
    //Blocks appear inline along with the rest of your code, inside a method or function.
    
#pragma blocks : some of the concept
//1.
  //int
    
    int multiple=7;
    
    int (^first_Block_int)(int)=^(int num){
        
        return num * multiple;
    };
    
    NSLog(@"first_Block : %d",first_Block_int(7));
    
    //string
    
    NSString *(^first_Block_str)(NSString *)=^(NSString *str){
        
        if ([str isEqualToString:@"true"]) {
            return @"Success block";
        }
        else{
            return @"Failed block";
        }
    };
    
    NSLog(@"%@",first_Block_str(@"true"));
    
    
//-------------------------------------------------------------------------------------------------------------
    
//2.
    
    NSArray *localArray=@[@"77",@"seven",@"7",@"7777",@"777",@"77777"];
    
    //set the options for compare the above array
    static NSStringCompareOptions comparations=NSCaseInsensitiveSearch | NSNumericSearch | NSWidthInsensitiveSearch | NSForcedOrderingSearch;
    
    //get the current language,date nd time,religion depends on ur iphone settings,
    NSLocale *CurrentLocale=[NSLocale currentLocale];
    //comparator block
    NSComparator findsortBlock=^(id str1 , id str2){
        
        NSRange str1_Range=NSMakeRange(0, [str1 length]);
        
        return [str1 compare:str2 options:comparations range:str1_Range locale:CurrentLocale];
        
    };
    //invoke the block
    NSArray *SortArray=[localArray sortedArrayUsingComparator:findsortBlock];
    
    NSLog(@"Sorted array : %@ ,",SortArray);
    
   
//-------------------------------------------------------------------------------------------------------------
    
 //how to use : __block variables in the block concepts
    
    
    NSArray *DuplicateArray=@[ @"string 1",
                               @"String 21", // <-
                               @"string 12",
                               @"String 11",
                               @"Strîng 21", // <-
                               @"Striñg 21", // <-
                               @"String 02" ];
    
    //declare block variable
    
    __block NSUInteger countOfDuplicateVal=0;
    
    //invoke the block
    
    NSArray *diacriticInsensitiveSortArray=[DuplicateArray sortedArrayUsingComparator:^(id  _Nonnull str1, id  _Nonnull str2) {
        
        NSRange str_Range=NSMakeRange(0, [str1 length]);
        //comparator block
        NSComparisonResult finddiacriticInsensitiveBlock=[str1 compare:str2 options:NSDiacriticInsensitiveSearch range:str_Range locale:CurrentLocale];
            
        if (finddiacriticInsensitiveBlock == NSOrderedSame) {
            countOfDuplicateVal++;
        }
            return finddiacriticInsensitiveBlock;
    
    }];

    NSLog(@"finddiacriticInsensitiveSortArray : %@ ,",diacriticInsensitiveSortArray);
    NSLog(@"finddiacriticInsensitiveSortArrayCount :%lu",(unsigned long)countOfDuplicateVal);

//-------------------------------------------------------------------------------------------------------------
    
//3.
    
//declare as property obj

    _callBack=^(int a){
        return a*1;
    };
    NSLog(@"Property val : %d",_callBack(2));

//-------------------------------------------------------------------------------------------------------------

 //declaration of block without return val
    [self My_first_Block:^(int random) {
    
        NSLog(@"randomValues :%d",random);
        
    }];
             
//-------------------------------------------------------------------------------------------------------------
   //4.
    //declaration of block with return val
    
    int currentDay=[self My_Second_Block:^int(int passedValue) {
       NSLog(@"passedValue ;%d",passedValue);
        return passedValue;
    }];
    NSLog(@"CurrentDate : %d",currentDay);
    
 //-------------------------------------------------------------------------------------------------------------
// 5.
    
 //how we have to use typedef into the blocks
    
   //typedef is one of the populate keyword for muitiple language such as (C,C++) even Obj c also.
    //Use :  typedef, allows the creation of an alias, or alternative name, for a type.
    
    //This is often used for code intended to run on different OSs that have different mixes of types. Tweaking the types for different systems then means just tweaking a few type definitions, not large amounts of code.
    
  //  It can also be used if you think you can make your code more readable by assigning very specific types for different kinds of values. So we might define:
        
        typedef int animalCount;
  //  This creates an alias for the special case of variables that contain counts of animals. We might then have:
        animalCount bears = 7;
        animalCount raccoons = 27;
    
    NSLog(@"typedef declaration%d,%d",bears,raccoons);
    
   // The usual syntax for typedef for the simple alias definition done above is:
        
      //  typedef [existing type name] [alias]
    typedef int (^TwoInAndOneOutBlock) (int a, int b);
    
    //use
    TwoInAndOneOutBlock operateWithTwoNumbersBlock;
    operateWithTwoNumbersBlock = ^ (int a, int b) {
        return a*b;  // multiply the numbers
    };

    NSLog(@"typedef ex : %d",operateWithTwoNumbersBlock(10,20));
 //-------------------------------------------------------------------------------------------------------------
}
-(void)My_first_Block:(void(^)(int random))completionBlock{
    //rondom numbers
    int rondomVal=(arc4random()%9999999)+1;
    completionBlock(rondomVal);
}

-(int)My_Second_Block:(int (^)(int))completionBlock{
    NSDate *Currentdate=[NSDate date];
    NSDateFormatter *dateFormate=[[NSDateFormatter alloc]init];
    [dateFormate setDateFormat:@"dd"];
    NSString *currentDay=[dateFormate stringFromDate:Currentdate];
    
    //pass as usually
    completionBlock(5);
    //assign and return belongs to the data type
    return [currentDay integerValue];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
