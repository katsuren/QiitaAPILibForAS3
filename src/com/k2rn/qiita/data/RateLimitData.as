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
     * RateLimitData.as
     * 
     * <p>リクエスト上限データをまとめたクラスです.</p>
     * 
     * @auther Takefumi Katsuren
     */
    public dynamic class RateLimitData
    {
        //--------------------------------------------------------------------------
        //
        // Properties
        //
        //--------------------------------------------------------------------------
        /**
         * <p>残りリクエスト回数です.</p>
         */
        public function get remaining():int
        {
            return _remaining;
        }
        public function set remaining(value:int):void
        {
            _remaining = value;
        }
        private var _remaining:int = 0;
        
        /**
         * <p>リクエストの上限です.</p>
         */
        public function get limit():int
        {
            return _limit;
        }
        public function set limit(value:int):void
        {
            _limit = value;
        }
        private var _limit:int = 0;
        
        
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
        public function RateLimitData(seed:Object=null)
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