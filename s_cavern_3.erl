-module(s_cavern_3).
-export([d/0]).

d() ->
  [<<"You hear a footstep, far too close in your invisible surrounding.">>,
   {r, gems, '>=', 2, 
     [<<"A wizard stands peering confusedly into the faint moonlight.">>,
     {c, <<"Steal his gemstone">>, here, '=', s_town_revive}
   ]},
   <<"Your feet bump into what feels like a pile of gems.">>,
  {c, <<"Retreat1.">>, here, '=', s_cavern_2},
  {r, gems, '<', 4,
  [{c, <<"Pick up a gem">>, gems, '+', 1}]}
  ].