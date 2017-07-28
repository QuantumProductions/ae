-module(world).
-compile(export_all).

newPlayerState() ->
  Here = "cavern1",
  #{here => Here, gems => 0}.

zones() ->
  {ok, Zones} = file:list_dir("zones"),
  Zones.

default() ->
  default(zones(), #{}).
default([], Scenes) ->
  Scenes;
default([H | T], Scenes) ->
  default(T, zone(H, Scenes)).

zone(Name, Scenes) ->
  {ok, ZoneScenes} = file:list_dir("zones/" ++ Name),
  scenes(ZoneScenes, Scenes, Name).

scenes([], Scenes, _) -> Scenes;
scenes([H | T], Scenes, Name) ->
  {ok, SceneData} = file:consult("zones/" ++ Name ++ "/" ++ H),
  AssembledScene = a:a(SceneData),
  scenes(T, maps:put(H, AssembledScene, Scenes), Name).

loadZone(Z, Scenes) ->
  {ok, Module} = compile:file(Z),
  loadScenes(Module:scenes(), Scenes).

loadScenes([], Scenes) ->
  Scenes;
loadScenes([H | T], Scenes) ->
  {ok, SceneModule} = compile:file(H),
  AssembledScene = a:a(SceneModule:d()),
  loadScenes(T, maps:put(H, AssembledScene, Scenes)).
