/**
 * Licensed under the MIT License
 * 
 * Copyright (c) 2012 Katsuren Takefumi
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy 
 * of this software and associated documentation files (the "Software"), to deal 
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 * 
 * In Japanese, http://sourceforge.jp/projects/opensource/wiki/licenses%2FMIT_license
 */
package com.k2rn.qiita
{
    /**
    * <p>発生するエラーのIDをまとめたクラスです.</p>
    */
    public class ErrorID
    {
        public static const UNKNOWN:int                 = 10000;
        
        public static const MISSING_USER_ID:int         = 10001;
        public static const MISSING_PASSWORD:int        = 10002;
        public static const MISSING_TAG_ID:int          = 10003;
        public static const MISSING_SEARCH_QUERY:int    = 10004;
        public static const MISSING_TOKEN:int           = 10005;
        public static const MISSING_TITLE:int           = 10006;
        public static const MISSING_TAG:int             = 10007;
        public static const MISSING_BODY:int            = 10008;
        public static const MISSING_UUID:int            = 10009;
        public static const DESTROYED_ALREADY:int       = 10010;
        
        public static const INVALID_JSON_FORMAT:int     = 10101;
    }
}