package flexUnitTests.com.k2rn.qiita
{
    import com.k2rn.qiita.Qiita;
    
    import flexunit.framework.Assert;
    
    public class QiitaTest
    {		
        private static var qiita:Qiita;
        
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
            qiita = new Qiita();
        }
        
        [AfterClass]
        public static function tearDownAfterClass():void
        {
        }
        
        [Test]
        public function testAuth():void
        {
            Assert.fail("Test method Not yet implemented");
        }
        
        [Test]
        public function testDeleteItem():void
        {
            Assert.fail("Test method Not yet implemented");
        }
        
        [Test]
        public function testGetMyItemList():void
        {
            Assert.fail("Test method Not yet implemented");
        }
        
        [Test]
        public function testGetMyStockList():void
        {
            Assert.fail("Test method Not yet implemented");
        }
        
        [Test]
        public function testGetNewlyItemList():void
        {
            Assert.fail("Test method Not yet implemented");
        }
        
        [Test]
        public function testGetRateLimit():void
        {
            Assert.fail("Test method Not yet implemented");
        }
        
        [Test]
        public function testGetTagItemList():void
        {
            Assert.fail("Test method Not yet implemented");
        }
        
        [Test]
        public function testGetTagList():void
        {
            Assert.fail("Test method Not yet implemented");
        }
        
        [Test]
        public function testGetUserInfo():void
        {
            Assert.fail("Test method Not yet implemented");
        }
        
        [Test]
        public function testGetUserItemList():void
        {
            Assert.fail("Test method Not yet implemented");
        }
        
        [Test]
        public function testGetUserStockList():void
        {
            Assert.fail("Test method Not yet implemented");
        }
        
        [Test]
        public function testPostItem():void
        {
            Assert.fail("Test method Not yet implemented");
        }
        
        [Test]
        public function testUpdateItem():void
        {
            Assert.fail("Test method Not yet implemented");
        }
    }
}