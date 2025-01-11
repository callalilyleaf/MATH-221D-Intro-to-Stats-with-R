-module(simple_calc).
-export([run/0]).

%% @doc The <kbd>run/0</kbd> function is the service keep-alive function. 
%% <kbd>run/0</kbd> offers several services;
%% <ol>
%%   <li>multiplication of all elements of a list of numbers (BigO(n)),</li>
%%   <li>addition of all elements of a list of numbers (BigO(n)),and</li>
%%   <li>division of two numbers, the dividend followed by the divisor in a tuple.
%% </ol>
%% All messages are to be tuples following the pattern {\<pid\>,\<command\>,
%% \<list\>} for
%% those acting on lists, and {\<pid\>,\<command\>,\<params\>} for those that 
%% act on more than one parameter, but not a list of them.

%% Available message types are, <kbd>multiply</kbd>, <kbd>add</kbd>, and 
%% <kbd>divide</kbd>.
run()->
    receive
        {Pid,multiply,List} ->
              Pid ! {ok,lists:foldl(fun(X,Y)->X*Y end,1,List)};
        {Pid,add,List} ->
              Pid ! {ok,lists:foldl(fun(X,Y)->X+Y end,0,List)};
        {Pid,divide,Dividend,Divisor} -> 
              Pid ! {ok,Dividend div Divisor}
    end,
    run().