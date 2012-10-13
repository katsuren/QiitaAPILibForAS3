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
package flexUnitTests.com.k2rn.qiita.api
{
    import com.k2rn.qiita.ErrorID;
    import com.k2rn.qiita.api.Auth;
    
    import flash.events.Event;
    import flash.events.HTTPStatusEvent;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.system.Capabilities;
    
    import flexUnitTests.com.k2rn.qiita.Config;
    import flexUnitTests.com.k2rn.qiita.helper.TestHelper;
    
    import flexunit.framework.Assert;
    
    import org.flexunit.async.Async;
    
    public class AuthTest
    {		
        [Before]
        public function setUp():void
        {
        }
        
        [After]
        public function tearDown():void
        {
        }
        
        [BeforeClass]
        public static function setUpBeforeClass():void
        {
        }
        
        [AfterClass]
        public static function tearDownAfterClass():void
        {
        }
        
        /**
        * <p>通常リクエストをテストをします.</p>
        * <p>テストする場合は、テストアカウントの設定を行ってください.</p>
        * <p>設定は flexUnitTexts.com.k2rn.Config に記述します.</p>
        */
        [Test(async)]
        public function testSend():void
        {
            var auth:Auth   = new Auth(TestHelper.API_END_POINT);
            auth.userId     = Config.userId;
            auth.password   = Config.password;
            
            var timeout:int = 10000;
            var responseHandler:Function = function(e:Event, passThroughObject:Object):void {
                Assert.assertNotNull("通信に成功したらデータが取得できる。", auth.data);
            };
            var timeoutHandler:Function = function():void {
                Assert.fail("通信がタイムアウトしました。");
            };
            Async.handleEvent(this, auth, Event.COMPLETE, responseHandler, timeout, null, timeoutHandler);
            auth.send();
        }
        
        /**
         * <p>リクエスト時の例外発生をテストします.</p>
         */
        [Test]
        public function testSendException():void
        {
            var auth:Auth = new Auth(TestHelper.API_END_POINT);
            
            // userId 未設定での例外テスト
            try {
                auth.send();
                Assert.fail(
                    "userId 未設定のままでも例外が発生していません。\n" +
                    "userId 未設定の場合は例外が発生すべきです。");
            }
            catch (err:Error) {
                Assert.assertEquals("userId 未設定のままリクエストすると例外が発生する",
                    err.errorID, ErrorID.MISSING_USER_ID);
            }
            auth.userId = "qiitatest";
            
            // password 未設定での例外テスト
            try {
                auth.send();
                Assert.fail(
                    "password 未設定のままでも例外が発生していません。\n" +
                    "password 未設定の場合は例外が発生すべきです。");
            }
            catch (err:Error) {
                Assert.assertEquals("password 未設定のままリクエストすると例外が発生する",
                    err.errorID, ErrorID.MISSING_PASSWORD);
            }
            
            // destroy の後はsendできない
            auth.destroy();
            try {
                auth.send();
                Assert.fail("destroy 後に send しても例外が発生していません。");
            }
            catch (err:Error) {
                Assert.assertEquals("destroy 後にリクエストすると例外が発生する",
                    err.errorID, ErrorID.DESTROYED_ALREADY);
            }
        }
        
        /**
        * <p>エンドポイントと疎通できない場合をテストします.</p>
        */
        [Test(async)]
        public function testSendInvalidEndPoint():void
        {
            var auth:Auth   = new Auth("http://some.invalid.end.point/");
            auth.userId     = Config.userId;
            auth.password   = "someInvalidPassword";
            
            var responseHandler:Function = function(e:IOErrorEvent, passThroughObject:Object=null):void {
                Assert.assertEquals("不正なURLの場合は IOError が送出される。",
                    e.type, IOErrorEvent.IO_ERROR);
            };
            var timeoutHandler:Function = function():void {
                Assert.fail("通信がタイムアウトしました。");
            };
            Async.handleEvent(this, auth, IOErrorEvent.IO_ERROR, responseHandler, 500, null, timeoutHandler);
            Async.failOnEvent(this, auth, Event.COMPLETE);
            auth.send();
        }
        
        /**
        * <p>不正な password でリクエストした場合をテストします.</p>
        */
        [Test(async)]
        public function testSendInvalidPassword():void
        {
            var auth:Auth   = new Auth(TestHelper.API_END_POINT);
            auth.userId     = Config.userId;
            auth.password   = "someInvalidPassword";
            
            var timeout:int = 10000;
            var responseHandler:Function = function(e:Event, passThroughObject:Object=null):void {
                Assert.assertEquals("不正なパスワードの場合は通信は成功し、エラーメッセージが返ってくる。",
                    auth.data, "{\"error\":\"url_name and password don't match.\"}");
            };
            var timeoutHandler:Function = function():void {
                Assert.fail("通信がタイムアウトしました。");
            };
            Async.handleEvent(this, auth, Event.COMPLETE, responseHandler, timeout, null, timeoutHandler);
            auth.send();
        }
        
        /**
        * <p>不正な password でリクエストした場合のHTTPステータスコードをテストします.</p>
        */
        [Test(async)]
        public function testSendInvalidPasswordHttpStatus():void
        {
            var auth:Auth   = new Auth(TestHelper.API_END_POINT);
            auth.userId     = Config.userId;
            auth.password   = "someInvalidPassword";
            
            var timeout:int = 10000;
            var httpStatusHandler:Function = function(e:HTTPStatusEvent, passThroughObject:Object=null):void {
                Assert.assertEquals("不正なパスワードでリクエストをした場合はステータスコード 400 が返る。", e.status, 400);
            }
            var timeoutHandler:Function = function():void {
                Assert.fail("通信がタイムアウトしました。");
            };
            if (Capabilities.playerType.toLowerCase() == "plugin" || Capabilities.playerType.toLowerCase() == "activex") {
	            Async.handleEvent(this, auth, HTTPStatusEvent.HTTP_STATUS, httpStatusHandler, timeout, null, timeoutHandler);
            }
            else {
	            Async.handleEvent(this, auth, HTTPStatusEvent.HTTP_RESPONSE_STATUS, httpStatusHandler, timeout, null, timeoutHandler);
            }
            auth.send();
        }
        
        /**
        * <p>UserId を入力せずにリクエストした場合をテストします.</p>
        */
        [Test(async)]
        public function testSendEmptyUserId():void
        {
            var auth:Auth   = new Auth(TestHelper.API_END_POINT);
            auth.userId     = "";
            auth.password   = Config.password;
            
            var timeout:int = 10000;
            var responseHandler:Function = function(e:Event, passThroughObject:Object=null):void {
                Assert.assertEquals("UserIdが空の場合は通信は成功し、エラーメッセージが返ってくる。",
                    auth.data, "{\"error\":\"Required key 'url_name' is missing.\"}");
            };
            var timeoutHandler:Function = function():void {
                Assert.fail("通信がタイムアウトしました。");
            };
            Async.handleEvent(this, auth, Event.COMPLETE, responseHandler, timeout, null, timeoutHandler);
            auth.send();
        }
        
        /**
        * <p>UserId を入力せずにリクエストした場合のHTTPステータスをテストします.</p>
        */
        [Test(async)]
        public function testSendEmptyUserIdHttpStatus():void
        {
            var auth:Auth   = new Auth(TestHelper.API_END_POINT);
            auth.userId     = "";
            auth.password   = Config.password;
            
            var timeout:int = 10000;
            var httpStatusHandler:Function = function(e:HTTPStatusEvent, passThroughObject:Object=null):void {
                Assert.assertEquals("UserIdを空でリクエストをした場合はステータスコード 400 が返る。", e.status, 400);
            }
            var timeoutHandler:Function = function():void {
                Assert.fail("通信がタイムアウトしました。");
            };
            if (Capabilities.playerType.toLowerCase() == "plugin" || Capabilities.playerType.toLowerCase() == "activex") {
	            Async.handleEvent(this, auth, HTTPStatusEvent.HTTP_STATUS, httpStatusHandler, timeout, null, timeoutHandler);
            }
            else {
	            Async.handleEvent(this, auth, HTTPStatusEvent.HTTP_RESPONSE_STATUS, httpStatusHandler, timeout, null, timeoutHandler);
            }
            auth.send();
        }
        
        /**
        * <p>Password を入力せずにリクエストした場合をテストします.</p>
        */
        [Test(async)]
        public function testSendEmptyPassword():void
        {
            var auth:Auth   = new Auth(TestHelper.API_END_POINT);
            auth.userId     = Config.userId;
            auth.password   = "";
            
            var timeout:int = 10000;
            var responseHandler:Function = function(e:Event, passThroughObject:Object=null):void {
                Assert.assertEquals("Passwordが空の場合は通信は成功し、エラーメッセージが返ってくる。",
                    auth.data, "{\"error\":\"Required key 'password' is missing.\"}");
            };
            var timeoutHandler:Function = function():void {
                Assert.fail("通信がタイムアウトしました。");
            };
            Async.handleEvent(this, auth, Event.COMPLETE, responseHandler, timeout, null, timeoutHandler);
            auth.send();
        }
        
        /**
        * <p>Password を入力せずにリクエストした場合のHTTPステータスをテストします.</p>
        */
        [Test(async)]
        public function testSendEmptyPasswordHttpStatus():void
        {
            var auth:Auth   = new Auth(TestHelper.API_END_POINT);
            auth.userId     = Config.userId;
            auth.password   = "";
            
            var timeout:int = 10000;
            var httpStatusHandler:Function = function(e:HTTPStatusEvent, passThroughObject:Object=null):void {
                Assert.assertEquals("Passwordを空でリクエストをした場合はステータスコード 400 が返る。", e.status, 400);
            }
            var timeoutHandler:Function = function():void {
                Assert.fail("通信がタイムアウトしました。");
            };
            if (Capabilities.playerType.toLowerCase() == "plugin" || Capabilities.playerType.toLowerCase() == "activex") {
	            Async.handleEvent(this, auth, HTTPStatusEvent.HTTP_STATUS, httpStatusHandler, timeout, null, timeoutHandler);
            }
            else {
	            Async.handleEvent(this, auth, HTTPStatusEvent.HTTP_RESPONSE_STATUS, httpStatusHandler, timeout, null, timeoutHandler);
            }
            auth.send();
        }
        
        /**
        * <p>存在しないユーザーをリクエストした場合をテストします.</p>
        */
        [Test(async)]
        public function testSendNotExistUserId():void
        {
            var user:String = "a";
            var auth:Auth   = new Auth(TestHelper.API_END_POINT);
            auth.userId     = user;
            auth.password   = user;
            
            var timeout:int = 10000;
            var responseHandler:Function = function(e:Event, passThroughObject:Object=null):void {
                Assert.assertEquals("ユーザーが存在しない場合は通信は成功し、エラーメッセージが返ってくる。",
                    auth.data, "{\"error\":\"The user '" + user + "' doesn't exist.\"}");
            };
            var timeoutHandler:Function = function():void {
                Assert.fail("通信がタイムアウトしました。");
            };
            Async.handleEvent(this, auth, Event.COMPLETE, responseHandler, timeout, null, timeoutHandler);
            auth.send();
        }
        
        /**
        * <p>存在しないユーザーをリクエストした場合のHTTPステータスをテストします.</p>
        */
        [Test(async)]
        public function testSendNotExistUserIdHttpStatus():void
        {
            var user:String = "a";
            var auth:Auth   = new Auth(TestHelper.API_END_POINT);
            auth.userId     = user;
            auth.password   = user;
            
            var timeout:int = 10000;
            var httpStatusHandler:Function = function(e:HTTPStatusEvent, passThroughObject:Object=null):void {
                Assert.assertEquals("ユーザーが存在しない場合はステータスコード 404 が返る。", e.status, 404);
            }
            var timeoutHandler:Function = function():void {
                Assert.fail("通信がタイムアウトしました。");
            };
            if (Capabilities.playerType.toLowerCase() == "plugin" || Capabilities.playerType.toLowerCase() == "activex") {
	            Async.handleEvent(this, auth, HTTPStatusEvent.HTTP_STATUS, httpStatusHandler, timeout, null, timeoutHandler);
            }
            else {
	            Async.handleEvent(this, auth, HTTPStatusEvent.HTTP_RESPONSE_STATUS, httpStatusHandler, timeout, null, timeoutHandler);
            }
            auth.send();
        }
    }
}