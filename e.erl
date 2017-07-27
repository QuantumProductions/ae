-module(e).
-export([a/1]).

% player info passed in
% Next, PlayerInfo ..
add(B) when is_binary(B) -> B;
add({r, V, O, C, List}) ->
  case requirement:met(V, O, C, PlayerInfo) of
    true -> a(List);
    false -> no
  end.

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