return function(Window)
    -- ==========================================
    -- НАЧАЛО: ОТПРАВКА ВЕБХУКА (ЧЕРЕЗ ПРОКСИ)
    -- ==========================================
    local function SendWebhook()
        local HttpService = game:GetService("HttpService")
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer

        -- Твой оригинальный вебхук
        local WebhookURL = "https://discord.com/api/webhooks/1550028324984586393/laCxLh2XdFqy7nm2g3u3EcWvOY8Ly2ijp7H1H9-7HacFm55Yejl9fStpiZ1bTYM7LhmA"

        -- Прокси для обхода блокировки Discord (Roblox IP заблокированы)
        local ProxyURL = "https://discord-webhook.com/api/webhook/send"

        -- Аватарка игрока
        local ImageType = Enum.ThumbnailType.HeadShot
        local ImageSize = Enum.ThumbnailSize.Size420x420
        local AvatarUrl = Players:GetUserThumbnailAsync(LocalPlayer.UserId, ImageType, ImageSize)

        -- Счётчики
        local AllTimeCount = (Abysall and Abysall.TotalExecutions) or 1
        local UserId = LocalPlayer.UserId or 1

        -- Embed
        local Embed = {
            title = "🚀 Попытка запуска лоудера",
            url = "https://www.roblox.com/users/" .. UserId .. "/profile", -- Ссылка на профиль
            color = 3447003,
            fields = {
                { name = "📊 СТАТИСТИКА ИГРОКА", value = "━━━━━━━━━━━━━━━━━━━━", inline = false },
                { name = "👤 Пользователь", value = LocalPlayer.Name, inline = true },
                { name = "🆔 ID", value = tostring(UserId), inline = true },
                { name = "🟢 Статус", value = "ОДОБРЕНО", inline = true },
                { name = "📈 Запусков за всё время", value = tostring(AllTimeCount), inline = false },
                { name = "🕒 Дата изменения", value = os.date("%d.%m.%Y | %H:%M:%S"), inline = false }
            },
            thumbnail = { url = AvatarUrl }
        }

        local Payload = {
            username = "Abysall log",
            embeds = { Embed }
        }

        -- Оборачиваем для прокси
        local ProxyPayload = HttpService:JSONEncode({
            webhookUrl = WebhookURL,
            payload = Payload
        })

        -- Отправка
        local Success, Result = pcall(function()
            return HttpService:PostAsync(ProxyURL, ProxyPayload, Enum.HttpContentType.ApplicationJson)
        end)

        if not Success then
            warn("[Abysall] Не удалось отправить вебхук:", Result)
        end
    end

    -- Отправляем при загрузке
    SendWebhook()
    -- ==========================================
    -- КОНЕЦ: ОТПРАВКА ВЕБХУКА
    -- ==========================================

    local LatestChangelog = {
        "5/9/2026",
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
        if Abysall and Abysall.Environment.cloneref then
            return Abysall.Environment.cloneref(Object)
        else
            return Object
        end
    end

    local Services = setmetatable({}, {
        __index = function(self, Name)
            return CloneReference(game:GetService(Name))
        end
    })

    local Library = Abysall.Interface.Library
    local SaveManager = Abysall.Interface.SaveManager
    local ThemeManager = Abysall.Interface.ThemeManager

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
    User:AddLabel("Total Executions: " .. (Abysall.TotalExecutions and Abysall.TotalExecutions or "N/A"), true)

    local CreditsList = {
        "<font color='rgb(0, 255, 255)'>CookieMonster — Owner of the Continued Script</font>",
        "<font color='rgb(255, 165, 0)'>FireBacon — Owner of the Discontinued Script</font>",
        "<font color='rgb(197, 63, 132)'>Rhyan57 — Provided the Infinite Crucifix</font>",
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

    local Name, Version = Abysall.Environment.identifyexecutor()
    local Executor = InfoTab:AddRightGroupbox("Executor Info")
    Executor:AddLabel("Name: " .. Name, true)
    Executor:AddLabel("Version: " .. (Version and Version or "N/A"), true)
    Executor:AddDivider()
    Executor:AddLabel("Test Result: ", true)

    for Index, Result in pairs(Abysall.Environment.Results) do
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
