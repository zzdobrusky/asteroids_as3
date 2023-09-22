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
	import flash.display.Sprite;
	import flash.geom.Point;

	public class Asteroid extends Particle implements Explodable
	{
		/**
		 * MEMBER VARIABLES
		 */

		
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
		public function Asteroid( parent_sprite  : DisplayObjectContainer, 
							  	  simulator      : Simulator,
							  	  init_loc       : Point,
							  	  init_dir       : Vector,
							  	  init_vel       : Vector,
							  	  init_angle_vel : Number,
							  	  mass           : Number )
		{
			//this.parent_sprite = parent_sprite;	
			
			// Call the super constructor of Particle class.
			super( parent_sprite,
				   simulator,
				   init_loc.clone(),
				   init_dir.clone(), 
				   init_vel.clone(), 
				   init_angle_vel,
				   mass );

			
			// Add flash CS3 artwork.
			[Embed(source="./Resources/asteroid_lib.swf", symbol="asteroid_mc")] 				
			var run_time_class : Class; 			               
			var asteroid : Sprite = new run_time_class();            
            this.addChild( asteroid ); // Add it to this Asteroid class. This should center it around (0,0).
             
            // Scale it.
            asteroid.scaleX = .3; 
            asteroid.scaleY = .3
		}
		
	}
}