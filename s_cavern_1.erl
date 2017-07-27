-module(s_cavern_1).
-export([d/0]).

d() ->
  [<<"You see only the darkness of the cavern.">>,
  {c, <<"Venture cautiously.">>, here, '=', s_cavern_2}].