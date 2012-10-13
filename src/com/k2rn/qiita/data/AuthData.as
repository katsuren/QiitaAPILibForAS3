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
package com.k2rn.qiita.data
{
    /**
     * AuthData.as
     * 
     * <p>認証時のデータをまとめたクラスです.</p>
     * 
     * @auther Takefumi Katsuren
     */
    public dynamic class AuthData
    {
        //--------------------------------------------------------------------------
        //
        // Properties
        //
        //--------------------------------------------------------------------------
        /**
         * <p>記事のURLに表示されるパスの名前です.</p>
         */
        public function get url_name():String
        {
            return _url_name;
        }
        public function set url_name(value:String):void
        {
            _url_name = value;
        }
        private var _url_name:String = null;
        
        /**
        * <p>APIのトークンです.</p>
        */
        public function get token():String
        {
            return _token;
        }
        public function set token(value:String):void
        {
            _token = value;
        }
        private var _token:String = null;
        
        
        //--------------------------------------------------------------------------
        //
        // Public methods
        //
        //--------------------------------------------------------------------------
        /**
         * <p>コンストラクタ.</p>
         * <p>オブジェクトを渡した場合、そのオブジェクトのプロパティから初期化します.</p>
         * 
         * @param seed <p>初期化子. このオブジェクトのプロパティの値をコピーして初期化します.</p>
         */
        public function AuthData(seed:Object=null)
        {
            if (seed != null) {
                for (var p:String in seed) {
                    try {
                        this[p] = seed[p];
                    }
                    catch (err:Error) {
                        // パースエラーが起きた場合は無視する.
                    }
                }
            }
        }
    }
}