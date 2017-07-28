-module(strre).
-export([sub/3,gsub/3]).

sub(Str,Old,New) ->
RegExp = "\\Q"++Old++"\\E",
re:replace(Str,RegExp,New,[multiline, {return, list}]).

gsub(Str,Old,New) ->
RegExp = "\\Q"++Old++"\\E",
re:replace(Str,RegExp,New,[global, multiline, {return, list}]).


