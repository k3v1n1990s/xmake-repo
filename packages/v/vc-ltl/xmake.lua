package("vc-ltl")
    set_homepage("https://github.com/Chuyu-Team/VC-LTL")
    set_description("Shared to msvcrt.dll or ucrtbase.dll and optimize the C/C++ application file size.")
    add_urls("https://github.com/Chuyu-Team/VC-LTL/releases/download/v$(version)/VC-LTL-$(version)-Binary-VS2017.7z")
    add_versions("4.1.3", "c3a8fd29c1a91b9e8844709e14126fba74f60244f3ad7e556bc9671d4f85ec6e")

    on_install(function (package)
        os.cp("*", package:installdir("vc-ltl"))
        os.exec(package:installdir("vc-ltl") .. "/Install.cmd /U")
        os.exec(package:installdir("vc-ltl") .. "/Install.cmd /I")
    end)
