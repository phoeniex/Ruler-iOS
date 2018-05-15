//
//  CustomRule.m
//  SwiftRuler
//
//  Created by Rawipon Srivibha  on 8/9/17.
//  Copyright © 2017 Rawipon Srivibha. All rights reserved.
//

#import "CustomRule.h"

@implementation CustomRule

- (BOOL)validateWithCandidate:(id)candidate {
  if(![candidate isKindOfClass:[NSString class]]) {
    return NO;
  }
  
  NSString *candidateString = (NSString*)candidate;
  NSCharacterSet *capSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ"];
  if([candidateString rangeOfCharacterFromSet:capSet].location != NSNotFound) {
    return NO;
  }
  
  return YES;
}

@end
