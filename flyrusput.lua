local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local flying = false
local bodyVel = nil

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui

local flyButton = Instance.new("TextButton")
flyButton.Parent = screenGui
flyButton.Size = UDim2.new(0, 150, 0, 50)
flyButton.Position = UDim2.new(0.5, -75, 0.9, 0)
flyButton.Text = "ВКЛЮЧИТЬ ПОЛЁТ"
flyButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
flyButton.TextColor3 = Color3.fromRGB(0, 0, 0)
flyButton.Font = Enum.Font.SourceSansBold
flyButton.TextSize = 18

local userInput = game:GetService("UserInputService")
local run = game:GetService("RunService")

local function startFly()
    if flying then return end
    flying = true
    
    bodyVel = Instance.new("BodyVelocity")
    bodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyVel.Velocity = Vector3.new(0, 0, 0)
    bodyVel.Parent = hrp
    
    humanoid.PlatformStand = true
    
    flyButton.Text = "ВЫКЛЮЧИТЬ ПОЛЁТ"
    flyButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
end

local function stopFly()
    if not flying then return end
    flying = false
    
    if bodyVel then bodyVel:Destroy() bodyVel = nil end
    humanoid.PlatformStand = false
    
    flyButton.Text = "ВКЛЮЧИТЬ ПОЛЁТ"
    flyButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
end

run.RenderStepped:Connect(function()
    if not flying or not bodyVel then return end
    
    local move = Vector3.new()
    
    if userInput:IsKeyDown(Enum.KeyCode.W) then move = move + Vector3.new(0, 0, -1) end
    if userInput:IsKeyDown(Enum.KeyCode.S) then move = move + Vector3.new(0, 0, 1) end
    if userInput:IsKeyDown(Enum.KeyCode.A) then move = move + Vector3.new(-1, 0, 0) end
    if userInput:IsKeyDown(Enum.KeyCode.D) then move = move + Vector3.new(1, 0, 0) end
    if userInput:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
    if userInput:IsKeyDown(Enum.KeyCode.LeftControl) then move = move + Vector3.new(0, -1, 0) end
    
    if move.Magnitude > 0 then move = move.Unit end
    
    local cam = workspace.CurrentCamera
    bodyVel.Velocity = (cam.CFrame:VectorToWorldSpace(move)) * 70
end)

flyButton.MouseButton1Click:Connect(function()
    if flying then stopFly() else startFly() end
end)

player.CharacterAdded:Connect(function(c)
    character = c
    hrp = c:WaitForChild("HumanoidRootPart")
    humanoid = c:WaitForChild("Humanoid")
    if flying then stopFly() end
end)
