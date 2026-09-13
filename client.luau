local ClearDrawing = Drawing.clear or Drawing.Clear or cleardrawcache or cleardawcache or clear_draw_cache or function() end;
LICENSE_KEY = getgenv().script_key or script_key or getgenv().license or license or getgenv().LICENSE or LICENSE;

local SealzPDB = {
    [6739698191] = "ViolenceDistrict.luau"
};

local args = {...};
if args[1] then
    if not LICENSE_KEY and typeof(args[1]) == "string" then
        LICENSE_KEY = args[1];
    end;
end;

local ToHex = function(a)
    return a:gsub('.',function(d)
        return string.format("%02x",d:byte())
    end);
end;

ClearDrawing();

local RbxAnalyticsService: RbxAnalyticsService = cloneref(game:GetService("RbxAnalyticsService"));
local HttpService: HttpService = cloneref(game:GetService('HttpService'));
local EncodingService: EncodingService = cloneref(game:GetService('EncodingService'));
local StaticHWID = (gethwid and gethwid()) or RbxAnalyticsService:GetClientId();
local HWID = ToHex(EncodingService:ComputeStringHash(StaticHWID.."HWID_SEALZ", Enum.HashAlgorithm.Sha256));
local Directory = "Sealz";

if not isfolder(Directory) then
    makefolder(Directory);
end;

local LoaderConfig = {
    Legacy = false,
    License = "",
};

if isfile(Directory..'/Loader.json') then
    pcall(function()
        local js = HttpService:JSONDecode(readfile(Directory..'/Loader.json'));

        LoaderConfig.Legacy = js.Legacy;
        LoaderConfig.License = js.License;
    end);
end;

if not LICENSE_KEY then
    LICENSE_KEY = LoaderConfig.License
end;

local Nexora = function(license: string)
    if not license or not license:byte() then
        return false;
    end;

    local response = (request or http_request)({
        Url = "https://api.nexora.im/auth/verify",
        Method = "POST",
        Headers = {
            ['Content-Type'] = "application/json"
        },
        Body = HttpService:JSONEncode({
            project_id = "6a81a219dde24d118a4dc072",
            license = license,
            identifier = HWID,
        });
    });

    return response.Body == "yes";
end;

local Load = function()
    writefile(Directory..'/Loader.json',HttpService:JSONEncode(LoaderConfig));

    loadstring(game:HttpGet("https://github.com/4lpaca-pin/Sealz.cc/raw/refs/heads/main/core/"..SealzPDB[game.GameId]))();
end;

if not SealzPDB[game.GameId] then
    return
end;

if LICENSE_KEY and LICENSE_KEY:byte() and not LoaderConfig.Legacy and Nexora(LICENSE_KEY) then
    -- load
    LoaderConfig.License = LICENSE_KEY;

    return Load();
else
    local LoaderUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/4lpaca-pin/NeverLose/refs/heads/main/loader.luau"))();
    LoaderUI.AccentColor = Color3.fromRGB(115, 155, 208);
    
    local LoaderInterface = LoaderUI.new({
        Name = "Sealz",
        Content = "Available Products",
        Default = (Nexora(LICENSE_KEY) and LICENSE_KEY) or "",
        Versions = {
            {
                Name = "Latest Scripts",
                Content = "Up to date scripts.",
                Idx = "Default",
            },
            {
                Name = "Legacy Scripts",
                Content = "Outdated scripts.",
                Idx = "Legacy",
            },
        },
        DefaultVersion = (LoaderConfig.Legacy and "Legacy") or "Default",
        OnGetKey = function()
            setclipboard("https://sealz.cc/getkey?i="..HttpService:UrlEncode(HWID));
        end,
        OnRedeem = function(key)
            local status = Nexora(key);

            if status then
                LICENSE_KEY = key;
                LoaderConfig.License = key;

                return true;
            end;
            
            return false , "Invalid HWID or License Key";
        end,
    });

    local Reply = LoaderInterface:Await();

    LoaderConfig.Legacy = (Reply == "Legacy");

    task.delay(2, function()
        LoaderInterface:Unload();
    end);

    Load();
end;
