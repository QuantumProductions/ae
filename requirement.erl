-module(requirement).
-export([met/4]).

met(V, O, C, Info) ->
  case maps:is_key(V, Info) of
    false -> false;
    true -> met(maps:get(V, Info), O, C)
  end.
met(V, '>', C) -> V > C;
met(V, '<', C) -> V < C;
met(V, '=<', C) -> V =< C;
met(V, '<=', C) -> V =< C;
met(V, '>=', C) -> V >= C;
met(V, '=', C) -> V = C;
met(V, '!=', C) -> V =/= C.
