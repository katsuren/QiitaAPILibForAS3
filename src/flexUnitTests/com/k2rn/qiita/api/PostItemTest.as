package flexUnitTests.com.k2rn.qiita.api
{
    import com.k2rn.qiita.ErrorID;
    import com.k2rn.qiita.api.PostItem;
    import com.k2rn.qiita.data.ItemTagData;
    
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    
    import flexUnitTests.com.k2rn.qiita.helper.TestHelper;
    
    import flexunit.framework.Assert;
    
    import org.flexunit.async.Async;

    public class PostItemTest
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
         * <p>リクエスト時の例外発生をテストします.</p>
         */
        [Test]
        public function testSendException():void
        {
            var api:PostItem = new PostItem(TestHelper.API_END_POINT);
            
            // token 未設定での例外テスト
            try {
                api.send();
                Assert.fail(
                    "token 未設定のままでも例外が発生していません。\n" +
                    "token 未設定の場合は例外が発生すべきです。");
            }
            catch (err:Error) {
                Assert.assertEquals("token 未設定のままリクエストすると例外が発生する",
                    err.errorID, ErrorID.MISSING_TOKEN);
            }
            api.token = "some_dummy_token";
            
            // title 未設定での例外テスト
            try {
                api.send();
                Assert.fail(
                    "title 未設定のままでも例外が発生していません。\n" +
                    "title 未設定の場合は例外が発生すべきです。");
            }
            catch (err:Error) {
                Assert.assertEquals("title 未設定のままリクエストすると例外が発生する",
                    err.errorID, ErrorID.MISSING_TITLE);
            }
            api.title = "dummy";
            
            // tag 未設定での例外テスト
            try {
                api.send();
                Assert.fail(
                    "tag 未設定のままでも例外が発生していません。\n" +
                    "tag 未設定の場合は例外が発生すべきです。");
            }
            catch (err:Error) {
                Assert.assertEquals("tag 未設定のままリクエストすると例外が発生する",
                    err.errorID, ErrorID.MISSING_TAG);
            }
            var tags:Vector.<ItemTagData> = new Vector.<ItemTagData>();
            tags.push(new ItemTagData());
            tags[0].name = "unko";
            api.tags = new Vector.<ItemTagData>();
            
            // body 未設定での例外テスト
            try {
                api.send();
                Assert.fail(
                    "body 未設定のままでも例外が発生していません。\n" +
                    "body 未設定の場合は例外が発生すべきです。");
            }
            catch (err:Error) {
                Assert.assertEquals("body 未設定のままリクエストすると例外が発生する",
                    err.errorID, ErrorID.MISSING_BODY);
            }
            api.body = "dummy";
            
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
            var tags:Vector.<ItemTagData> = new Vector.<ItemTagData>();
            tags.push(new ItemTagData());
            tags[0].name = "hoge";
            var api:PostItem = new PostItem("http://some.invalid.end.point/");
            api.token = "hoge";
            api.title = "hoge";
            api.body = "hoge";
            api.tags = tags;
            
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