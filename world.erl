-module(world).
-compile(export_all).

handle_call(_, _, State) ->
  {reply, State, State}.

default() ->
  default(zones(), #{}).
default([], Scenes) ->
  Scenes;
default([H | T], Scenes) ->
  default(T, loadZone(H, Scenes)).

loadZone(Z, Scenes) ->
  {ok, Module} = compile:file(Z),
  loadScenes(Module:scenes(), Scenes).

loadScenes([], Scenes) ->
  Scenes;
loadScenes([H | T], Scenes) ->
  {ok, SceneModule} = compile:file(H),
  AssembledScene = a:a(SceneModule:d()),
  loadScenes(T, maps:put(H, AssembledScene, Scenes)).

init([]) ->
  {ok, default()}.

go() ->
  gen_server:start_link(?MODULE, [], []).

zones() ->
  [z_cavern].