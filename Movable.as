/**
 *  Author:   Zbynek Dusatko   
 *  Date:     04/10/2008
 *  Course:   1410-EAE Asteroids
 *  Partner:  None
 * 
 */

package Asteroids
{
	import flash.display.DisplayObject;
	
	/**
     * INTERFACE Movable
     *
	 *  Description:
 	 *      Makes sure that implements move function.
 	 * 
     */  
	public interface Movable
	{
		/**
		 * move
		 * 
		 *   PARAMETERS:   duration : the time interval between particle movements
		 *
         *   COMMENTS:     below
         * 
         */
		function move( duration : Number ) : void;
	}	
}