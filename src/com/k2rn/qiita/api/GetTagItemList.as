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
    
    import flash.net.URLRequest;
    import flash.net.URLRequestMethod;
    import flash.net.URLVariables;
    
    import mx.utils.StringUtil;
    
    /**
     * GetTagItemList.as
     * 
     * <p>特定タグの記事一覧を取得するクラスです.</p>
     * 
     * @auther Takefumi Katsuren
     */
    public class GetTagItemList extends AbstractAPI
    {
        //--------------------------------------------------------------------------
        //
        // Constants
        //
        //--------------------------------------------------------------------------
        private static const API_PATH:String        = "tags/{0}/items";
        
        
        //--------------------------------------------------------------------------
        //
        // Properties
        //
        //--------------------------------------------------------------------------
        /**
         * <p>取得するタグ名を指定します.</p>
         */
        public function get tagId():String
        {
            return _tagId;
        }
        public function set tagId(value:String):void
        {
            _tagId = value;
        }
        private var _tagId:String = null;
        
        
        //--------------------------------------------------------------------------
        //
        // Public methods
        //
        //--------------------------------------------------------------------------
        /**
         * <p>コンストラクタ.</p>
         * @param endPoint <p>通信するAPIのエンドポイントを指定します.</p>
         */
        public function GetTagItemList(endPoint:String)
        {
            super(endPoint);
        }
        
        /**
         * <p>リクエストを送信します.</p>
         * <p>リクエスト中の場合は古い通信を破棄し、新たにリクエストします.</p>
         * @throws Error <p>tagId を設定せずにリクエストすると例外が発生します.</p>
         * @throws Error <p>destroy メソッドをコールした後に send すると例外が発生します.<p>
         */
        override public function send():void
        {
            if (loader == null) {
                throw new Error("このインスタンスはすでに破棄されています", ErrorID.DESTROYED_ALREADY);
            }
            if (_tagId == null) {
                throw new Error("tagId が未設定のままリクエストしようとしました", ErrorID.MISSING_TAG_ID);
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
            
            var url:String = endPoint + StringUtil.substitute(API_PATH, _tagId);
            var req:URLRequest = new URLRequest(url);
            req.method = URLRequestMethod.GET;
            var vars:URLVariables = new URLVariables();
            vars["per_page"]    = _perPage;
            vars["page"]        = _page;
            if (_token != null) {
                vars["token"] = _token;
            }
            
            req.data = vars;
            loader.load(req);
            _isLoading = true;
        }
    }
}