package
{
    import flash.display.DisplayObject;
    import flash.utils.getQualifiedClassName;
    import com.demonsters.debugger.MonsterDebugger;
    
    /**
     * The Out class is logger console proxy for Monster Debugger.
     * @see http://www.monsterdebugger.com/
     */
    public class Out
    {
        private static var _levels:Object = {};
        private static var _silenced:Object = {};
        private static var _packages:Object = {};
        private static var _defaultPerson:String = "";
        private static var _defaultLabel:String = "";
        
        /**
         * INFO message console color
         */
        public static var INFO_COLOR:uint = 0x757575;
        
        /**
         * STATUS message console color
         */
        public static var STATUS_COLOR:uint = 0x0098FF;
        
        /**
         * DEBUG message console color
         */
        public static var DEBUG_COLOR:uint = 0x009932;
        
        /**
         * WARNING message console color
         */
        public static var WARNING_COLOR:uint = 0xFF9900;
        
        /**
         * ERROR message console color
         */
        public static var ERROR_COLOR:uint = 0xCC0000;
        
        /**
         * FATAL message console color
         */
        public static var FATAL_COLOR:uint = 0x000000;
        
        /**
         * Static constant for INFO level
         */
        public static const INFO:int = 0;
        
        /**
         * Static constant for STATUS level
         */
        public static const STATUS:int = 1;
        
        /**
         * Static constant for DEBUG level
         */
        public static const DEBUG:int = 2;
        
        /**
         * Static constant for WARNING level
         */
        public static const WARNING:int = 3;
        
        /**
         * Static constant for ERROR level
         */
        public static const ERROR:int = 4;
        
        /**
         * Static constant for FATAL level
         */
        public static const FATAL:int = 5;
        
        /**
         * Specifies if the proxy should send messages to the logger console or not.
         */
        public static var enabled:Boolean = true;
        
        /**
         * Enables a particular logging level
         * @param    level   A logging level to enable
         */
        public static function enableLevel( level:uint ):void 
        {
            _levels["Level" + level.toString()] = true;
        }
        
        /**
         * Disables a particular logging level
         * @param    level   A logging level to disable
         */
        public static function disableLevel( level:uint ):void 
        {
            _levels["Level" + level.toString()] = false;
        }
        
        /**
         * Determines if a logging level is enabled
         * @param    level   A logging level to check
         * @return  True or false
         */
        public static function isLevelEnabled( level:uint ):Boolean
        {
            return _levels["Level" + level.toString()];
        }
        
        /**
         * Enables all logging levels
         */
        public static function enableAllLevels():void 
        {
            enableLevel( INFO );
            enableLevel( STATUS );
            enableLevel( DEBUG );
            enableLevel( WARNING );
            enableLevel( ERROR );
            enableLevel( FATAL );
        }
        
        /**
         * Disables all logging levels
         */
        public static function disableAllLevels():void 
        {
            disableLevel( INFO );
            disableLevel( STATUS );
            disableLevel( DEBUG );
            disableLevel( WARNING );
            disableLevel( ERROR );
            disableLevel( FATAL );
        }
        
        /**
         * Checks if an class type is silenced.
         * @param    o   An instance of the class type you wish to check
         * @return  True or false
         */
        public static function isSilenced( o:* ):Boolean 
        {
            var s:String = getClassName( o );
            return _silenced[s];
        }
        
        /**
         * Checks if a package is silenced.
         * @param    packageName The package name you wish to check
         * @return  True or false
         */
        public static function isPackageSilenced( packageName:String ):Boolean
        {
            for each( var pack:String in _packages )
            {
                if( packageName.indexOf( pack ) == 0 )
                    return true;
            }
            return false;
        }
        
        /**
         * Silences a speficied class type
         * @param    o   An instance of the class you wish to silence
         */
        public static function silence( o:* ):void 
        {
            var s:String = getClassName( o );
            _silenced[s] = true;
        }
        
        /**
         * Silences a specified package
         * @param    packageName The package name you wish to silence
         */
        public static function silencePackage( packageName:String ):void
        {
            _packages[packageName] = packageName;
        }
        
        /**
         * Unsilences a specified class type
         * @param    o   An instance of the class you wish to unsilence
         */
        public static function unsilence( o:* ):void
        {
            var s:String = getClassName( o );
            _silenced[s] = false;
        }
        
        /**
         * Unsilences a specified package
         * @param    packageName The package name you wish to unslience
         */
        public static function unsilencePackage( packageName:String ):void
        {
            delete _packages[packageName];
        }
        
        /**
         * Sends an INFO message to the console
         * @param    origin  Origin object
         * @param    object  Message
         */
        public static function info( caller:*, object:*, person:String = "", label:String = "", depth:int = 4 ):void
        {
            output( caller, object, person, label, INFO, INFO_COLOR, depth );
        }
        
        /**
         * Sends a STATUS message to the console
         * @param    origin  Origin object
         * @param    object  Message
         */
        public static function status( caller:*, object:*, person:String = "", label:String = "", depth:int = 4 ):void
        {
            output( caller, object, person, label, STATUS, STATUS_COLOR, depth );
        }
        
        /**
         * Sends a DEBUG message to the console
         * @param    origin  Origin object
         * @param    object  Message
         */
        public static function debug( caller:*, object:*, person:String = "", label:String = "", depth:int = 4 ):void
        {
            output( caller, object, person, label, DEBUG, DEBUG_COLOR, depth );
        }
        
        /**
         * Sends a WARNING message to the console
         * @param    origin  Origin object
         * @param    object  Message
         */
        public static function warning( caller:*, object:*, person:String = "", label:String = "", depth:int = 4 ):void
        {
            output( caller, object, person, label, WARNING, WARNING_COLOR, depth );
        }
        
        /**
         * Sends an ERROR message to the console
         * @param    origin  Origin object
         * @param    object  Message
         */
        public static function error( caller:*, object:*, person:String = "", label:String = "", depth:int = 4 ):void
        {
            output( caller, object, person, label, ERROR, ERROR_COLOR, depth );
        }
        
        /**
         * Sends a FATAL message
         * @param    origin  Origin object
         * @param    object  Message
         */
        public static function fatal( caller:*, object:*, person:String = "", label:String = "", depth:int = 4 ):void
        {
            output( caller, object, person, label, FATAL, FATAL_COLOR, depth );
        }
        
        /**
         * Clears the logger console.
         */
        public static function clear():void
        {
            if( !enabled ) return;
            MonsterDebugger.clear();
        }    
        
        /**
         * Sets the default person to use with all trace calls.
         */
        public static function setPerson( person:String ):void
        {
            _defaultPerson = person;
        }
        
        /**
         * Sets the default label to use with all trace calls.
         */
        public static function setLabel( label:String ):void
        {
            _defaultLabel = label;
        }
        
        /**
         * Sends a snapshot to the logging console
         * @param    target
         */
        public static function snapshot( caller:*, target:DisplayObject, person:String = "", label:String = ""):void
        {
            if( !enabled ) return;
            MonsterDebugger.snapshot( caller, target, person, label );
        }
        
        private static function output( caller:*, object:*, person:String = "", label:String = "", level:uint = 0, color:uint = 0x000000, depth:int = 4 ):void
        {
            if( !enabled ) return;
            if( !isLevelEnabled( level ) ) return;
            if( isSilenced( caller ) ) return;
            if( isPackageSilenced( getPackageName( caller ) ) ) return;
            MonsterDebugger.trace( caller, object, (person.length > 0) ? person : _defaultPerson, (label.length > 0) ? label : _defaultLabel, color, depth );
        }
        
        private static function getPackageName( o:* ):String
        {
            var c:String = getQualifiedClassName( o );
            var s:String = (c == "String" ? o : c.split("::")[0] || c );
            return s;
        }
        
        private static function getClassName( o:* ):String 
        {
            var c:String = getQualifiedClassName( o );
            var s:String = (c == "String" ? o : c.split("::")[1] || c );
            return s;
        }
    }
}