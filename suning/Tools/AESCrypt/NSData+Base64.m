//
//  NSData+Base64.h
//  Gurpartap Singh
//
//  Created by Gurpartap Singh on 06/05/12.
//  Copyright (c) 2012 Gurpartap Singh. All rights reserved.
//

#import "NSData+Base64.h"

@implementation NSData (Base64Additions)

+ (NSData *)base64DataFromString:(NSString *)string {
  unsigned long ixtext, lentext;
  unsigned char ch, inbuf[4], outbuf[3];
  short i, ixinbuf;
  Boolean flignore, flendtext = false;
  const unsigned char *tempcstring;
  NSMutableData *theData;
  
  if (string == nil) {
    return [NSData data];
  }
  
  ixtext = 0;
  
  tempcstring = (const unsigned char *)[string UTF8String];
  
  lentext = [string length];
  
  theData = [NSMutableData dataWithCapacity: lentext];
  
  ixinbuf = 0;
  
  while (true) {
    if (ixtext >= lentext) {
      break;
    }
    
    ch = tempcstring [ixtext++];
    
    flignore = false;
    
    if ((ch >= 'A') && (ch <= 'Z')) {
      ch = ch - 'A';
    }
    else if ((ch >= 'a') && (ch <= 'z')) {
      ch = ch - 'a' + 26;
    }
    else if ((ch >= '0') && (ch <= '9')) {
      ch = ch - '0' + 52;
    }
    else if (ch == '+') {
      ch = 62;
    }
    else if (ch == '=') {
      flendtext = true;
    }
    else if (ch == '/') {
      ch = 63;
    }
    else {
      flignore = true; 
    }
    
    if (!flignore) {
      short ctcharsinbuf = 3;
      Boolean flbreak = false;
      
      if (flendtext) {
        if (ixinbuf == 0) {
          break;
        }
        
        if ((ixinbuf == 1) || (ixinbuf == 2)) {
          ctcharsinbuf = 1;
        }
        else {
          ctcharsinbuf = 2;
        }
        
        ixinbuf = 3;
        
        flbreak = true;
      }
      
      inbuf [ixinbuf++] = ch;
      
      if (ixinbuf == 4) {
        ixinbuf = 0;
        
        outbuf[0] = (inbuf[0] << 2) | ((inbuf[1] & 0x30) >> 4);
        outbuf[1] = ((inbuf[1] & 0x0F) << 4) | ((inbuf[2] & 0x3C) >> 2);
        outbuf[2] = ((inbuf[2] & 0x03) << 6) | (inbuf[3] & 0x3F);
        
        for (i = 0; i < ctcharsinbuf; i++) {
          [theData appendBytes: &outbuf[i] length: 1];
        }
      }
      
      if (flbreak) {
        break;
      }
    }
  }
  
  return theData;
}

+ (NSData *)dataWithBase64EncodedString:(NSString *)string
{
    const char lookup[] =
    {
        99, 99, 99, 99, 99,99, 99, 99, 99, 99,99, 99, 99, 99, 99,99,
        99, 99, 99, 99, 99,99, 99, 99, 99, 99,99, 99, 99, 99, 99,99,
        99, 99, 99, 99, 99,99, 99, 99, 99, 99,99, 62, 99, 99, 99,63,
        52, 53, 54, 55, 56,57, 58, 59, 60, 61,99, 99, 99, 99, 99,99,
        99,  0,  1,  2,  3, 4,  5,  6,  7,  8, 9, 10, 11, 12, 13,14,
        15, 16, 17, 18, 19,20, 21, 22, 23, 24,25, 99, 99, 99, 99,99,
        99, 26, 27, 28, 29,30, 31, 32, 33, 34,35, 36, 37, 38, 39,40,
        41, 42, 43, 44, 45,46, 47, 48, 49, 50,51, 99, 99, 99, 99,99
    };
    
    NSData *inputData = [string dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    long long inputLength = [inputData length];
    const unsigned char *inputBytes = [inputData bytes];
    
    long long maxOutputLength = (inputLength /4 + 1) * 3;
    NSMutableData *outputData = [NSMutableData dataWithLength:maxOutputLength];
    unsigned char *outputBytes = (unsigned char *)[outputData mutableBytes];
    
    int accumulator = 0;
    long long outputLength =0;
    unsigned char accumulated[] = {0,0, 0, 0};
    for (long long i = 0; i < inputLength; i++)
    {
        unsigned char decoded = lookup[inputBytes[i] &0x7F];
        if (decoded != 99)
        {
            accumulated[accumulator] = decoded;
            if (accumulator == 3)
            {
                outputBytes[outputLength++] = (accumulated[0] <<2) | (accumulated[1] >>4);
                outputBytes[outputLength++] = (accumulated[1] <<4) | (accumulated[2] >>2);
                outputBytes[outputLength++] = (accumulated[2] <<6) | accumulated[3];
            }
            accumulator = (accumulator +1) % 4;
        }
    }
    
    //handle left-over data
    if (accumulator > 0) outputBytes[outputLength] = (accumulated[0] <<2) | (accumulated[1] >>4);
    if (accumulator > 1) outputBytes[++outputLength] = (accumulated[1] <<4) | (accumulated[2] >>2);
    if (accumulator > 2) outputLength++;
    
    //truncate data to match actual output length
    outputData.length = outputLength;
    return outputLength? outputData: nil;
}

- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    //ensure wrapWidth is a multiple of 4
    wrapWidth = (wrapWidth /4) * 4;
    
    const char lookup[] ="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    
    long long inputLength = [self length];
    const unsigned char *inputBytes = [self bytes];
    
    long long maxOutputLength = (inputLength /3 + 1) * 4;
    maxOutputLength += wrapWidth? (maxOutputLength / wrapWidth) *2: 0;
    unsigned char *outputBytes = (unsigned char *)malloc(maxOutputLength);
    
    long long i;
    long long outputLength =0;
    for (i = 0; i < inputLength -2; i += 3)
    {
        outputBytes[outputLength++] = lookup[(inputBytes[i] &0xFC) >> 2];
        outputBytes[outputLength++] = lookup[((inputBytes[i] &0x03) << 4) | ((inputBytes[i +1] & 0xF0) >>4)];
        outputBytes[outputLength++] = lookup[((inputBytes[i +1] & 0x0F) <<2) | ((inputBytes[i + 2] & 0xC0) >> 6)];
        outputBytes[outputLength++] = lookup[inputBytes[i +2] & 0x3F];
        
        //add line break
        if (wrapWidth && (outputLength + 2) % (wrapWidth + 2) == 0)
        {
            outputBytes[outputLength++] ='\r';
            outputBytes[outputLength++] ='\n';
        }
    }
    
    //handle left-over data
    if (i == inputLength - 2)
    {
        // = terminator
        outputBytes[outputLength++] = lookup[(inputBytes[i] &0xFC) >> 2];
        outputBytes[outputLength++] = lookup[((inputBytes[i] &0x03) << 4) | ((inputBytes[i +1] & 0xF0) >>4)];
        outputBytes[outputLength++] = lookup[(inputBytes[i +1] & 0x0F) <<2];
        outputBytes[outputLength++] =  '=';
    }
    else if (i == inputLength -1)
    {
        // == terminator
        outputBytes[outputLength++] = lookup[(inputBytes[i] &0xFC) >> 2];
        outputBytes[outputLength++] = lookup[(inputBytes[i] &0x03) << 4];
        outputBytes[outputLength++] ='=';
        outputBytes[outputLength++] ='=';
    }
    
    //truncate data to match actual output length
    outputBytes =realloc(outputBytes, outputLength);
    NSString *result = [[NSString alloc] initWithBytesNoCopy:outputBytes length:outputLength encoding:NSASCIIStringEncoding freeWhenDone:YES];
    
#if !__has_feature(objc_arc)
    [resultautorelease];
#endif
    
    return (outputLength >= 4)? result: nil;
}

- (NSString *)base64EncodedString
{
    return [self base64EncodedStringWithWrapWidth:0];
}
@end
