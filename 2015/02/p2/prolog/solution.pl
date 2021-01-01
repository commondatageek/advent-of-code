use_module(library(lists)).
use_module(library(readutil)).

perimeter(A, B, Perimeter) :-
    Perimeter is (2 * A) + (2 * B).

needed_ribbon(L, W, H, Ribbon) :-
    perimeter(L, W, P1),
    perimeter(L, H, P2),
    perimeter(W, H, P3),
    min_list([P1, P2, P3], Ribbon).

needed_bow(L, W, H, Bow) :-
    Bow is L * W * H.

needed_feet(L, W, H, Total) :-
    needed_ribbon(L, W, H, Ribbon),
    needed_bow(L, W, H, Bow),
    Total is Ribbon + Bow.

parse_dimensions(S, L, W, H) :-
    split_string(S, 'x', '', [L_str, W_str, H_str]),
    number_string(L, L_str),
    number_string(W, W_str),
    number_string(H, H_str).

read_line(_) :- at_end_of_stream(user_input), !, false.
read_line(Line) :-
    read_line_to_string(user_input, Line);
    read_line(Line).

process_line(Total) :-
    read_line(Line),
    parse_dimensions(Line, L, W, H),
    needed_feet(L, W, H, Total).

main :-
    findall(Total, process_line(Total), Results),
    sum_list(Results, Sum),
    format('~d', [Sum]).
