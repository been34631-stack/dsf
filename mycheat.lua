local Players = game:GetService("Players")

local RunService = game:GetService("RunService")

local UserInputService = game:GetService("UserInputService")

local CoreGui = game:GetService("CoreGui")

local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

local Camera = workspace.CurrentCamera



local VALID_KEYS = {"1"}



_G.CS_RUNNING = true

_G.MENU_VISIBLE = true

_G.ESP_ENABLED = false

_G.NAMES_ENABLED = false

_G.INFJUMP_ENABLED = false

_G.SPEED_ENABLED = false

_G.TP_CLICK_ENABLED = false



local function ResetWalkSpeed()

    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then

        LocalPlayer.Character.Humanoid.WalkSpeed = 16

    end

end



local function Cleanup()

    _G.CS_RUNNING = false

    ResetWalkSpeed()

    local guis = {"CSVISUALS_PREMIUM", "CSV_LOADING", "CSV_TP_CURSOR", "CS_AUTH"}

    for _, name in pairs(guis) do

        local old = CoreGui:FindFirstChild(name)

        if old then old:Destroy() end

    end

    for _, p in pairs(Players:GetPlayers()) do

        if p.Character then

            local e = p.Character:FindFirstChild("TP_GLOW")

            local e2 = p.Character:FindFirstChild("CSV_ESP")

            local e3 = p.Character:FindFirstChild("CSV_NAME")

            if e then e:Destroy() end

            if e2 then e2:Destroy() end

            if e3 then e3:Destroy() end

        end

    end

end

Cleanup()

_G.CS_RUNNING = true



local function MakeDraggable(gui)

    local dragging, dragInput, dragStart, startPos

    gui.InputBegan:Connect(function(input)

        if input.UserInputType == Enum.UserInputType.MouseButton1 then

            dragging = true

            dragStart = input.Position

            startPos = gui.Position

            input.Changed:Connect(function()

                if input.UserInputState == Enum.UserInputState.End then dragging = false end

            end)

        end

    end)

    gui.InputChanged:Connect(function(input)

        if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end

    end)

    UserInputService.InputChanged:Connect(function(input)

        if input == dragInput and dragging then

            local delta = input.Position - dragStart

            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)

        end

    end)

end



function StartLoading()

    local LoadingGui = Instance.new("ScreenGui", CoreGui); LoadingGui.Name = "CSV_LOADING"; LoadingGui.IgnoreGuiInset = true

    local BG = Instance.new("Frame", LoadingGui); BG.Size = UDim2.new(1, 0, 1, 0); BG.BackgroundColor3 = Color3.fromRGB(5, 5, 10)

    local Logo = Instance.new("TextLabel", BG); Logo.Size = UDim2.new(0, 600, 0, 100); Logo.Position = UDim2.new(0.5, -300, 0.5, -50)

    Logo.BackgroundTransparency = 1; Logo.Text = "ckokohack"; Logo.Font = Enum.Font.GothamBold; Logo.TextSize = 80

    task.spawn(function()

        local h = 0

        while LoadingGui.Parent do

            Logo.TextColor3 = Color3.fromHSV(h, 0.7, 1)

            h = h + 0.005; task.wait()

        end

    end)

    task.wait(1.5); LoadingGui:Destroy(); CreateAuth()

end



function CreateAuth()

    local AuthGui = Instance.new("ScreenGui", CoreGui); AuthGui.Name = "CS_AUTH"; AuthGui.IgnoreGuiInset = true

    local Back = Instance.new("Frame", AuthGui); Back.Size = UDim2.new(1, 0, 1, 0); Back.BackgroundColor3 = Color3.new(0,0,0); Back.BackgroundTransparency = 0.6

    local AuthBox = Instance.new("Frame", Back); AuthBox.Size = UDim2.new(0, 320, 0, 180); AuthBox.Position = UDim2.new(0.5, -160, 0.5, -90)

    AuthBox.BackgroundColor3 = Color3.fromRGB(20, 15, 30); Instance.new("UICorner", AuthBox)

    Instance.new("UIStroke", AuthBox).Color = Color3.fromRGB(124, 58, 237)

    local Label = Instance.new("TextLabel", AuthBox); Label.Size = UDim2.new(1, 0, 0, 60); Label.BackgroundTransparency = 1; Label.Text = "ВВЕДИТЕ КЛЮЧ"; Label.TextColor3 = Color3.new(1,1,1); Label.Font = Enum.Font.GothamBold; Label.TextSize = 22

    local Input = Instance.new("TextBox", AuthBox); Input.Size = UDim2.new(0, 260, 0, 45); Input.Position = UDim2.new(0.5, -130, 0.6, -10); Input.PlaceholderText = "KEY"; Input.Text = ""; Input.BackgroundColor3 = Color3.fromRGB(30, 25, 45); Input.TextColor3 = Color3.new(1, 1, 1); Instance.new("UICorner", Input)

    Input.FocusLost:Connect(function(enter)

        if enter then

            for _, k in pairs(VALID_KEYS) do

                if Input.Text == k then AuthGui:Destroy(); CreateMenu(); return end

            end

            Input.Text = ""; Input.PlaceholderText = "НЕВЕРНЫЙ КЛЮЧ"; task.wait(1); Input.PlaceholderText = "KEY"

        end

    end)

end



function CreateMenu()

    local MainGui = Instance.new("ScreenGui", CoreGui); MainGui.Name = "CSVISUALS_PREMIUM"; MainGui.IgnoreGuiInset = true

    local Main = Instance.new("Frame", MainGui)

    Main.Size = UDim2.new(0, 520, 0, 400); Main.Position = UDim2.new(0.5, -260, 0.5, -200)

    Main.BackgroundColor3 = Color3.fromRGB(15, 10, 25); Main.BackgroundTransparency = 0.1

    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

    Instance.new("UIStroke", Main).Color = Color3.fromRGB(124, 58, 237)

   

    MakeDraggable(Main)



    local Title = Instance.new("TextLabel", Main)

    Title.Size = UDim2.new(1, -30, 0, 60); Title.Position = UDim2.new(0, 20, 0, 0)

    Title.BackgroundTransparency = 1; Title.RichText = true; Title.Text = "ckokohack <font color='#a855f7'>DELUX EDITION</font>"

    Title.TextColor3 = Color3.new(1,1,1); Title.Font = Enum.Font.GothamBold; Title.TextSize = 24; Title.TextXAlignment = Enum.TextXAlignment.Left



    local TitleTag = Instance.new("TextLabel", Title)

    TitleTag.Size = UDim2.new(0, 100, 1, 0)

    TitleTag.Position = UDim2.new(1, -80, 0, 4)

    TitleTag.BackgroundTransparency = 1

    TitleTag.Text = "@ckokohack"

    TitleTag.TextColor3 = Color3.fromRGB(80, 80, 85)

    TitleTag.Font = Enum.Font.GothamMedium

    TitleTag.TextSize = 12

    TitleTag.TextXAlignment = Enum.TextXAlignment.Left





    local TabContainer = Instance.new("Frame", Main)

    TabContainer.Size = UDim2.new(0, 130, 1, -80); TabContainer.Position = UDim2.new(0, 15, 0, 65)

    TabContainer.BackgroundTransparency = 1; Instance.new("UIListLayout", TabContainer).Padding = UDim.new(0, 6)



    local ContentArea = Instance.new("Frame", Main)

    ContentArea.Size = UDim2.new(1, -170, 1, -85); ContentArea.Position = UDim2.new(0, 155, 0, 70)

    ContentArea.BackgroundColor3 = Color3.fromRGB(20, 15, 30); ContentArea.BackgroundTransparency = 0.5; Instance.new("UICorner", ContentArea)



    local Pages = {

        Movement = Instance.new("ScrollingFrame", ContentArea),

        Visuals = Instance.new("ScrollingFrame", ContentArea),

        Settings = Instance.new("ScrollingFrame", ContentArea)

    }



    for name, frame in pairs(Pages) do

        frame.Size = UDim2.new(1, -20, 1, -20); frame.Position = UDim2.new(0, 10, 0, 10)

        frame.BackgroundTransparency = 1; frame.Visible = (name == "Movement"); frame.ScrollBarThickness = 0

        Instance.new("UIListLayout", frame).Padding = UDim.new(0, 8)

    end



    local function CreateTab(text, target)

        local b = Instance.new("TextButton", TabContainer)

        b.Size = UDim2.new(1, 0, 0, 40); b.BackgroundColor3 = Color3.fromRGB(30, 25, 45)

        b.Text = text; b.TextColor3 = Color3.fromRGB(200, 200, 200); b.Font = Enum.Font.GothamMedium; Instance.new("UICorner", b)

        b.MouseButton1Click:Connect(function()

            for _, p in pairs(Pages) do p.Visible = false end

            target.Visible = true

        end)

    end

    CreateTab("MOVEMENT", Pages.Movement); CreateTab("VISUALS", Pages.Visuals); CreateTab("SETTINGS", Pages.Settings)



    local function AddToggle(text, var, parent)

        local b = Instance.new("TextButton", parent)

        b.Size = UDim2.new(1, 0, 0, 45); b.BackgroundColor3 = Color3.fromRGB(40, 35, 55)

        b.Text = text; b.TextColor3 = _G[var] and Color3.fromRGB(168, 85, 247) or Color3.new(1, 1, 1)

        b.Font = Enum.Font.GothamBold; Instance.new("UICorner", b)

        b.MouseButton1Click:Connect(function()

            _G[var] = not _G[var]

            b.TextColor3 = _G[var] and Color3.fromRGB(168, 85, 247) or Color3.new(1, 1, 1)

           

            if var == "SPEED_ENABLED" and not _G[var] then

                ResetWalkSpeed()

            end

           

            if var == "TP_CLICK_ENABLED" then

                if CoreGui:FindFirstChild("CSV_TP_CURSOR") then

                    CoreGui.CSV_TP_CURSOR.Enabled = _G[var]

                end

            end

        end)

    end



    AddToggle("SPEEDHACK", "SPEED_ENABLED", Pages.Movement)

    AddToggle("INFINITE JUMP", "INFJUMP_ENABLED", Pages.Movement)

    AddToggle("TP CLICK (P)", "TP_CLICK_ENABLED", Pages.Movement)

    AddToggle("ESP CHAMS", "ESP_ENABLED", Pages.Visuals)

    AddToggle("PLAYER NAMES", "NAMES_ENABLED", Pages.Visuals)



    local Unload = Instance.new("TextButton", Pages.Settings)

    Unload.Size = UDim2.new(1, 0, 0, 45); Unload.BackgroundColor3 = Color3.fromRGB(100, 30, 30); Unload.Text = "UNLOAD"; Unload.TextColor3 = Color3.new(1,1,1); Unload.Font = Enum.Font.GothamBold; Instance.new("UICorner", Unload)

    Unload.MouseButton1Click:Connect(Cleanup)



    local CursorGui = Instance.new("ScreenGui", CoreGui); CursorGui.Name = "CSV_TP_CURSOR"; CursorGui.IgnoreGuiInset = true; CursorGui.Enabled = false

    local CursorRing = Instance.new("Frame", CursorGui); CursorRing.Size = UDim2.new(0, 40, 0, 40); CursorRing.BackgroundTransparency = 1; CursorRing.AnchorPoint = Vector2.new(0.5, 0.5)

    Instance.new("UICorner", CursorRing).CornerRadius = UDim.new(1, 0)

    local CursorStroke = Instance.new("UIStroke", CursorRing); CursorStroke.Color = Color3.fromRGB(124, 58, 237); CursorStroke.Thickness = 2

    local TargetPlayer = nil



    UserInputService.InputBegan:Connect(function(i, gp)

        if gp or not _G.CS_RUNNING then return end

       

        if i.KeyCode == Enum.KeyCode.Insert then

            _G.MENU_VISIBLE = not _G.MENU_VISIBLE

            Main.Visible = _G.MENU_VISIBLE

        end



        if i.KeyCode == Enum.KeyCode.P then

            _G.TP_CLICK_ENABLED = not _G.TP_CLICK_ENABLED

            CursorGui.Enabled = _G.TP_CLICK_ENABLED

        end

       

        if _G.TP_CLICK_ENABLED and i.UserInputType == Enum.UserInputType.MouseButton1 and TargetPlayer then

            LocalPlayer.Character.HumanoidRootPart.CFrame = TargetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)

        end

    end)



    RunService.RenderStepped:Connect(function()

        if not _G.CS_RUNNING then return end

       

        if _G.TP_CLICK_ENABLED then

            local mPos = UserInputService:GetMouseLocation()

            CursorRing.Position = UDim2.new(0, mPos.X, 0, mPos.Y)

           

            local closest = nil; local dist = 60

            for _, p in pairs(Players:GetPlayers()) do

                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then

                    local pos, onScreen = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)

                    if onScreen then

                        local d = (Vector2.new(pos.X, pos.Y) - mPos).Magnitude

                        if d < dist then closest = p; dist = d end

                    end

                end

            end



            if closest then

                if TargetPlayer ~= closest then

                    if TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("TP_GLOW") then TargetPlayer.Character.TP_GLOW:Destroy() end

                    TargetPlayer = closest

                    local g = Instance.new("Highlight", closest.Character); g.Name = "TP_GLOW"; g.FillColor = Color3.new(1, 0, 0); g.FillTransparency = 0.5

                end

                CursorStroke.Color = Color3.new(1, 0, 0)

            else

                if TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("TP_GLOW") then TargetPlayer.Character.TP_GLOW:Destroy() end

                TargetPlayer = nil; CursorStroke.Color = Color3.fromRGB(124, 58, 237)

            end

        end



        if _G.SPEED_ENABLED and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then

            LocalPlayer.Character.Humanoid.WalkSpeed = 100

        end



        for _, p in pairs(Players:GetPlayers()) do

            if p ~= LocalPlayer and p.Character then

                local esp = p.Character:FindFirstChild("CSV_ESP")

                if _G.ESP_ENABLED then

                    if not esp and p ~= TargetPlayer then

                        esp = Instance.new("Highlight", p.Character); esp.Name = "CSV_ESP"; esp.FillColor = Color3.fromRGB(124, 58, 237)

                    end

                elseif esp then esp:Destroy() end

               

                local nt = p.Character:FindFirstChild("CSV_NAME")

                if _G.NAMES_ENABLED then

                    if not nt and p.Character:FindFirstChild("Head") then

                        nt = Instance.new("BillboardGui", p.Character); nt.Name = "CSV_NAME"; nt.Size = UDim2.new(0, 150, 0, 50); nt.AlwaysOnTop = true; nt.Adornee = p.Character.Head

                        local txt = Instance.new("TextLabel", nt); txt.Size = UDim2.new(1, 0, 1, 0); txt.BackgroundTransparency = 1; txt.Text = p.Name; txt.TextColor3 = Color3.new(1,1,1); txt.Font = Enum.Font.GothamBold; txt.TextSize = 14

                    end

                elseif nt then nt:Destroy() end

            end

        end

    end)

end



UserInputService.JumpRequest:Connect(function()

    if _G.CS_RUNNING and _G.INFJUMP_ENABLED and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then

        LocalPlayer.Character.Humanoid:ChangeState(3)

    end

end)



StartLoading()