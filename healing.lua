local Tool = Instance.new("Tool")
Tool.Name = "Healing Tool"
Tool.RequiresHandle = false

local healingAmount = 100
local maxHealth = 100

local scream = Instance.new("Sound")
scream.SoundId = "rbxassetid://1655262564"
scream.Volume = 2
scream.Parent = game.Workspace

local function healPlayer(player)
    if player and player.Character then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Health = math.min(humanoid.Health + healingAmount, maxHealth)
            scream:Play()
        end
    end
end

Tool.Activated:Connect(function()
    local player = game.Players.LocalPlayer
    healPlayer(player)
end)

Tool.Parent = game.Players.LocalPlayer.Backpack
