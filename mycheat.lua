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