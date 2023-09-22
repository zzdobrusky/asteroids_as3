/**
 *  Author:   Zbynek Dusatko   
 *  Date:     04/10/2008
 *  Course:   1410-EAE Asteroids
 *  Partner:  None
 * 
 */

package Asteroids
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;

	public class Laser extends Particle
	{
		/**
		 * MEMBER VARIABLES
		 */
		private var life_time : Number;
		
		/**
		 * CONSTRUCTOR
		 * 
		 * 
		 * PARAMETERS:
		 *     
		 * 
		 * DESCRIPTION:
		 * 
		 */
		public function Laser( parent_sprite  : DisplayObjectContainer, 
			       			   simulator      : Simulator, 
			       			   loc       : Point,
						       dir     : Vector, 
						       vel       : Vector, 
						       angle_vel : Number )
		{    
			// Set life time.
			this.life_time = 0.5;		
		    
		    //TODO: implement function
			super( parent_sprite, 
			       simulator, 
			       loc,
			       dir, 
			       vel, 
			       angle_vel,
			       5 );
			       
			trace( "laser.x, laser.y = " + this.x + ", " + this.y );
			
			// Draw the laser ray.
		    this.create_display_list();
		}
		
		/**
		 * create_display_list
		 * 
		 *   PARAMETERS:   none
		 * 
		 *   RETURNS:      none
		 *
         *   COMMENTS:     below
         * 
         */
		private function create_display_list() : void
		{
			// It will draw a rectancle around the (0, 0) on x coordinate.
			this.graphics.beginFill( 0x33FF00 );
			this.graphics.drawRect( 0, -1, 700, 2 );
			this.graphics.endFill();
		}
		
		/**
		 * move
		 * 
		 *   PARAMETERS:   duration
		 * 
		 *   RETURNS:      none
		 *
         *   COMMENTS:     below
         * 
         */
		override public function move( duration : Number ) : void
		{			 
            // We don't move just give it a lifetime.
            this.life_time -= duration;
            
            if( this.life_time < 0 )
            {
            	this.remove_me();
            }
          
			super.update_gui();
		}
		
		override public function explode() : void
		{
			//super.explode();
		}
		
	}
}