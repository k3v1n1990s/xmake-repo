package("sciter-js-sdk")
    set_homepage("https://github.com/k3v1n1990s/sciter-js-sdk")
    set_description("Sciter.JS - Sciter but with QuickJS on board instead of my TIScript")
    add_urls("https://github.com/k3v1n1990s/sciter-js-sdk.git")
    add_versions("4.4.8.34", "d36ec87200673f5d691f9708c3006e5fa14394bd501cadcc892a76ed1b2f9a2e")

    on_install(function (package)
        local configs = {}
        io.writefile("xmake.lua", [[
target("sciter-js-sdk")
   set_kind("headeronly")
   on_install(function (target)
	if is_arch("x64") then
		arch = "x64"
		else
		arch = "x32"
	end
	   os.mkdir(path.join(target:installdir(), "lib"))
       os.cp("./bin/$(plat)/*.exe", path.join(target:installdir(), "lib"))
	   os.cp("./bin/$(plat)/".. arch .. "/*", path.join(target:installdir(), "lib"))
	   os.cp("./bin.lite/$(plat)/" .. arch, path.join(target:installdir(), "lib/lite"))
	   os.cp("./include", path.join(target:installdir(), "include/sciter"))
   end)
        ]])
        if package:config("shared") then
            configs.kind = "shared"
        end
        import("package.tools.xmake").install(package, configs)
    end)

