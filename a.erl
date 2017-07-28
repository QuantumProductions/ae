-module(a).
-export([a/1]).
-compile(export_all).
-include_lib("eunit/include/eunit.hrl").

add({r, V, O, C, List}) ->
  [{r, V, O, C, a(List)}];
add(Choice = {c, Text, _V, _O, _F}) ->
  {ok, Pid} = choice:create(Choice),
  {c, Text, Pid};
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
  Info = #{here => "cavern"},
  D = [<<"You see a darkness in the cavern.">>,
  {c, <<"Venture cautiously.">>, here, '=', "cavern2"}],
  R = a:a(D),
  [<<"You see a darkness in the cavern.">>,
   {c, <<"Venture cautiously.">>,
   ChoicePid}] = R,
  #{here := "cavern2"} = s:s(ChoicePid, {make, Info}).