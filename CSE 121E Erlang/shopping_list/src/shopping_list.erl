-module(shopping_list). 
-export([run/1, start/1, rpc/2]). 

% Start a process to keep track of a shopping list.
start(Initial_list) ->
    spawn(?MODULE, run, [Initial_list]).

% Client interface to send messages to the shopping list process.
rpc(Pid, Message) ->
    Pid ! {self(), Message},
    receive
        Response ->
            Response
    end.

% Shopping list process.
run(Shopping_list)-> 
    % Notice how the Updated_list variable is updated with whatever is returned by 
    % each clause under the "receive" block.
    Updated_list = 
        receive
            {Pid,{add, Item}} ->
                Pid ! {added, Item}, % Send a message back to the client
                [Item | Shopping_list]; % Update the shopping list by adding an item to the head of the list.
            {Pid,get_list} ->
                Pid ! Shopping_list, % Send the shopping list back to the client
                Shopping_list; % The list is not modified
            {Pid,{remove, Item}} -> 
                Pid ! {removed, Item}, % Send a message back to the client
                Shopping_list -- [Item]; % Update the list by removing an item
                % lists:delete(Item, Shopping_list); % Another way to remove an item from a list
            {Pid, {has_item, Item}} ->
                Pid ! lists:member(Item, Shopping_list), % Send message back to client. This will be true or false.
                Shopping_list; % The list is not modified
            {Pid,_Other} ->
                Pid ! {fail, unrecognized_message}, % Send message back to client
                Shopping_list % The list is not modified
        end,
    run(Updated_list). % Call run recursively with the updated shopping List