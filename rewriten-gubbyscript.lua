local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Flyxo Hub",
   Icon = 0,
   LoadingTitle = "Loading Flyxo Hub..",
   LoadingSubtitle = "by yxc.f",
   Theme = "Default",
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,
   ConfigurationSaving = {Enabled = true, FolderName = nil, FileName = "Big Hub"},
   Discord = {Enabled = false, Invite = "noinvitelink", RememberJoins = true},
   KeySystem = false,
   KeySettings = {Title = "Untitled", Subtitle = "Key System", Note = "No method of obtaining the key is provided", FileName = "Key", SaveKey = true, GrabKeyFromSite = false, Key = {"Hello"}}
})

local Tab = Window:CreateTab("Main", 4483362458)

local player = game.Players.LocalPlayer
local target = game.Workspace.Gubbies
local gubby = target:WaitForChild("RegularGubby")

local voidDamage = game:GetService("ReplicatedStorage").Networking.Server.RemoteEvents.DamageEvents.VoidDamage
local airstrikeDamage = game:GetService("ReplicatedStorage").Networking.Server.RemoteEvents.DamageEvents.AirstrikeDamage
local smiteDamage = game:GetService("ReplicatedStorage").Networking.Server.RemoteEvents.DamageEvents.SmiteDamage
local physicsDamage = game:GetService("ReplicatedStorage").Networking.Server.RemoteEvents.DamageEvents.PhysicsDamage
local foodDamage = game:GetService("ReplicatedStorage").Networking.Server.RemoteEvents.DamageEvents.FoodDamage
local purchaseGas = game:GetService("ReplicatedStorage").Networking.Server.RemoteEvents.PurchaseGas
local burn = gubby:FindFirstChild("GubbyEvents") and gubby.GubbyEvents:FindFirstChild("Burn")

local mainAnchored = false
local fuelRunning = false
local infDamageRunning = false

Tab:CreateToggle({
   Name = "Anchor Main Gubby",
   CurrentValue = false,
   Flag = "AnchorMainGubby",
   Callback = function(value)
       mainAnchored = value
       if gubby and gubby:FindFirstChild("RootPart") then
           gubby.RootPart.Anchored = mainAnchored
       end
   end
})

Tab:CreateToggle({
   Name = "Auto Refill Fuel",
   CurrentValue = false,
   Flag = "AutoRefillFuel",
   Callback = function(value)
       fuelRunning = value
       if fuelRunning then
           task.spawn(function()
               while fuelRunning do
                   purchaseGas:FireServer(10)
                   task.wait()
               end
           end)
       end
   end
})

Tab:CreateToggle({
   Name = "Inf Damage",
   CurrentValue = false,
   Flag = "InfDamage",
   Callback = function(value)
       infDamageRunning = value
       if infDamageRunning then
           task.spawn(function()
               while infDamageRunning do
                   voidDamage:FireServer(Vector3.new(999, 999, 999))
                   airstrikeDamage:FireServer(Vector3.new(999, 999, 999), 3.11)
                   smiteDamage:FireServer(Vector3.new(999, 999, 999))
                   physicsDamage:FireServer(333.54, Vector3.new(999, 999, 999))
                   foodDamage:FireServer("CherryBomb", Vector3.new(999, 999, 999))
                   foodDamage:FireServer("RatPoison", Vector3.new(999, 999, 999))
                   task.wait()
               end
           end)
       end
   end
})
