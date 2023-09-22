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

	public class Round extends Particle
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
		public function Round( parent_sprite : DisplayObjectContainer, 
							   simulator : Simulator, 
							   loc       : Point,
							   angle     : Number, 
							   vel       : Vector, 
							   angle_vel : Number,
							   mass      : Number )
		{
			
			       
			// Set life time.
			this.life_time = 5;
			       
			// Draw the round.
		    this.create_display_list();
		    
		    //TODO: implement function
			super( parent_sprite, 
			       simulator, 
			       loc,
			       angle, 
			       vel, 
			       angle_vel,
			       mass );
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
			this.graphics.beginFill( 0x00FF00 );
			this.graphics.drawRect( -6, -1, 12, 2 );
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
		override public function move( duration:Number ) : void
		{			 
            this.life_time -= duration;
            
            if( this.life_time < 0 )
            {
            	this.remove_me();
            }
            
            // Call Particle's super move.
			super.move( duration );
		}
		
		override public function explode() : void
		{
			// just fake to make the round not to explode...
		}
		
	}
}