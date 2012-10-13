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
package com.k2rn.qiita.api
{
    import com.k2rn.qiita.ErrorID;
    import com.k2rn.qiita.data.ItemTagData;
    
    import flash.net.URLRequest;
    import flash.net.URLRequestMethod;
    import flash.net.URLVariables;
    
    import mx.utils.StringUtil;

    /**
     * UpdateItem.as
     * 
     * <p>自分の記事を更新するクラスです.</p>
     * 
     * @auther Takefumi Katsuren
     */
    public class UpdateItem extends AbstractAPI
    {
        //--------------------------------------------------------------------------
        //
        // Constants
        //
        //--------------------------------------------------------------------------
        private static const API_PATH:String        = "items/{0}";
        
        
        //--------------------------------------------------------------------------
        //
        // Properties
        //
        //--------------------------------------------------------------------------
        /**
        * <p>記事のIDです.</p>
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
         * <p>記事のタグの配列です.</p>
         */
        public function get tags():Vector.<ItemTagData>
        {
            return _tags;
        }
        public function set tags(value:Vector.<ItemTagData>):void
        {
            _tags = value;
        }
        private var _tags:Vector.<ItemTagData> = null;
        
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
         * <p>記事の公開設定です.</p>
         * <p>非公開のものを公開する場合のみ適用されます. すなわち false のときのみ反映されます.</p>
         * @default true
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
        
        
        //--------------------------------------------------------------------------
        //
        // Public methods
        //
        //--------------------------------------------------------------------------
        /**
         * <p>コンストラクタ.</p>
         * @param endPoint <p>通信するAPIのエンドポイントを指定します.</p>
         */
        public function UpdateItem(endPoint:String)
        {
            super(endPoint);
        }
        
        /**
         * <p>リクエストを送信します.</p>
         * <p>リクエスト中の場合は古い通信を破棄し、新たにリクエストします.</p>
         * @throws Error <p>token を設定せずにリクエストすると例外が発生します.</p>
         * @throws Error <p>記事タイトルを設定せずにリクエストすると例外が発生します.</p>
         * @throws Error <p>タグを設定せずにリクエストすると例外が発生します.</p>
         * @throws Error <p>記事内容を設定せずにリクエストすると例外が発生します.</p>
         * @throws Error <p>destroy メソッドをコールした後に send すると例外が発生します.<p>
         */
        override public function send():void
        {
            if (loader == null) {
                throw new Error("このインスタンスはすでに破棄されています", ErrorID.DESTROYED_ALREADY);
            }
            if (_token == null) {
                throw new Error("token が未設定のままリクエストしようとしました", ErrorID.MISSING_TOKEN);
            }
            if (_uuid == null) {
                throw new Error("記事IDが未設定のままリクエストしようとしました", ErrorID.MISSING_UUID);
            }
            
            if (_isLoading) {
                try {
                    loader.close();
                }
                catch (err:Error) {
                    // 通信を閉じたいだけなので、エラーは無視する.
                    // trace(err.message);
                }
            }
            
            var url:String = endPoint + StringUtil.substitute(API_PATH, _uuid);
            var req:URLRequest = new URLRequest(url);
            req.method = URLRequestMethod.PUT;
            var vars:URLVariables = new URLVariables();
            vars["token"] = _token;
            if (_title != null) vars["title"] = _title;
            if (_body != null) vars["body"] = _body;
            if (_isPrivate == false) vars["private"] = _isPrivate;
            if (_tags != null) {
	            var tagString:String = "[";
	            for (var i:int=0; i<_tags.length; i++) {
	                if (i!=0) {
	                    tagString += ", ";
	                }
	                tagString += _tags[i].toString();
	            }
	            tagString += "]";
	            vars["tags"] = tagString;
            }
            
            req.data = vars;
            loader.load(req);
            _isLoading = true;
        }
    }
}