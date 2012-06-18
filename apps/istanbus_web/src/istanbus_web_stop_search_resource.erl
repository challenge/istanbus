%% @author Mustafa Paltun <mpaltun@gmail.com>
%% @copyright 2012 mpaltun.
%% @doc istanbus webmachine_resource.

-module(istanbus_web_stop_search_resource).
-export([init/1, to_json/2, content_types_provided/2]).

-include_lib("webmachine/include/webmachine.hrl").

init([]) -> 
    {ok, undefined}.

content_types_provided(ReqData, Context) ->
   {[{"application/json",to_json}], ReqData, Context}.

to_json(ReqData, Context) ->
    Keyword = wrq:path_info(keyword, ReqData),
    DecodedKeyword = unicode:characters_to_list(list_to_binary(http_uri:decode(Keyword)), utf8),
    Keywords = re:split(DecodedKeyword, " ", [{return, list}]),
    Stops = istanbus_core_stop_module:search(Keywords),
    {mochijson2:encode(Stops),  ReqData, Context}.