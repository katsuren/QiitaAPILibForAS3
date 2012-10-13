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
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.HTTPStatusEvent;
    import flash.events.IEventDispatcher;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.system.Capabilities;
    
    [Event (type="flash.events.Event", name="complete")]
    [Event (type="flash.events.IOErrorEvent", name="ioError")]
    [Event (type="flash.events.SecurityErrorEvent", name="securityError")]
    [Event (type="flash.events.HTTPStatusEvent", name="httpStatus")]
    [Event (type="flash.events.HTTPStatusEvent", name="httpResponseStatus")]
    
    /**
     * AbstractAPI.as
     * 
     * <p>Qiita の API に通信するためのベースクラスです.</p>
     * 
     * @auther com.k2rn<Takefumi Katsuren>
     */
    public class AbstractAPI extends EventDispatcher
    {
        //--------------------------------------------------------------------------
        //
        // Properties
        //
        //--------------------------------------------------------------------------
        protected var endPoint:String;
        protected var loader:URLLoader;
        protected var isDestroyed:Boolean = false;
        
        /**
        * <p>現在リクエストを送信中かどうかを表します.</p>
        */
        public function get isLoading():Boolean
        {
            return _isLoading;
        }
        protected var _isLoading:Boolean = false;
        
        /**
        * <p>通信した結果です.</p>
        */
        public function get data():String
        {
            return loader == null ? null : loader.data as String;
        }
        
        /**
         * <p>APIトークンです.</p>
         * <p>トークンはなくてもリクエスト可能な場合があります.</p>
         * <p>トークンが必須なリクエストで指定しない場合は send メソッドで例外が発生します.</p>
         * <p>トークンが必須でないリクエストで設定されている場合は認証つきでリクエストを送信します.</p>
         */
        public function get token():String
        {
            return _token;
        }
        public function set token(value:String):void
        {
            _token = value;
        }
        protected var _token:String = null;
        
        /**
         * <p>一度に取得する件数を指定します.</p>
         * <p>2012/10/10 現在では最大100件までです.</p>
         */
        public function get perPage():uint
        {
            return _perPage;
        }
        public function set perPage(value:uint):void
        {
            _perPage = value;
        }
        protected var _perPage:uint = 20;
        
        /**
         * <p>取得するデータのオフセットを指定します.</p>
         * <p>0インデックスです.</p>
         */
        public function get page():uint
        {
            return _page;
        }
        public function set page(value:uint):void
        {
            _page = value;
        }
        protected var _page:uint = 0;
        
        
        //--------------------------------------------------------------------------
        //
        // Public methods
        //
        //--------------------------------------------------------------------------
        /**
        * <p>コンストラクタ.</p>
        */
        public function AbstractAPI(endPoint:String)
        {
            super(this);
            
            this.endPoint = endPoint;
            
            loader = new URLLoader();
            loader.dataFormat = URLLoaderDataFormat.TEXT;
            loader.addEventListener(Event.COMPLETE, loader_completeHandler);
            loader.addEventListener(IOErrorEvent.IO_ERROR, loader_ioErrorHandler);
            loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_securityErrorHandler);
            if (Capabilities.playerType.toLowerCase() == "plugin" || Capabilities.playerType.toLowerCase() == "activex") {
                loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, loader_httpStatusHandler);
            }
            else {
	            loader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, loader_httpResponseStatusHandler);
            }
        }
        
        /**
        * <p>通信オブジェクトを破棄します.</p>
        */
        public function destroy():void
        {
            isDestroyed = true;
            try {
                loader.close();
            }
            catch (err:Error) {
                // 最終処理をしたいだけなので、エラーが発生しても握りつぶす
            }
            loader.removeEventListener(Event.COMPLETE, loader_completeHandler);
            loader.removeEventListener(IOErrorEvent.IO_ERROR, loader_ioErrorHandler);
            loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_securityErrorHandler);
            loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, loader_httpStatusHandler);
            loader.removeEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, loader_httpResponseStatusHandler);
            loader = null;
        }
        
        /**
        * <p>リクエストを送信します.</p>
        */
        public function send():void
        {
            // 中身はサブクラスで実装すること
        }
        
        
        //--------------------------------------------------------------------------
        //
        // Event handlers
        //
        //--------------------------------------------------------------------------
        /**
        * <p>通信が完了したときに呼び出される関数です.</p>
        */
        protected function loader_completeHandler(e:Event):void
        {
            _isLoading = false;
            
            if (!isDestroyed) {
	            var data:String = loader.data as String;
	            var event:Event = e.clone();
	            dispatchEvent(event);
            }
        }
        
        /**
        * <p>通信中にIOエラーが発生した時に呼び出される関数です.</p>
        */
        protected function loader_ioErrorHandler(e:IOErrorEvent):void
        {
            _isLoading = false;
            
            if (!isDestroyed) {
	            var event:IOErrorEvent = e.clone() as IOErrorEvent;
	            dispatchEvent(event);
            }
        }
        
        /**
        * <p>通信中にセキュリティエラーが発生した時に呼び出される関数です.</p>
        */
        protected function loader_securityErrorHandler(e:SecurityErrorEvent):void
        {
            _isLoading = false;
            
            if (!isDestroyed) {
	            var event:SecurityErrorEvent = e.clone() as SecurityErrorEvent;
	            dispatchEvent(event);
            }
        }
        
        /**
        * <p>通信が完了したときに呼び出される関数です.</p>
        * <p>主にHTTPステータス、レスポンスヘッダが確認できます.</p>
        * <p>ブラウザのプラグイン用です.</p>
        */
        protected function loader_httpStatusHandler(e:HTTPStatusEvent):void
        {
            if (!isDestroyed) {
	            var event:HTTPStatusEvent = e.clone() as HTTPStatusEvent;
	            dispatchEvent(event);
            }
        }
        
        /**
        * <p>通信が完了したときに呼び出される関数です.</p>
        * <p>主にHTTPステータス、レスポンスヘッダが確認できます.</p>
        * <p>AIR用です.</p>
        */
        protected function loader_httpResponseStatusHandler(e:HTTPStatusEvent):void
        {
            if (!isDestroyed) {
	            var event:HTTPStatusEvent = e.clone() as HTTPStatusEvent;
	            dispatchEvent(event);
            }
        }
    }
}