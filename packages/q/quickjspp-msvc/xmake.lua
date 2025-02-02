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
            set_kind("$(kind)")
			if(is_kind("shared")) then
				add_rules("utils.symbols.export_list", {
          symbols = {
            "JS_AddIntrinsicBaseObjects",
"JS_AddIntrinsicBigDecimal",
"JS_AddIntrinsicBigFloat",
"JS_AddIntrinsicBigInt",
"JS_AddIntrinsicDate",
"JS_AddIntrinsicEval",
"JS_AddIntrinsicJSON",
"JS_AddIntrinsicMapSet",
"JS_AddIntrinsicOperators",
"JS_AddIntrinsicPromise",
"JS_AddIntrinsicProxy",
"JS_AddIntrinsicRegExp",
"JS_AddIntrinsicRegExpCompiler",
"JS_AddIntrinsicStringNormalize",
"JS_AddIntrinsicTypedArrays",
"JS_AddModuleExport",
"JS_AddModuleExportList",
"JS_AreFunctionsOfSameOrigin",
"JS_AtomGetKind",
"JS_AtomGetStr",
"JS_AtomGetStrRT",
"JS_AtomIsArrayIndex",
"JS_AtomIsSymbol",
"JS_AtomToCString",
"JS_AtomToString",
"JS_AtomToValue",
"JS_Call",
"JS_CallConstructor",
"JS_CallConstructor2",
"JS_ComputeMemoryUsage",
"JS_CopyDataProperties",
"JS_DefineProperty",
"JS_DefinePropertyGetSet",
"JS_DefinePropertyValue",
"JS_DefinePropertyValueInt64",
"JS_DefinePropertyValueStr",
"JS_DefinePropertyValueUint32",
"JS_DefinePropertyValueValue",
"JS_DeleteProperty",
"JS_DeletePropertyInt64",
"JS_DetachArrayBuffer",
"JS_DetectModule",
"JS_DumpMemoryUsage",
"JS_DupAtom",
"JS_DupAtomRT",
"JS_DupContext",
"JS_EnableBignumExt",
"JS_EnqueueJob",
"JS_Eval",
"JS_Eval2",
"JS_EvalFunction",
"JS_EvalThis",
"JS_ExecutePendingJob",
"JS_FreeAtom",
"JS_FreeAtomRT",
"JS_FreeCString",
"JS_FreeContext",
"JS_FreeRuntime",
"JS_GetArrayBuffer",
"JS_GetClassID",
"JS_GetClassName",
"JS_GetClassProto",
"JS_GetContextOpaque",
"JS_GetException",
"JS_GetFastArray",
"JS_GetGlobalObject",
"JS_GetImportMeta",
"JS_GetModuleExportItem",
"JS_GetModuleExportItemStr",
"JS_GetModuleName",
"JS_GetOpaque",
"JS_GetOpaque2",
"JS_GetOwnProperty",
"JS_GetOwnPropertyNames",
"JS_GetPropertyInternal",
"JS_GetPropertyLength",
"JS_GetPropertyStr",
"JS_GetPropertyUint32",
"JS_GetPrototype",
"JS_GetPrototypeOfDate",
"JS_GetRuntime",
"JS_GetRuntimeOpaque",
"JS_GetScriptOrModuleName",
"JS_GetTupleTag",
"JS_GetTypedArrayBuffer",
"JS_HasProperty",
"JS_Invoke",
"JS_IsArray",
"JS_IsCFunction",
"JS_IsConstructor",
"JS_IsDate",
"JS_IsError",
"JS_IsExtensible",
"JS_IsFunction",
"JS_IsFunctionOfThisRealm",
"JS_IsInstanceOf",
"JS_IsJobPending",
"JS_IsLiveObject",
"JS_IsObjectPlain",
"JS_IsRegisteredClass",
"JS_IsTuple",
"JS_IsUncatchableError",
"JS_JSONStringify",
"JS_MarkValue",
"JS_NewArray",
"JS_NewArrayBuffer",
"JS_NewArrayBufferCopy",
"JS_NewAtom",
"JS_NewAtomLen",
"JS_NewAtomLenRT",
"JS_NewAtomString",
"JS_NewAtomSymbolLenRT",
"JS_NewAtomUInt32",
"JS_NewBigInt64",
"JS_NewBigInt64_1",
"JS_NewBigUint64",
"JS_NewCFunction2",
"JS_NewCFunctionData",
"JS_NewCModule",
"JS_NewClass",
"JS_NewClassID",
"JS_NewContext",
"JS_NewContextRaw",
"JS_NewDate",
"JS_NewError",
"JS_NewFastArray",
"JS_NewObject",
"JS_NewObjectClass",
"JS_NewObjectProto",
"JS_NewObjectProtoClass",
"JS_NewPromiseCapability",
"JS_NewRuntime",
"JS_NewRuntime2",
"JS_NewString",
"JS_NewStringLen",
"JS_ParseJSON",
"JS_ParseJSON2",
"JS_PreventExtensions",
"JS_ReadObject",
"JS_ReadObject2",
"JS_ResetUncatchableError",
"JS_ResolveModule",
"JS_RunGC",
"JS_RunModule",
"JS_SetCanBlock",
"JS_SetClassProto",
"JS_SetConstructor",
"JS_SetConstructorBit",
"JS_SetContextOpaque",
"JS_SetGCThreshold",
"JS_SetHostPromiseRejectionTracker",
"JS_SetHostUnhandledPromiseRejectionTracker",
"JS_SetInterruptHandler",
"JS_SetIsHTMLDDA",
"JS_SetMaxStackSize",
"JS_SetMemoryLimit",
"JS_SetModuleExport",
"JS_SetModuleExportList",
"JS_SetModuleLoaderFunc",
"JS_SetOpaque",
"JS_SetPropertyFunctionList",
"JS_SetPropertyInt64",
"JS_SetPropertyInternal",
"JS_SetPropertyStr",
"JS_SetPropertyUint32",
"JS_SetPrototype",
"JS_SetRuntimeInfo",
"JS_SetRuntimeOpaque",
"JS_SetSharedArrayBufferFunctions",
"JS_SetUncatchableError",
"JS_ThisTimeValue",
"JS_Throw",
"JS_ThrowInternalError",
"JS_ThrowOutOfMemory",
"JS_ThrowRangeError",
"JS_ThrowReferenceError",
"JS_ThrowSyntaxError",
"JS_ThrowTypeError",
"JS_ToBigInt64",
"JS_ToBool",
"JS_ToCStringLen2",
"JS_ToFloat64",
"JS_ToIndex",
"JS_ToInt32",
"JS_ToInt32Clamp",
"JS_ToInt32Sat",
"JS_ToInt64",
"JS_ToInt64Clamp",
"JS_ToInt64Ext",
"JS_ToInt64Sat",
"JS_ToPropertyKey",
"JS_ToString",
"JS_ToStringInternal",
"JS_UpdateStackTop",
"JS_ValueToAtom",
"JS_WriteObject",
"JS_WriteObject2",
"js_free",
"js_free_prop_enum",
"js_free_rt",
"js_init_module_os",
"js_init_module_std",
"js_load_file",
"js_malloc",
"js_malloc_rt",
"js_malloc_usable_size",
"js_malloc_usable_size_rt",
"js_mallocz",
"js_mallocz_rt",
"js_module_loader",
"js_module_set_import_meta",
"js_parse_error",
"js_realloc",
"js_realloc2",
"js_realloc_rt",
"js_std_add_helpers",
"js_std_dump_error",
"js_std_eval_binary",
"js_std_free_handlers",
"js_std_init_handlers",
"js_std_loop",
"js_std_promise_rejection_tracker",
"js_std_set_worker_new_context_func",
"js_strdup",
"js_string_codePointRange",
"js_strndup",
"__JS_FreeValue",
"__JS_FreeValueRT"
          }
        })
			end
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
