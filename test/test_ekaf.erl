
-module(test_ekaf).

-export([test/0]).

test() ->
    application:load(gproc),
    application:load(kafkamocker),
    application:load(ekaf),

    application:set_env(ekaf, ekaf_bootstrap_broker, {"localhost", 9092}),

    application:start(gproc), 
    application:start(kafkamocker),
    application:start(ekaf),

    Topic = <<"test">>,
    ekaf:produce_sync(Topic, <<"foo">>).

