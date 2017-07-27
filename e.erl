-module(e).
-export([a/1]).
-include_lib("eunit/include/eunit.hrl").

% player info passed in
% Next, PlayerInfo ..
add(B) when is_binary(B) -> B;
add({r, N, List}) ->
  case N =< 4 of
    true -> a(List);
    false -> no
  end.


% add({r, V, O, C, List}) ->
%   case requirement:met(V, O, C, PlayerInfo) of
%     true -> a(List);
%     false -> no
%   end.

% assemble
a(List) ->
  a(List, []).
a([], Result) ->
  Result;
a([H | T], List) -> 
  case add(H) of
    no -> a(T, List);
    V -> a(T, lists:append(List, [V]))
  end.

basic_test() ->
  R = e:a([{r, 1, [<<"cavern">>]},
   <<"The bats blink battily">>,  
   {r, 5, <<"You do not see the invisible wizard!">>}]),
  [[<<"cavern">>],<<"The bats blink battily">>] = R.