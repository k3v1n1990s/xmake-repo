package("detours")
    set_homepage("https://github.com/k3v1n1990s/Detours")
    set_description("Detours is a software package for monitoring and instrumenting API calls on Windows.  It is distributed in source code form.")
    set_license("MIT")

    add_urls("https://github.com/k3v1n1990s/detours.git")
    add_versions("2022.04.26", "2ec2a2a83e4b04d8485e538ee7a31e9222225fe6")

    on_install(function (package)
        local configs = {}
        io.writefile("xmake.lua", [[
            add_rules("mode.release", "mode.debug")
            target("detours")
               set_kind("$(kind)")
               add_headerfiles("src/*.h")
               add_files("src/detours.cpp","src/disasm.cpp","src/image.cpp","src/modules.cpp")
        ]])
        if package:config("shared") then
            configs.kind = "shared"
        end
        import("package.tools.xmake").install(package, configs)
    end)

