-module(server_test).
-compile(export_all).
-include_lib("eunit/include/eunit.hrl").

connect_test() ->
  {ok, S} = server:go(),
  #{here := _} = s:s(S, {join, <<"Sal">>}).
