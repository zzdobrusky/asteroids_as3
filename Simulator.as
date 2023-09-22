/**
 *  Author:   Zbynek Dusatko  
 *  Date:     04/05/2008
 *  Course:   1410-EAE HW8
 *  Partner:  None
 * 
 */

package Asteroids
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
  
  	/**
     * CLASS Simulator
     *
	 * DESCRIPTION:
 	 *     This is a time machine of the game with some physics in it.
 	 * 
     */      
	public class Simulator 
  	{
        /**
         * OBJECT LEVEL VARIABLES
         *
         *   objects            : Represents particles
		 *   gravity     	    : Vector representing the constant gravity force.
		 *   duration           : Time interval between particle movements.
         */
      	public var   objects  : Array  = new Array();
      	private var  duration : Number = 0.1; 

      	/**
		 * start_simulation
		 * 
		 * PARAMETERS: parent_sprite
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		attaches the enter frame event to the parent sprite, each enter frame animate function 
		 *      is called
		 */
      	public function start_simulation( parent_sprite : DisplayObjectContainer ) : void
      	{
          	parent_sprite.addEventListener( Event.ENTER_FRAME, animate );
      	}

      	/**
		 * stop_simulation
		 * 
		 * PARAMETERS: parent_sprite
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		stops the simulation by removing the enter frame event
		 */
      	public function stop_simulation( parent_sprite : DisplayObjectContainer ) : void
      	{
        	parent_sprite.removeEventListener( Event.ENTER_FRAME, animate );
      	}

      	/**
		 *add_object_to_simulation
		 * 
		 * PARAMETERS: particle
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		adds the particle to objects array
		 */
      	public function add_object_to_simulation( particle : Particle ) : void
      	{
        	this.objects.push( particle );
      	}
      
      	/**
		 * remove_object_from_simulation
		 * 
		 * PARAMETERS: particle
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		removes the particle object from objects array by using splice function.
		 */  
      	public function remove_object_from_simulation( particle : Particle ) : void
      	{
      		this.objects.splice( this.objects.indexOf( particle ), 1 );
      	}
                
      	/**
		 * animate
		 * 
		 * PARAMETERS: event
		 * 
		 * RETURNS:    none
		 * 
		 * DESCRIPTION:
		 * 		this is our time machine
		 */
      	public function animate( e : Event ) : void
      	{
      		//trace( "animating..." );
	  		
	  		// This should animate all objects at once.
	  		for( var i : int = 0; i < this.objects.length; i++ )
	  		{
	  			var current_object : Particle = this.objects[ i ];
	 	  			
	  			// Move the object.
	  			current_object.move( this.duration );
	  			
	  			// Check if not hit. If yes explode.
	  			for( var j : int = 0; j < this.objects.length; j++ )
	  			{
	  				if( j != i )
	  				{
	  					var other_object : Particle = this.objects[ j ];
	  					
	  					if(	other_object.hitTestObject( current_object ) )
	  					{
	  						//trace( current_object.toString() + "just exploded!!!!" );
	  						
	  						// Lets explode both objects.
	  						( current_object as Particle ).explode();
	  						( other_object as Particle ).explode();	  						
	  					}
	  				}
	  				
	  			}	  			
	  			
	  			// Clear all the forces.
	  			current_object.clear_forces();
	  		}
        }
  	}
}












