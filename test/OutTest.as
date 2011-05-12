package {
	
	import org.flexunit.Assert;
    
	public class OutTest {
		
		[Test]
        public function enable_and_disable():void
        {
            Out.enableLevel(Out.ERROR);
            Assert.assertTrue(Out.isLevelEnabled(Out.ERROR));
            Out.disableLevel(Out.ERROR);
            Assert.assertFalse(Out.isLevelEnabled(Out.ERROR));
        }
        
        [Test]
        public function enable_all_levels():void
        {
            Out.enableAllLevels();
            Assert.assertTrue(Out.isLevelEnabled(Out.FATAL));
            Assert.assertTrue(Out.isLevelEnabled(Out.ERROR));
            Assert.assertTrue(Out.isLevelEnabled(Out.WARNING));
            Assert.assertTrue(Out.isLevelEnabled(Out.DEBUG));
            Assert.assertTrue(Out.isLevelEnabled(Out.STATUS));
            Assert.assertTrue(Out.isLevelEnabled(Out.INFO));
        }
        
        [Test]
        public function disable_all_levels():void
        {
        	Out.disableAllLevels();
        	Assert.assertFalse(Out.isLevelEnabled(Out.FATAL));
            Assert.assertFalse(Out.isLevelEnabled(Out.ERROR));
            Assert.assertFalse(Out.isLevelEnabled(Out.WARNING));
            Assert.assertFalse(Out.isLevelEnabled(Out.DEBUG));
            Assert.assertFalse(Out.isLevelEnabled(Out.STATUS));
            Assert.assertFalse(Out.isLevelEnabled(Out.INFO));
        }
        
        [Test]
        public function silence_and_unsilence_package():void
        {
        	var p:String = "com.somewhere";
        	Out.silencePackage(p);
        	Assert.assertTrue(Out.isPackageSilenced(p));
        	Out.unsilencePackage(p);
        	Assert.assertFalse(Out.isPackageSilenced(p));
        }
        
        [Test]
        public function silence_and_unsilence_object():void
        {
        	var o:Object = {};
        	Out.silence(o);
        	Assert.assertTrue(Out.isSilenced(o));
        	Out.unsilence(o);
        	Assert.assertFalse(Out.isSilenced(o));
        }
		
	}
}
