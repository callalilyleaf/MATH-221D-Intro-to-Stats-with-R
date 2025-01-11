-module(friend_tracker). % Get the defined module
-export([start/1,rpc/2,run/1]). % Import the functions from friend_tracker


%%
%% Spawn a process for adding, removing, and finding friends.
%% The parameter is an initial list of friends. It may be an 
%% empty list.
%%

start(Initial_friends_list)->
	spawn(?MODULE, run, [Initial_friends_list]). % The MODULE macro is used to refer to the current module instead of hard coding the module name

%%--------------------------
%% Client functions
%%--------------------------

%%
%% Add, remove, or find a friend.
%%
rpc(Pid,Message)-> % receive Pid and message to interact with the clinet (user)
	Pid ! {self(),Message}, % {!} means send messages to the sever. {self(), Message} is the message to send to 
	receive
        Response -> % Wait for the reponse from the server process
        	Response % Return the reponse
     end.



%%---------------------------
%% Server function
%%---------------------------

%
%% Spawn a process for adding, removing, and finding friends.
%% The parameter is an initial list of friends. It may be an 
%% empty list.
%%

run(Friend_list)->
	Updated_list = receive % Waits to receive a message and assigns the result to Updated_list
						{Pid,{add,Friends}} when is_list(Friends)->
							Pid ! received, % send "received" string back to user
							Friends++Friend_list; % Concatenates new friends to existing list
						{Pid,{add,Friend}}-> % Pattern matches for single friend
							Pid ! received,
							[Friend]++Friend_list; %List concatenation
						{Pid,{has_friends,Friends}} when is_list(Friends)-> % "has_friends" is the function name
							Pid ! length(Friend_list -- Friends) == length(Friend_list) - length(Friends), % Friend_list -- Friends is the list Subtraction 
							Friend_list;
						{Pid,{has_friend,Friend}}->
							Pid ! lists:any(fun(Element)-> Element == Friend end,Friend_list),
							Friend_list;
						{Pid,{remove,Friends}} when is_list(Friends)->
							Pid ! received,
							Friend_list -- Friends;
						{Pid,{remove,Friend}}->
							Pid ! received,
							Friend_list -- [Friend];
						{Pid,get}->
							Pid ! Friend_list,
							Friend_list;
						{Pid,_other}-> % Be aware of here, it uses the underscored other to include each one that hasn't been mentioned.
							Pid ! {fail, unrecognized_message},
							Friend_list
					end,
	run(Updated_list).

-ifdef(EUNIT).


-include_lib("eunit/include/eunit.hrl").

add_friend_test_() ->
{setup,
	fun()->
			Pid = spawn(?MODULE, run, [[sue,grace,fred]]),	
			register(test_adder, Pid)
		end,
	fun(_)->
		unregister(test_adder)
	end,

	[ ?_assertEqual(received, rpc(test_adder, {add, bob})),
	  ?_assertEqual(received, rpc(test_adder, {add, 1})),
	  ?_assertEqual(received, rpc(test_adder, {add, #{name=>suzannah, age=>23}}))
	]
}.

add_friends_test_() ->
{setup,
	fun()-> 
			Pid = spawn(?MODULE,run,[[sue,grace,fred]]),	
			register(test_adder,Pid)
		end,
	fun(_)->
		unregister(test_adder)
	end,
	
	[ ?_assertEqual(received,rpc(test_adder,{add,[bob,alice,joe]})),
	  ?_assertEqual(received,rpc(test_adder,{add,[]})),
	  ?_assertEqual(received,rpc(test_adder,{add,[#{name=>suzannah,age=>23},#{name=>gunhild,age=>20}]}))
	]
}.

has_friend_test_() ->
{setup,
	fun()->
			Pid = spawn(?MODULE,run,[[sue,grace,fred]]),	
			register(test_finder,Pid)
		end,
	fun(_)->
		unregister(test_finder)
	end,
	
	[ ?_assert(rpc(test_finder,{has_friend,sue})),
	  ?_assertNot(rpc(test_finder,{has_friend,bob})),
	  ?_assertNot(rpc(test_finder,{has_friend,[#{name=>suzannah,age=>23},#{name=>gunhild,age=>20}]}))
	]
}.

has_friends_test_() ->
{setup,
	fun()->
			Pid = spawn(?MODULE,run,[[sue,grace,fred]]),	
			register(test_finder,Pid)
		end,
	fun(_)->
		unregister(test_finder)
	end,
	
	[ ?_assert(rpc(test_finder,{has_friends,[sue,fred]})),
	  ?_assert(rpc(test_finder,{has_friends,[]})),
	  ?_assertNot(rpc(test_finder,{has_friends,[bob]})),
	  ?_assertNot(rpc(test_finder,{has_friends,[#{name=>suzannah,age=>23},#{name=>gunhild,age=>20}]}))
	]
}.



remove_friend_test_() ->
{setup,
	fun()->
			Pid = spawn(?MODULE,run,[[sue,grace,fred]]),	
			register(test_remover,Pid)
		end,
	fun(_)->
		unregister(test_remover)
	end,
	
	[ ?_assertEqual(received,rpc(test_remover,{remove,fred})),
	  ?_assertEqual(received,rpc(test_remover,{remove,bob})),
	  ?_assertEqual(received,rpc(test_remover,{remove,[#{name=>suzannah,age=>23},#{name=>gunhild,age=>20}]}))
	]
}.

remove_friends_test_() ->
{setup,
	fun()->
			Pid = spawn(?MODULE,run,[[sue,grace,fred]]),	
			register(test_remover,Pid)
		end,
	fun(_)->
		unregister(test_remover)
	end,
	
	[ ?_assertEqual(received,rpc(test_remover,{remove,[sue,fred]})),
	  ?_assertEqual(received,rpc(test_remover,{remove,[bob]})),
	  ?_assertEqual(received,rpc(test_remover,{remove,[#{name=>suzannah,age=>23},#{name=>gunhild,age=>20}]}))
	]
}.

get_friends_test_() ->
{setup,
	fun()->
			Pid = spawn(?MODULE,run,[[sue,grace,fred]]),	
			register(test_remover,Pid)
		end,
	fun(_)->
		unregister(test_remover)
	end,
	[ ?_assertEqual([sue,grace,fred],rpc(test_remover,get))
	]
}.

bad_message_test_() ->
	{setup,
	fun()->
			Pid = spawn(?MODULE,run,[[sue,grace,fred]]),	
			register(test_bad_message,Pid)
		end,
	fun(_)->
		unregister(test_bad_message)
	end,
	[ ?_assertMatch({fail, unrecognized_message},rpc(test_bad_message,what)),
	  ?_assertMatch({fail, unrecognized_message},rpc(test_bad_message,nil)),
	  ?_assertMatch({fail, unrecognized_message},rpc(test_bad_message,[])),
	  ?_assertMatch({fail, unrecognized_message},rpc(test_bad_message,{}))
	]
}.

-endif.