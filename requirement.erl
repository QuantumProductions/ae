-module(requirement).
-compile(export_all).

go(Requirement) ->
  gen_server:start_link(?MODULE, [Requirement], []).
