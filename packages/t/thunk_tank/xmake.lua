package("thunk_tank")
    set_homepage("https://github.com/k3v1n1990s/thunk_tank")
    set_description("C++11 function thunk type for use with C/C++/whatever APIs that don't provide user data or context pointers")
    set_license("MIT")

    add_urls("https://github.com/k3v1n1990s/thunk_tank.git")
    add_versions("2016.10.10", "1bfb7a08c332f58773b2e153bf007956708778da")

    on_install(function (package)
        local configs = {}
        io.writefile("xmake.lua", [[
            add_rules("mode.release", "mode.debug")
            target("thunk_tank")
               set_kind("headeronly")
               add_headerfiles("*.h", {prefixdir = "thunk_tank"})
        ]])
        if package:config("shared") then
            configs.kind = "shared"
        end
        import("package.tools.xmake").install(package, configs)
    end)
