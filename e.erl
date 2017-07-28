-module(e).
-export([a/2]).
-include_lib("eunit/include/eunit.hrl").

% player info passed in
% Next, PlayerInfo ..
add(L, Info) when is_list(L) -> a(L, Info);
add(B, _Info) when is_binary(B) -> B; 
add({r, V, O, C, List1, List2}, Info) ->
  case requirement:met(V, O, C, Info) of
    true -> a(List1, Info);
    false -> a(List2, Info)
  end;
add({r, V, O, C, List}, Info) ->
  case requirement:met(V, O, C, Info) of
    true -> a(List, Info);
    false -> no
  end;
add(Choice = {c, _Text, _ChoicePid}, _Info) ->
  choice:r(Choice).

% assemble
a(List, Info) ->
  a(List, [], Info).
a([], Result, _) ->
  lists:flatten(Result);
a([H | T], List, Info) -> 
  case add(H, Info) of
    no -> a(T, List, Info);
    V -> a(T, lists:append(List, [V]), Info)
  end.

basic_requirement_test() ->
  Info = #{gems => 1},
  D = [{r, gems, '>', 0, [<<"You see the outline of an invisible wizard">>, <<"But you can't quite tell what kind of wizard.">>]}],
  R = e:a(D, Info),
  R = [<<"You see the outline of an invisible wizard">>, <<"But you can't quite tell what kind of wizard.">>].

missing_info_key_test() ->
  Info = #{},
  D = [{r, gems, '>', 4, [<<"A wizard stands peering at the moon. He appears not to notice you.">>]}],  
  R = e:a(D, Info),
  R = [].

met_requirement_test() ->
  Info = #{here => test, gems => 4},
  D = [{r,gems,'>=',2,
  [<<"A wizard stands peering confusedly into the faint moonlight.">>,
      [<<"Steal his gemstone?">>]]}],
  R = e:a(D, Info),
  R.                               

else_test() ->
  Info = #{gems => 1},
  D = [<<"You stand in a puddle of cool water.">>,
      {r, gems, '>', 1, [
        <<"You hear a tone buzzing from your gemstones.">>], 
        [<<"You cannot fathom where this water poured from.">>]}],
  A = a:a(D),
  R = e:a(A, Info),
  [<<"You stand in a puddle of cool water.">>,
 <<"You cannot fathom where this water poured from.">>] = R.

% basic_test() ->
  % R = e:a([{r, 1, [<<"cavern">>]},
  %  <<"The bats blink battily">>,  
  %  {r, 5, <<"You do not see the invisible wizard!">>}]),
  % [[<<"cavern">>],<<"The bats blink battily">>] = R.