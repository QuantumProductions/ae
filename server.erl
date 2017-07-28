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
  {reply, Text, State};
handle_call({read_html, Name}, _, State = {_World, Players}) ->
  #{text := Text} = maps:get(Name, Players),
  {reply, html:html(Text), State};
handle_call({make_choice, Name, ChoicePid}, _, State = {World, Players}) ->
  Info = maps:get(Name, Players),
  case makeChoice(ChoicePid, Info, World) of
    false -> {reply, invalid_choice, State};
    Info2 -> {reply, Info2, {World, maps:put(Name, Info2, Players)}}
  end.

makeChoice(Choice, Info, World) when is_binary(Choice) ->
  try list_to_pid(binary_to_list(Choice)) of
    Pid ->
      case is_process_alive(Pid) of
        false -> false;
        true -> makeChoice(Pid, Info, World)
      end
  catch
    _ -> false;
    _:_ -> false
  end;
makeChoice(Choice, Info, World) ->
  Info2 = s:s(Choice, {make, Info}),
  Here = maps:get(here, Info2),
  ZD = maps:get(Here, World),
  ZDE = e:a(ZD, Info2),
  maps:put(text, ZDE, Info2).

default() ->
  {world:default(), #{}}.

init([]) ->
  {ok, default()}.
go() ->
  gen_server:start_link(?MODULE, [], []).