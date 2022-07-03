package("wow64pp")
    set_homepage("https://github.com/k3v1n1990s/wow64pp")
    set_description("A modern c++ implementation of windows heavens gate")
    set_license("Apache-2.0")

    add_urls("https://github.com/k3v1n1990s/wow64pp.git")
    add_versions("2020.09.19", "4573048c41657cf66555a87a736720ab8712cbdd")

    on_install(function (package)
        local configs = {}
        io.writefile("xmake.lua", [[
            add_rules("mode.release", "mode.debug")
            target("phnt")
               set_kind("headeronly")
               add_headerfiles("include/*.hpp")
        ]])
        if package:config("shared") then
            configs.kind = "shared"
        end
        import("package.tools.xmake").install(package, configs)
    end)

