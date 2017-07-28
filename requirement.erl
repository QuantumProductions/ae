-module(requirement).
-export([met/4, inverse/1]).

met(V, O, C, Info) ->
  case maps:is_key(V, Info) of
    false -> met(0, O, C);
    true -> met(maps:get(V, Info), O, C)
  end.
met(V, '>', C) -> V > C;
met(V, '<', C) -> V < C;
met(V, '=<', C) -> V =< C;
met(V, '<=', C) -> V =< C;
met(V, '>=', C) -> V >= C;
met(V, '=', C) -> V = C;
met(V, '!=', C) -> V =/= C.

inverse('>') -> '<=';
inverse('<') -> '>=';
inverse('=<') -> '>';
inverse('<=') -> '>';
inverse('>=') -> '<';
inverse('=') -> '!=';
inverse('!=') -> '='.