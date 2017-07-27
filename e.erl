-module(e).
-export([a/1]).

add(B) when is_binary(B) -> B;
add({r, N, List}) ->
  case N =< 4 of
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