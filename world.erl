-module(world).
-compile(export_all).

newPlayerState() ->
  Here = s_cavern_1,
  #{here => Here, gems => 0}.

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

zones() ->
  [z_cavern].