-module(e).
-export([a/2]).
-include_lib("eunit/include/eunit.hrl").

% player info passed in
% Next, PlayerInfo ..
add(B, _Info) when is_binary(B) -> B;
add({r, V, O, C, List}, Info) ->
  case requirement:met(V, O, C, Info) of
    true -> a(List, Info);
    false -> no
  end.

% assemble
a(List, Info) ->
  a(List, [], Info).
a([], Result, _) ->
  lists:flatten(Result);
a([H | T], List, Info) -> 
  case add(H, Info) of
    no -> a(T, List, Info);
    V -> a(T, lists:append(List, [V]), Info)
  end.

basic_test() ->
  Info = #{gems => 1},
  D = [{r, gems, '>', 0, [<<"You see the outline of an invisible wizard">>, <<"But you can't quite tell what kind of wizard.">>]}],
  R = e:a(D, Info),
  R = [<<"You see the outline of an invisible wizard">>, <<"But you can't quite tell what kind of wizard.">>].

% basic_test() ->
  % R = e:a([{r, 1, [<<"cavern">>]},
  %  <<"The bats blink battily">>,  
  %  {r, 5, <<"You do not see the invisible wizard!">>}]),
  % [[<<"cavern">>],<<"The bats blink battily">>] = R.