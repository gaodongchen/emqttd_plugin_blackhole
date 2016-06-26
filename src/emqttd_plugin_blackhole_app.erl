%% @doc emqttd plugin blackhole application.
-module(emqttd_plugin_blackhole_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    {ok, Sup} = emqttd_plugin_blackhole_sup:start_link(),
    emqttd_plugin_blackhole:load(application:get_all_env()),

    application:load(gproc),
    application:load(kafkamocker),
    application:load(ekaf),

    application:set_env(ekaf, ekaf_bootstrap_broker, {"localhost", 9092}),

    application:start(gproc),
    application:start(kafkamocker),
    application:start(ekaf),

    {ok, Sup}.

stop(_State) ->
    emqttd_plugin_blackhole:unload().

