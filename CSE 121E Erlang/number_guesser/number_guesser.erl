-module(number_guesser).
-export([start/0, game_loop/2]).

start() -> % Initializer
    Random_number = rand:uniform(100), %Get a random 1~100 number 
    io:format("Welcome to the Number Guessing Game!~n"),
    io:format("Try to guess the number between 1 and 100~n~n"), % ~n is similiar to \n in python, to create a new line in format string
    game_loop(Random_number, 0). % Start the game loop function with 0

game_loop(Target, Guess_count) ->
    Input = io:get_line("Enter your guess: "), % Get user input wiwth get_line function
    Guess = try 
        list_to_integer(string:trim(Input)) % Get rid of the possible blank with trim() function
    catch  % handle the errors and the input not in 1-100 range
        error:_ ->
            io:format("Please enteer a valid number!~n"),
            game_loop(Target, Guess_count) % Go back to game loop if there's an error
    end,


    if  
        Guess < 1 ; Guess > 100 ->
            io:format("Please guess a number between 1 and 100~n"),
            game_loop(Target, Guess_count); % Go back to the game_loop function since input is invalid
    true ->
        case Guess of
            Target -> % if Guess == Target:
                Total_guesses = Guess_count + 1,
                io:format("Congratulations! You guessed it in ~p tries!~n",
                          [Total_guesses]);
            _ when Guess < Target ->
                io:format("Too low! Try again.~n"),
            game_loop(Target, Guess_count + 1);
            _ -> % Guess > Target value
                io:format("Too high! Try again~n"),
                game_loop(Target, Guess_count + 1)
        end
    end.




