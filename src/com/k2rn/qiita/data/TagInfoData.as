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
     * TagInfoData.as
     * 
     * <p>タグデータをまとめたクラスです.</p>
     * <p>タグの情報を定義します.</p>
     * 
     * @auther Takefumi Katsuren
     */
    public class TagInfoData
    {
        //--------------------------------------------------------------------------
        //
        // Properties
        //
        //--------------------------------------------------------------------------
        /**
         * <p>タグの名前です.</p>
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
         * <p>記事のURLに表示されるパスの名前です.</p>
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
         * <p>iconのURLです.</p>
         */
        public function get icon_url():String
        {
            return _iconUrl;
        }
        public function set icon_url(value:String):void
        {
            _iconUrl = value;
        }
        private var _iconUrl:String = null;
        
        /**
        * <p>このタグが設定されている記事の数です.</p>
        */
        public function get item_count():int
        {
            return _item_count;
        }
        public function set item_count(value:int):void
        {
            _item_count = value;
        }
        private var _item_count:int = 0;
        
        /**
        * <p>このタグをフォローしているユーザーの数です.</p>
        */
        public function get follower_count():int
        {
            return _follower_count;
        }
        public function set follower_count(value:int):void
        {
            _follower_count = value;
        }
        private var _follower_count:int = 0;
        
        /**
        * <p>自分がこのタグをフォローしている場合は true です.</p>
        */
        public function get following():Boolean
        {
            return _following;
        }
        public function set following(value:Boolean):void
        {
            _following = value;
        }
        private var _following:Boolean = false;
        
        
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
        public function TagInfoData(seed:Object=null)
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