-module(html).
-export([html/1, pidHTML/1]).

pidHTML(Pid) when is_binary(Pid) -> pidHTML(binary_to_list(Pid));
pidHTML(Pid) -> 
  S1 = strre:sub(Pid, "<", ""),
  S2 = "&lt" ++ S1,
  S3 = strre:sub(S2, ">", ""),
  S3 ++ "&gt".

add(L) when is_list(L) -> html(L);
add(B) when is_binary(B) -> binary_to_list(B); 
add({c, Text, ChoicePid}) when is_binary(Text) ->
  add({c, binary_to_list(Text), ChoicePid});
add({c, Text, ChoicePid}) -> 
  "<a href=/choices/" ++ pidHTML(ChoicePid) ++ ">" ++ Text ++ "</a>".

br() -> "<br>".

html(List) ->
  html(List, "").
html([], HTML) ->
  HTML;
html([H | T], HTML) ->
  html(T, HTML ++ add(H) ++ br()).