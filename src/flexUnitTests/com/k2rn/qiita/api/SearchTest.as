package flexUnitTests.com.k2rn.qiita.api
{
    import com.k2rn.qiita.ErrorID;
    import com.k2rn.qiita.api.Search;
    
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    
    import flexUnitTests.com.k2rn.qiita.helper.TestHelper;
    
    import flexunit.framework.Assert;
    
    import org.flexunit.async.Async;

    public class SearchTest
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
         */
        [Test(async)]
        public function testSend():void
        {
            var api:Search = new Search(TestHelper.API_END_POINT);
            var query:Vector.<String> = new Vector.<String>();
            query.push("hoge");
            query.push("fuga");
            api.query = query;
            
            var timeout:int = 10000;
            var responseHandler:Function = function(e:Event, passThroughObject:Object):void {
                Assert.assertNotNull("通信に成功したらデータが取得できる。", api.data);
            };
            var timeoutHandler:Function = function():void {
                Assert.fail("通信がタイムアウトしました。");
            };
            Async.handleEvent(this, api, Event.COMPLETE, responseHandler, timeout, null, timeoutHandler);
            api.send();
        }
        
        /**
         * <p>リクエスト時の例外発生をテストします.</p>
         */
        [Test]
        public function testSendException():void
        {
            var api:Search = new Search(TestHelper.API_END_POINT);
            
            // query 未設定での例外テスト
            try {
                api.send();
                Assert.fail(
                    "query 未設定のままでも例外が発生していません。\n" +
                    "query 未設定の場合は例外が発生すべきです。");
            }
            catch (err:Error) {
                Assert.assertEquals("query 未設定のままリクエストすると例外が発生する",
                    err.errorID, ErrorID.MISSING_SEARCH_QUERY);
            }
            var query:Vector.<String> = new Vector.<String>();
            query.push("hoge");
            query.push("fuga");
            api.query = query;
            
            // destroy の後はsendできない
            api.destroy();
            try {
                api.send();
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
            var api:Search = new Search("http://some.invalid.end.point/");
            var query:Vector.<String> = new Vector.<String>();
            query.push("hoge");
            query.push("fuga");
            api.query = query;
            
            var responseHandler:Function = function(e:IOErrorEvent, passThroughObject:Object=null):void {
                Assert.assertEquals("不正なURLの場合は IOError が送出される。",
                    e.type, IOErrorEvent.IO_ERROR);
            };
            var timeoutHandler:Function = function():void {
                Assert.fail("通信がタイムアウトしました。");
            };
            Async.handleEvent(this, api, IOErrorEvent.IO_ERROR, responseHandler, 500, null, timeoutHandler);
            Async.failOnEvent(this, api, Event.COMPLETE);
            api.send();
        }
        
    }
}