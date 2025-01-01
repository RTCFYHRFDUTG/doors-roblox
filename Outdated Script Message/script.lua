-- Get the local player
local player = game.Players.LocalPlayer

-- Function to handle camera adjustment
local function adjustCameraOnDeath()
    local camera = workspace.CurrentCamera
    if camera then
        -- Tween the camera to look downward
        local goal = {}
        goal.CFrame = CFrame.new(camera.CFrame.Position) * CFrame.Angles(math.rad(90), 0, 0) -- Look straight down

        local tweenService = game:GetService("TweenService")
        local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out) -- 1 second duration

        local tween = tweenService:Create(camera, tweenInfo, goal)
        tween:Play()
    else
        warn("Camera not found.")
    end
end

-- Function to display the custom death message
local function displayDeathMessage()
    local gui = Instance.new("ScreenGui")
    local textLabel = Instance.new("TextLabel")

    gui.Parent = player:WaitForChild("PlayerGui")
    textLabel.Parent = gui
    textLabel.Size = UDim2.new(0.5, 0, 0.2, 0) -- Adjust the size
    textLabel.Position = UDim2.new(0.25, 0, 0.4, 0) -- Center on screen
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "Outdated Script"
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextSize = 48
    textLabel.TextColor3 = Color3.new(1, 0, 0) -- Red text
    textLabel.TextTransparency = 0 -- Initially fully visible

    -- Tween the text transparency to fade it out
    local tweenService = game:GetService("TweenService")
    local tweenInfo = TweenInfo.new(4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out) -- 4 seconds duration
    local fadeGoal = { TextTransparency = 1 }

    local fadeTween = tweenService:Create(textLabel, tweenInfo, fadeGoal)
    fadeTween:Play()

    -- Remove the GUI after 4 seconds
    game:GetService("Debris"):AddItem(gui, 4)
end

-- Check if the player's character exists
if player and player.Character then
    -- Ensure the Humanoid exists in the character
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        -- Connect a function to run when the Humanoid's health changes
        humanoid:GetPropertyChangedSignal("Health"):Connect(function()
            if humanoid.Health <= 0 then
                adjustCameraOnDeath()
                displayDeathMessage()
            end
        end)

        -- Kill the character by setting the Humanoid's health to 0
        humanoid.Health = 0
    else
        warn("Humanoid not found in the character.")
    end
else
    warn("Player or Character not found.")
end
