local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 420)
frame.Position = UDim2.new(0.5, -125, 0.5, -210)
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

local autoFuelBtn = Instance.new("TextButton")
autoFuelBtn.Size = UDim2.new(1, -20, 0, 40)
autoFuelBtn.Position = UDim2.new(0, 10, 0, 150)
autoFuelBtn.Text = "Auto refill fuel: off"
autoFuelBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
autoFuelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoFuelBtn.Parent = frame

local anchorMainBtn = Instance.new("TextButton")
anchorMainBtn.Size = UDim2.new(1, -20, 0, 40)
anchorMainBtn.Position = UDim2.new(0, 10, 0, 200)
anchorMainBtn.Text = "Anchor main gubby: off"
anchorMainBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
anchorMainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
anchorMainBtn.Parent = frame

local anchorOthersBtn = Instance.new("TextButton")
anchorOthersBtn.Size = UDim2.new(1, -20, 0, 40)
anchorOthersBtn.Position = UDim2.new(0, 10, 0, 250)
anchorOthersBtn.Text = "Anchor other gubbies: off"
anchorOthersBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
anchorOthersBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
anchorOthersBtn.Parent = frame

local deleteBtn = Instance.new("TextButton")
deleteBtn.Size = UDim2.new(1, -20, 0, 40)
deleteBtn.Position = UDim2.new(0, 10, 0, 300)
deleteBtn.Text = "Delete other Gubbies"
deleteBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
deleteBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
deleteBtn.Parent = frame

local source = game.ReplicatedStorage.GameAssets.Objects.GubbySkins
local target = game.Workspace.Gubbies
local gubby = target:WaitForChild("RegularGubby")
local voidDamage = game:GetService("ReplicatedStorage").Networking.Server.RemoteEvents.DamageEvents.VoidDamage
local burn = gubby:FindFirstChild("GubbyEvents") and gubby.GubbyEvents:FindFirstChild("Burn")
local purchaseGas = game:GetService("ReplicatedStorage").Networking.Server.RemoteEvents.PurchaseGas

local originalGubbies = {}
for _, child in pairs(target:GetChildren()) do
	originalGubbies[child.Name] = true
end

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
				voidDamage:FireServer(Vector3.new(-5.273, 4.99, 0.0016))
				game:GetService("ReplicatedStorage").Networking.Server.RemoteEvents.DamageEvents.AirstrikeDamage:FireServer(Vector3.new(11.01, 3.09, -0.00044), 3.11)
				game:GetService("ReplicatedStorage").Networking.Server.RemoteEvents.DamageEvents.SmiteDamage:FireServer(Vector3.new(-0.81, 4.52, 0))
				game:GetService("ReplicatedStorage").Networking.Server.RemoteEvents.DamageEvents.PhysicsDamage:FireServer(333.54, Vector3.new(19.89, 9.54, 0.025))
				game:GetService("ReplicatedStorage").Networking.Server.RemoteEvents.DamageEvents.FoodDamage:FireServer("CherryBomb", Vector3.new(-9.3959, 3.8405, -0.00194))
				game:GetService("ReplicatedStorage").Networking.Server.RemoteEvents.DamageEvents.FoodDamage:FireServer("RatPoison", Vector3.new(-9.3959, 3.8405, -0.00194))
				if burn then
					for _ = 1, 10 do
						burn:Fire()
					end
				end
				task.wait()
			end
		end)
	end
end)

local fuelRunning = false
autoFuelBtn.MouseButton1Click:Connect(function()
	fuelRunning = not fuelRunning
	autoFuelBtn.Text = fuelRunning and "Auto refill fuel: on" or "Auto refill fuel: off"
	if fuelRunning then
		task.spawn(function()
			while fuelRunning do
				purchaseGas:FireServer(10)
				task.wait()
			end
		end)
	end
end)

local mainAnchored = false
anchorMainBtn.MouseButton1Click:Connect(function()
	if gubby and gubby:FindFirstChild("RootPart") then
		mainAnchored = not mainAnchored
		gubby.RootPart.Anchored = mainAnchored
		anchorMainBtn.Text = mainAnchored and "Anchor main gubby: on" or "Anchor main gubby: off"
	end
end)

local othersAnchored = false
anchorOthersBtn.MouseButton1Click:Connect(function()
	othersAnchored = not othersAnchored
	for _, child in pairs(target:GetChildren()) do
		if not originalGubbies[child.Name] and child:FindFirstChild("RootPart") then
			child.RootPart.Anchored = othersAnchored
		end
	end
	anchorOthersBtn.Text = othersAnchored and "Anchor other gubbies: on" or "Anchor other gubbies: off"
end)

deleteBtn.MouseButton1Click:Connect(function()
	for _, child in pairs(target:GetChildren()) do
		if not originalGubbies[child.Name] then
			child:Destroy()
		end
	end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.LeftControl then
		frame.Visible = not frame.Visible
	end
end)
