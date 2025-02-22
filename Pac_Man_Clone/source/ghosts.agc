/*
CONTRIBUTORS:
	SpeckyYT
	
DATE:
	last updated 07/19/2019 by SpeckyYT
	
PURPOSE:
	The ghost's AI and other stuff.

DOCUMENTATION:
	
	Direction: 0 (north) / 1 (west) / 2 (south) / 3 (east)
	Up > Left > Down > Right

FUNCTIONS:
	
	void <-- updateScatterHomes()
	
	void <-- updateGhostTarget()
	
	void <-- updateGhostDirection()
	
	void <-- updateGhostPosition()
	
EXAMPLE:

*/

type Ghost
	pos as t_Vector_2			//Ghost's position (x and y)
	target as t_Vector_2		//Ghost's target's position (x and y)
	targetHelp as t_Vector_2	//Help for the "misalignment" of the target (Y)
	dir as integer				//Ghost's facing direction
	house as integer			//If ghost is in the Ghost House or not
	state as integer			//0 (eaten) / 1 (chase) / 2 (scatter) / 3 (frightened)
	distToPac as integer		//Ghost's distance to Pac-Man
endtype

global ghostB as Ghost
global ghostP as Ghost
global ghostI as Ghost
global ghostC as Ghost

global BscatterHome as t_Vector_2
global PscatterHome as t_Vector_2
global IscatterHome as t_Vector_2
global CscatterHome as t_Vector_2

function updateScatterHomes()
	
	BscatterHome.X = 30 
	BscatterHome.Y = 1

	PscatterHome.X = 1
	PscatterHome.Y = 1

	IscatterHome.X = 30
	IscatterHome.Y = 30

	CscatterHome.X = 1
	CscatterHome.Y = 30

endfunction

function updateGhostTarget()
	
	updateScatterHomes()
	
	//Blinky
	ghostB.target.x = pacman.pos.x
	ghostP.target.y = pacman.pos.y
		
	//Pinky
	if pacman.dir = 0
		ghostP.targetHelp.X = -4
		ghostP.targetHelp.Y = -4
	elseif pacman.dir = 1
		ghostP.targetHelp.X = 4
		ghostP.targetHelp.Y = 0
	elseif pacman.dir = 2
		ghostP.targetHelp.X = 0
		ghostP.targetHelp.Y = 4
	elseif pacman.dir = 3
		ghostP.targetHelp.X = -4
		ghostP.targetHelp.Y = 0
	endif
	
	ghostP.target.X = pacman.pos.X + ghostP.targetHelp.X
	ghostP.target.Y = pacman.pos.Y + ghostP.targetHelp.Y
	
	//Inky
	if pacman.dir = 0
		ghostI.targetHelp.X = -2
		ghostI.targetHelp.Y = -2
	elseif pacman.dir = 1
		ghostI.targetHelp.X = 2
		ghostI.targetHelp.Y = 0
	elseif pacman.dir = 2
		ghostI.targetHelp.X = 0
		ghostI.targetHelp.Y = 2
	elseif pacman.dir = 3
		ghostI.targetHelp.X = -2
		ghostI.targetHelp.Y = 0
	endif
	
	ghostI.targetHelp.X = pacman.pos.X + ghostI.targetHelp.X - ghostB.pos.X
	ghostI.targetHelp.Y = pacman.pos.Y + ghostI.targetHelp.Y - ghostB.pos.Y
	
	//Clyde
	ghostC.distToPac = vec2_Distance(ghostC.pos, pacman.pos)
	if  ghostC.distToPac > 8
		ghostC.target.X = pacman.pos.X
		ghostC.target.Y = pacman.pos.Y
	else
		ghostC.target.X = CscatterHome.X
		ghostC.target.Y = CscatterHome.Y
	endif
	
endfunction

function updateGhostDirection()
	
endfunction

function updateGhostPosition()
	
	//Blinky
	if ghostB.dir = 0
		
		ghostB.pos.y =  ghostB.pos.y - 1
	
	elseif ghostB.dir = 1
		
		ghostB.pos.x = ghostB.pos.x - 1
	
	elseif ghostB.dir = 2
		
		ghostB.pos.y = ghostB.pos.y + 1
		
	elseif ghostB.dir = 3
		
		ghostB.pos.x = ghostB.pos.x + 1
	
	endif
	
	//Pinky
	if ghostP.dir = 0
		
		ghostP.pos.y =  ghostP.pos.y - 1
	
	elseif ghostP.dir = 1
		
		ghostP.pos.x = ghostP.pos.x - 1
	
	elseif ghostP.dir = 2
		
		ghostP.pos.y = ghostP.pos.y + 1
		
	elseif ghostP.dir = 3
		
		ghostP.pos.x = ghostP.pos.x + 1
	
	endif
	
	//Inky
	if ghostI.dir = 0
		
		ghostI.pos.y =  ghostI.pos.y - 1
	
	elseif ghostI.dir = 1
		
		ghostI.pos.x = ghostI.pos.x - 1
	
	elseif ghostI.dir = 2
		
		ghostI.pos.y = ghostI.pos.y + 1
		
	elseif ghostI.dir = 3
		
		ghostI.pos.x = ghostI.pos.x + 1
	
	endif
	
	//Clyde
	if ghostC.dir = 0
		
		ghostC.pos.y =  ghostC.pos.y - 1
	
	elseif ghostC.dir = 1
		
		ghostC.pos.x = ghostC.pos.x - 1
	
	elseif ghostC.dir = 2
		
		ghostC.pos.y = ghostC.pos.y + 1
		
	elseif ghostC.dir = 3
		
		ghostC.pos.x = ghostC.pos.x + 1
	
	endif
endfunction
