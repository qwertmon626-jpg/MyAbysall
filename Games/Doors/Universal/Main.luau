local Services = setmetatable({}, {
    __index = function(self, Name)
        if Abysall.Environment.cloneref then
            return Abysall.Environment.cloneref(game:GetService(Name))
        else
            return game:GetService(Name)
        end
    end
})

local Bindable = Instance.new("BindableFunction")
Bindable.OnInvoke = function(Response)
    local Success, Result = pcall(function()
        toclipboard("https://discord.gg/VKjMcaAt79")
    end)
    if not Success then
        Services.LocalPlayer:Kick("Failed to copy invite.\nhttps://discord.gg/VKjMcaAt79")
    end
end

Services.StarterGui:SetCore("SendNotification", {
    Title = "Abysall Hub",
    Text = "Простите подерживаеться токо дорс другое лень делать або времини нету ;3",
    Duration = 10,
    Button1 = "Copy Discord Invite",
    Callback = Bindable,
})
