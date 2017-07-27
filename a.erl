-module(a).
-export([a/1]).

add(Choice = {c, _Text, _V, _O, _F}) ->
  {c, choice:create(Choice)};
add(Part) -> Part.

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

simple_test() ->
  [<<"You see a darkness in the cavern.">>,
  {c, <<"Venture cautiously.">>, where, '=', 'cavern2'}
  ]