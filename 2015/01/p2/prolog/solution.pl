nth_walk(Start, [X | _], N, X) :-
	N is Start + 1.
nth_walk(Start, [_ | Rem], N, X) :-
	NextN is Start + 1,
	nth_walk(NextN, Rem, N, X).

nth(List, N, X) :-
	nth_walk(0, List, N, X).

floor_movement('(', 1).
floor_movement(')', -1).

add(A, B, Sum) :-
	Sum is A + B.

walk_floors(StartFloor, StartN, [DC | _], RetDir, RetFloor, RetN) :-
	floor_movement(DC, RetDir),
	add(StartFloor, RetDir, RetFloor),
	add(StartN, 1, RetN).
walk_floors(StartFloor, StartN, [DC | Rem], RetDir, RetFloor, RetN) :-
	floor_movement(DC, Dir),
	add(StartFloor, Dir, NextFloor),
	add(StartN, 1, NextN),
	walk_floors(NextFloor, NextN, Rem, RetDir, RetFloor, RetN).

find_first_to_basement(DirChars, RetN) :-
	StartFloor = 0,
	StartN = 0,
	RetFloor = -1,
	walk_floors(StartFloor, StartN, DirChars, _, RetFloor, RetN).
