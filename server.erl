-module(server).
-compile(export_all).

handle_call(info, _, State) ->
  {reply, State, State};
handle_call({join, Name}, _, {World, Players}) ->
  StartingPlayerState = world:newPlayerState(),
  Here = maps:get(here, StartingPlayerState),
  ZoneData = maps:get(Here, World),
  ZoneDataEvaluated = e:a(ZoneData, StartingPlayerState),
  StartingPlayerStateWithText = maps:put(text, ZoneDataEvaluated, StartingPlayerState),
  Players2 = maps:put(Name, StartingPlayerStateWithText, Players),
  {reply, StartingPlayerState, {World, Players2}};
handle_call({read, Name}, _, State = {_World, Players}) ->
  #{text := Text} = maps:get(Name, Players),
  {reply, Text, State}.

default() ->
  {world:default(), #{}}.

init([]) ->
  {ok, default()}.
go() ->
  gen_server:start_link(?MODULE, [], []).