local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 290)
frame.Position = UDim2.new(0.5, -125, 0.5, -145)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.Text = "Beat Gubby script by yxc"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Parent = frame

local cloneBtn = Instance.new("TextButton")
cloneBtn.Size = UDim2.new(1, -20, 0, 40)
cloneBtn.Position = UDim2.new(0, 10, 0, 50)
cloneBtn.Text = "Spawn more Gubbies"
cloneBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
cloneBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
cloneBtn.Parent = frame

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(1, -20, 0, 40)
toggleBtn.Position = UDim2.new(0, 10, 0, 100)
toggleBtn.Text = "Start inf money"
toggleBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Parent = frame

local anchorBtn = Instance.new("TextButton")
anchorBtn.Size = UDim2.new(1, -20, 0, 40)
anchorBtn.Position = UDim2.new(0, 10, 0, 150)
anchorBtn.Text = "Anchor gubby: off"
anchorBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
anchorBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
anchorBtn.Parent = frame

local deleteBtn = Instance.new("TextButton")
deleteBtn.Size = UDim2.new(1, -20, 0, 40)
deleteBtn.Position = UDim2.new(0, 10, 0, 200)
deleteBtn.Text = "Delete other Gubbies"
deleteBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
deleteBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
deleteBtn.Parent = frame

local source = game.ReplicatedStorage.GameAssets.Objects.GubbySkins
local target = game.Workspace.Gubbies
local gubby = target:WaitForChild("RegularGubby")
local voidDamage = game:GetService("ReplicatedStorage").Networking.Server.RemoteEvents.DamageEvents.VoidDamage
local burn = gubby:FindFirstChild("GubbyEvents") and gubby.GubbyEvents:FindFirstChild("Burn")

cloneBtn.MouseButton1Click:Connect(function()
    for _, child in pairs(source:GetChildren()) do
        if not target:FindFirstChild(child.Name) then
            local clone = child:Clone()
            clone.Parent = target
        end
    end
end)

local running = false
toggleBtn.MouseButton1Click:Connect(function()
    running = not running
    toggleBtn.Text = running and "Stop inf money" or "Start inf money"
    if running then
        task.spawn(function()
            while running do
                for _ = 1, 100 do
                    voidDamage:FireServer(Vector3.new(-5.273, 4.99, 0.0016))
                    game:GetService("ReplicatedStorage").Networking.Server.RemoteEvents.DamageEvents.AirstrikeDamage:FireServer(Vector3.new(11.01, 3.09, -0.00044), 3.11)
                    game:GetService("ReplicatedStorage").Networking.Server.RemoteEvents.DamageEvents.SmiteDamage:FireServer(Vector3.new(-0.81, 4.52, 0))
                    game:GetService("ReplicatedStorage").Networking.Server.RemoteEvents.DamageEvents.PhysicsDamage:FireServer(333.54, Vector3.new(19.89, 9.54, 0.025))
                    task.wait()
                end
                if burn then
                    for _ = 1, 10 do
                        burn:Fire()
                        task.wait()
                    end
                end
                task.wait()
            end
        end)
    end
end)

local anchored = false
anchorBtn.MouseButton1Click:Connect(function()
    if gubby and gubby:FindFirstChild("RootPart") then
        anchored = not anchored
        gubby.RootPart.Anchored = anchored
        anchorBtn.Text = anchored and "Anchor gubby: on" or "Anchor gubby: off"
    end
end)

deleteBtn.MouseButton1Click:Connect(function()
    for _, child in pairs(target:GetChildren()) do
        if child.Name ~= "RegularGubby" then
            child:Destroy()
        end
    end
end)
