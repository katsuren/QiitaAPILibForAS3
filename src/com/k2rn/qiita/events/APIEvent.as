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
    import flash.events.Event;
    
    /**
     * APIEvent.as
     * 
     * <p>通信が完了したときに発行されるイベントです.</p>
     * 
     * @auther Takefumi Katsuren
     */
    public class APIEvent extends Event
    {
        //--------------------------------------------------------------------------
        //
        // Constants
        //
        //--------------------------------------------------------------------------
        public static const AUTH_COMPLETE:String                    = "authComplete";
        
        public static const GET_FOLLOWING_USER_COMPLETE:String      = "getFollowingUserComplete";
        public static const GET_FOLLOWING_TAG_COMPLETE:String       = "getFollowingTagComplete";
        public static const GET_MY_ITEM_LIST_COMPLETE:String        = "getMyItemListComplete";
        public static const GET_MY_STOCK_LIST_COMPLETE:String       = "getMyStockListComplete";
        public static const GET_NEWLY_ITEM_LIST_COMPLETE:String     = "getNewlyItemListComplete";
        public static const GET_RATE_LIMIT_COMPLETE:String          = "getRateLimitComplete";
        public static const GET_TAG_ITEM_LIST_COMPLETE:String       = "getTagItemListComplete";
        public static const GET_TAG_LIST_COMPLETE:String            = "getTagListComplete";
        public static const GET_USER_INFO_COMPLETE:String           = "getUserInfoComplete";
        public static const GET_USER_ITEM_LIST_COMPLETE:String      = "getUserItemListComplete";
        public static const GET_USER_STOCK_LIST_COMPLETE:String     = "getUserStockListComplete";
        public static const SEARCH_COMPLETE:String                  = "searchComplete";
        public static const SEARCH_FROM_MY_STOCK_COMPLETE:String    = "searchFromMyStockComplete";
        
        public static const DELETE_ITEM_COMPLETE:String             = "deleteItemComplete";
        public static const POST_ITEM_COMPLETE:String               = "postItemComplete";
        public static const UPDATE_ITEM_COMPLETE:String             = "updateItemComplete";
        
        public static const STOCK_COMPLETE:String                   = "stockComplete";
        public static const UNSTOCK_COMPLETE:String                 = "unstockComplete";
        
        
        //--------------------------------------------------------------------------
        //
        // Properties
        //
        //--------------------------------------------------------------------------
        public var data:*;
        public var response:String;
        public var link:Object;
        
        
        //--------------------------------------------------------------------------
        //
        // Public methods
        //
        //--------------------------------------------------------------------------
        public function APIEvent(type:String, data:*, response:String, link:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);
            
            this.data = data;
            this.response = response;
            this.link = link;
        }
        
        override public function clone():Event
        {
            var e:APIEvent = new APIEvent(type, data, response, bubbles, cancelable);
            return e;
        }
    }
}