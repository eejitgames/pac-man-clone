
/*
AUTHOR:
	IronManhood
	
DATE:
	last updated 07-22-2019
	
PURPOSE:
	A procedurally generated pac man map.

DOCUMENTATION:
	

FUNCTIONS:
	
	
EXAMPLE:
	
*/


#constant TILETYPE_WALL		0 // For blocking movement.
#constant TILETYPE_PATH		1 // For movement.
#constant TILETYPE_SPAWN		2 // For ghost block path.
#constant TILETYPE_WHITEWALL	3 // For ghost block wall.


type t_Cell
	fuck
endtype




type t_Tile
	tileType as integer
	pos as t_Vector_2
	size as t_Vector_2
	center as t_Vector_2
endtype




type t_Map
	tiles as t_Tile[-1,-1]
	
	created as integer
endtype


global map as t_Map




function Map_Delete()
	for i = 0 to map.tiles.length - 1
		map.tiles[i].length = 0
	next i
	map.tiles.length = 0
	
	map.created = FALSE
endfunction


// Loads a map from file.
function LoadMap(_mapFile$)
	if GetFileExists(_mapFile$) = 0 then exitfunction
	
	_fileType$ = GetStringToken2(_mapFile$, ".", CountStringTokens2(_mapFile$, "."))
//~	if CompareString(_fileType$, "csv")
//~	elseif CompareString(_fileType$, "json")
//~	endif
	select _fileType$
		case "csv":
			f = OpenToRead(_mapFile$)
			while FileEOF(f) = FALSE
				_line$ = ReadLine(f)
				map.tiles.length = map.tiles.length + 1
				map.tiles[map.tiles.length].length = CountStringTokens2(_line$, ";")
				for i = 0 to map.tiles[map.tiles.length].length - 1
					map.tiles[map.tiles.length,i].tileType = val(GetStringToken(_line$, ";", i + 1))
				next i
			endwhile
			CloseFile(f)
			map.created = TRUE
		endcase
		
		case "json":
			map.tiles.load(_mapFile$)
		endcase
		
		case default:
			exitfunction
		endcase
	endselect
	
	remstart
	temp as integer
    // From forum thread: https://forum.thegamecreators.com/thread/212096
    
    mazeFile = openToRead("map.csv")
    // Set first index of array to zero, this is available to use, but is not being used.
    y = 0
    repeat
		line$ = readline(mazeFile) // Read a line from file
		numParts = countStringTokens(line$ , ";" ) // Count number of csv parameters in line
		if numParts > 0 // If more than none - ie not a blank line
			inc y // Increase y index
			for x = 1 to numParts // Loop through parameters on this line, using x array index
			temp = val(getstringToken(line$ , ";" , x)) // find type
			if temp = 0
				map.tiles[x,y].tileType = TILETYPE_WALL
			elseif temp = 1
				map.tiles[x,y].tileType = TILETYPE_PATH
			elseif temp = 2
				map.tiles[x,y].tileType = TILETYPE_WALL
			elseif temp = 3
				map.tiles[x,y].tileType = TILETYPE_SPAWN
			elseif temp = 4
				map.tiles[x,y].tileType = TILETYPE_PATH
			elseif temp = 5
				map.tiles[x,y].tileType = TILETYPE_WHITEWALL
			endif
			map.tiles[x , y].tileType = val(getstringToken(line$ , ";" , x)) // populate array
			next x
		endif
    until fileeof(mazeFile) > 0 // Until the end of the file
    closefile(mazeFile) // y will now contain the number of lines read.
    remend
endfunction








// A temporary function for representing tiles.
// Simply draws a box for each cell.
function DrawAllTiles()
	if map.created
		for i = 0 to map.tiles.length - 1
			for j = 0 to map.tiles[i].length - 1
				select map.tiles[i,j].tileType
					case TILETYPE_WALL:
						DrawRange(map.tiles[i,j].pos, map.tiles[i,j].size, clr_lightblue, clr_lightblue, clr_lightblue, clr_lightblue, TRUE)
						DrawRange(map.tiles[i,j].pos, map.tiles[i,j].size, clr_violet, clr_violet, clr_violet, clr_violet, FALSE)
					endcase
					case TILETYPE_PATH:
						DrawRange(map.tiles[i,j].pos, map.tiles[i,j].size, clr_darkgrey, clr_darkgrey, clr_darkgrey, clr_darkgrey, TRUE)
					endcase
					case TILETYPE_SPAWN:
						DrawRange(map.tiles[i,j].pos, map.tiles[i,j].size, clr_white, clr_white, clr_white, clr_white, TRUE)
					endcase
					case TILETYPE_WHITEWALL:
						DrawRange(map.tiles[i,j].pos, map.tiles[i,j].size, clr_lightgrey, clr_lightgrey, clr_lightgrey, clr_lightgrey, TRUE)
					endcase
				endselect
			next j
		next i
	endif
endfunction

// Prints the tiles in map formation.
function PrintAllTiles()
	if map.created
		for i = 0 to map.tiles.length - 1
			for j = 0 to map.tiles[i].length - 1
				printC(map.tiles[i,j].tileType)
				if j < map.tiles[i].length - 1 then PrintC("    ")
			next j
			print("")
		next i
	endif
endfunction




