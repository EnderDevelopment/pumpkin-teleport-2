-- TeleportToPumpkins.server.lua

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local function teleportToRandomPumpkins(player)
    local eventPumpkinsFolder = Workspace:FindFirstChild("EventPumpkins")
    if not eventPumpkinsFolder then
        warn("EventPumpkins folder not found in the workspace.")
        return
    end

    local pumpkins = {}
    for _, child in ipairs(eventPumpkinsFolder:GetChildren()) do
        if child:IsA("BasePart") and child.Name:lower():find("pumpkin") then
            table.insert(pumpkins, child)
        end
    end

    if #pumpkins == 0 then
        warn("No pumpkins found in the EventPumpkins folder.")
        return
    end

    local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        warn("Humanoid not found for player: " .. player.Name)
        return
    end

    for _, pumpkin in ipairs(pumpkins) do
        humanoid:MoveTo(pumpkin.Position)
        wait(2) -- Wait for 2 seconds before moving to the next pumpkin
    end
end

local function onButtonClicked(player)
    teleportToRandomPumpkins(player)
end

local function createGui(player)
    local playerGui = Instance.new("ScreenGui")
    playerGui.Name = "TeleportGui"
    playerGui.Parent = player:WaitForChild("PlayerGui")

    local button = Instance.new("TextButton")
    button.Name = "TeleportButton"
    button.Size = UDim2.new(0, 200, 0, 50)
    button.Position = UDim2.new(0.5, -100, 0.5, -25)
    button.Text = "RUN PUMPKINS"
    button.Parent = playerGui

    button.MouseButton1Click:Connect(function()
        onButtonClicked(player)
    end)
end

Players.PlayerAdded:Connect(createGui)

for _, player in ipairs(Players:GetPlayers()) do
    createGui(player)
end
