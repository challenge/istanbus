%% @author Mustafa Paltun <mpaltun@gmail.com>
%% @copyright 2012 Mustafa Paltun

%% @doc istanbus_core init here

-module(istanbus_core).
-author('Mustafa Paltun <mpaltun@gmail.com>').
-export([start/0, start_link/0, stop/0]).

ensure_started(App) ->
    case application:start(App) of
        ok ->
            ok;
        {error, {already_started, App}} ->
            ok
    end.

%% @spec start_link() -> {ok,Pid::pid()}
%% @doc Starts the app for inclusion in a supervisor tree
start_link() ->
    ensure_started(crypto),
    istanbus_core_sup:start_link().

%% @spec start() -> ok
%% @doc Start the csd_core server.
start() ->
    ensure_started(crypto),
    application:start(istanbus_core).

%% @spec stop() -> ok
%% @doc Stop the csd_core server.
stop() ->
    Res = application:stop(istanbus_core),
    application:stop(crypto),
    Res.

