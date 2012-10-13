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
     * ItemTagData.as
     * 
     * <p>タグデータをまとめたクラスです.</p>
     * <p>記事に紐付いているタグの情報を定義します.</p>
     * 
     * @auther Takefumi Katsuren
     */
    public dynamic class ItemTagData
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
        * <p>バージョンの配列です.</p>
        * <p>バージョンを追加/削除する場合には addVersion, removeVersionAt を利用してください.</p>
        */
        public function get versions():Vector.<String>
        {
            return _versions;
        }
        private var _versions:Vector.<String> = new Vector.<String>();
        
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
        public function ItemTagData(seed:Object=null)
        {
            if (seed != null) {
	            for (var p:String in seed) {
	                try {
		                if (p == "versions") {
		                    var v:Array = seed[p];
		                    for (var i:int=0; i<v.length; i++) {
	                            addVersion(v[i] as String);
	                        }
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
        
        /**
        * <p>バージョンを追加します.</p>
        * @param v <p>バージョンを文字列で指定します.</p>
        */
        public function addVersion(v:String):void
        {
            _versions.push(v);
        }
        
        /**
        * <p>指定したインデックスのバージョンを削除します.</p>
        * <p>削除したいバージョンのインデックスは versions プロパティを参照してください.</p>
        * @param index <p>削除したいバージョンのインデックスです.</p>
        * @return <p>削除されたバージョンを返します.</p>
        */
        public function removeVersionAt(index:uint):String
        {
            if (_versions.length <= index) {
                return null;
            }
            return _versions.splice(index, 1)[0];
        }
        
        /**
        * <p>バージョンをすべて削除し、空にします.</p>
        */
        public function clearVersions():void
        {
            _versions = new Vector.<String>();
        }
        
        public function toString():String
        {
            var str:String = "{";
            str += "\"name\": \"" + _name + "\"";
            if (_versions.length > 0) {
                str += ", \"versions\": ['" + _versions[0] + "'";
                for (var i:int=1; i<_versions.length; i++) {
                    str += ", '" + _versions[i] + "'";
                }
                str += "]";
            }
            if (_urlName != null) {
                str += ", \"url_name\": \"" + _urlName + "\"";
            }
            if (_iconUrl != null) {
                str += ", \"icon_url\": \"" + _iconUrl + "\"";
            }
            str += "}";
            return str;
        }
    }
}