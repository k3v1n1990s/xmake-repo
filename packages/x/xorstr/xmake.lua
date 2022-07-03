package("xorstr")
    set_homepage("https://github.com/k3v1n1990s/xorstr")
    set_description("heavily vectorized c++17 compile time string encryption.")
    set_license("Apache-2.0")

    add_urls("https://github.com/k3v1n1990s/xorstr.git")
    add_versions("2021.11.19", "066c64eea5104f4e3cfbc49e39031400e086425a")

    on_install(function (package)
        local configs = {}
        io.writefile("xmake.lua", [[
            add_rules("mode.release", "mode.debug")
            target("xorstr")
               set_kind("headeronly")
               add_headerfiles("**.hpp", {prefixdir = "xorstr"})
        ]])
        if package:config("shared") then
            configs.kind = "shared"
        end
        import("package.tools.xmake").install(package, configs)
    end)
