package("portable-executable-library")
    set_homepage("https://github.com/k3v1n1990s/portable-executable-library")
    set_description("PE Bliss - Cross-Platform Portable Executable C++ Library")

    add_urls("https://github.com/k3v1n1990s/portable-executable-library.git")
    add_versions("2015.04.29", "598b120bf0a51dd48fb73fa648e1953a56c71c73")

    on_install(function (package)
        local configs = {}
        io.writefile("xmake.lua", [[
            add_rules("mode.release", "mode.debug")
            target("portable-executable-library")
               set_kind("$(kind)")
               add_files("pe_lib/*.cpp")
               add_headerfiles("pe_lib/*.h")
        ]])
        if package:config("shared") then
            configs.kind = "shared"
        end
        import("package.tools.xmake").install(package, configs)
    end)

    -- on_test(function (package)
    --     assert(package:has_cfuncs("foo", {includes = "foo.h"}))
    -- end)
