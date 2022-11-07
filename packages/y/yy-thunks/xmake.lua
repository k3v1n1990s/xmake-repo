
package("yy-thunks")
    set_homepage("https://github.com/Chuyu-Team/YY-Thunks")
    set_description("Fix DecodePointer, EncodePointer,RegDeleteKeyEx etc. APIs not found in Windows XP RTM.")
    set_license("MIT")

    add_urls("https://github.com/Chuyu-Team/YY-Thunks/releases/download/v$(version)/YY-Thunks-$(version)-Binary.zip")
    add_versions("1.0.5", "99b8864541fdb41d39ec57456b0145007ce0910ba5da0c079148adf01e2c2f19")
    on_install(function (package)
        os.cp("*", package:installdir("yy-thunks"))
        --import("lib.detect.find_package")
        io.writefile("Install.cmd","reg ADD HKCU\\Code\\YY-Thunks /v Root /t REG_SZ /d \"" ..package:installdir("yy-thunks")..  "\" /f")
        os.exec("Install.cmd")
        print("$(reg HKCU\\Code\\YY-Thunks;Root)")
        io.writefile("$(env LOCALAPPDATA)/.xmake/xmakerc.lua", [=[
before_build("windows", function (target)
	
    local function find_in_file()
        for _, dir in ipairs(os.dirs("$(projectdir)/*")) do
            name = dir:match(".*\\(.*)")
            if name:find("VC%-LTL") then
                return dir .. [[\build\native\]]
            end
        end
    end
	local function find_yy_thunk_in_reg()
		return vformat("$(reg HKEY_CURRENT_USER\\Code\\YY-Thunks;Root)")
	end
    local function find_in_reg()
        return vformat("$(reg HKEY_CURRENT_USER\\Code\\VC-LTL;Root)")
    end
	local YY_Thunks_Root = find_yy_thunk_in_reg()
    local VC_LTL_Root = find_in_file() or find_in_reg()
    if #VC_LTL_Root==0 then
        return
    end
	
	if os.isdir(VC_LTL_Root) == false then
		local p = os.dirs(path.join(import("core.package.package").installdir(), 'v', 'vc-ltl5', '*', '*', 'vc-ltl5'))
		if #p then
			VC_LTL_Root = p[1]
		end
	end
	
    local WindowsTargetPlatformMinVersion = "5.1.2600.0"

    import("core.tool.toolchain")
    local msvc = toolchain.load("msvc")
    local runenvs = msvc:runenvs()

    local includepath = VC_LTL_Root .. [[TargetPlatform\header;]] .. VC_LTL_Root .. [[TargetPlatform\]] .. WindowsTargetPlatformMinVersion..[[\header;]]



    local arch = target:arch()
    local archpath  = "Win32"
    if arch=="x86" then
        archpath = "Win32"
    elseif arch=="x64" then
        archpath = "x64"
    end
    cprint("${color.warning}Platform : %s", archpath)
    local libpath = VC_LTL_Root .. [[TargetPlatform\]] .. WindowsTargetPlatformMinVersion..[[\lib\]] .. archpath .. ";"


    if is_mode("release") then
        cprint("${color.warning}VC-LTL Path : %s", VC_LTL_Root)
        cprint("${color.warning}WindowsTargetPlatformMinVersion : %s", WindowsTargetPlatformMinVersion)
        runenvs.INCLUDE = includepath .. runenvs.INCLUDE
        runenvs.LIB = libpath .. runenvs.LIB
    end

    if(target:kind()=="binary" or target:kind()=="shared") then
		if #YY_Thunks_Root ~= 0 then
			local yy_chunk_path = YY_Thunks_Root .. [[\objs\]] .. arch .. [[\YY_Thunks_for_WinXP.obj]]
			if os.isfile(yy_chunk_path) == false then
				print([[warning: yy thunk not found:]] .. yy_chunk_path)
				return
			end
			
			table.insert(target:objectfiles(), yy_chunk_path)
			target:add("links","advapi32","user32")
		end
        
        
        --print(target:objectfiles())
    end
    print("$(mode)")
    -- print(runenvs.INCLUDE)
    -- print(runenvs.LIB)
    end)
]=])
        --print(package:find_package("vc-ltl5"))
    end)

