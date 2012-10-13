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
    import mx.utils.ObjectUtil;

    /**
     * ItemData.as
     * 
     * <p>記事のデータをまとめたクラスです.</p>
     * 
     * @auther Takefumi Katsuren
     */
    public dynamic class ItemData
    {
        //--------------------------------------------------------------------------
        //
        // Properties
        //
        //--------------------------------------------------------------------------
        /**
         * <p>記事のIDです.</p>
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
         * <p>記事のUUIDです.</p>
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
         * <p>記事を投稿したユーザーの簡易情報です.</p>
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
         * <p>記事のタイトルです.</p>
         */
        public function get title():String
        {
            return _title;
        }
        public function set title(value:String):void
        {
            _title = value;
        }
        private var _title:String = null;
        
        /**
         * <p>記事の内容です.</p>
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
        
        /**
         * <p>記事が作成された日時です.</p>
         */
        public function get created_at():String
        {
            return _created_at;
        }
        public function set created_at(value:String):void
        {
            _created_at = value;
        }
        private var _created_at:String = null;
        
        /**
         * <p>記事が更新された日時です.</p>
         */
        public function get updated_at():String
        {
            return _updated_at;
        }
        public function set updated_at(value:String):void
        {
            _updated_at = value;
        }
        private var _updated_at:String = null;
        
        /**
        * <p>"xx ago" の形式での記事が作成された日時です.</p>
        */
        public function get created_at_in_words():String
        {
            return _created_at_in_words;
        }
        public function set created_at_in_words(value:String):void
        {
            _created_at_in_words = value;
        }
        private var _created_at_in_words:String = null;
        
        /**
        * <p>"xx ago" の形式での記事が更新された日時です.</p>
        */
        public function get updated_at_in_words():String
        {
            return _updated_at_in_words;
        }
        public function set updated_at_in_words(value:String):void
        {
            _updated_at_in_words = value;
        }
        private var _updated_at_in_words:String = null;
        
        /**
        * <p>記事に指定されているタグの配列です.</p>
        */
        public function get tags():Vector.<ItemTagData>
        {
            return tags;
        }
        public function set tags(value:Vector.<ItemTagData>):void
        {
            _tags = value;
        }
        private var _tags:Vector.<ItemTagData> = new Vector.<ItemTagData>();
        
        /**
        * <p>記事がストックされた数です.</p>
        */
        public function get stock_count():int
        {
            return _stock_count;
        }
        public function set stock_count(value:int):void
        {
            _stock_count = value;
        }
        private var _stock_count:int = 0;
        
        /**
        * <p>ストックしているユーザー名の配列です.</p>
        */
        public function get stock_users():Vector.<String>
        {
            return _stock_users;
        }
        public function set stock_users(value:Vector.<String>):void
        {
            _stock_users = value;
        }
        private var _stock_users:Vector.<String> = new Vector.<String>();
        
        /**
        * <p>コメントの数です.</p>
        */
        public function get comment_count():int
        {
            return _comment_count;
        }
        public function set comment_count(value:int):void
        {
            _comment_count = value;
        }
        private var _comment_count:int = 0;
        
        /**
        * <p>記事のURLです.</p>
        */
        public function get url():String
        {
            return _url;
        }
        public function set url(value:String):void
        {
            _url = value;
        }
        private var _url:String = null;
        
        /**
        * <p>gistのURLです.</p>
        */
        public function get gist_url():String
        {
            return _gist_url;
        }
        public function set gist_url(value:String):void
        {
            _gist_url = value;
        }
        private var _gist_url:String = null;
        
        /**
        * <p>記事が限定公開の場合は true です.</p>
        */
        public function get isPrivate():Boolean
        {
            return _isPrivate;
        } 
        public function set isPrivate(value:Boolean):void
        {
            _isPrivate = value;
        }
        private var _isPrivate:Boolean = true;
        
        /**
        * <p>記事をストックしている場合は true です.</p>
        */
        public function get stocked():Boolean
        {
            return _stocked;
        }
        public function set stocked(value:Boolean):void
        {
            _stocked = value;
        }
        private var _stocked:Boolean = false;
        
        /**
        * <p>コメントデータの配列です.</p>
        */
        public function get comments():Vector.<CommentData>
        {
            return _comments;
        }
        public function set comments(value:Vector.<CommentData>):void
        {
            _comments = value;
        }
        private var _comments:Vector.<CommentData> = new Vector.<CommentData>();
        
        
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
        public function ItemData(seed:Object=null)
        {
            if (seed != null) {
                for (var p:String in seed) {
                    try {
                        if (p == "private") {
                            // private は予約語のため使えないのでプロパティ名を変更して保存
                            _isPrivate = seed[p];
                        }
                        else if (p == "tags") {
                            setTags(seed[p] as Array);
                        }
                        else if (p == "comments") {
                            setComments(seed[p] as Array);
                        }
                        else if (p == "user") {
                            _user = new ItemUserData(seed[p]);
                        }
                        else if (p == "stock_users") {
                            setStockedUsers(seed[p]);
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
        
        
        //--------------------------------------------------------------------------
        //
        // Private methods
        //
        //--------------------------------------------------------------------------
        /**
        * <p>タグデータの生配列をクラスオブジェクトに変換し格納します.</p>
        */
        private function setTags(data:Array):void
        {
            if (data != null) {
                for (var i:int=0; i<data.length; i++) {
                    var o:Object = data[i];
                    var tag:ItemTagData = new ItemTagData(o);
                    _tags.push(tag);
                }
            }
        }
        
        /**
        * <p>コメントデータの生配列をクラスオブジェクトに変換し格納します.</p>
        */
        private function setComments(data:Array):void
        {
            if (data != null) {
                for (var i:int=0; i<data.length; i++) {
                    var o:Object = data[i];
                    var c:CommentData = new CommentData(o);
                    _comments.push(c);
                }
            }
        }
        
        /**
        * <p>ストックしたユーザーの生配列を_stock_usersに格納します.</p>
        */
        private function setStockedUsers(data:Array):void
        {
            if (data != null) {
                for (var i:int=0; i<data.length; i++) {
                    var s:String = data[i] as String;
                    if (s != null && s != "") {
	                    _stock_users.push(s);
                    }
                }
            }
        }
    }
}