package("call_thunk")
    set_homepage("https://github.com/k3v1n1990s/call_thunk")
    set_description("Take the member function of the C++ class as the callback function of the C function")
    set_license("Apache-2.0")

    add_urls("https://github.com/k3v1n1990s/call_thunk.git")
    add_versions("2018.12.24", "f4b16151f15a27bbc5ac939ee9053ebc4bf71790")

    on_install(function (package)
        io.writefile("xmake.lua", [[
            add_rules("mode.release", "mode.debug")
            target("call_thunk")
               set_kind("static")
               add_headerfiles("./*.h")
               add_files("./call_thunk.cpp")
        ]])
        import("package.tools.xmake").install(package)
    end)

