-- ====================================================================
-- 🚀 АВТОРСКИЙ ИМБА-ЛОАДЕР ДЛЯ ABYSALL HUB (DOORS)
-- ====================================================================
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

-- Ожидаем полной загрузки локального игрока
local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
	task.wait(0.1)
	LocalPlayer = Players.LocalPlayer
end

-- Ссылка на твой основной скрипт Doors
local ScriptURL = "https://raw.githubusercontent.com/qwertmon626-jpg/MyAbysall/refs/heads/main/Games/Doors/Main.luau"

-- Безопасный прокси для вебхука (скрывает реальный домен Discord)
local RawWebhook = "https://discord.com"
local WebhookURL = string.gsub(RawWebhook, "discord.com", "webhook.lewisakura.moe")

-- Кросс-платформенный HTTP-клиент для эксплойтов
local httpRequest = (syn and syn.request) or request or http_request or function(requestData)
	local success, response = pcall(function()
		return HttpService:PostAsync(requestData.Url, requestData.Body, Enum.HttpContentType.ApplicationJson)
	end)
	if success then return { Body = response } else return nil end
end

-- ====================================================================
-- 🖨️ ВЫВОД ПИКСЕЛЬНОГО ASCII-АРТА ПРИВЕТСТВИЯ
-- ====================================================================
local PixelArt = [[
█░█ █▀▀ █▄█ ░   █▄█ █▀█ █░█ ▀ █░█ █▀▀   █░░ ▄▀█ █░█ █▄░█ █▀▀ █░█ █▀▀ █▀▄   █▀▄▀█ █▄█   █▀▀ █ █▀█ █▀ ▀█▀
█▀█ ██▄ ░█░ █   ░█░ █▄█ █▄█ ░ ▀▄▀ ██▄   █▄▄ █▀█ █▄█ █░▀█ █▄▄ █▀█ ██▄ █▄▀   █░▀░█ ░█░   █▀░ █ █▀▄ ▄█ ░█░

█▀ █▀▀ █▀█ █ █▀█ ▀█▀ ░   █▄█ █▀█ █░█ ▀ █▀█ █▀▀  empty░ █▄░█   ▀█▀ █░█ █▀▀   █░░ █▀█ ▄▀█ █▀▄ █▀▀ █▀█
▄█ █▄▄ █▀▄ █ █▀▀ ░█░ ▄   ░█░ █▄█ █▄█ ░ █▀▄ ██▄   █ █░▀█   ░█░ █▀█ ██▄  微█▄▄ █▄█ █▀█ █▄▀ ██▄ █▀▄

█▀█ █ █▀▀ █░█ ▀█▀   █▄░█ █▀█ █░█░█   ▀█▀ █░█ █▀▀   █▀ █▀▀ █▀█ █ █▀█ ▀█▀   █░█░█ █ █░░ █░░
█▀▄ █ █▄█ █▀█ ░█░   █░▀█ █▄█ ▀▄▀▄▀   ░█░ █▀█ ██▄   ▄█ █▄▄ █▀▄ █ █▀▀ ░█░   ▀▄▀▄▀ █ █▄▄ █▄▄

█▀█ █▀▀ █▀▄ █ █▀█ █▀▀ █▀▀ ▀█▀   █▄█ █▀█ █░█   █▀ █▀█ █▀█ █▄░█ ░   █▀█ █▄░█ █▀▀ █▀▀  推█▄█ █▀█ █░█ ▀ █▀█ █▀▀
█▀▄ ██▄ █▄▀ █ █▀▄ ██▄ █▄▄ ░█░   ░█░ █▄█ █▄█   ▄█ █▄█ █▄█ █░▀█ ▄   █▄█ █░▀█ █▄▄ ██▄   ░█░ █▄█ █▄█ ░ █▀▄ ██▄

█▀▄▀█ █▀█ █░█ █▀▀ █▀▄   █▀█ █░█ █▀▀ █▀█ ░   █▄█ █▀█ █░█ ▀ █░░ █░░   █▀ █▀▀ █▀▀   ▄▀█   █▀▄▀█ █▀▀ █▀ █▀ ▄▀█ █▀▀ █▀▀
█░▀░█ █▄█ ▀▄▀ ██▄ █▄▀   █▄█ ▀▄▀ ██▄ █▀▄ █   ░█░ █▄█ █▄█ ░ █▄▄ █▄▄   ▄█ ██▄ ██▄   █▀█   █░▀░█ ██▄ ▄█ ▄█ █▀█ █▄█ ██▄

█░█░█ █░█ █▀▀ █▄░█   █▄█ █▀█ █░█   █▀█ █▀█ █▀▀ █▀ █▀   █▀▀ █▀█ ░   ▄▀█ █▄░█ █▄█ █░█░█ ▄▀█ █▄█ ░   █░█ ▄▀█ █░█ █▀▀   ▄▀█
▀▄▀▄▀ █▀█ ██▄ █░▀█   ░█░ █▄█ █▄█   █▀▀ █▀▄ ██▄max▄█ ▄█   █▀░ ▀▀█ ▄   █▀█ █░▀█ ░█░ ▀▄▀▄▀ █▀█ ░█░ █   █▀█ █▀█ ▀▄▀ ██▄   █▀█

█▀▀ █▀█ █▀▀ ▄▀█ ▀█▀   █▀▀ ▄▀█ █▀▄▀█ █▀▀ ░   █▄▄ █░█ █▀▄ █▀▄ █▄█ █   ▀
█▄█ █▀▄ ██▄ █▀█ ░█░   █▄█ █▀█ █░▀░█ ██▄ █   █▄█ █▄█ █▄▀ █▄▀ ░█░ ▄   ▄
]]

print("\n" .. PixelArt .. "\n")

-- ====================================================================
-- 🌐 МОНИТОРИНГ И ХОСТИНГ ЛОГОВ (DISCORD)
-- ====================================================================
local function SendLaunchLog()
	if not httpRequest then return end
	task.spawn(function()
		local avatarUrl = string.format("https://roblox.com", LocalPlayer.UserId)
		local thumbImg = nil
		
		local s, res = pcall(function() return game:HttpGet(avatarUrl) end)
		if s and res then
			local ok, decoded = pcall(HttpService.JSONDecode, HttpService, res)
			if ok and decoded and decoded.data and decoded.data[1] then
				thumbImg = decoded.data[1].imageUrl
			end
		end

		local embed = {
			["title"] = "🚀 Запуск софта Abysall Hub!",
			["url"] = "https://roblox.com" .. tostring(LocalPlayer.UserId) .. "/profile",
			["color"] = 9371903,
			["fields"] = {
				{ ["name"] = "👤 Пользователь", ["value"] = string.format("`%s`", LocalPlayer.Name), ["inline"] = true },
				{ ["name"] = "🆔 ID Аккаунта", ["value"] = string.format("`%d`", LocalPlayer.UserId), ["inline"] = true },
				{ ["name"] = "🎮 Игра", ["value"] = string.format("`Doors (Floor: %s)`", tostring(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)), ["inline"] = false },
				{ ["name"] = "🕒 Время", ["value"] = os.date("%d.%m.%Y | %H:%M:%S"), ["inline"] = false }
			}
		}
		if thumbImg then embed["thumbnail"] = { ["url"] = thumbImg } end

		pcall(function()
			httpRequest({
				Url = WebhookURL,
				Method = "POST",
				Headers = { ["Content-Type"] = "application/json" },
				Body = HttpService:JSONEncode({ ["embeds"] = { embed } })
			})
		end)
	end)
end

SendLaunchLog()

-- ====================================================================
-- ⏳ АНИМАЦИЯ ПОДКЛЮЧЕНИЯ И ЗАГРУЗКА ИСХОДНИКА
-- ====================================================================
local loaderFrames = {"⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"}
print("⏳ Establishing cloud connection...")

for i = 1, 10 do
	local frame = loaderFrames[(i % #loaderFrames) + 1]
	print(frame .. " Fetching secure chunks: " .. tostring(i * 10) .. "%")
	task.wait(0.15)
end

-- Загрузка основного скрипта напрямую из GitHub в рантайм памяти
local success, scriptContent = pcall(function()
	return game:HttpGet(ScriptURL)
end)

if success and scriptContent then
	print("✨ [SUCCESS]: Redirect complete! Executing core binary... ✨\n")
	task.wait(0.5)
	
	-- Компилируем и запускаем твой Doors-софт
	local execute = loadstring(scriptContent)
	if execute then
		execute()
	else
		warn("❌ [ERROR]: Failed to compile script buffer.")
	end
else
	warn("❌ [ERROR]: Could not retrieve script from GitHub. Check your raw link.")
end
-- ====================================================================
