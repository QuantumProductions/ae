-module(server).
-compile(export_all).

handle_call(info, _, State) ->
  {reply, State, State};
handle_call({join, Name}, _, {World, Players}) ->
  StartingPlayerState = world:newPlayerState(),
  Here = maps:get(here, StartingPlayerState),
  ZoneData = maps:get(Here, World),
  % Status = 
  % TODO: e:a(Data)
  % ignoring any kind of additional UI, simple!
  StartingPlayerStateWithText = maps:put(text, ZoneData, StartingPlayerState),
  Players2 = maps:put(Name, StartingPlayerStateWithText, Players),
  {reply, StartingPlayerState, {World, Players2}}.

default() ->
  {world:default(), #{}}.

init([]) ->
  {ok, default()}.
go() ->
  gen_server:start_link(?MODULE, [], []).