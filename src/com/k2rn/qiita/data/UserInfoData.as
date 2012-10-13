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
     * UserInfoData.as
     * 
     * <p>ユーザー情報をまとめたクラスです.</p>
     * 
     * @auther Takefumi Katsuren
     */
    public dynamic class UserInfoData
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
        
        /**
        * <p>Qiita のユーザーURLです.</p>
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
        * <p>ユーザーの紹介文です.</p>
        */
        public function get description():String
        {
            return _description;
        }
        public function set description(value:String):void
        {
            _description = value;
        }
        private var _description:String = null;
        
        /**
        * <p>ユーザーのWEBサイトURLです.</p>
        */
        public function get website_url():String
        {
            return _websiteUrl;
        }
        public function set website_url(value:String):void
        {
            _websiteUrl = value;
        }
        private var _websiteUrl:String = null;
        
        /**
        * <p>ユーザーの所属組織です.</p>
        */
        public function get organization():String
        {
            return _organization;
        }
        public function set organization(value:String):void
        {
            _organization = value;
        }
        private var _organization:String = null;
        
        /**
        * <p>ユーザーの地域です.</p>
        */
        public function get location():String
        {
            return _location;
        }
        public function set location(value:String):void
        {
            _location = value;
        }
        private var _location:String = null;
        
        /**
        * <p>ユーザーのFacebookアカウントです.</p>
        */
        public function get facebook():String
        {
            return _facebook;
        }
        public function set facebook(value:String):void
        {
            _facebook = value;
        }
        private var _facebook:String = null;
        
        /**
        * <p>ユーザーのLinkedInアカウントです.</p>
        */
        public function get linkedin():String
        {
            return _linkedin;
        }
        public function set linkedin(value:String):void
        {
            _linkedin = value;
        }
        private var _linkedin:String = null;
        
        /**
        * <p>ユーザーのツイッターアカウントです.</p>
        */
        public function get twitter():String
        {
            return _twitter;
        }
        public function set twitter(value:String):void
        {
            _twitter = value;
        }
        private var _twitter:String = null;
        
        /**
        * <p>ユーザーのgithubアカウントです.</p>
        */
        public function get github():String
        {
            return _github;
        }
        public function set github(value:String):void
        {
            _github = value;
        }
        private var _github:String = null;
        
        /**
        * <p>ユーザーのフォロワーの数です.</p>
        */
        public function get followers():int
        {
            return _followers;
        }
        public function set followers(value:int):void
        {
            _followers = value;
        }
        private var _followers:int = 0;
        
        /**
        * <p>ユーザーがフォローしているユーザーの数です.</p>
        */
        public function get following_users():int
        {
            return _followingUsers;
        }
        public function set followingUsers(value:int):void
        {
            _followingUsers = value;
        }
        private var _followingUsers:int = 0;
        
        /**
        * <p>ユーザーが投稿した記事の数です.</p>
        */
        public function get items():int
        {
            return _items;
        }
        public function set items(value:int):void
        {
            _items = value;
        }
        private var _items:int = 0;
        
        
        //--------------------------------------------------------------------------
        //
        // Public methods
        //
        //--------------------------------------------------------------------------
        /**
         * <p>コンストラクタ.</p>
         * @param seed <p>ユーザー情報のオブジェクトです. このオブジェクトのプロパティから初期情報を設定することができます.</p>
         */
        public function UserInfoData(seed:Object=null)
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