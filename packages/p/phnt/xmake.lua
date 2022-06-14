package("phnt")
    set_homepage("https://github.com/processhacker/processhacker")
    set_description("Native API header files for the Process Hacker project.")

    add_urls("https://github.com/k3v1n1990s/phnt.git")
    add_versions("2022.05.13", "0f32b6e51337b0527344e9c280a6bc6e2b333db0")

    on_install(function (package)
        local configs = {}
        io.writefile("xmake.lua", [[
            add_rules("mode.release", "mode.debug")
            target("phnt")
               set_kind("headeronly")
               add_headerfiles("*.h")
        ]])
        if package:config("shared") then
            configs.kind = "shared"
        end
        import("package.tools.xmake").install(package, configs)
    end)
