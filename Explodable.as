package Asteroids
{
	import flash.display.DisplayObject;
	
	public interface Explodable
	{
		/**
         * hitTestObject
         * 
		 *   PARAMETERS:
		 *		obj : DisplayObject
		 * 
		 *   RETURNS:
		 *		Boolean
		 * 
         *   COMMENTS:
         * 		All collidable objects returns true if hits by obj.
         */
		function hitTestObject( obj : DisplayObject ) : Boolean;
		
		/**
         * explode
         * 
		 *   PARAMETERS:
		 *		 none
		 * 
		 *   RETURNS:
		 *		 none
		 * 
         *   COMMENTS:
         * 		Explodes the object.
         */
		function explode() : void;
	}
}