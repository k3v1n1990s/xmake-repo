package("vc-ltl5")
    set_homepage("https://github.com/Chuyu-Team/VC-LTL5")
    set_description("Shared to msvcrt.dll or ucrtbase.dll and optimize the C/C++ application file size.")

    add_urls("https://github.com/Chuyu-Team/VC-LTL5/releases/download/v$(version)/VC-LTL-$(version)-Binary.7z")
    add_versions("5.0.5", "fcc2676d3fabfdbd09f4f09ec71db0a14a3d5087dbf8851269c52a3a5bc45ba3")

    on_install(function (package)
        os.cp("*", package:installdir("vc-ltl5"))
        os.exec(package:installdir("vc-ltl5") .. "/Install.cmd /U")
        os.exec(package:installdir("vc-ltl5") .. "/Install.cmd /I")
    end)
