-module(funcs).
-export([average_two_numbers/2,print_parts/1,factorial/1,double/1]).

% Returns the average of two numbers
average_two_numbers(First, Second) -> 
    (First + Second) div 2.


% Prints the Head and Tail of a list
print_parts([H|T]) ->
    io:format("Head: ~p~n",[H]),
    io:format("Tail: ~p~n",[T]).


% Returns the factorial of a number
factorial(0) -> 1;
factorial(N) -> N * factorial(N-1).


% Double each item in a list of numbers
double([]) -> [];
double([H|T]) ->
    [2 * H | double(T)].