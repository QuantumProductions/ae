-module(block).
-compile(export_all).

% handle_call({render, Player}, _, State = {Requirement, Text, [Options]} ->
%   case passesRequirement(Player, Requirement) of
%     false -> {reply, null, State};
%     true -> {reply, renderReply(Text, Options)
%      ...return #{text => Text, options => AllowedOptions}



  % {Requirement, Text, [Options]}

block(String) ->
  A = {Requirement, Text, Options} = parser:ee(String),
  A.

init([String]) -> 
  {ok, block(String)}.

go(String) ->
  gen_server:start_link(?MODULE, [String], []).
