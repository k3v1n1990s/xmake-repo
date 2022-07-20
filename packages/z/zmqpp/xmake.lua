package("zmqpp")
    set_homepage("http://zeromq.github.io/zmqpp")
    set_description("0mq 'highlevel' C++ bindings")

    add_urls("https://github.com/zeromq/zmqpp/archive/refs/tags/$(version).tar.gz",
             "https://github.com/zeromq/zmqpp.git")
    add_versions("4.2.0", "c1d4587df3562f73849d9e5f8c932ca7dcfc7d8bec31f62d7f35073ef81f4d29")
    add_deps("zeromq")
    on_install(function (package)
        local configs = {}
        io.writefile("src/zmqpp/zmqpp_export.h", [[
#ifndef ZMQPP_EXPORT_HPP_
#define ZMQPP_EXPORT_HPP_
#define NOMINMAX
#include <winsock2.h>
#define ZMQPP_EXPORT
#endif
        ]])
        io.writefile("xmake.lua", [[
            add_rules("mode.release", "mode.debug")
            add_requires("zeromq")
            target("zmqpp")
               set_kind("static")
               add_defines("ZMQ_STATIC","ZMQPP_STATIC_DEFINE")
               add_headerfiles("src/zmqpp/*.hpp", {prefixdir = "zmqpp"})
               add_headerfiles("src/zmqpp/*.h", {prefixdir = "zmqpp"})
               add_files(
                    "src/zmqpp/actor.cpp",
                    "src/zmqpp/context.cpp",
                    "src/zmqpp/curve.cpp",
                    "src/zmqpp/frame.cpp",
                    "src/zmqpp/loop.cpp",
                    "src/zmqpp/message.cpp",
                    "src/zmqpp/poller.cpp",
                    "src/zmqpp/reactor.cpp",
                    "src/zmqpp/signal.cpp",
                    "src/zmqpp/socket.cpp",
                    "src/zmqpp/z85.cpp",
                    "src/zmqpp/zap_request.cpp",
                    "src/zmqpp/auth.cpp",
                    "src/zmqpp/zmqpp.cpp",
                    "src/zmqpp/proxy.cpp",
                    "src/zmqpp/proxy_steerable.cpp"
               )
               add_packages("zeromq")
        ]])
        if package:config("shared") then
            configs.kind = "shared"
        end
        import("package.tools.xmake").install(package, configs)
    end)
