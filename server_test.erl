-module(server_test).
-compile(export_all).
-include_lib("eunit/include/eunit.hrl").

connect_test() ->
  {ok, S} = server:go(),
  #{here := _} = s:s(S, {join, <<"Sal">>}).

read_test() -> 
  {ok, S} = server:go(),
  s:s(S, {join, <<"Sal">>}),
  s:s(S, {read, <<"Sal">>}).

choice_test() ->
  {ok, S} = server:go(),
  s:s(S, {join, <<"Sal">>}),
  Read1 = [_, {c, _Prompt, Choice}] = s:s(S, {read, <<"Sal">>}),
  s:s(S, {make_choice, <<"Sal">>, Choice}),
  Read2 = s:s(S, {read, <<"Sal">>}),
  Read1 =/= Read2.