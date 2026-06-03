local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

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
local moveDirection = Vector3.new()

local function updateFly()
    if not flying or not bodyVelocity then return end
    
    local moveVector = Vector3.new()
    
    if userInputService:IsKeyDown(Enum.KeyCode.W) then
        moveVector = moveVector + Vector3.new(0, 0, -1)
    end
    if userInputService:IsKeyDown(Enum.KeyCode.S) then
        moveVector = moveVector + Vector3.new(0, 0, 1)
    end
    if userInputService:IsKeyDown(Enum.KeyCode.A) then
        moveVector = moveVector + Vector3.new(-1, 0, 0)
    end
    if userInputService:IsKeyDown(Enum.KeyCode.D) then
        moveVector = moveVector + Vector3.new(1, 0, 0)
    end
    if userInputService:IsKeyDown(Enum.KeyCode.Space) then
        moveVector = moveVector + Vector3.new(0, 1, 0)
    end
    if userInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        moveVector = moveVector + Vector3.new(0, -1, 0)
    end
    
    if moveVector.Magnitude > 0 then
        moveVector = moveVector.Unit
    end
    
    local camera = workspace.CurrentCamera
    local moveVelocity = (camera.CFrame:VectorToWorldSpace(moveVector)) * 80
    bodyVelocity.Velocity = moveVelocity
end

local function startFly()
    if flying then return end
    flying = true
    
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = humanoid.Parent
    
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    humanoid.PlatformStand = true
    
    flyButton.Text = "ВЫКЛЮЧИТЬ ПОЛЁТ"
    flyButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    
    runService.RenderStepped:Connect(updateFly)
end

local function stopFly()
    if not flying then return end
    flying = false
    
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
    
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
    humanoid.PlatformStand = false
    
    flyButton.Text = "ВКЛЮЧИТЬ ПОЛЁТ"
    flyButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
end

flyButton.MouseButton1Click:Connect(function()
    if flying then
        stopFly()
    else
        startFly()
    end
end)
