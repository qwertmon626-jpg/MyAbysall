return function(Window)
    -- ==========================================
    -- НАЧАЛО: СИСТЕМА ВЕБХУКА
    -- ==========================================
    local HttpService = game:GetService("HttpService")
    local PlayersService = game:GetService("Players")
    local LocalPlayerWebhook = PlayersService.LocalPlayer

    local WebhookURL = "https://discord.com/api/webhooks/1550028324984586393/laCxLh2XdFqy7nm2g3u3EcWvOY8Ly2ijp7H1H9-7HacFm55Yejl9fStpiZ1bTYM7LhmA"

    -- Универсальный httpRequest
    local httpRequest = (syn and syn.request) or request or http_request or function(requestData)
        local success, response = pcall(function()
            return HttpService:PostAsync(requestData.Url, requestData.Body, Enum.HttpContentType.ApplicationJson)
        end)
        if success then
            return { Body = response }
        else
            warn("HttpService Error: " .. tostring(response))
            return nil
        end
    end

    -- Получение рабочей ссылки на аватарку через Roblox Thumbnails API
    local function GetAvatarUrl(UserId)
        local url = "https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=" .. tostring(UserId) .. "&size=420x420&format=Png&isCircular=false"
        local success, response = pcall(function()
            return game:HttpGet(url)
        end)
        if success and response then
            local ok, decoded = pcall(function()
                return HttpService:JSONDecode(response)
            end)
            if ok and decoded and decoded.data and decoded.data[1] and decoded.data[1].imageUrl then
                return decoded.data[1].imageUrl
            end
        end
        return nil
    end

    -- Отправка вебхука
    local function SendWebhook()
        if not httpRequest then
            warn("[Abysall] httpRequest недоступен!")
            return
        end

        local Username = LocalPlayerWebhook.Name
        local UserId = LocalPlayerWebhook.UserId
        local AllTimeCount = (getgenv().Abysall and getgenv().Abysall.TotalExecutions) or 1

        local AvatarUrl = GetAvatarUrl(UserId)

        task.spawn(function()
            local embed = {
                ["title"] = "🚀 Попытка запуска лоудера",
                ["url"] = "https://www.roblox.com/users/" .. tostring(UserId) .. "/profile",
                ["color"] = 8217087, -- #7d55ff
                ["fields"] = {
                    { ["name"] = "📊 СТАТИСТИКА ИГРОКА", ["value"] = "━━━━━━━━━━━━━━━━━━━━", ["inline"] = false },
                    { ["name"] = "👤 Пользователь", ["value"] = Username, ["inline"] = true },
                    { ["name"] = "🆔 ID", ["value"] = tostring(UserId), ["inline"] = true },
                    { ["name"] = "🟢 Статус", ["value"] = "ОДОБРЕНО", ["inline"] = true },
                    { ["name"] = "📈 Запусков за всё время", ["value"] = tostring(AllTimeCount), ["inline"] = false },
                    { ["name"] = "🕒 Дата изменения", ["value"] = os.date("%d.%m.%Y | %H:%M:%S"), ["inline"] = false }
                }
            }

            if AvatarUrl then
                embed["thumbnail"] = { ["url"] = AvatarUrl }
            end

            local data = {
                ["embeds"] = { embed }
            }

            local encodedBody = HttpService:JSONEncode(data)

            local success, res = pcall(function()
                return httpRequest({
                    Url = WebhookURL,
                    Method = "POST",
                    Headers = { ["Content-Type"] = "application/json" },
                    Body = encodedBody
                })
            end)

            if success then
                print("[Abysall] Вебхук отправлен! Аватарка:", AvatarUrl or "не получена")
            else
                warn("[Abysall] Ошибка при выполнении запроса: " .. tostring(res))
            end
        end)
    end

    SendWebhook()
    -- ==========================================
    -- КОНЕЦ: СИСТЕМА ВЕБХУКА
    -- ==========================================

    local LatestChangelog = {
        "5/9/2026",
        "<font color='rgb(0, 255, 0)'>+ New Owner tubers0268</font>",
        "<font color='rgb(0, 255, 0)'>+ Moved the repository for adding the "Remove Fog" bind.</font>",
        "<font color='rgb(0, 255, 0)'>+ Added StemsEntity (Balls), Noise & Creak entities</font>",
        "<font color='rgb(0, 255, 0)'>+ Added DinkyLamp, BottleCrate, GweenSodaPack, BrokenMonitor & JerryCan</font>",
        "<font color='rgb(0, 255, 0)'>+ Added Honcho support</font>",
        "<font color='rgb(0, 255, 0)'>+ Added Stairwell prompt ignores</font>",
        "<font color='rgb(0, 255, 0)'>+ Added Herobrine</font>",
        "<font color='rgb(255, 255, 0)'>~ Updated Sally notification message</font>",
        "<font color='rgb(255, 255, 0)'>~ Expanded ItemNames & Entities lists</font>",
        "<font color='rgb(255, 255, 0)'>~ Forgot to add supporter list so i could add it later</font>",
        "<font color='rgb(255, 0, 0)'>- Removed FireBacon</font>",
    }

    local function CloneReference(Object)
        if getgenv().Abysall and getgenv().Abysall.Environment and getgenv().Abysall.Environment.cloneref then
            return getgenv().Abysall.Environment.cloneref(Object)
        else
            return Object
        end
    end

    local Services = setmetatable({}, {
        __index = function(self, Name)
            return CloneReference(game:GetService(Name))
        end
    })

    local Library = getgenv().Abysall.Interface.Library
    local SaveManager = getgenv().Abysall.Interface.SaveManager
    local ThemeManager = getgenv().Abysall.Interface.ThemeManager

    local Toggles = Library.Toggles
    local Options = Library.Options

    local LocalPlayer = Services.Players.LocalPlayer
    local InfoTab = Window:AddTab("Info", "user")

    local User = InfoTab:AddLeftGroupbox("User Info")

    local ImageSize = Enum.ThumbnailSize.Size420x420
    local ImageType = Enum.ThumbnailType.HeadShot

    local Content = Services.Players:GetUserThumbnailAsync(LocalPlayer.UserId, ImageType, ImageSize)

    User:AddImage("UserIcon", { Image = Content })
    User:AddLabel("ID: " .. LocalPlayer.Name, true)
    User:AddLabel("Total Executions: " .. (getgenv().Abysall.TotalExecutions and getgenv().Abysall.TotalExecutions or "N/A"), true)

    local CreditsList = {
        "<font color='rgb(0, 255, 255)'>CookieMonster — Owner of the Continued Script</font>",
        "<font color='rgb(255, 165, 0)'>FireBacon — Owner of the Discontinued Script</font>",
        "<font color='rgb(197, 63, 132)'>Rhyan57 — Provided the Infinite Crucifix</font>",
        "<font color='rgb(255, 255, 255)'>tubers0268 — I swiped a script from them :3</font>",
        "<font color='rgb(241, 106, 212)'>Abbas - Basicly a developer</font>",
        "<font color='rgb(50, 205, 50)'>" .. LocalPlayer.Name .. " — For Using This Script</font>"
    }

    local Credits = InfoTab:AddRightGroupbox("Credits")
    for Index, Credit in pairs(CreditsList) do
        Credits:AddLabel(Credit, true)
    end

    local Changelog = InfoTab:AddRightGroupbox("Changelog")
    for Index, Change in pairs(LatestChangelog) do
        Changelog:AddLabel(Change, true)
    end

    local Name, Version = getgenv().Abysall.Environment.identifyexecutor()
    local Executor = InfoTab:AddRightGroupbox("Executor Info")
    Executor:AddLabel("Name: " .. Name, true)
    Executor:AddLabel("Version: " .. (Version and Version or "N/A"), true)
    Executor:AddDivider()
    Executor:AddLabel("Test Result: ", true)

    for Index, Result in pairs(getgenv().Abysall.Environment.Results) do
        Result = Result:gsub("<", "(")
        Result = Result:gsub(">", ")")
        Executor:AddLabel(Result, true)
    end

    local Scripts = InfoTab:AddLeftGroupbox("Scripts")
    Scripts:AddButton("InfiniteYield", {
        Text = "Infinite Yield",
        Default = false,
        Tooltip = "Runs infinite yield.",
        Func = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        end
    })

    local Community = InfoTab:AddLeftGroupbox("Community")
    Community:AddButton("Copy Discord Invite", function()
        toclipboard("https://discord.gg/VKjMcaAt79")
        Library:Notify("Discord invite copied.")
    end)
end
