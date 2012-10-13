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
     * HttpStatusCode.as
     * 
     * <p>HTTPのステータスコードをまとめたクラスです.</p>
     * 
     * @auther Takefumi Katsuren
     */
    public class HttpStatusCode
    {
        public static const CONTINUE:int                        = 100;
        public static const SWITCHING_PROTOCOLS:int             = 101;
        
        public static const OK:int                              = 200;
        public static const CREATED:int                         = 201;
        public static const ACCEPTED:int                        = 202;
        public static const NON_AUTHORITATIVE_INFORMATION:int   = 203;
        public static const NO_CONTENT:int                      = 204;
        public static const RESET_CONTENT:int                   = 205;
        public static const PARTIAL_CONTENT:int                 = 206;
        
        public static const AMBIGUOUS:int                       = 300;
        public static const MOVED:int                           = 301;
        public static const FOUND:int                           = 302;
        public static const REDIRECT_METHOD:int                 = 303;
        public static const NOT_MODIFIED:int                    = 304;
        public static const USE_PROXY:int                       = 305;
        public static const UNUSED:int                          = 306;
        public static const REDIRECT_KEEP_VERB:int              = 307;
        
        public static const BAD_REQUEST:int                     = 400;
        public static const UNAUTHORIZED:int                    = 401;
        public static const PAYMENT_REQUIRED:int                = 402;
        public static const FORBIDDEN:int                       = 403;
        public static const NOT_FOUND:int                       = 404;
        public static const METHOD_NOT_ALLOWED:int              = 405;
        public static const NOT_ACCEPTABLE:int                  = 406;
        public static const PROXY_AUTHENTICATION_REQUIRED:int   = 407;
        public static const REQUEST_TIMEOUT:int                 = 408;
        public static const CONFLICT:int                        = 409;
        public static const GONE:int                            = 410;
        public static const LENGTH_REQUIRED:int                 = 411;
        public static const PRECONDITION_FAILED:int             = 412;
        public static const REQUEST_ENTITY_TOO_LARGE:int        = 413;
        public static const REQUEST_URI_TOO_LONG:int            = 414;
        public static const UNSUPPORTED_MEDIA_TYPE:int          = 415;
        public static const REQUESTED_RANGE_NOT_SATISFIABLE:int = 416;
        public static const EXPECTATION_FAILED:int              = 417;
        
        public static const INTERNAL_SERVER_ERROR:int           = 500;
        public static const NOT_IMPLEMENTED:int                 = 501;
        public static const BAD_GATEWAY:int                     = 502;
        public static const SERVICE_UNAVAILABLE:int             = 503;
        public static const GATEWAY_TIMEOUT:int                 = 504;
        public static const HTTP_VERSION_NOT_SUPPORTED:int      = 505;
    }
}