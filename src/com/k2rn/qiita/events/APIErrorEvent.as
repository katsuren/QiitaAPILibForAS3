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
package com.k2rn.qiita.events
{
    import com.k2rn.qiita.data.ErrorData;
    
    import flash.events.ErrorEvent;
    import flash.events.Event;
    
    /**
     * APIErrorEvent.as
     * 
     * <p>レスポンスにエラーがある場合に発行されるイベントです.</p>
     * 
     * @auther Takefumi Katsuren
     */
    public class APIErrorEvent extends ErrorEvent
    {
        //--------------------------------------------------------------------------
        //
        // Constants
        //
        //--------------------------------------------------------------------------
        public static const AUTH_FAILED:String                      = "authFailed";
        
        public static const GET_FOLLOWING_USER_FAILED:String        = "getFollowingUserFailed";
        public static const GET_FOLLOWING_TAG_FAILED:String         = "getFollowingTagFailed";
        public static const GET_MY_ITEM_LIST_FAILED:String          = "getMyItemListFailed";
        public static const GET_MY_STOCK_LIST_FAILED:String         = "getMyStockListFailed";
        public static const GET_NEWLY_ITEM_LIST_FAILED:String       = "getNewlyItemListFailed";
        public static const GET_RATE_LIMIT_FAILED:String            = "getRateLimitFailed";
        public static const GET_TAG_ITEM_LIST_FAILED:String         = "getTagItemListFailed";
        public static const GET_TAG_LIST_FAILED:String              = "getTagListFailed";
        public static const GET_USER_INFO_FAILED:String             = "getUserInfoFailed";
        public static const GET_USER_ITEM_LIST_FAILED:String        = "getUserItemListFailed";
        public static const GET_USER_STOCK_LIST_FAILED:String       = "getUserStockListFailed";
        public static const SEARCH_FAILED:String                    = "searchFailed";
        public static const SEARCH_FROM_MY_STOCK_FAILED:String      = "searchFromMyStockFailed";
        
        public static const DELETE_ITEM_FAILED:String               = "deleteItemFailed";
        public static const POST_ITEM_FAILED:String                 = "postItemFailed";
        public static const UPDATE_ITEM_FAILED:String               = "updateItemFailed";
        
        public static const STOCK_FAILED:String                     = "stockFailed";
        public static const UNSTOCK_FAILED:String                   = "unstockFailed";
        
        
        //--------------------------------------------------------------------------
        //
        // Properties
        //
        //--------------------------------------------------------------------------
        public var data:ErrorData = null;
        
        
        //--------------------------------------------------------------------------
        //
        // Public methods
        //
        //--------------------------------------------------------------------------
        public function APIErrorEvent(type:String, data:ErrorData, bubbles:Boolean=false, cancelable:Boolean=false, id:int=0)
        {
            super(type, bubbles, cancelable, data.error, id);
            
            this.data = data;
        }
        
        override public function clone():Event
        {
            var e:APIErrorEvent = new APIErrorEvent(type, data, bubbles, cancelable, errorID);
            return e;
        }
    }
}