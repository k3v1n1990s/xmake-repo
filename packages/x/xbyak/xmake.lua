package("xbyak")
    set_homepage("https://github.com/k3v1n1990s/xbyak")
    set_description("a JIT assembler for x86(IA-32)/x64(AMD64, x86-64) MMX/SSE/SSE2/SSE3/SSSE3/SSE4/FPU/AVX/AVX2/AVX-512 by C++ header")

    add_urls("https://github.com/k3v1n1990s/xbyak.git")
    add_versions("2022.06.16", "1c35e34abc359d14d7cba2505f2c851354298f5c")

    on_install(function (package)
        local configs = {}
        io.writefile("xmake.lua", [[
            add_rules("mode.release", "mode.debug")
            target("phnt")
               set_kind("headeronly")
               add_headerfiles("xbyak/*.h", {prefixdir = "xbyak"})
        ]])
        if package:config("shared") then
            configs.kind = "shared"
        end
        import("package.tools.xmake").install(package, configs)
    end)
