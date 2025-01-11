-module(practice).

-export([]).

average_two_numbers(First, Second) -> 
    (First + Second) div 2.


print_parts([]) ->
    io:format("Empty List");
print_parts([H|T]) ->
    io:format("Head: ~p~n", [H]),
    io:format("Tail: ~p~n", [T]).

factorial(N) ->factorial(N,1).

factorial(N, Accum) when N > 0 -> factorial(N-1, Accum*N);
factorial(N, Accum) when N == 0 -> Accum;
factorial(N, Accum) when N < 0 -> undefined. 
% Factorials of negative don't exist

double([]) -> [];
double([H|T]) ->
    [2 * H | double(T)].