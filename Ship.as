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
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;

	public class Ship extends Particle implements Explodable
	{
		/**
		 * MEMBER VARIABLES
		 */
		private var mouse_vector    : Vector;
		private var thrust_force    : Vector;
		private var break_force     : Vector;
		private var break_force_on  : Boolean;
		private const MAX_THRUST    : Number = 200;
		private const MAX_BREAK     : Number = 130;
		private const MAX_ANGLE_VEL : Number = 20;
		private const FRICTION      : Number = 3; // Friction in %.
		
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
		public function Ship( parent_sprite  : DisplayObjectContainer, 
							  simulator      : Simulator,
							  init_loc       : Point,
							  init_dir       : Vector,
							  init_vel       : Vector,
							  init_angle_vel : Number,
							  mass           : Number )
		{
			
			// Call the super constructor of Particle class.
			super( parent_sprite,
				   simulator,
				   init_loc.clone(),
				   init_dir.clone(), 
				   init_vel.clone(),
				   init_angle_vel, 
				   mass );	
				   
					
			
			// Declare the thrust and break forces.
			this.thrust_force = new Vector( 0, 0 );
			this.break_force  = new Vector( 0, 0 );
			
			// Declare the mouse vector.
			this.mouse_vector = new Vector( 0, 0 );
			
			// Set the break to be off.
			this.break_force_on = false;
			
			// Set the angle velocity.
			this.angle_velocity = 0;
			
			// Add flash CS3 artwork.
			[Embed(source="./Resources/space_ship.swf", symbol="Spaceship")] 				
			var run_time_class : Class; 			               
			var ship : Sprite = new run_time_class();            
            this.addChild( ship ); // Add it to this Ship class. This should center it around (0,0).
            
            // Scale it.
            ship.scaleX = .3; 
            ship.scaleY = .3;
     			        		
	        // Start listener for pressed keyboard keys.
	        this.parent.stage.addEventListener(	KeyboardEvent.KEY_DOWN, this.key_down_handler );
	        this.parent.stage.addEventListener(	KeyboardEvent.KEY_UP,   this.key_up_handler );
	        // Start listener for left mouse down.
	        this.parent.stage.addEventListener( MouseEvent.MOUSE_DOWN,  this.mouse_down_handler );
		}
		
		/**
		 * key_down_handler
		 */
		private function key_down_handler( event : KeyboardEvent ) : void
		{
			// Breaking
			if( event.keyCode == Keyboard.SPACE ) // && this.break_force_on )
			{
				//trace( "breaking..." );
				
				// Make sure that thrust is disabled and zero.
				this.break_force_on = true;
				this.thrust_force.zero_me();				
				
				// Compute the break force.
				this.break_force.set_x( 1 );
				this.break_force.set_y( 0 );				
				this.break_force.rotate_me( this.dir_vector.get_angle() );
				this.break_force.scale_me( -this.MAX_BREAK );
				//trace("break_force = " + this.break_force.toString() );				
			}
		}
		
		/**
		 * key_up_handler
		 */
		private function key_up_handler( event : KeyboardEvent ) : void
		{
			// Stop breaking.
			if( event.keyCode == Keyboard.SPACE ) // && this.break_force_on )
			{
				//trace( "stopped breaking..." );
				
				// Make sure the break is disabled and zero.
				this.break_force_on = false;				
				this.break_force.zero_me();
			}
		}
		
		/**
		 * mouse_down_handler
		 */
		private function mouse_down_handler( event : MouseEvent ) : void
		{													      
			if( event.shiftKey )
			{
				this.launch_racket();
			}
			else
			{
				trace( "Left mouse down!" );
				this.fire_laser();
			}										   
		}
		
		/**
		 * launch_racket
		 */
		private function launch_racket() : void
		{			
			// Add the ships's velocity to racket's.
			var racket_vel : Vector = this.dir_vector.clone();
			racket_vel.scale_me( 100 );
			
			racket_vel.add_to_me( this.velocity );
			
			// Set the location where to shoot from.
			//var racket_location : Point = this.location.clone();
			
			var racket : Racket = new Racket( this.parent_sprite, 
										   	  this.simulator, 
										      this.location.clone(),//racket_location,
										      this.dir_vector.clone(), 
										      racket_vel );
		}
		
		/**
		 * fire_laser
		 */
		private function fire_laser() : void
		{			
			
			var laser : Laser = new Laser( this.parent_sprite, 
										   this.simulator, 
										   this.location,
										   this.dir_vector, 
										   this.velocity.clone(),
										   this.angle_velocity );
										   
		    trace( "laser just fired! Inside ship laser.x , laser.y = " + laser.x + ", " + laser.y );
		}
		
		/**
		 * update_thrust_force
		 * 
		 *   PARAMETERS:   none
		 * 
		 *   RETURNS:      none
		 *
         *   COMMENTS:     below
         * 
         */
        public function update_thrust_force() : void
        {            
          		if( !this.break_force_on )
          		{
          			// Create two vectors representing directions of the ship and the mouse vector in relation to
          			// the logic origin (0,0).   
                	this.mouse_vector = new Vector( this.parent_sprite.mouseX, 
                									this.parent.stage.stageHeight - this.parent_sprite.mouseY ); 
	                this.thrust_force.set_x( this.location.x );
	                this.thrust_force.set_y( this.location.y );
	                
	                this.thrust_force.subtract_from_me( this.mouse_vector );
	                this.thrust_force.scale_me( -1 ); 
	                
	                // Check if not bigger and if yes set to max thrust.
	                if( this.thrust_force.get_magnitude() > this.MAX_THRUST )
	                {
	                	this.thrust_force.normalize();
	                	this.thrust_force.scale_me( this.MAX_THRUST );
	                } 
          		}    		
        }
        
        /**
         * update_angle
         */
        private function update_angle_velocity() : void
        {
        	this.angle_velocity = 0;
        	
        	// Rotate the ship according to thrust force.
        	if( !this.break_force_on )
        	{       		
        		var angle_between : Number = this.dir_vector.get_angle_between( this.mouse_vector );
        		
        		trace( "dir_vector = " + this.dir_vector.toString() + ", mouse_vector = " + this.mouse_vector.toString() );        		
        		trace( "angle_between = " + angle_between );
        		
        		if(  angle_between > 10 )
	        	{
	        		// Get the direction of the angle velocity as 1 or -1.
        			var dir_sign : Number = this.dir_vector.dot_product( this.mouse_vector );
        			dir_sign = dir_sign / Math.abs( dir_sign ); // Normalize.
        			
        			//trace( "dir_sign = " + dir_sign );
        			
	        		this.angle_velocity = dir_sign * this.MAX_ANGLE_VEL;
	        		
	        		
	        	}
	        		        		        	        		
	        	//trace( "this.rotation = " + this.rotation );
        		//trace( "-this.thrust_force.get_angle() = " + ( -this.thrust_force.get_angle() ) );
	        	//trace( "this.angle_velocity = " + this.angle_velocity );        	   
        	}        	 
        }
        
        //private function 
		
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
            // Only if mouse not over the ship.
            if( this.mouseX > this.width/2 ||
                this.mouseX < -this.width/2 ||
                this.mouseY > this.height/2 ||
                this.mouseY < -this.height/2 )
            {
                // Calculate and add the thrust force.   
                this.update_thrust_force();         	
            	this.add_force( this.thrust_force );             	                   	
            }
            
            // Update ship's angle even if mouse over.
            this.update_angle_velocity();                                   
            	 
            // Add the break forces.            
            this.add_force( this.break_force );  
                               
            //trace("break_force = " + this.break_force.toString() );  
            //trace( "force_acting_on = " + this.force_acting_on.toString() );
            
            // Introduce friction. Reduce the velocity in the X and Y direction by %.
            // This will keep the ship selfstabilizing.
			this.velocity.set_x( ( 1 - this.FRICTION / 100 ) * this.velocity.get_x() );
			this.velocity.set_y( ( 1 - this.FRICTION / 100 ) * this.velocity.get_y() );
            
            // Call Particle's super move.
			super.move( duration );
		}
		
		override public function explode() : void
		{
			// just fake to make ship not to explode...
		}
	}
}