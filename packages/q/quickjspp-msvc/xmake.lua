package("quickjspp-msvc")
set_homepage("https://github.com/k3v1n1990s/quickjspp")
set_description("QuickJS C++ wrapper")

add_urls("https://github.com/k3v1n1990s/quickjspp-msvc.git")
add_versions("2022.12.01", "926a7258cb1c1c20ca5538f89c36fedd5a5868c7")
add_versions("2022.07.22", "e96847db44ff2aefe384a0cdc5b971a3374a9378")
-- add_patches("2022.05.09", "quickjs/patches/getclassid.patch", "b1532231752f3d4eaf1c19c43bd2ebf1b346ae0e2e0f5caa2405c7f67a31ae46")
-- add_patches("2022.05.09", "quickjs/patches/getpropertyvalue_uninitialized_read_fix.patch", "34957cdda69b644b9827b38b792d778145c74626edf1a4fe6bac064739130817")
-- add_patches("2022.05.09", "quickjs/patches/msvc-header-fix.patch", "ebe7aaa1903d3deaac2a794c6414ffba4c93d0986e583124f9da6f8390562d75")
-- add_patches("2022.05.09", "quickjs/patches/unhandled_rejection.patch", "d7a8bf053ceab572ca30c4c026fc4532a8644163099ab7033f467baa9bbe857a")

add_includedirs("include", "include/quickjs")
add_linkdirs("lib")
add_links("quickjs")
on_install(function(package)
    local configs = {}
    io.writefile("xmake.lua", [[
        add_rules("mode.release", "mode.debug")
        option("bignum", {default = true})
        option("strictnan", {default = true})
        option("jsx", {default = false})
        option("qjs", {default = false})
        option("qjsc", {default = false})
        option("storage", {default = false})
        
        target("quickjs")
            set_kind("static")
            set_languages("c17")
            add_includedirs("quickjs/win")
            add_headerfiles("quickjspp.hpp")
            add_headerfiles("quickjs/*.h", {prefixdir = "quickjs"})
            if has_config("strictnan") then add_defines("JS_STRICT_NAN_BOXING") end
            if has_config("bignum") then add_defines("CONFIG_BIGNUM") end
            if has_config("debugger") then add_defines("CONFIG_DEBUGGER") end
            if has_config("qjs") then
              add_files("quickjs/qjs.c", "quickjs/repl.c", "quickjs/qjscalc.c")
            end
            if has_config("qjsc") then
              add_files("quickjs/qjsc.c")
            end
            if has_config("jsx") then add_defines("CONFIG_JSX") end
        
            add_defines("_CRT_SECURE_NO_WARNINGS")
        
            add_files("quickjs/cutils.c", "quickjs/libregexp.c", "quickjs/libunicode.c",
                      "quickjs/quickjs.c", "quickjs/quickjs-libc.c", "quickjs/libbf.c")
            
            if has_config("storage") then
              add_defines("CONFIG_STORAGE")
              add_includedirs("quickjs/storage/dybase/include")
              add_files("quickjs/storage/quickjs-storage.c",
              "quickjs/storage/dybase/src/btree.cpp",
              "quickjs/storage/dybase/src/database.cpp",
              "quickjs/storage/dybase/src/dybase.cpp",
              "quickjs/storage/dybase/src/file.cpp",
              "quickjs/storage/dybase/src/pagepool.cpp")
            end        
        ]])
    if package:config("shared") then configs.kind = "shared" end
    import("package.tools.xmake").install(package, configs)
end)

-- on_test(function(package)
--     assert(package:check_cxxsnippets({
--         test = [[
--             #include <iostream>

--             class MyClass
--             {
--             public:
--                 MyClass() {}
--                 MyClass(std::vector<int>) {}
            
--                 double member_variable = 5.5;
--                 std::string member_function(const std::string& s) { return "Hello, " + s; }
--             };
            
--             void println(qjs::rest<std::string> args) {
--                 for (auto const & arg : args) std::cout << arg << " ";
--                 std::cout << "\n";
--             }
            
--             int test()
--             {
--                 qjs::Runtime runtime;
--                 qjs::Context context(runtime);
--                 try
--                 {
--                     // export classes as a module
--                     auto& module = context.addModule("MyModule");
--                     module.function<&println>("println");
--                     module.class_<MyClass>("MyClass")
--                             .constructor<>()
--                             .constructor<std::vector<int>>("MyClassA")
--                             .fun<&MyClass::member_variable>("member_variable")
--                             .fun<&MyClass::member_function>("member_function");
--                     // import module
--                     context.eval(R"xxx(
--                         import * as my from 'MyModule';
--                         globalThis.my = my;
--                     )xxx", "<import>", JS_EVAL_TYPE_MODULE);
--                     // evaluate js code
--                     context.eval(R"xxx(
--                         let v1 = new my.MyClass();
--                         v1.member_variable = 1;
--                         let v2 = new my.MyClassA([1,2,3]);
--                         function my_callback(str) {
--                           my.println("at callback:", v2.member_function(str));
--                         }
--                     )xxx");
            
--                     // callback
--                     auto cb = (std::function<void(const std::string&)>) context.eval("my_callback");
--                     cb("world");
--                 }
--                 catch(qjs::exception)
--                 {
--                     auto exc = context.getException();
--                     std::cerr << (std::string) exc << std::endl;
--                     if((bool) exc["stack"])
--                         std::cerr << (std::string) exc["stack"] << std::endl;
--                     return 1;
--                 }
--             }
--         ]]
--     }, {
--         configs = {languages = "c++20", defines = "JS_STRICT_NAN_BOXING"},
--         includes = {"quickjspp.hpp"},
        
--     }))
-- end)
