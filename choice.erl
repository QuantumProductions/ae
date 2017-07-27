-module(choice).
-export([r/1]).

r({c, Text, Pid}) ->
  {c, Text, binary:list_to_bin(pid_to_list(Pid)}.

create({c, Text, V, O, F} ->)
  gen_server:start_link(?MODULE, [Text, V, O, F], []),

init([Text, V, O, F]) -> 
  {ok, {V, O, F}}.

% make(Pid, Info) ->
%   Info2 = s:s(Pid, {make, Info}).

% handle_call({make, Info}, _, State = {V, O, F}) ->
%   Value = maps:get(V, Info),
%   Value2 = operate(Value, O, F),
%   Info2 = maps:put(V, Value2, Info),
%   {reply, Info2, State}.

