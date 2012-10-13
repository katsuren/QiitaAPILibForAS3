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
     * ItemUserData.as
     * 
     * <p>ユーザーのデータをまとめたクラスです.</p>
     * <p>記事に紐付いているユーザーの簡易的な情報を定義します.</p>
     * 
     * @auther Takefumi Katsuren
     */
    public dynamic class ItemUserData
    {
        //--------------------------------------------------------------------------
        //
        // Properties
        //
        //--------------------------------------------------------------------------
        /**
         * <p>ユーザーの名前です.</p>
         */
        public function get name():String
        {
            return _name;
        }
        public function set name(value:String):void
        {
            _name = value;
        }
        private var _name:String = null;
        
        /**
         * <p>ユーザーのURL名です.</p>
         */
        public function get url_name():String
        {
            return _urlName;
        }
        public function set url_name(value:String):void
        {
            _urlName = value;
        }
        private var _urlName:String = null;
        
        /**
         * <p>プロフィール画像のURLです.</p>
         */
        public function get profile_image_url():String
        {
            return _profileImageUrl;
        }
        public function set profile_image_url(value:String):void
        {
            _profileImageUrl = value;
        }
        private var _profileImageUrl:String = null;
        
        
        //--------------------------------------------------------------------------
        //
        // Public methods
        //
        //--------------------------------------------------------------------------
        /**
         * <p>コンストラクタ.</p>
         * @param seed <p>ユーザー情報のオブジェクトです. このオブジェクトのプロパティから初期情報を設定することができます.</p>
         */
        public function ItemUserData(seed:Object=null)
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