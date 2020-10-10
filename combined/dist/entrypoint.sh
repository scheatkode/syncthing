#!/bin/sh
${USERHOME}/server/discosrv                                                                       \
    $([ "${SERVER_DEBUG}"        = "false"    ] || echo "-debug")                                 \
    $([ "${SERVER_HTTP}"         = "false"    ] || echo "-http")                                  \
    $([ "${SERVER_METRICS_PORT}" = "disabled" ] || echo "-metrics-listen ${SERVER_METRICS_PORT}") \
    -listen         ":${SERVER_DISCOVERY_PORT}"                                                   \
    -db-dir         "${USERHOME}/db/discosrv.db"                                                  \
    -cert           "${USERHOME}/certs/cert.pem"                                                  \
    -key            "${USERHOME}/certs/key.pem"                                                   \
    ${SERVER_DISCOVERY_OPTS} &
${USERHOME}/server/relaysrv                                                                 \
    $([ "${SERVER_DEBUG}"      = "false"    ] || echo "-debug")                             \
    $([ "{SERVER_STATUS_PORT}" = "disabled" ] || echo "-status-srv ${SERVER_METRICS_PORT}") \
    -listen           ":${SERVER_RELAY_PORT}"                                               \
    -global-rate      "${SERVER_RATE_GLOBAL}"                                               \
    -per-session-rate "${SERVER_RATE_SESSION}"                                              \
    -message-timeout  "${SERVER_MESSAGE_TIMEOUT}"                                           \
    -network-timeout  "${SERVER_NETWORK_TIMEOUT}"                                           \
    -ping-interval    "${SERVER_PING_INTERVAL}"                                             \
    -provided-by      "${SERVER_PROVIDED_BY}"                                               \
    -pools            "${SERVER_POOLS}"                                                     \
    -keys             "${USERHOME}/certs/"                                                  \
    ${SERVER_RELAY_OPTS} &
wait
