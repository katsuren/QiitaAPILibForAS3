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
package com.k2rn.qiita
{
    import com.k2rn.qiita.api.AbstractAPI;
    import com.k2rn.qiita.api.Auth;
    import com.k2rn.qiita.api.DeleteItem;
    import com.k2rn.qiita.api.GetFollowingTag;
    import com.k2rn.qiita.api.GetFollowingUser;
    import com.k2rn.qiita.api.GetMyItemList;
    import com.k2rn.qiita.api.GetMyStockList;
    import com.k2rn.qiita.api.GetNewlyItemList;
    import com.k2rn.qiita.api.GetRateLimit;
    import com.k2rn.qiita.api.GetTagItemList;
    import com.k2rn.qiita.api.GetTagList;
    import com.k2rn.qiita.api.GetUserInfo;
    import com.k2rn.qiita.api.GetUserItemList;
    import com.k2rn.qiita.api.GetUserStockList;
    import com.k2rn.qiita.api.PostItem;
    import com.k2rn.qiita.api.Search;
    import com.k2rn.qiita.api.SearchFromMyStock;
    import com.k2rn.qiita.api.Stock;
    import com.k2rn.qiita.api.Unstock;
    import com.k2rn.qiita.api.UpdateItem;
    import com.k2rn.qiita.data.AuthData;
    import com.k2rn.qiita.data.ErrorData;
    import com.k2rn.qiita.data.ItemData;
    import com.k2rn.qiita.data.ItemTagData;
    import com.k2rn.qiita.data.ItemUserData;
    import com.k2rn.qiita.data.RateLimitData;
    import com.k2rn.qiita.data.TagInfoData;
    import com.k2rn.qiita.data.UserInfoData;
    import com.k2rn.qiita.events.APIErrorEvent;
    import com.k2rn.qiita.events.APIEvent;
    
    import flash.events.ErrorEvent;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.HTTPStatusEvent;
    import flash.events.IEventDispatcher;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLRequestHeader;
    
    import mx.utils.ObjectUtil;
    
    [Event (type="com.k2rn.qiita.events.APIEvent", name="authComplete")]
    [Event (type="com.k2rn.qiita.events.APIEvent", name="getFollowingTagComplete")]
    [Event (type="com.k2rn.qiita.events.APIEvent", name="getFollowingUserComplete")]
    [Event (type="com.k2rn.qiita.events.APIEvent", name="getMyItemListComplete")]
    [Event (type="com.k2rn.qiita.events.APIEvent", name="getMyStockListComplete")]
    [Event (type="com.k2rn.qiita.events.APIEvent", name="getNewlyItemListComplete")]
    [Event (type="com.k2rn.qiita.events.APIEvent", name="getRateLimitComplete")]
    [Event (type="com.k2rn.qiita.events.APIEvent", name="getTagItemListComplete")]
    [Event (type="com.k2rn.qiita.events.APIEvent", name="getTagListComplete")]
    [Event (type="com.k2rn.qiita.events.APIEvent", name="getUserInfoComplete")]
    [Event (type="com.k2rn.qiita.events.APIEvent", name="getUserItemListComplete")]
    [Event (type="com.k2rn.qiita.events.APIEvent", name="getUserStockListComplete")]
    [Event (type="com.k2rn.qiita.events.APIEvent", name="deleteItemComplete")]
    [Event (type="com.k2rn.qiita.events.APIEvent", name="postItemComplete")]
    [Event (type="com.k2rn.qiita.events.APIEvent", name="updateItemComplete")]
    [Event (type="com.k2rn.qiita.events.APIEvent", name="searchComplete")]
    [Event (type="com.k2rn.qiita.events.APIEvent", name="searchFromMyStockComplete")]
    [Event (type="com.k2rn.qiita.events.APIEvent", name="stockComplete")]
    [Event (type="com.k2rn.qiita.events.APIEvent", name="unstockComplete")]
    
    [Event (type="com.k2rn.qiita.events.APIErrorEvent", name="authFailed")]
    [Event (type="com.k2rn.qiita.events.APIErrorEvent", name="getFollowingTagFailed")]
    [Event (type="com.k2rn.qiita.events.APIErrorEvent", name="getFollowingUserFailed")]
    [Event (type="com.k2rn.qiita.events.APIErrorEvent", name="getMyItemListFailed")]
    [Event (type="com.k2rn.qiita.events.APIErrorEvent", name="getMyStockListFailed")]
    [Event (type="com.k2rn.qiita.events.APIErrorEvent", name="getNewlyItemListFailed")]
    [Event (type="com.k2rn.qiita.events.APIErrorEvent", name="getRateLimitFailed")]
    [Event (type="com.k2rn.qiita.events.APIErrorEvent", name="getTagItemListFailed")]
    [Event (type="com.k2rn.qiita.events.APIErrorEvent", name="getTagListFailed")]
    [Event (type="com.k2rn.qiita.events.APIErrorEvent", name="getUserInfoFailed")]
    [Event (type="com.k2rn.qiita.events.APIErrorEvent", name="getUserItemListFailed")]
    [Event (type="com.k2rn.qiita.events.APIErrorEvent", name="getUserStockListFailed")]
    [Event (type="com.k2rn.qiita.events.APIErrorEvent", name="deleteItemFailed")]
    [Event (type="com.k2rn.qiita.events.APIErrorEvent", name="postItemFailed")]
    [Event (type="com.k2rn.qiita.events.APIErrorEvent", name="updateItemFailed")]
    [Event (type="com.k2rn.qiita.events.APIErrorEvent", name="searchFailed")]
    [Event (type="com.k2rn.qiita.events.APIErrorEvent", name="searchFromMyStockFailed")]
    [Event (type="com.k2rn.qiita.events.APIErrorEvent", name="stockFailed")]
    [Event (type="com.k2rn.qiita.events.APIErrorEvent", name="unstockFailed")]
    
    /**
    * Qiita.as
    * 
    * <p>Qiita の API を利用するためのコアクラスです.</p>
    * 
    * @auther Takefumi Katsuren
    */
    public class Qiita extends EventDispatcher
    {
        //--------------------------------------------------------------------------
        //
        // Constants
        //
        //--------------------------------------------------------------------------
        private static const API_END_POINT:String       = "https://qiita.com/api/v1/";
        
        
        //--------------------------------------------------------------------------
        //
        // Properties
        //
        //--------------------------------------------------------------------------
        /**
        * <p>API のエンドポイントを設定します.</p>
        * <p>"/" で終了する必要があります.</p>
        * 
        * @default "https://qiita.com/api/v1/"
        */
        public function get endPoint():String
        {
            return _endPoint;
        }
        public function set endPoint(value:String):void
        {
            _endPoint = value;
        }
        private var _endPoint:String = API_END_POINT;
        
        
        //--------------------------------------------------------------------------
        //
        // Public methods
        //
        //--------------------------------------------------------------------------
        /**
        * コンストラクタ.
        */
        public function Qiita()
        {
            super(this);
        }
        
        public function auth(userId:String, password:String):void
        {
            var completeType:String = APIEvent.AUTH_COMPLETE;
            var errorType:String    = APIErrorEvent.AUTH_FAILED;
            
            var api:Auth    = new Auth(_endPoint);
            api.userId      = userId;
            api.password    = password;
            
            var createDataFunction:Function = function(headers:Array):void {
                var data:Object = JSON.parse(api.data);
                var authData:AuthData = new AuthData(data);
                // token が取得できなければエラー
                if (authData.token == null) {
                    parseFailed(APIErrorEvent.AUTH_FAILED, api.data);
                }
                else {
                    var event:APIEvent = new APIEvent(completeType, authData, api.data);
                    dispatchEvent(event);
                }
            };
            
            var destroy:Function = setupApi(api, createDataFunction, errorType);
            
            try {
	            api.send();
            }
            catch (err:Error) {
                trace("#", err.errorID, ":", err.message);
                trace(err.getStackTrace());
                destroy();
                throw new Error(err.message, ErrorID.UNKNOWN);
            }
        }
        
        public function getRateLimit(token:String=null):void
        {
            var completeType:String = APIEvent.GET_RATE_LIMIT_COMPLETE;
            var errorType:String    = APIErrorEvent.GET_RATE_LIMIT_FAILED;
            
            var api:GetRateLimit = new GetRateLimit(_endPoint);
            api.token = token;
            
            var createDataFunction:Function = function(headers:Array):void {
                var data:Object = JSON.parse(api.data);
                var rlData:RateLimitData = new RateLimitData(JSON.parse(api.data));
                var event:APIEvent = new APIEvent(completeType, rlData, api.data);
                dispatchEvent(event);
            };
            
            var destroy:Function = setupApi(api, createDataFunction, errorType);
            
            try {
	            api.send();
            }
            catch (err:Error) {
                trace("#", err.errorID, ":", err.message);
                trace(err.getStackTrace());
                destroy();
                throw new Error(err.message, ErrorID.UNKNOWN);
            }
        }
        
        public function getFollowingTag(userId:String, token:String=null, perPage:uint=20, page:uint=0):void
        {
            var completeType:String = APIEvent.GET_FOLLOWING_TAG_COMPLETE;
            var errorType:String    = APIErrorEvent.GET_FOLLOWING_TAG_FAILED;
            
            var api:GetFollowingTag = new GetFollowingTag(_endPoint);
            api.userId  = userId;
            api.token   = token;
            api.perPage = perPage;
            api.page    = page;
            
            var createDataFunction:Function = function(headers:Array):void {
                var data:Array = JSON.parse(api.data) as Array;
                var list:Vector.<TagInfoData> = new Vector.<TagInfoData>();
                var length:uint = data == null ? 0 : data.length;
                for (var i:int=0; i<length; i++) {
                    var obj:Object = data[i];
                    var tag:TagInfoData = new TagInfoData(obj);
                    list.push(tag);
                }
                var link:Object = extractLinkHeader(headers);
                var event:APIEvent = new APIEvent(completeType, list, api.data, link);
                dispatchEvent(event);
            };
            
            var destroy:Function = setupApi(api, createDataFunction, errorType);
            
            try {
                api.send();
            }
            catch (err:Error) {
                trace("#", err.errorID, ":", err.message);
                trace(err.getStackTrace());
                destroy();
                throw new Error(err.message, ErrorID.UNKNOWN);
            }
        }
        
        public function getFollowingUser(userId:String, token:String=null, perPage:uint=20, page:uint=0):void
        {
            var completeType:String = APIEvent.GET_FOLLOWING_USER_COMPLETE;
            var errorType:String    = APIErrorEvent.GET_FOLLOWING_USER_FAILED;
            
            var api:GetFollowingUser = new GetFollowingUser(_endPoint);
            api.userId  = userId;
            api.token   = token;
            api.perPage = perPage;
            api.page    = page;
            
            var createDataFunction:Function = function(headers:Array):void {
                var data:Array = JSON.parse(api.data) as Array;
                var list:Vector.<ItemUserData> = new Vector.<ItemUserData>();
                var length:uint = data == null ? 0 : data.length;
                for (var i:int=0; i<length; i++) {
                    var obj:Object = data[i];
                    var user:ItemUserData = new ItemUserData(obj);
                    list.push(user);
                }
                var link:Object = extractLinkHeader(headers);
                var event:APIEvent = new APIEvent(completeType, list, api.data, link);
                dispatchEvent(event);
            };
            
            var destroy:Function = setupApi(api, createDataFunction, errorType);
            
            try {
	            api.send();
            }
            catch (err:Error) {
                trace("#", err.errorID, ":", err.message);
                trace(err.getStackTrace());
                destroy();
                throw new Error(err.message, ErrorID.UNKNOWN);
            }
        }
        
        public function getMyItemList(token:String, perPage:uint=20, page:uint=0):void
        {
            var completeType:String = APIEvent.GET_MY_ITEM_LIST_COMPLETE;
            var errorType:String    = APIErrorEvent.GET_MY_ITEM_LIST_FAILED;
            
            var api:GetMyItemList = new GetMyItemList(_endPoint);
            api.token   = token;
            api.perPage = perPage;
            api.page    = page;
            
            var createDataFunction:Function = function(headers:Array):void {
                var data:Array = JSON.parse(api.data) as Array;
                var list:Vector.<ItemData> = new Vector.<ItemData>();
                var length:uint = data == null ? 0 : data.length;
                for (var i:int=0; i<length; i++) {
                    var obj:Object = data[i];
                    var item:ItemData = new ItemData(obj);
                    list.push(item);
                }
                var link:Object = extractLinkHeader(headers);
                var event:APIEvent = new APIEvent(completeType, list, api.data, link);
                dispatchEvent(event);
            };
            
            var destroy:Function = setupApi(api, createDataFunction, errorType);
            
            try {
	            api.send();
            }
            catch (err:Error) {
                trace("#", err.errorID, ":", err.message);
                trace(err.getStackTrace());
                destroy();
                throw new Error(err.message, ErrorID.UNKNOWN);
            }
        }
        
        public function getMyStockList(token:String, perPage:uint=20, page:uint=0):void
        {
            var completeType:String = APIEvent.GET_MY_STOCK_LIST_COMPLETE;
            var errorType:String    = APIErrorEvent.GET_MY_STOCK_LIST_FAILED;
            
            var api:GetMyStockList = new GetMyStockList(_endPoint);
            api.token   = token;
            api.perPage = perPage;
            api.page    = page;
            
            var createDataFunction:Function = function(headers:Array):void {
                var data:Array = JSON.parse(api.data) as Array;
                var list:Vector.<ItemData> = new Vector.<ItemData>();
                var length:uint = data == null ? 0 : data.length;
                for (var i:int=0; i<length; i++) {
                    var obj:Object = data[i];
                    var item:ItemData = new ItemData(obj);
                    list.push(item);
                }
                var link:Object = extractLinkHeader(headers);
                var event:APIEvent = new APIEvent(completeType, list, api.data, link);
                dispatchEvent(event);
            };
            
            var destroy:Function = setupApi(api, createDataFunction, errorType);
            
            try {
	            api.send();
            }
            catch (err:Error) {
                trace("#", err.errorID, ":", err.message);
                trace(err.getStackTrace());
                destroy();
                throw new Error(err.message, ErrorID.UNKNOWN);
            }
        }
        
        public function getNewlyItemList(token:String=null, perPage:uint=20, page:uint=0):void
        {
            var completeType:String = APIEvent.GET_NEWLY_ITEM_LIST_COMPLETE;
            var errorType:String    = APIErrorEvent.GET_NEWLY_ITEM_LIST_FAILED;
            
            var api:GetNewlyItemList = new GetNewlyItemList(_endPoint);
            api.token   = token;
            api.perPage = perPage;
            api.page    = page;
            
            var createDataFunction:Function = function(headers:Array):void {
                var data:Array = JSON.parse(api.data) as Array;
                var list:Vector.<ItemData> = new Vector.<ItemData>();
                var length:uint = data == null ? 0 : data.length;
                for (var i:int=0; i<length; i++) {
                    var obj:Object = data[i];
                    var item:ItemData = new ItemData(obj);
                    list.push(item);
                }
                var link:Object = extractLinkHeader(headers);
                var event:APIEvent = new APIEvent(completeType, list, api.data, link);
                dispatchEvent(event);
            };
            
            var destroy:Function = setupApi(api, createDataFunction, errorType);
            
            try {
	            api.send();
            }
            catch (err:Error) {
                trace("#", err.errorID, ":", err.message);
                trace(err.getStackTrace());
                destroy();
                throw new Error(err.message, ErrorID.UNKNOWN);
            }
        }
        
        public function getTagItemList(tagId:String, token:String=null, perPage:uint=20, page:uint=0):void
        {
            var completeType:String = APIEvent.GET_TAG_ITEM_LIST_COMPLETE;
            var errorType:String    = APIErrorEvent.GET_TAG_ITEM_LIST_FAILED;
            
            var api:GetTagItemList = new GetTagItemList(_endPoint);
            api.tagId   = tagId;
            api.token   = token;
            api.perPage = perPage;
            api.page    = page;
            
            var createDataFunction:Function = function(headers:Array):void {
                var data:Array = JSON.parse(api.data) as Array;
                var list:Vector.<ItemData> = new Vector.<ItemData>();
                var length:uint = data == null ? 0 : data.length;
                for (var i:int=0; i<length; i++) {
                    var obj:Object = data[i];
                    var item:ItemData = new ItemData(obj);
                    list.push(item);
                }
                var link:Object = extractLinkHeader(headers);
                var event:APIEvent = new APIEvent(completeType, list, api.data, link);
                dispatchEvent(event);
            };
            
            var destroy:Function = setupApi(api, createDataFunction, errorType);
            
            try {
	            api.send();
            }
            catch (err:Error) {
                trace("#", err.errorID, ":", err.message);
                trace(err.getStackTrace());
                destroy();
                throw new Error(err.message, ErrorID.UNKNOWN);
            }
        }
        
        public function getTagList(token:String=null, perPage:uint=20, page:uint=0):void
        {
            var completeType:String = APIEvent.GET_TAG_LIST_COMPLETE;
            var errorType:String    = APIErrorEvent.GET_TAG_LIST_FAILED;
            
            var api:GetTagList = new GetTagList(_endPoint);
            api.token   = token;
            api.perPage = perPage;
            api.page    = page;
            
            var createDataFunction:Function = function(headers:Array):void {
                var data:Array = JSON.parse(api.data) as Array;
                var list:Vector.<TagInfoData> = new Vector.<TagInfoData>();
                var length:uint = data == null ? 0 : data.length;
                for (var i:int=0; i<length; i++) {
                    var obj:Object = data[i];
                    var item:TagInfoData = new TagInfoData(obj);
                    list.push(item);
                }
                var link:Object = extractLinkHeader(headers);
                var event:APIEvent = new APIEvent(completeType, list, api.data, link);
                dispatchEvent(event);
            };
            
            var destroy:Function = setupApi(api, createDataFunction, errorType);
            
            try {
	            api.send();
            }
            catch (err:Error) {
                trace("#", err.errorID, ":", err.message);
                trace(err.getStackTrace());
                destroy();
                throw new Error(err.message, ErrorID.UNKNOWN);
            }
        }
        
        public function getUserInfo(userId:String, token:String=null):void
        {
            var completeType:String = APIEvent.GET_USER_INFO_COMPLETE;
            var errorType:String    = APIErrorEvent.GET_USER_INFO_FAILED;
            
            var api:GetUserInfo = new GetUserInfo(_endPoint);
            api.userId  = userId;
            api.token   = token;
            
            var createDataFunction:Function = function(headers:Array):void {
                var data:Object = JSON.parse(api.data);
                var info:UserInfoData = new UserInfoData(data);
                var event:APIEvent = new APIEvent(completeType, info, api.data);
                dispatchEvent(event);
            };
            
            var destroy:Function = setupApi(api, createDataFunction, errorType);
            
            try {
	            api.send();
            }
            catch (err:Error) {
                trace("#", err.errorID, ":", err.message);
                trace(err.getStackTrace());
                destroy();
                throw new Error(err.message, ErrorID.UNKNOWN);
            }
        }
        
        public function getUserItemList(userId:String, token:String=null, perPage:uint=20, page:uint=0):void
        {
            var completeType:String = APIEvent.GET_USER_ITEM_LIST_COMPLETE;
            var errorType:String    = APIErrorEvent.GET_USER_ITEM_LIST_FAILED;
            
            var api:GetUserItemList = new GetUserItemList(_endPoint);
            api.userId  = userId;
            api.token   = token;
            api.perPage = perPage;
            api.page    = page;
            
            var createDataFunction:Function = function(headers:Array):void {
                var data:Array = JSON.parse(api.data) as Array;
                var list:Vector.<ItemData> = new Vector.<ItemData>();
                var length:uint = data == null ? 0 : data.length;
                for (var i:int=0; i<length; i++) {
                    var obj:Object = data[i];
                    var item:ItemData = new ItemData(obj);
                    list.push(item);
                }
                var link:Object = extractLinkHeader(headers);
                var event:APIEvent = new APIEvent(completeType, list, api.data, link);
                dispatchEvent(event);
            };
            
            var destroy:Function = setupApi(api, createDataFunction, errorType);
            
            try {
	            api.send();
            }
            catch (err:Error) {
                trace("#", err.errorID, ":", err.message);
                trace(err.getStackTrace());
                destroy();
                throw new Error(err.message, ErrorID.UNKNOWN);
            }
        }
        
        public function getUserStockList(userId:String, token:String=null, perPage:uint=20, page:uint=0):void
        {
            var completeType:String = APIEvent.GET_USER_STOCK_LIST_COMPLETE;
            var errorType:String    = APIErrorEvent.GET_USER_STOCK_LIST_FAILED;
            
            var api:GetUserStockList = new GetUserStockList(_endPoint);
            api.userId  = userId;
            api.token   = token;
            api.perPage = perPage;
            api.page    = page;
            
            var createDataFunction:Function = function(headers:Array):void {
                var data:Array = JSON.parse(api.data) as Array;
                var list:Vector.<ItemData> = new Vector.<ItemData>();
                var length:uint = data == null ? 0 : data.length;
                for (var i:int=0; i<length; i++) {
                    var obj:Object = data[i];
                    var item:ItemData = new ItemData(obj);
                    list.push(item);
                }
                var link:Object = extractLinkHeader(headers);
                var event:APIEvent = new APIEvent(completeType, list, api.data, link);
                dispatchEvent(event);
            };
            
            var destroy:Function = setupApi(api, createDataFunction, errorType);
            
            try {
	            api.send();
            }
            catch (err:Error) {
                trace("#", err.errorID, ":", err.message);
                trace(err.getStackTrace());
                destroy();
                throw new Error(err.message, ErrorID.UNKNOWN);
            }
        }
        
        public function search(query:Vector.<String>, token:String=null, perPage:uint=20, page:uint=0):void
        {
            var completeType:String = APIEvent.SEARCH_COMPLETE;
            var errorType:String    = APIErrorEvent.SEARCH_FAILED;
            
            var api:Search = new Search(_endPoint);
            api.token   = token;
            api.query   = query;
            api.perPage = perPage;
            api.page    = page;
            
            var createDataFunction:Function = function(headers:Array):void {
                var data:Array = JSON.parse(api.data) as Array;
                var list:Vector.<ItemData> = new Vector.<ItemData>();
                var length:uint = data == null ? 0 : data.length;
                for (var i:int=0; i<length; i++) {
                    var obj:Object = data[i];
                    var item:ItemData = new ItemData(obj);
                    list.push(item);
                }
                var link:Object = extractLinkHeader(headers);
                var event:APIEvent = new APIEvent(completeType, list, api.data, link);
                dispatchEvent(event);
            };
            
            var destroy:Function = setupApi(api, createDataFunction, errorType);
            
            try {
	            api.send();
            }
            catch (err:Error) {
                trace("#", err.errorID, ":", err.message);
                trace(err.getStackTrace());
                destroy();
                throw new Error(err.message, ErrorID.UNKNOWN);
            }
        }
        
        public function searchFromMyStock(query:Vector.<String>, token:String, perPage:uint=20, page:uint=0):void
        {
            var completeType:String = APIEvent.SEARCH_FROM_MY_STOCK_COMPLETE;
            var errorType:String    = APIErrorEvent.SEARCH_FROM_MY_STOCK_FAILED;
            
            var api:SearchFromMyStock = new SearchFromMyStock(_endPoint);
            api.token   = token;
            api.query   = query;
            api.perPage = perPage;
            api.page    = page;
            
            var createDataFunction:Function = function(headers:Array):void {
                var data:Array = JSON.parse(api.data) as Array;
                var list:Vector.<ItemData> = new Vector.<ItemData>();
                var length:uint = data == null ? 0 : data.length;
                for (var i:int=0; i<length; i++) {
                    var obj:Object = data[i];
                    var item:ItemData = new ItemData(obj);
                    list.push(item);
                }
                var link:Object = extractLinkHeader(headers);
                var event:APIEvent = new APIEvent(completeType, list, api.data, link);
                dispatchEvent(event);
            };
            
            var destroy:Function = setupApi(api, createDataFunction, errorType);
            
            try {
                api.send();
            }
            catch (err:Error) {
                trace("#", err.errorID, ":", err.message);
                trace(err.getStackTrace());
                destroy();
                throw new Error(err.message, ErrorID.UNKNOWN);
            }
        }
        
        public function deleteItem(uuid:String, token:String):void
        {
            var completeType:String = APIEvent.DELETE_ITEM_COMPLETE;
            var errorType:String    = APIErrorEvent.DELETE_ITEM_FAILED;
            
            var api:DeleteItem = new DeleteItem(_endPoint);
            api.uuid    = uuid;
            api.token   = token;
            
            var createDataFunction:Function = function(headers:Array):void {
                var event:APIEvent = new APIEvent(completeType, null, api.data);
                dispatchEvent(event);
            };
            
            var destroy:Function = setupApi(api, createDataFunction, errorType);
            
            try {
                api.send();
            }
            catch (err:Error) {
                trace("#", err.errorID, ":", err.message);
                trace(err.getStackTrace());
                destroy();
                throw new Error(err.message, ErrorID.UNKNOWN);
            }
        }
        
        public function postItem(token:String, title:String, body:String, tags:Vector.<ItemTagData>,
                                 isPrivate:Boolean=true, gist:Boolean=false, tweet:Boolean=false):void
        {
            var completeType:String = APIEvent.POST_ITEM_COMPLETE;
            var errorType:String    = APIErrorEvent.POST_ITEM_FAILED;
            
            var api:PostItem = new PostItem(_endPoint);
            api.token       = token;
            api.title       = title;
            api.body        = body;
            api.tags        = tags;
            api.isPrivate   = isPrivate;
            api.gist        = gist;
            api.tweet       = tweet;
            
            var createDataFunction:Function = function(headers:Array):void {
                var event:APIEvent = new APIEvent(completeType, null, api.data);
                dispatchEvent(event);
            };
            
            var destroy:Function = setupApi(api, createDataFunction, errorType, HttpStatusCode.NO_CONTENT);
            
            try {
                api.send();
            }
            catch (err:Error) {
                trace("#", err.errorID, ":", err.message);
                trace(err.getStackTrace());
                destroy();
                throw new Error(err.message, ErrorID.UNKNOWN);
            }
        }
        
        public function updateItem(token:String, title:String, body:String, tags:Vector.<ItemTagData>, isPrivate:Boolean=false):void
        {
            var completeType:String = APIEvent.UPDATE_ITEM_COMPLETE;
            var errorType:String    = APIErrorEvent.UPDATE_ITEM_FAILED;
            
            var api:UpdateItem = new UpdateItem(_endPoint);
            api.token       = token;
            api.title       = title;
            api.body        = body;
            api.tags        = tags;
            api.isPrivate   = isPrivate;
            
            var createDataFunction:Function = function(headers:Array):void {
                var event:APIEvent = new APIEvent(completeType, null, api.data);
                dispatchEvent(event);
            };
            
            var destroy:Function = setupApi(api, createDataFunction, errorType, HttpStatusCode.NO_CONTENT);
            
            try {
                api.send();
            }
            catch (err:Error) {
                trace("#", err.errorID, ":", err.message);
                trace(err.getStackTrace());
                destroy();
                throw new Error(err.message, ErrorID.UNKNOWN);
            }
        }
        
        public function stock(uuid:String, token:String):void
        {
            var completeType:String = APIEvent.STOCK_COMPLETE;
            var errorType:String    = APIErrorEvent.STOCK_FAILED;
            
            var api:Stock = new Stock(_endPoint);
            api.token       = token;
            api.uuid        = uuid;
            
            var createDataFunction:Function = function(headers:Array):void {
                var event:APIEvent = new APIEvent(completeType, null, api.data);
                dispatchEvent(event);
            };
            
            var destroy:Function = setupApi(api, createDataFunction, errorType, HttpStatusCode.NO_CONTENT);
            
            try {
                api.send();
            }
            catch (err:Error) {
                trace("#", err.errorID, ":", err.message);
                trace(err.getStackTrace());
                destroy();
                throw new Error(err.message, ErrorID.UNKNOWN);
            }
        }
        
        public function unstock(uuid:String, token:String):void
        {
            var completeType:String = APIEvent.UNSTOCK_COMPLETE;
            var errorType:String    = APIErrorEvent.UNSTOCK_FAILED;
            
            var api:Unstock = new Unstock(_endPoint);
            api.token       = token;
            api.uuid        = uuid;
            
            var createDataFunction:Function = function(headers:Array):void {
                var event:APIEvent = new APIEvent(completeType, null, api.data);
                dispatchEvent(event);
            };
            
            var destroy:Function = setupApi(api, createDataFunction, errorType, HttpStatusCode.NO_CONTENT);
            
            try {
                api.send();
            }
            catch (err:Error) {
                trace("#", err.errorID, ":", err.message);
                trace(err.getStackTrace());
                destroy();
                throw new Error(err.message, ErrorID.UNKNOWN);
            }
        }
        
        
        //--------------------------------------------------------------------------
        //
        // Private methods
        //
        //--------------------------------------------------------------------------
        private function setupApi(api:AbstractAPI, createDataFunction:Function, errorType:String, okStatus:int=HttpStatusCode.OK):Function
        {
            var callback:Function = function(status:int, headers:Array):void {
                // HTTP ステータスコードが OK
                if (status == okStatus) {
                    createDataFunction(headers);
                }
                // Qiita API doc で定義されている エラーステータスコードの場合
                else if (status == HttpStatusCode.BAD_REQUEST ||
	                    status == HttpStatusCode.FORBIDDEN ||
	                    status == HttpStatusCode.NOT_FOUND) {
                    errorStatusCode(errorType, api);
                }
                // それ以外のレスポンス HTTP ステータスコード（5xx系など）
                else {
                    unknownStatusCode(errorType, api);
                }
            };
            
            var errorCallback:Function = function(e:ErrorEvent):void {
                var eData:ErrorData = new ErrorData({error:e.text});
                dispatchErrorEvent(errorType, eData, e.errorID);
            };
            
            var destroy:Function = setHandlers(api, callback, errorCallback);
            
            return destroy;
        }
        
        private function setHandlers(api:AbstractAPI, callback:Function, errorCallback:Function):Function
        {
            var status:int = 0;
            var headers:Array = null;
            var statusHandler:Function = function(e:HTTPStatusEvent):void {
                status = e.status;
                headers = e.responseHeaders;
            }
            var completeHandler:Function = function(e:Event):void {
                callback(status, headers);
                destroy();
            };
            var ioErrorHandler:Function = function(e:IOErrorEvent):void {
                errorCallback(e);
                destroy();
            };
            var securityErrorHandler:Function = function(e:SecurityErrorEvent):void {
                errorCallback(e);
                destroy();
            };
            var destroy:Function = function():void {
                api.removeEventListener(Event.COMPLETE, completeHandler);
                api.removeEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, statusHandler);
                api.removeEventListener(HTTPStatusEvent.HTTP_STATUS, statusHandler);
                api.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
                api.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
                api.destroy();
                api = null;
                
                statusHandler           = null;
                completeHandler         = null;
                ioErrorHandler          = null;
                securityErrorHandler    = null;
                destroy                 = null;
            };
            
            api.addEventListener(Event.COMPLETE, completeHandler);
            api.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, statusHandler);
            api.addEventListener(HTTPStatusEvent.HTTP_STATUS, statusHandler);
            api.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            api.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            
            return destroy;
        }
        
        private function dispatchErrorEvent(type:String, data:ErrorData, errorId:int=0):void
        {
            var e:APIErrorEvent = new APIErrorEvent(type, data, false, false, errorId);
            dispatchEvent(e);
        }
        
        private function parseFailed(eventType:String, rawData:Object=null):void
        {
            var data:ErrorData = new ErrorData({error:"Connot read response object.", rawData:rawData});
            dispatchErrorEvent(eventType, data, ErrorID.INVALID_JSON_FORMAT);
        }
        
        private function errorStatusCode(eventType:String, api:AbstractAPI):void
        {
            var eData:ErrorData;
            try {
	            eData = new ErrorData(JSON.parse(api.data));
            }
            catch (err:Error) {
                trace("#", err.errorID, ":", err.message);
                trace(err.getStackTrace());
                parseFailed(eventType, api.data);
            }
            // エラー文字列が取得できてなければパースエラー
            if (eData.error == null) {
                parseFailed(eventType, api.data);
            }
            else {
                dispatchErrorEvent(eventType, eData);
            }
        }
        
        private function unknownStatusCode(eventType:String, api:AbstractAPI):void
        {
            var eData:ErrorData = new ErrorData({error:"Unknown status code.", rawData:api.data});
            dispatchErrorEvent(eventType, eData);
        }
        
        private function extractLinkHeader(headers:Array):Object
        {
            if (headers == null || headers.length == 0) {
                return null;
            }
            
            var linkHeader:URLRequestHeader = null;
            for (var i:int=0; i<headers.length; i++) {
                var h:* = headers[i];
                if (h is URLRequestHeader) {
                    var _h:URLRequestHeader = h as URLRequestHeader;
                    if (_h.name.toLowerCase() == "link") {
                        linkHeader = _h;
                        break;
                    }
                }
            }
            if (linkHeader == null) {
                return null;
            }
            
            var value:String = linkHeader.value;
            var strList:Array = value.split(", ");
            var hashList:Object = new Object();
            for (var i:int=0; i<strList.length; i++) {
                var str:String = strList[i];
                var rels:Array = /rel="\w+"/.exec(str);
                if (rels == null || rels.length == 0) continue;
                var rel:String = (rels[0] as String).substring(5, rels[0].length - 1);
                // TODO: エラー処理
                var pageStr:String = /page=\d+/.exec(str)[0].substr(5);
                var perPageStr:String = /per_page=\d+/.exec(str)[0].substr(9);
                hashList[rel] = {page:pageStr, perPage:perPageStr};
            }
            
            return hashList;
        }
    }
}