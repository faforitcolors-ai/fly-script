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

local function startFly()
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
end

local function stopFly()
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

local userInputService = game:GetService("UserInputService")
local moveDirection = Vector3.new()

local function updateFly()
    if not flying or not bodyVelocity then return end
    
    if userInputService:IsKeyDown(Enum.KeyCode.W) then
        moveDirection = Vector3.new(0, 0, -1)
    elseif userInputService:IsKeyDown(Enum.KeyCode.S) then
        moveDirection = Vector3.new(0, 0, 1)
    elseif userInputService:IsKeyDown(Enum.KeyCode.A) then
        moveDirection = Vector3.new(-1, 0, 0)
    elseif userInputService:IsKeyDown(Enum.KeyCode.D) then
        moveDirection = Vector3.new(1, 0, 0)
    elseif userInputService:IsKeyDown(Enum.KeyCode.Space) then
        moveDirection = Vector3.new(0, 1, 0)
    elseif userInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        moveDirection = Vector3.new(0, -1, 0)
    else
        moveDirection = Vector3.new(0, 0, 0)
    end
    
    local camera = workspace.CurrentCamera
    local moveVector = (camera.CFrame:VectorToWorldSpace(moveDirection)) * 50
    bodyVelocity.Velocity = moveVector
end

game:GetService("RunService").RenderStepped:Connect(updateFly)