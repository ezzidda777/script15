local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local Debris = game:GetService("Debris")

Mouse.Button1Click:Connect(function()
    -- 파트 생성
    local part = Instance.new("Part")
    part.Size = Vector3.new(5, 5, 5)  -- 원하는 크기로 설정
    part.Position = Mouse.Hit.p  -- 마우스 클릭 위치
    part.Anchored = true
    part.CanCollide = false
    part.Parent = game.Workspace

    -- 파트 주변의 플레이어들 밀기
    local explosionRadius = 20  -- 밀기 반경
    local forceStrength = 50  -- 밀기 힘의 강도

    -- 파트 주위의 모든 플레이어를 찾아서 밀기
    for _, obj in ipairs(workspace:GetChildren()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj ~= Player.Character then
            local humanoid = obj:FindFirstChild("Humanoid")
            local distance = (part.Position - obj.PrimaryPart.Position).magnitude

            if distance <= explosionRadius then
                -- 밀기
                local direction = (obj.PrimaryPart.Position - part.Position).unit
                humanoid:MoveTo(obj.PrimaryPart.Position + direction * forceStrength)

                -- 밀기 효과는 1초간만 유지
                Debris:AddItem(part, 5)  -- 파트가 1초 뒤에 자동으로 제거됨
            end
        end
    end
end)
