package("retdec")
    set_homepage("https://retdec.com/")
    set_description("RetDec is a retargetable machine-code decompiler based on LLVM.")
    set_license("MIT")

    if is_host("windows") then
        if os.arch() == "x86" then 
            add_urls("https://github.com/avast/retdec/releases/download/$(version)/retdec-$(version)-windows-32b.7z")
            add_versions("v4.0", "c9b6fc91007c2158209ac730d981a99006a960a27e3b0f54e5618872f34e1afe")
        else
            add_urls("https://github.com/avast/retdec/releases/download/$(version)/retdec-$(version)-windows-64b.7z")
            add_versions("v4.0", "5fc667da3af3530cf3d393f96627987c3e46da62f4b426e78cdcc25a79416a31")
        end
    end

    on_install(function (package)
        os.cp("*", package:installdir())
    end)