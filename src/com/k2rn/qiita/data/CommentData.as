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
     * CommentData.as
     * 
     * <p>コメントのデータをまとめたクラスです.</p>
     * 
     * @auther Takefumi Katsuren
     */
    public dynamic class CommentData
    {
        //--------------------------------------------------------------------------
        //
        // Properties
        //
        //--------------------------------------------------------------------------
        /**
         * <p>コメントのIDです.</p>
         */
        public function get id():String
        {
            return _id;
        }
        public function set id(value:String):void
        {
            _id = value;
        }
        private var _id:String = null;
        
        /**
        * <p>コメントのUUIDです.</p>
        */
        public function get uuid():String
        {
            return _uuid;
        }
        public function set uuid(value:String):void
        {
            _uuid = value;
        }
        private var _uuid:String = null;
        
        /**
        * <p>コメントを投稿したユーザーの簡易情報です.</p>
        */
        public function get user():ItemUserData
        {
            return _user;
        }
        public function set user(value:ItemUserData):void
        {
            _user = value;
        }
        private var _user:ItemUserData = null;
        
        /**
        * <p>コメントの内容です.</p>
        */
        public function get body():String
        {
            return _body;
        }
        public function set body(value:String):void
        {
            _body = value;
        }
        private var _body:String = null;
        
        
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
        public function CommentData(seed:Object=null)
        {
            if (seed != null) {
                for (var p:String in seed) {
                    try {
                        if (p == "user") {
                            var userObj:ItemUserData = new ItemUserData(seed[p]);
                            _user = userObj;
                        }
                        else {
	                        this[p] = seed[p];
                        }
                    }
                    catch (err:Error) {
                        // パースエラーが起きた場合は無視する.
                    }
                }
            }
        }
    }
}