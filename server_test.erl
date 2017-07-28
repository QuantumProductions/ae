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

missing_requirement_test() -> 
  {ok, S} = server:go(),
  s:s(S, {join, <<"Sal">>}),  
  [_, {c, _Prompt, Choice}] = s:s(S, {read, <<"Sal">>}),
  s:s(S, {make_choice, <<"Sal">>, Choice}),
  Read2 = [_, {c, _Prompt, Choice2}]= s:s(S, {read, <<"Sal">>}),
  s:s(S, {make_choice, <<"Sal">>, Choice2}),
  [_Text, _, {c, _Prompt2, Choice3}, _] = s:s(S, {read, <<"Sal">>}),
  s:s(S, {make_choice, <<"Sal">>, Choice3}),
  Read3 = s:s(S, {read, <<"Sal">>}),
  Read2 = Read3.

gem_test() ->
  {ok, S} = server:go(),
  s:s(S, {join, <<"Sal">>}),  
  [_, {c, _Prompt, Choice}] = s:s(S, {read, <<"Sal">>}),
  s:s(S, {make_choice, <<"Sal">>, Choice}),
  [_, {c, _Prompt, Choice2}]= s:s(S, {read, <<"Sal">>}),
  s:s(S, {make_choice, <<"Sal">>, Choice2}),
  [_Text, _, {c, _Prompt2, _}, {c, _, Choice4}] = s:s(S, {read, <<"Sal">>}),
  s:s(S, {make_choice, <<"Sal">>, Choice4}),
  [_, _, _, {c, _, Choice5}] = s:s(S, {read, <<"Sal">>}),
  s:s(S, {make_choice, <<"Sal">>, Choice5}),
  s:s(S, {make_choice, <<"Sal">>, Choice5}),
  [_, _, {c, _, Choice6}, _,_,_] = s:s(S, {read, <<"Sal">>}),
  #{here := "town_revive"} = s:s(S, {make_choice, <<"Sal">>, Choice6}).

html_test() ->
  {ok, S} = server:go(),
  s:s(S, {join, <<"Sal">>}),  
  HTML = s:s(S, {read_html, <<"Sal">>}),
  HTML.

