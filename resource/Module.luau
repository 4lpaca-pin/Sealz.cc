--[[
        Module.luau
    Author: 4lpaca
]]

if _G and _G.SealzCore then
    return _G.SealzCore;
end;

local SealzCore = {
    discord = "https://sealz.cc/discord",
};

local HttpService = cloneref(game:GetService('HttpService'));

clonefunction = clonefunction or function(f) return f; end;
identifyexecutor = identifyexecutor or getexecutorname or function()
	return "Seliware", 0.1;
end;
getgenv = getgenv or getfenv;
cloneref = cloneref or function(i) return i end;
getconstant = getconstant or debug.getconstant;
getconstants = getconstants or debug.getconstants;
getupvalue = getupvalue or debug.getupvalue;
getupvalues = getupvalues or debug.getupvalues;
setclipboard = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set);
request = request or http_request or (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request);
sethiddenproperty = sethiddenproperty or set_hidden_property or set_hidden_prop;
gethiddenproperty = gethiddenproperty or get_hidden_property or get_hidden_prop;
gethui = gethui or get_hidden_gui;
getcustomasset = getcustomasset or getsynasset or function(f) return "" end;
_G = _G or getgenv();
isfolder = isfolder or function() end;
makefolder = makefolder or function() end;
delfolder = delfolder or function() end;
listfiles = listfiles or function() end;
writefile = writefile or function() end;
readfile = readfile or function() end;
appendfile = appendfile or function() end;
isfile = isfile or function() end;

_G.SealzCore = SealzCore;

if not isfolder("Sealz") then
    makefolder("Sealz");
end;

if not isfolder("Sealz/Configs") then
    makefolder("Sealz/Configs")
end;

if not isfolder("Sealz/Custom") then
    makefolder("Sealz/Custom")
end;

function SealzCore:EncodeData(data)
	if typeof(data) == "number" then
		return {
			a = "Number",
			b = data,
		};
	elseif typeof(data) == "string" then
		return {
			a = "String",
			b = data
		};
	elseif typeof(data) == "boolean" then
		return {
			a = "Boolean",
			b = data
		};
	elseif typeof(data) == "Color3" then
		return {
			a = "Color",
			b = {
				[1] = data.R,
				[2] = data.G,
				[3] = data.B
			}
		};
	elseif typeof(data) == "table" then
		return {
			a = "Table",
			b = data
		};
	elseif typeof(data) == "EnumItem" then
        return {
            a = data.EnumType,
            b = data.Name,
        };
	elseif typeof(data) == "nil" then
		return {
			a = "Nil",
			b = nil,
		};
	else
		warn(data);
		error("Invalid Data "..debug.traceback());
	end;
end;

function SealzCore:DecodeData(data)
	if data.a == "Number" or data.a == "String" or data.a == "Boolean" or data.a == "Table" or data.a == "Nil" then
		return data.b
	elseif data.a == "Color" then
		return Color3.new(data.b[1],data.b[2],data.b[3])
	elseif data.a == "KeyCode" then
		return Enum.KeyCode[data.b]
	elseif data.a == "UserInputType" then
		return Enum.UserInputType[data.b]
	end
end

do
    if not isfolder("Sealz/Testscript.env") then
        makefolder("Sealz/Testscript.env")
    end;

    if not isfile("Sealz/Testscript.env/sealz.test-env.png") then
        writefile("Sealz/Testscript.env/sealz.test-env.png",game:HttpGet("https://i.ibb.co/TBfbkDzs/image.png"));
    end;

    if not isfile("Sealz/Testscript.env/audio.mp3") then
        writefile("Sealz/Testscript.env/audio.mp3",'unknow');
    end;

    local result = getcustomasset("Sealz/Testscript.env/sealz.test-env.png");
    local audio_test = getcustomasset("Sealz/Testscript.env/audio.mp3");

    if not string.find(audio_test, ".mp3",1,true) and not string.find(audio_test, ".gg",1,true) then
        SealzCore.AssetImageOnly = true;
    end;

    if string.find(result, "Testscript.env" ,1 ,true) or not string.find(result, "sealz.test-env.png" ,1 ,true) then
        SealzCore.AssetRename = true;
    end;
end;

SealzCore.SaveMenuSettings = LPH_NO_VIRTUALIZE(function(MenuSettings)
    local data = {};

    for i,v in next , MenuSettings do
        data[i] = SealzCore:EncodeData(v);
    end;

    local JSON = HttpService:JSONEncode(data);

    writefile("Sealz/Menu.json",JSON);

    return true;
end);

SealzCore.LoadMenuSettings = LPH_NO_VIRTUALIZE(function()
    if isfile("Sealz/Menu.json") then
        local MenuSettings = {};

        local read = readfile("Sealz/Menu.json");
        local JSON = HttpService:JSONDecode(read);

        for i,v in next , JSON do
            MenuSettings[i] = SealzCore:DecodeData(v);
        end;

        return MenuSettings
    end;

    return false;
end);

SealzCore.Hash = function(str)
    local hash = 5381;
    for i = 1, #str do
        local char_code = string.byte(str, i)
        hash = ((hash * 33) + char_code) % 4294967296
    end
    return hash
end;

function SealzCore:ConnectWithInterface(SealzUI)
    SealzCore.EncodeData = SealzUI.EncodeData;
    SealzCore.DecodeData = SealzUI.DecodeData;
end;

SealzCore.GetFileType = function(path)
    local filetype = string.split(path,'.');

    return filetype[#filetype];
end;

SealzCore.GetFileName = function(path)
    return path:match("^.+[\\/]([^\\/]+)$") or path;
end;


SealzCore.GetAsset = function(path)
    if not isfile(path) then
        return;
    end;

    if SealzCore.AssetRename then
        return getcustomasset(path);
    end;

    local Type = SealzCore.GetFileType(path);
    local Hash = SealzCore.Hash(path);
    local CachePath =  "Sealz/Preloads/"..Hash..'.'..Type;

    if not isfolder("Sealz/Preloads") then
        makefolder("Sealz/Preloads");
    end;

    if not isfile(CachePath) then
        writefile(CachePath , readfile(path));
        task.wait();
    end;

    return getcustomasset(CachePath);
end;

return SealzCore;
