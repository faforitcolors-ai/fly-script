local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")

local flying = false
local bodyVelocity = nil

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

local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")

local function startFly()
    if flying then return end
    flying = true
    
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = hrp
    
    humanoid.PlatformStand = true
    
    flyButton.Text = "ВЫКЛЮЧИТЬ ПОЛЁТ"
    flyButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
end

local function stopFly()
    if not flying then return end
    flying = false
    
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
    
    humanoid.PlatformStand = false
    
    flyButton.Text = "ВКЛЮЧИТЬ ПОЛЁТ"
    flyButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
end

-- ДВИЖЕНИЕ отдельным циклом
runService.RenderStepped:Connect(function()
    if not flying or not bodyVelocity then return end
    
    local moveDirection = Vector3.new()
    
    if userInputService:IsKeyDown(Enum.KeyCode.W) then
        moveDirection = moveDirection + Vector3.new(0, 0, -1)
    end
    if userInputService:IsKeyDown(Enum.KeyCode.S) then
        moveDirection = moveDirection + Vector3.new(0, 0, 1)
    end
    if userInputService:IsKeyDown(Enum.KeyCode.A) then
        moveDirection = moveDirection + Vector3.new(-1, 0, 0)
    end
    if userInputService:IsKeyDown(Enum.KeyCode.D) then
        moveDirection = moveDirection + Vector3.new(1, 0, 0)
    end
    if userInputService:IsKeyDown(Enum.KeyCode.Space) then
        moveDirection = moveDirection + Vector3.new(0, 1, 0)
    end
    if userInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        moveDirection = moveDirection + Vector3.new(0, -1, 0)
    end
    
    if moveDirection.Magnitude > 0 then
        moveDirection = moveDirection.Unit
    end
    
    local camera = workspace.CurrentCamera
    local moveVelocity = (camera.CFrame:VectorToWorldSpace(moveDirection)) * 60
    
    if moveVelocity.Magnitude > 0 then
        bodyVelocity.Velocity = moveVelocity
    else
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    end
end)

flyButton.MouseButton1Click:Connect(function()
    if flying then
        stopFly()
    else
        startFly()
    end
end)

player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = character:WaitForChild("Humanoid")
    hrp = character:WaitForChild("HumanoidRootPart")
    if flying then
        stopFly()
    end
end)
