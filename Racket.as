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

	public class Racket extends Particle implements Explodable
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
		public function Racket( parent_sprite  : DisplayObjectContainer, 
							    simulator      : Simulator, 
							    init_loc       : Point,
							    init_dir     : Vector, 
							    init_vel       : Vector )
		{		
			       
			// Set life time.
			this.life_time = 5;
			       
			
		    //TODO: implement function
			super( parent_sprite, 
			       simulator, 
			       init_loc.clone(),
			       init_dir.clone(), 
			       init_vel.clone(), 
			       0,
			       5 );
			       
			// Draw the round.
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
			this.graphics.beginFill( 0xFF0000 );
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
            
            // Call Particle's.
			super.move( duration );
		}
		
		override public function explode() : void
		{
			//super.explode();
		}
		
	}
}