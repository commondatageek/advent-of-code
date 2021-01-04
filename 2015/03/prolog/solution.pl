use_module(library(lists)).
use_module(library(readutil)).

delta('v', 0, -1).
delta('^', 0, 1).
delta('<', -1, 0).
delta('>', 1, 0).

update(X0, Y0, Dx, Dy, X, Y) :-
    X is X0 + Dx,
    Y is Y0 + Dy.

dir_chars(Path, DirChars) :-
    read_file_to_string(Path, String, []),
    string_chars(String, DirChars).

follow_dirs(X0, Y0, [], X0, Y0).
follow_dirs(X0, Y0, [D|DirChars], X, Y) :-
    delta(D, Dx, Dy),
    update(X0, Y0, Dx, Dy, IntX, IntY),
    follow_dirs(IntX, IntY, DirChars, X, Y).

track_houses(_X0, _Y0, [], []).
track_houses(X0, Y0, [D|DirChars], [[IntX, IntY]|Houses]) :-
    delta(D, Dx, Dy),
    update(X0, Y0, Dx, Dy, IntX, IntY),
    track_houses(IntX, IntY, DirChars, Houses).

start_track_houses(DirChars, [[0,0]|Houses]) :-
    track_houses(0, 0, DirChars, Houses).

split_directions([], _Owner, [], []).
split_directions([D|DirChars], santa, [D|SantaDirChars], RoboDirChars) :-
    split_directions(DirChars, robo, SantaDirChars, RoboDirChars).
split_directions([D|DirChars], robo, SantaDirChars, [D|RoboDirChars]) :-
    split_directions(DirChars, santa, SantaDirChars, RoboDirChars).

part1_solution :-
    dir_chars('../../input.txt', DirChars),
    start_track_houses(DirChars, Houses),
    sort(Houses, Set),
    length(Set, L),
    format('~d', L).

part2_solution :-
    dir_chars('../../input.txt', DirChars),
    split_directions(DirChars, santa, SantaDirChars, RoboDirChars),
    start_track_houses(SantaDirChars, SantaHouses),
    start_track_houses(RoboDirChars, RoboHouses),
    append(SantaHouses, RoboHouses, AllHouses),
    sort(AllHouses, Set),
    length(Set, L),
    format('~d', L).
