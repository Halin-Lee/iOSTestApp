//
//  SwitchHelper.m
//  Halin
//
//  Created by Halin on 15/9/10.
//  Copyright (c) 2015年Halin. All rights reserved.
//

#import "SwitchHelper.h"




@implementation SwitchHelper





+ (Switch2D) swtich2DWithFirst:(BOOL)first second:(BOOL)second{
    return (first << 1) + second;
    /*
     
     
     if (first && second) {
     return Switch2DBothTrue;
     }else if(first && !second){
     return Switch2DTrueFalse;
     }else if(!first && second){
     return Switch2DFalseTrue;
     }else{
     return Switch2DBothFalse;
     }
     
     */
}

@end
