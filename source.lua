
-- Instances:
local SummitUI
local SideBar
local UIPadding
local settingsBTN
local TabsScrollingFrame
local UIListLayout
local MenuFrame
local TabTitle
local UIGradient
local TabContentsFrame
local UIListLayout_2
local UIPadding_2
local UIPadding_3
local TopBar
local GUITitle
local UIGradient_2
local ImageLabel
local UIGradient_3

local summitLib = {
	Connections = {},
	contents = {
		Tabs = {}
	}
}



function summitLib:CreateWindow(ConfigArgs)
	local defaultFont = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	local Players = game:GetService("Players")
	
	local minimizeAnim = true
	local instantClose = false
	
	local function getPlayersAndIcons()
		local players = Players:GetPlayers()
		local playerIcons = {}
		for _, player in pairs(players) do
			local userId = player.UserId
			local thumbType = Enum.ThumbnailType.HeadShot
			local thumbSize = Enum.ThumbnailSize.Size420x420
			local content, isReady = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
			table.insert(playerIcons,{
				Name = player.Name,
				Icon = content
			})
		end
		return playerIcons
	end
	local function addConnection(event, func)
		local signal = event:Connect(func)
		table.insert(summitLib.Connections, signal)
		return signal
	end

	local function assignClickAnimation(Button,clipsDescendants)
		local player = game:GetService("Players").LocalPlayer
		local mouse = player:GetMouse()
		if clipsDescendants == nil then
			clipsDescendants = true
		end
		addConnection(Button.MouseButton1Click, function()
			local sound = Instance.new("Sound")
			sound.Parent = game
			sound.Volume = 0.25
			sound.SoundId = 'rbxassetid://6895079853'
			sound:Play()
			local x, y = mouse.X, mouse.Y

			Button.ClipsDescendants = true
			if clipsDescendants == false then
				Button.ClipsDescendants = false
			end
			local frame = Instance.new("Frame")
			local UiCorner = Instance.new("UICorner")

			frame.AnchorPoint = Vector2.new(0.5, 0.5)
			frame.Position = UDim2.new(0, x - Button.AbsolutePosition.X, 0, y - Button.AbsolutePosition.Y)
			frame.Size = UDim2.new(0, 1, 0, 1)
			frame.Parent = Button
			frame.Transparency = .2
			frame.BackgroundColor3 = Color3.new(0.886, 0.886, 0.886)
			frame.ZIndex = 0 

			UiCorner.Parent = frame
			UiCorner.CornerRadius = UDim.new(1, 0)

			local tween = game:GetService("TweenService"):Create(frame, TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
				Size = UDim2.new(0, 200, 0, 200),
				BackgroundTransparency = 1
			})
			tween:Play()
			tween.Completed:Connect(function()
				frame:Destroy()
			end)
			sound:Destroy()
		end)
	end

	local function loadTabContents(tabName)
		for _, v in pairs(TabContentsFrame:GetChildren()) do
			if v.ClassName == 'TextLabel' or v.ClassName == 'Frame' then
				if string.find(v.Name,tabName) then
					v.Visible = true
				else
					v.Visible = false
				end			
			end
		end
	end

	local function Color3ToRGB(color)
		return Color3.new(math.floor(color.R * 255),math.floor(color.G * 255),math.floor(color.B * 255))
	end

	local function DPRound(decimal,points)
		local pow = math.pow(10,points)
		local newDP = decimal * pow
		newDP = math.floor(newDP)
		return newDP / pow
	end

	local function setHueAndSaturation(color3,Sat,Value)
		local hue, sat, val = color3:ToHSV()
		return Color3.fromHSV(hue,Sat,Value)
	end

	ConfigArgs = ConfigArgs or {}
	ConfigArgs.Name = ConfigArgs.Name or "Unnamed Summit UI Menu"
	ConfigArgs.Icon = ConfigArgs.Icon or "rbxassetid://18820555586"
	ConfigArgs.AccentColor3 = ConfigArgs.AccentColor3 or Color3.new(0.556863, 0.564706, 1)

	SummitUI = Instance.new("ScreenGui")
	SideBar = Instance.new("Frame")
	UIPadding = Instance.new("UIPadding")
	settingsBTN = Instance.new("ImageButton")
	TabsScrollingFrame = Instance.new("ScrollingFrame")
	UIListLayout = Instance.new("UIListLayout")
	MenuFrame = Instance.new("Frame")
	TabTitle = Instance.new("TextLabel")
	UIGradient = Instance.new("UIGradient")
	TabContentsFrame = Instance.new("ScrollingFrame")
	UIListLayout_2 = Instance.new("UIListLayout")
	UIPadding_2 = Instance.new("UIPadding")
	UIPadding_3 = Instance.new("UIPadding")
	TopBar = Instance.new("Frame")
	GUITitle = Instance.new("TextLabel")
	UIGradient_2 = Instance.new("UIGradient")
	ImageLabel = Instance.new("ImageLabel")
	UIGradient_3 = Instance.new("UIGradient")
	local SettingsPanel = Instance.new("Frame")

	--Properties:

	SummitUI.Name = "SummitUI"
	SummitUI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	SummitUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	SideBar.Name = "SideBar"
	SideBar.Parent = TopBar
	SideBar.BackgroundColor3 = Color3.fromRGB(22, 23, 27)
	SideBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SideBar.BorderSizePixel = 0
	SideBar.Position = UDim2.new(0, 0,0.984, 0)
	SideBar.Size = UDim2.new(0, 237, 0, 310)

	UIPadding.Parent = SideBar
	UIPadding.PaddingLeft = UDim.new(0, 10)

	SettingsPanel.Name = "SettingsPanel"
	SettingsPanel.Parent = SideBar
	SettingsPanel.BackgroundColor3 = Color3.fromRGB(20, 21, 24)
	SettingsPanel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SettingsPanel.BorderSizePixel = 0
	SettingsPanel.Position = UDim2.new(0, 0, 0.870967746, 0)
	SettingsPanel.Size = UDim2.new(1, 0, 0, 40)
	SettingsPanel.ZIndex = 5

	settingsBTN.Name = "settingsBTN"
	settingsBTN.Parent = SettingsPanel
	settingsBTN.BackgroundTransparency = 1.000
	settingsBTN.LayoutOrder = 1
	settingsBTN.Position = UDim2.new(0.0421940945, 0, 0, 7)
	settingsBTN.Size = UDim2.new(0, 25, 0, 25)
	settingsBTN.ZIndex = 2
	settingsBTN.Image = "rbxassetid://3926307971"
	settingsBTN.ImageRectOffset = Vector2.new(324, 124)
	settingsBTN.ImageRectSize = Vector2.new(36, 36)

	local TextLabel77 = Instance.new("TextLabel")
	TextLabel77.Parent = SettingsPanel
	TextLabel77.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel77.BackgroundTransparency = 1.000
	TextLabel77.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel77.BorderSizePixel = 0
	TextLabel77.Position = UDim2.new(0.177215189, 0, 0, 7)
	TextLabel77.Size = UDim2.new(0, 185, 0, 25)
	TextLabel77.FontFace = defaultFont
	TextLabel77.Text = "Settings"
	TextLabel77.TextColor3 = Color3.fromRGB(253, 253, 253)
	TextLabel77.TextSize = 30.000
	TextLabel77.TextXAlignment = Enum.TextXAlignment.Left

	TabsScrollingFrame.Name = "TabsScrollingFrame"
	TabsScrollingFrame.Parent = SideBar
	TabsScrollingFrame.Active = true
	TabsScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabsScrollingFrame.BackgroundTransparency = 1.000
	TabsScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabsScrollingFrame.BorderSizePixel = 0
	TabsScrollingFrame.Size = UDim2.new(0, 243, 0, 262)
	TabsScrollingFrame.ScrollBarImageTransparency = 1

	UIListLayout.Parent = TabsScrollingFrame
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 5)

	UIPadding_3.Parent = TabsScrollingFrame
	UIPadding_3.PaddingTop = UDim.new(0, 5)
	UIPadding_3.PaddingLeft = UDim.new(0,7)

	MenuFrame.Name = "MenuFrame"
	MenuFrame.Parent = TopBar
	MenuFrame.BackgroundColor3 = Color3.fromRGB(17, 19, 21)
	MenuFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MenuFrame.BorderSizePixel = 0
	MenuFrame.Position = UDim2.new(0.345, 0,0.984, 0)
	MenuFrame.Size = UDim2.new(0, 450, 0, 310)

	TabTitle.Name = "TabTitle"
	TabTitle.Parent = MenuFrame
	TabTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabTitle.BackgroundTransparency = 1.000
	TabTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabTitle.BorderSizePixel = 0
	TabTitle.Position = UDim2.new(0.0111111114, 0, 0.00055286038, 0)
	TabTitle.Size = UDim2.new(0, 444, 0, 31)
	TabTitle.Font = Enum.Font.SourceSansBold
	TabTitle.Text = "Select A Tab"
	TabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	TabTitle.TextSize = 22.000
	TabTitle.TextXAlignment = Enum.TextXAlignment.Left

	UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, ConfigArgs.AccentColor3), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(225, 226, 227))} -- Color3.fromRGB(253, 186, 187)
	UIGradient.Rotation = -180
	UIGradient.Parent = TabTitle

	TabContentsFrame.Name = "TabContentsFrame"
	TabContentsFrame.Parent = MenuFrame
	TabContentsFrame.Active = true
	TabContentsFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabContentsFrame.BackgroundTransparency = 1
	TabContentsFrame.ScrollBarThickness = 4
	TabContentsFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabContentsFrame.BorderSizePixel = 0
	TabContentsFrame.Position = UDim2.new(0, 0, 0.100000001, 0)
	TabContentsFrame.Size = UDim2.new(0, 448, 0, 279)

	UIListLayout_2.Parent = TabContentsFrame
	UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_2.Padding = UDim.new(0, 4)

	UIPadding_2.Parent = TabContentsFrame
	UIPadding_2.PaddingLeft = UDim.new(0, 5)

	TopBar.Name = "TopBar"
	TopBar.Parent = SummitUI
	TopBar.BackgroundColor3 = Color3.fromRGB(22, 23, 27)
	TopBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TopBar.BorderSizePixel = 0
	TopBar.Position = UDim2.new(0.311196476, 0, 0.351635993, 0)
	TopBar.Size = UDim2.new(0, 687, 0, 40)

	GUITitle.Name = "GUITitle"
	GUITitle.Parent = TopBar
	GUITitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	GUITitle.BackgroundTransparency = 1.000
	GUITitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
	GUITitle.BorderSizePixel = 0
	GUITitle.Position = UDim2.new(0,45, 7.62939464e-07, 0)
	GUITitle.Size = UDim2.new(0, 463, 0, 39)
	GUITitle.Font = Enum.Font.SourceSansBold
	GUITitle.Text = ConfigArgs.Name
	GUITitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	GUITitle.TextSize = 24.000
	GUITitle.TextXAlignment = Enum.TextXAlignment.Left

	UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, ConfigArgs.AccentColor3), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(225, 226, 227))} -- Color3.fromRGB(253, 186, 187)
	UIGradient_2.Rotation = -180
	UIGradient_2.Parent = GUITitle

	ImageLabel.Parent = TopBar
	ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel.BackgroundTransparency = 1.000
	ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ImageLabel.BorderSizePixel = 0
	ImageLabel.Position = UDim2.new(0.0029112082, 0, 0, 0)
	ImageLabel.Size = UDim2.new(0, 40, 0, 40)
	ImageLabel.Image = ConfigArgs.Icon

	UIGradient_3.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, ConfigArgs.AccentColor3), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(225, 226, 227))}--Color3.fromRGB(253, 186, 187)
	UIGradient_3.Rotation = -180
	UIGradient_3.Parent = ImageLabel

	local NotificationTable = Instance.new("Frame")
	NotificationTable.Name = "NotificationTable"
	NotificationTable.Parent = SummitUI
	NotificationTable.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	NotificationTable.BackgroundTransparency = 1
	NotificationTable.BorderColor3 = Color3.fromRGB(0, 0, 0)
	NotificationTable.BorderSizePixel = 0
	NotificationTable.Position = UDim2.new(0.846871555, 0, 0.01813, 0)
	NotificationTable.Size = UDim2.new(0.143249184, 0, 0.96545, 0)

	local close = Instance.new("ImageButton")
	local remove = Instance.new("ImageButton")
	local uiCorner44432 = Instance.new("UICorner")
	local minimized = false
	local closed = false
	local closedPos = UDim2.new(0.311, 0,0.352, 0)

	uiCorner44432.Parent = TopBar
	uiCorner44432.CornerRadius = UDim.new(0,0)

	close.Name = "close"
	close.Parent = TopBar
	close.BackgroundTransparency = 1.000
	close.LayoutOrder = 5
	close.Position = UDim2.new(1, -30,0.175, 0)
	close.Size = UDim2.new(0, 25, 0, 25)
	close.ZIndex = 2
	close.Image = "rbxassetid://3926305904"
	close.ImageRectOffset = Vector2.new(284, 4)
	close.ImageRectSize = Vector2.new(24, 24)

	remove.Name = "remove"
	remove.Parent = close
	remove.BackgroundTransparency = 1.000
	remove.LayoutOrder = 6
	remove.Position = UDim2.new(-1,0,0,0)
	remove.Size = UDim2.new(0, 25, 0, 25)
	remove.ZIndex = 2
	remove.Image = "rbxassetid://3926307971"
	remove.ImageRectOffset = Vector2.new(884, 284)
	remove.ImageRectSize = Vector2.new(36, 36)

	local TemporaryText = Instance.new("TextLabel")

	--Properties:

	TemporaryText.Name = "TabTitle"
	TemporaryText.Parent = TabContentsFrame
	TemporaryText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TemporaryText.BackgroundTransparency = 1.000
	TemporaryText.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TemporaryText.BorderSizePixel = 0
	TemporaryText.Position = UDim2.new(0.0111111114, 0, 0.00055286038, 0)
	TemporaryText.Size = UDim2.new(0, 444, 0, 31)
	TemporaryText.Font = Enum.Font.SourceSansBold
	TemporaryText.Text = `<b>{ConfigArgs.Name}</b> x <b>Summit UI Library v1.4 </b>`
	TemporaryText.TextColor3 = Color3.fromRGB(150, 150, 150)
	TemporaryText.TextSize = 15
	TemporaryText.RichText = true
	TemporaryText.TextXAlignment = Enum.TextXAlignment.Left
	TemporaryText.TextYAlignment = Enum.TextYAlignment.Top


	local ScrollingFrame555 = Instance.new("ScrollingFrame")
	ScrollingFrame555.Parent = SettingsPanel
	ScrollingFrame555.Active = true
	ScrollingFrame555.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ScrollingFrame555.BackgroundTransparency = 1.000
	ScrollingFrame555.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ScrollingFrame555.BorderSizePixel = 0
	ScrollingFrame555.ScrollBarThickness = 4
	ScrollingFrame555.Position = UDim2.new(0.0527426153, 0, 0.119354837, 0)
	ScrollingFrame555.Size = UDim2.new(0, 214, 0, 265)

	local UILIST5 = Instance.new("UIListLayout")
	UILIST5.Parent = ScrollingFrame555
	UILIST5.Padding = UDim.new(0,5)

	UIPadding.Parent = ScrollingFrame555
	UIPadding.PaddingRight = UDim.new(0, 10)

	local dragging = false
	local dragInput = nil
	local dragStart = nil
	local startPosition = nil

	local function update(input)
		local delta = input.Position - dragStart
		TopBar.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
	end

	TopBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPosition = TopBar.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	TopBar.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end) 

	-- Add the CreateTab method to the window object
	local window = {}

	function window:CreateNotification(args)
		args.Duration = args.Duration or 3
		args.Title = args.Title or "Notification"
		args.Description = args.Description or "UI created lovingly by Github.com/Dialga156b. You forgot to put a description."

		local Notification = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local Title = Instance.new("TextLabel")
		local BodyText = Instance.new("TextLabel")
		local Frame = Instance.new("Frame")
		local notifications = Instance.new("ImageButton")
		local UIListLayout = Instance.new("UIListLayout")

		UIStroke.Parent = Notification
		UIStroke.Thickness = 1.8
		UIStroke.Color = Color3.new(.8,.8,.8)

		Notification.Name = "Notification"
		Notification.Parent = NotificationTable -- Make sure NotificationTable is defined
		Notification.BackgroundColor3 = Color3.fromRGB(16, 18, 20)
		Notification.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Notification.BorderSizePixel = 0
		Notification.BackgroundTransparency = 0.15
		Notification.ClipsDescendants = true
		Notification.Position = UDim2.new(0.934865892, 0, 0.991055429, 0)
		Notification.Size = UDim2.new(0.87356323, 0, 0, 0) -- Start with height 0 for animation

		UICorner.Parent = Notification

		Title.Name = "Title"
		Title.Parent = Notification
		Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Title.BackgroundTransparency = 1.000
		Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Title.BorderSizePixel = 0
		Title.Position = UDim2.new(0.149122804, 0, 0.0588235296, 0)
		Title.Size = UDim2.new(0.820175409, 0, 0, 25) -- Set proper size
		Title.FontFace = Font.new('rbxasset://fonts/families/TitilliumWeb.json', Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Title.Text = args.Title
		Title.TextColor3 = Color3.fromRGB(255, 255, 255)
		Title.TextSize = 25.000
		Title.TextXAlignment = Enum.TextXAlignment.Left

		BodyText.Name = "BodyText"
		BodyText.Parent = Notification
		BodyText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BodyText.BackgroundTransparency = 1.000
		BodyText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BodyText.BorderSizePixel = 0
		BodyText.Position = UDim2.new(0.026, 0, 0.33, 0)
		BodyText.Size = UDim2.new(0.94, 0, 0.53, 0)
		BodyText.FontFace = Font.new('rbxasset://fonts/families/TitilliumWeb.json', Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		BodyText.Text = args.Description
		BodyText.TextColor3 = Color3.fromRGB(191, 191, 191)
		BodyText.TextSize = 18.000
		BodyText.TextWrapped = true
		BodyText.TextXAlignment = Enum.TextXAlignment.Left
		BodyText.TextYAlignment = Enum.TextYAlignment.Top

		Frame.Parent = Notification
		Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame.BorderSizePixel = 0
		Frame.Position = UDim2.new(0.026, 0, 0.92, 0)
		Frame.Size = UDim2.new(0.94, 0, 0.03, 0)

		notifications.Name = "notifications"
		notifications.Parent = Notification
		notifications.BackgroundTransparency = 1.000
		notifications.LayoutOrder = 1
		notifications.Position = UDim2.new(0.02, 0, 0.08, 0)
		notifications.Size = UDim2.new(0.11, 0, 0.245, 0)
		notifications.ZIndex = 2
		notifications.Image = "rbxassetid://3926305904"
		notifications.ImageRectOffset = Vector2.new(844, 564)
		notifications.ImageRectSize = Vector2.new(36, 36)

		UIListLayout.Parent = NotificationTable
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
		UIListLayout.Padding = UDim.new(0, 15)

		coroutine.wrap(function()
			local showTween = game:GetService("TweenService"):Create(Notification, TweenInfo.new(.7, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Size = UDim2.new(0.87356323, 0, 0.0912343487, 0)})
			showTween:Play()

			local thingy = game:GetService("TweenService"):Create(Frame, TweenInfo.new(args.Duration, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0.03, 0)})
			thingy:Play()
			wait(args.Duration)

			local hideTween = game:GetService("TweenService"):Create(Notification, TweenInfo.new(.7, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Size = UDim2.new(0.87356323, 0, 0, 0)})
			local hideStrokeTween = game:GetService("TweenService"):Create(UIStroke, TweenInfo.new(.7, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Thickness = 0})
			hideTween:Play()
			hideStrokeTween:Play()
			hideTween.Completed:Wait()
			Notification:Destroy()
		end)()
	end
	
	SideBar.ClipsDescendants = true
	MenuFrame.ClipsDescendants = true
	
	addConnection(remove.MouseButton1Click,function() 
		if minimizeAnim then
			game:GetService("TweenService"):Create(SideBar,TweenInfo.new(.6,Enum.EasingStyle.Cubic,Enum.EasingDirection.In),{Size = UDim2.new(0, 237, 0, 0)}):Play()
			wait(.3)
			coroutine.wrap(function()
				GUITitle.Text = ConfigArgs.Name
				for i = #GUITitle.Text, 0, -1 do
					GUITitle.Text = string.sub(GUITitle.Text,0,i)
					task.wait()
				end
				GUITitle.Text = "U"
				task.wait()
				GUITitle.Text = "UI"
			end)()
			game:GetService("TweenService"):Create(MenuFrame,TweenInfo.new(.6,Enum.EasingStyle.Cubic,Enum.EasingDirection.In),{Size = UDim2.new(0, 450, 0, 0)}):Play()
			wait(.4)
			game:GetService("TweenService"):Create(TopBar,TweenInfo.new(1,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut),{Size = UDim2.new(0, 140, 0, 40)}):Play()
			game:GetService("TweenService"):Create(close,TweenInfo.new(.6,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut),{Rotation = -45}):Play()
			game:GetService("TweenService"):Create(remove,TweenInfo.new(.3,Enum.EasingStyle.Cubic,Enum.EasingDirection.In),{ImageTransparency = 1}):Play()
			wait(.3)
			game:GetService("TweenService"):Create(uiCorner44432,TweenInfo.new(.5,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut),{CornerRadius = UDim.new(0,8)}):Play()
			minimized = true
		else
			uiCorner44432.CornerRadius = UDim.new(0,8)
			remove.ImageTransparency = 1
			TopBar.Size = UDim2.new(0,140,0,40)
			MenuFrame.Size = UDim2.new(0,450,0,0)
			SideBar.Size = UDim2.new(0,237,0,0)
			GUITitle.Text = 'UI'
			close.Rotation = -45
			minimized = true
		end
	end)

	addConnection(close.MouseButton1Click,function() 
		if minimized then
			game:GetService("TweenService"):Create(uiCorner44432,TweenInfo.new(.5,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut),{CornerRadius = UDim.new(0,0)}):Play()
			game:GetService("TweenService"):Create(TopBar,TweenInfo.new(1,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut),{Size = UDim2.new(0, 687, 0, 40)}):Play()
			game:GetService("TweenService"):Create(close,TweenInfo.new(.6,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut),{Rotation = 0}):Play()
			game:GetService("TweenService"):Create(remove,TweenInfo.new(.3,Enum.EasingStyle.Cubic,Enum.EasingDirection.In),{ImageTransparency = 0}):Play()
			wait(.4)
			coroutine.wrap(function()
				local text = ConfigArgs.Name
				for i = 1, #text do
					GUITitle.Text = string.sub(text, 1, i)
					task.wait()
				end
			end)()
			game:GetService("TweenService"):Create(SideBar,TweenInfo.new(.6,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut),{Size = UDim2.new(0, 237, 0, 310)}):Play()
			wait(.2)
			game:GetService("TweenService"):Create(MenuFrame,TweenInfo.new(.6,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut),{Size = UDim2.new(0, 450, 0, 310)}):Play()
			minimized = false
		else
			closedPos = TopBar.Position
			closed = true
			if not instantClose then
				game:GetService("TweenService"):Create(TopBar,TweenInfo.new(.6,Enum.EasingStyle.Cubic,Enum.EasingDirection.In),{Position = closedPos + UDim2.new(0,0,1.1,0)}):Play()
				window:CreateNotification({Title = "UI Hidden",Duration = 2,Description = "UI will be hidden until RightShift is pressed."})	
			else
				TopBar.Position = closedPos + UDim2.new(0,0,1.1,0)
			end
		end
	end)

	addConnection(game:GetService("UserInputService").InputBegan,function(input: InputObject, gameProcessedEvent: boolean) 
		if input.KeyCode == Enum.KeyCode.RightShift and closed then
			game:GetService("TweenService"):Create(TopBar,TweenInfo.new(.6,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out),{Position = closedPos}):Play()
			wait(.6)
			closed = false
		end
	end)


	function window:CreateTab(tabConfig)
		local tabName = tabConfig.Name or 'Untitled_Tab'
		local tabIcon = tabConfig.Icon or 'rbxassetid://7733800044' -- gavel
		local TabExample = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local SelectionText = Instance.new("TextLabel")
		local InteractionButton = Instance.new("ImageButton")
		local SelectionImage = Instance.new("ImageLabel")
		local UICorner_2 = Instance.new("UICorner")

		if not summitLib.contents.Tabs[tabName] then
			summitLib.contents.Tabs[tabName] = { Objects = {} }
		end

		TabExample.Name = "Tab_"..tabName
		TabExample.Parent = TabsScrollingFrame
		TabExample.BackgroundColor3 = Color3.fromRGB(17, 18, 21)
		TabExample.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabExample.BorderSizePixel = 0
		TabExample.Size = UDim2.new(0, 223, 0, 30)
		
		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = TabExample

		SelectionText.Name = "SelectionText"
		SelectionText.Parent = TabExample
		SelectionText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SelectionText.BackgroundTransparency = 1.000
		SelectionText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SelectionText.BorderSizePixel = 0
		SelectionText.Position = UDim2.new(0.165, 0, 0.033, 0)
		SelectionText.Size = UDim2.new(0, 182, 0, 29)
		SelectionText.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		SelectionText.Text = tabName
		SelectionText.TextColor3 = Color3.fromRGB(206, 206, 206)
		SelectionText.TextSize = 15
		SelectionText.TextXAlignment = Enum.TextXAlignment.Left

		InteractionButton.Name = "InteractionButton"
		InteractionButton.Parent = TabExample
		InteractionButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		InteractionButton.BackgroundTransparency = 1.000
		InteractionButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		InteractionButton.BorderSizePixel = 0
		InteractionButton.Size = UDim2.new(0, 218, 0, 30)
		InteractionButton.Image = ""
		assignClickAnimation(InteractionButton)

		SelectionImage.Name = "SelectionImage"
		SelectionImage.Parent = TabExample
		SelectionImage.AnchorPoint = Vector2.new(0, 0.5)
		SelectionImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SelectionImage.BackgroundTransparency = 1.000
		SelectionImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SelectionImage.BorderSizePixel = 0
		SelectionImage.Position = UDim2.new(0, 5, 0.5, 0)
		SelectionImage.Size = UDim2.new(0, 24, 0, 24)
		SelectionImage.Image = tabIcon

		addConnection(InteractionButton.MouseButton1Click, function()
			TabTitle.Text = tabName
			loadTabContents(tabName)
		end)

		UICorner_2.Parent = SelectionImage

		local thisTab = {
			Name = tabName,
			-- Reference to this tab's content storage
			Contents = summitLib.contents.Tabs[tabName]
		}

		function thisTab:CreateLabel(text)
			table.insert(self.Contents.Objects, {
				ObjectType = 'Label',
				Text = text
			})
			local Label = Instance.new("TextLabel")
			Label.Name = tabName.."_Label"
			Label.Visible = false
			Label.Parent = TabContentsFrame
			Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Label.BackgroundTransparency = 1.000
			Label.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Label.BorderSizePixel = 0
			Label.Size = UDim2.new(0, 423, 0, 22)
			Label.FontFace = Font.new('rbxasset://fonts/families/TitilliumWeb.json', Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			Label.Text = text
			Label.TextColor3 = Color3.fromRGB(193, 193, 193)
			Label.TextSize = 21
			Label.TextWrapped = true
			Label.TextXAlignment = Enum.TextXAlignment.Left
		end
		function thisTab:CreateParagraph(text)
			table.insert(self.Contents.Objects, {
				ObjectType = 'Paragraph',
				Text = text
			})
			local Paragraph = Instance.new("TextLabel")
			Paragraph.Visible = false
			Paragraph.Name = tabName.."_Paragraph"
			Paragraph.Parent = TabContentsFrame
			Paragraph.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Paragraph.BackgroundTransparency = 1.000
			Paragraph.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Paragraph.BorderSizePixel = 0
			Paragraph.Size = UDim2.new(0, 423, 0, 22)
			Paragraph.FontFace = Font.new('rbxasset://fonts/families/TitilliumWeb.json', Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			Paragraph.Text = text
			Paragraph.TextColor3 = Color3.fromRGB(193, 193, 193)
			Paragraph.TextSize = 18
			Paragraph.TextWrapped = true
			Paragraph.AutomaticSize = Enum.AutomaticSize.Y
			Paragraph.TextXAlignment = Enum.TextXAlignment.Left
		end
		function thisTab:CreateSlider(args)
			local Minimum = args.Minimum
			local Maximum = args.Maximum
			local Text = args.Text
			local Default = args.Default
			local Callback = args.Callback or function() end
			table.insert(self.Contents.Objects, {
				ObjectType = 'Slider',
				
				sliderMinimum = Minimum,
				sliderMaximum = Maximum,
				Text = Text,
				sliderDefault = Default,
				sliderCallback = Callback
			})
			local Slider = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local SliderText = Instance.new("TextLabel")
			local sliderBG = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local SliderFrame = Instance.new("Frame")
			local UICorner_3 = Instance.new("UICorner")
			local CurrentValueText = Instance.new("TextLabel")
			local ImageButton = Instance.new("ImageButton")
			local MaximumText = Instance.new("TextLabel")
			local MinimumText = Instance.new("TextLabel")

			--Properties:

			Slider.Name = tabName.."_Slider"
			Slider.Parent = TabContentsFrame
			Slider.BackgroundColor3 = Color3.fromRGB(22, 23, 27)
			Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Slider.BorderSizePixel = 0
			Slider.Visible = false
			Slider.Position = UDim2.new(0, 0, 0.30107528, 0)
			Slider.Size = UDim2.new(0, 423, 0, 69)

			UICorner.CornerRadius = UDim.new(0, 6)
			UICorner.Parent = Slider

			SliderText.Name = "SliderText"
			SliderText.Parent = Slider
			SliderText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SliderText.BackgroundTransparency = 1.000
			SliderText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SliderText.BorderSizePixel = 0
			SliderText.Position = UDim2.new(0.0141843967, 0, 0, 0)
			SliderText.Size = UDim2.new(0, 417, 0, 22)
			SliderText.FontFace = Font.new('rbxasset://fonts/families/TitilliumWeb.json', Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			SliderText.Text = Text
			SliderText.TextColor3 = Color3.fromRGB(193, 193, 193)
			SliderText.TextSize = 21
			SliderText.TextWrapped = true
			SliderText.TextXAlignment = Enum.TextXAlignment.Left

			sliderBG.Name = "sliderBG"
			sliderBG.Parent = Slider
			sliderBG.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
			sliderBG.BorderColor3 = Color3.fromRGB(0, 0, 0)
			sliderBG.BorderSizePixel = 0
			sliderBG.Position = UDim2.new(0.0141843967, 0, 0.536231875, 0)
			sliderBG.Size = UDim2.new(0, 410, 0, 24)

			UICorner_2.Parent = sliderBG

			SliderFrame.Name = "SliderFrame"
			SliderFrame.Parent = sliderBG
			SliderFrame.AnchorPoint = Vector2.new(0, 0.5)
			SliderFrame.BackgroundColor3 = setHueAndSaturation(ConfigArgs.AccentColor3,.5,.8)
			SliderFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SliderFrame.BorderSizePixel = 0
			SliderFrame.Position = UDim2.new(0, 0, 0.5, 0)
			SliderFrame.Size = UDim2.new((Default - Minimum) / (Maximum - Minimum),0,1,0)

			UICorner_3.Parent = SliderFrame

			CurrentValueText.Name = "CurrentValueText"
			CurrentValueText.Parent = SliderFrame
			CurrentValueText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			CurrentValueText.BackgroundTransparency = 1.000
			CurrentValueText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			CurrentValueText.BorderSizePixel = 0
			CurrentValueText.Position = UDim2.new(0.0336964689, 0, 0, 0)
			CurrentValueText.Size = UDim2.new(0, 163, 0, 23)
			CurrentValueText.FontFace = Font.new('rbxasset://fonts/families/TitilliumWeb.json', Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			CurrentValueText.Text = Default
			CurrentValueText.TextColor3 = Color3.fromRGB(206, 206, 206)
			CurrentValueText.TextSize = 17.000
			CurrentValueText.TextXAlignment = Enum.TextXAlignment.Left
			CurrentValueText.TextYAlignment = Enum.TextYAlignment.Bottom

			ImageButton.Parent = sliderBG
			ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ImageButton.BackgroundTransparency = 1.000
			ImageButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ImageButton.BorderSizePixel = 0
			ImageButton.Size = UDim2.new(0, 410, 0, 24)

			MaximumText.Name = "MaximumText"
			MaximumText.Parent = Slider
			MaximumText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			MaximumText.BackgroundTransparency = 1.000
			MaximumText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			MaximumText.BorderSizePixel = 0
			MaximumText.Position = UDim2.new(0.49881798, 0, 0.347826093, 0)
			MaximumText.Size = UDim2.new(0, 205, 0, 7)
			MaximumText.FontFace = Font.new('rbxasset://fonts/families/TitilliumWeb.json', Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			MaximumText.Text = Maximum
			MaximumText.TextColor3 = Color3.fromRGB(150, 150, 150)
			MaximumText.TextSize = 17.000
			MaximumText.TextXAlignment = Enum.TextXAlignment.Right

			MinimumText.Name = "MinimumText"
			MinimumText.Parent = Slider
			MinimumText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			MinimumText.BackgroundTransparency = 1.000
			MinimumText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			MinimumText.BorderSizePixel = 0
			MinimumText.Position = UDim2.new(0.0141843967, 0, 0.347826093, 0)
			MinimumText.Size = UDim2.new(0, 156, 0, 7)
			MinimumText.FontFace = Font.new('rbxasset://fonts/families/TitilliumWeb.json', Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			MinimumText.Text = Minimum
			MinimumText.TextColor3 = Color3.fromRGB(150, 150, 150)
			MinimumText.TextSize = 17
			MinimumText.TextXAlignment = Enum.TextXAlignment.Left

			local isDragging = false
			local posOnSlider
			local sliderPercentage
			local x = game:GetService("Players").LocalPlayer:GetMouse()

			ImageButton.MouseButton1Down:Connect(function()
				isDragging = true
			end)

			ImageButton.MouseButton1Up:Connect(function()
				isDragging = false
				SliderFrame.Size = UDim2.new(sliderPercentage, 0, 1, 0)
			end)

			addConnection(game:GetService("RunService").RenderStepped, function(deltaTime: number)
				if isDragging == true then
					posOnSlider = (x.X - sliderBG.AbsolutePosition.X) / sliderBG.AbsoluteSize.X
					sliderPercentage = math.clamp(posOnSlider, 0, 1)
					SliderFrame.Size = SliderFrame.Size:Lerp(UDim2.new(sliderPercentage, 0, 1, 0), .3)

					local minValue = Minimum
					local maxValue = Maximum
					local range = maxValue - minValue
					local sliderValue = math.floor((sliderPercentage * range) + minValue)

					CurrentValueText.Text = sliderValue
					Callback(sliderValue)
				end					
			end)
			local slider = {}
			function slider:Set(value)
				sliderPercentage = (value - Minimum) / (Maximum - Minimum)
				local tween = game:GetService("TweenService"):Create(SliderFrame,TweenInfo.new(.6,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out),{Size = UDim2.new(sliderPercentage,0,1,0)})
				tween:Play()
				Callback(value)
				CurrentValueText.Text = value
			end
			return slider
		end
		function thisTab:CreateButton(args)
			args.Text = args.Text or "Button"
			args.Callback = args.Callback or function() end
			local Button = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local SliderText = Instance.new("TextLabel")
			local ImageButton = Instance.new("ImageButton")
			local tapIcon = Instance.new("ImageButton")

			--Properties:

			Button.Name =  tabName.."_Button"
			Button.Parent = TabContentsFrame
			Button.BackgroundColor3 = Color3.fromRGB(22, 23, 27)
			Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Button.BorderSizePixel = 0
			Button.Visible = false
			Button.Position = UDim2.new(0, 0, 0.562723994, 0)
			Button.Size = UDim2.new(0, 423, 0, 45)

			UICorner.CornerRadius = UDim.new(0, 6)
			UICorner.Parent = Button

			SliderText.Name = "SliderText"
			SliderText.Parent = Button
			SliderText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SliderText.BackgroundTransparency = 1.000
			SliderText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SliderText.BorderSizePixel = 0
			SliderText.Position = UDim2.new(0.0283687934, 0, 0, 0)
			SliderText.Size = UDim2.new(0, 366, 0, 45)
			SliderText.FontFace = Font.new('rbxasset://fonts/families/TitilliumWeb.json', Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			SliderText.Text = args.Text
			SliderText.TextColor3 = Color3.fromRGB(193, 193, 193)
			SliderText.TextSize = 21.000
			SliderText.TextWrapped = true
			SliderText.TextXAlignment = Enum.TextXAlignment.Left

			ImageButton.Parent = Button
			ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ImageButton.BackgroundTransparency = 1.000
			ImageButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ImageButton.BorderSizePixel = 0
			ImageButton.Size = UDim2.new(0, 423, 0, 45)
			ImageButton.Visible = true

			tapIcon.Name = "tapIcon"
			tapIcon.Parent = Button
			tapIcon.AnchorPoint = Vector2.new(0.5, 0.5)
			tapIcon.BackgroundTransparency = 1.000
			tapIcon.LayoutOrder = 11
			tapIcon.Position = UDim2.new(0.949999988, 0, 0.5, 0)
			tapIcon.Size = UDim2.new(0, 25, 0, 25)
			tapIcon.ZIndex = 2
			tapIcon.Image = "rbxassetid://3926305904"
			tapIcon.ImageRectOffset = Vector2.new(164, 844)
			tapIcon.ImageRectSize = Vector2.new(36, 36)
			assignClickAnimation(ImageButton)
			addConnection(ImageButton.MouseButton1Click,function() 
				args.Callback()
			end)
		end
		function thisTab:CreateToggle(args)
			args.Callback = args.Callback or function() end
			args.Default = args.Default or false
			args.Text = args.Text or "Toggle"
			local Checkbox = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local SliderText = Instance.new("TextLabel")
			local ImageButton = Instance.new("ImageButton")
			local tapIcon = Instance.new("ImageLabel")
			local UICorner_2 = Instance.new("UICorner")
			local UIStroke = Instance.new("UIStroke")
			--Properties:

			Checkbox.Name = tabName.."_Checkbox"
			Checkbox.Parent = TabContentsFrame
			Checkbox.BackgroundColor3 = Color3.fromRGB(22, 23, 27)
			Checkbox.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Checkbox.BorderSizePixel = 0
			Checkbox.Position = UDim2.new(0, 0, 0.562723994, 0)
			Checkbox.Size = UDim2.new(0, 423, 0, 45)
			Checkbox.Visible = false

			UICorner.CornerRadius = UDim.new(0, 6)
			UICorner.Parent = Checkbox

			SliderText.Name = "SliderText"
			SliderText.Parent = Checkbox
			SliderText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SliderText.BackgroundTransparency = 1.000
			SliderText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SliderText.BorderSizePixel = 0
			SliderText.Position = UDim2.new(0.0283687934, 0, 0, 0)
			SliderText.Size = UDim2.new(0, 366, 0, 45)
			SliderText.FontFace = Font.new('rbxasset://fonts/families/TitilliumWeb.json', Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			SliderText.Text = args.Text
			SliderText.TextColor3 = Color3.fromRGB(193, 193, 193)
			SliderText.TextSize = 21.000
			SliderText.TextWrapped = true
			SliderText.TextXAlignment = Enum.TextXAlignment.Left

			ImageButton.Parent = Checkbox
			ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ImageButton.BackgroundTransparency = 1.000
			ImageButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ImageButton.BorderSizePixel = 0
			ImageButton.Size = UDim2.new(0, 423, 0, 45)
			ImageButton.Visible = true
			ImageButton.ZIndex = 2

			tapIcon.Name = "tapIcon"
			tapIcon.Parent = Checkbox
			tapIcon.AnchorPoint = Vector2.new(0.5, 0.5)
			tapIcon.BackgroundColor3 = setHueAndSaturation(ConfigArgs.AccentColor3,.5,.8) 
			tapIcon.BackgroundTransparency = 1.000
			tapIcon.BorderSizePixel = 0
			tapIcon.LayoutOrder = 11
			tapIcon.Position = UDim2.new(0.949999988, 0, 0.5, 0)
			tapIcon.Size = UDim2.new(0, 15, 0, 15)
			tapIcon.ZIndex = 1
			tapIcon.ImageRectOffset = Vector2.new(164, 844)
			tapIcon.ImageRectSize = Vector2.new(36, 36)

			UICorner_2.CornerRadius = UDim.new(0, 16)
			UICorner_2.Parent = tapIcon

			UIStroke.Parent = tapIcon
			UIStroke.Thickness = 2.8
			UIStroke.Color = setHueAndSaturation(ConfigArgs.AccentColor3,.5,.8) 
			tapIcon.Size = UDim2.new(0,15,0,15)

			if args.Default == true then
				UIStroke.Thickness = 0
				UIStroke.Enabled = true
				tapIcon.Size = UDim2.new(0,20,0,20)
			end

			local enabled = args.Default
			assignClickAnimation(ImageButton)
			addConnection(ImageButton.MouseButton1Click,function() 
				enabled = not enabled
				args.Callback(enabled)
				if enabled == true then
					for i=0,1,.1 do
						UIStroke.Thickness = 2.8 - (2.8 * i)
						tapIcon.BackgroundTransparency = 1 - i
						task.wait()
					end
				else
					for i=0,1,.1 do
						UIStroke.Thickness = (2.8 * i)
						tapIcon.BackgroundTransparency = i
						task.wait()
					end
				end
			end)
			local toggle = {}
			function toggle:Set(Enabled: BoolValue)
				args.Callback(Enabled)
				if Enabled == true then
					for i=0,1,.1 do
						UIStroke.Thickness = 2.8 - (2.8 * i)
						tapIcon.BackgroundTransparency = 1 - i
						task.wait()
					end
				else
					for i=0,1,.1 do
						UIStroke.Thickness = (2.8 * i)
						tapIcon.BackgroundTransparency = i
						task.wait()
					end
				end
			end
			return toggle

		end
		function thisTab:CreatePlayerSelector(args)
			args.Text = args.Text or "Player Selector"
			args.Callback = args.Callback or function() end

			local PlayerSelector = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local SliderText = Instance.new("TextLabel")
			local ImageButton = Instance.new("ImageButton")
			local selectionFrame = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local ImageLabel = Instance.new("ImageLabel")
			local UICorner_3 = Instance.new("UICorner")
			local TextLabel = Instance.new("TextLabel")

			--Properties:

			PlayerSelector.Name = tabName.."_PlayerSelector"
			PlayerSelector.Parent = TabContentsFrame
			PlayerSelector.BackgroundColor3 = Color3.fromRGB(22, 23, 27)
			PlayerSelector.BorderColor3 = Color3.fromRGB(0, 0, 0)
			PlayerSelector.BorderSizePixel = 0
			PlayerSelector.Position = UDim2.new(0, 0, 0.351254493, 0)
			PlayerSelector.Size = UDim2.new(0, 423, 0, 63)
			PlayerSelector.Visible = false

			UICorner.CornerRadius = UDim.new(0, 6)
			UICorner.Parent = PlayerSelector

			SliderText.Name = "SliderText"
			SliderText.Parent = PlayerSelector
			SliderText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SliderText.BackgroundTransparency = 1.000
			SliderText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SliderText.BorderSizePixel = 0
			SliderText.Position = UDim2.new(0.0283687934, 0, 0, 0)
			SliderText.Size = UDim2.new(0, 218, 0, 63)
			SliderText.FontFace = defaultFont
			SliderText.Text = "Player Selector"
			SliderText.TextColor3 = Color3.fromRGB(193, 193, 193)
			SliderText.TextSize = 21.000
			SliderText.TextWrapped = true
			SliderText.TextXAlignment = Enum.TextXAlignment.Left

			ImageButton.Parent = PlayerSelector
			ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ImageButton.BackgroundTransparency = 1.000
			ImageButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ImageButton.BorderSizePixel = 0
			ImageButton.Size = UDim2.new(1,0,1,0)
			assignClickAnimation(ImageButton)

			selectionFrame.Name = "selectionFrame"
			selectionFrame.Parent = PlayerSelector
			selectionFrame.BackgroundColor3 = Color3.fromRGB(33, 34, 40)
			selectionFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			selectionFrame.BorderSizePixel = 0
			selectionFrame.ZIndex = 0
			selectionFrame.Position = UDim2.new(0.543735206, 0, 0.095238097, 0)
			selectionFrame.Size = UDim2.new(0, 185, 0, 51)

			UICorner_2.Parent = selectionFrame

			ImageLabel.Parent = selectionFrame
			ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ImageLabel.BorderSizePixel = 0
			ImageLabel.Position = UDim2.new(0.0324324332, 0, 0.0588235296, 0)
			ImageLabel.BackgroundTransparency = 1
			ImageLabel.Size = UDim2.new(0, 45, 0, 45)
			ImageLabel.Image = "http://www.roblox.com/asset/?id=10885644041"

			UICorner_3.Parent = ImageLabel

			TextLabel.Parent = selectionFrame
			TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.BackgroundTransparency = 1.000
			TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel.BorderSizePixel = 0
			TextLabel.Position = UDim2.new(0.313513517, 0, 0.0588235296, 0)
			TextLabel.Size = UDim2.new(0, 126, 0, 45)
			TextLabel.FontFace = defaultFont
			TextLabel.Text = "Select player.."
			TextLabel.TextColor3 = Color3.fromRGB(252, 252, 252)
			TextLabel.TextSize = 20.000
			TextLabel.TextWrapped = true
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left


			-- popup 

			local function popupMenu()	
				local playerIcons = getPlayersAndIcons()
				local PlayerDropdownMenu = Instance.new("Frame")
				local ScrollingFrame = Instance.new("ScrollingFrame")
				local UIPadding = Instance.new("UIPadding")
				local UIListLayout = Instance.new("UIListLayout")
				local TitleText = Instance.new("TextLabel")

				PlayerDropdownMenu.Name = "PlayerDropdownMenu"
				PlayerDropdownMenu.Parent = SideBar
				PlayerDropdownMenu.BackgroundColor3 = Color3.fromRGB(14, 15, 17)
				PlayerDropdownMenu.BorderColor3 = Color3.fromRGB(0, 0, 0)
				PlayerDropdownMenu.BorderSizePixel = 0
				PlayerDropdownMenu.Position = UDim2.new(-1.1, 0, -0.0032258064, 0)
				PlayerDropdownMenu.Size = UDim2.new(0, 237, 0, 271)

				ScrollingFrame.Parent = PlayerDropdownMenu
				ScrollingFrame.Active = true
				ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ScrollingFrame.BackgroundTransparency = 1.000
				ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ScrollingFrame.BorderSizePixel = 0
				ScrollingFrame.Position = UDim2.new(0, 0, 0.110701106, 0)
				ScrollingFrame.Size = UDim2.new(0, 236, 0, 213)
				ScrollingFrame.ScrollBarThickness = 4

				TitleText.Name = "TitleText"
				TitleText.Parent = PlayerDropdownMenu
				TitleText.AnchorPoint = Vector2.new(0, 0.5)
				TitleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TitleText.BackgroundTransparency = 1.000
				TitleText.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TitleText.BorderSizePixel = 0
				TitleText.Position = UDim2.new(0.0421940945, 0, 0.0585791096, 0)
				TitleText.Size = UDim2.new(0, 226, 0, 28)
				TitleText.FontFace = defaultFont
				TitleText.Text = args.Text
				TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
				TitleText.TextSize = 20.000
				TitleText.TextXAlignment = Enum.TextXAlignment.Left

				UIPadding.Parent = ScrollingFrame
				UIPadding.PaddingLeft = UDim.new(0, 10)
				UIPadding.PaddingRight = UDim.new(0, 10)

				UIListLayout.Parent = ScrollingFrame
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.Padding = UDim.new(0, 7)

				SideBar.ClipsDescendants = true
				local introTween = game:GetService("TweenService"):Create(PlayerDropdownMenu,TweenInfo.new(.4,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out),{Position = UDim2.new(0, 0, 0, 0)})
				introTween:Play()

				local isPlayerSelected = false
				for i,v in pairs(playerIcons) do
					local Name = v.Name
					local Icon = v.Icon

					local PlayerFrame = Instance.new("Frame")
					local UICorner = Instance.new("UICorner")
					local PlayerImage = Instance.new("ImageLabel")
					local UICorner_2 = Instance.new("UICorner")
					local PlayerNameLabel = Instance.new("TextLabel")
					local SelectionBox = Instance.new("ImageButton")

					PlayerFrame.Name = "PlayerFrame"
					PlayerFrame.Parent = ScrollingFrame
					PlayerFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
					PlayerFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
					PlayerFrame.BorderSizePixel = 0
					PlayerFrame.Size = UDim2.new(1, 0, -0.101060174, 100)

					UICorner.Parent = PlayerFrame

					PlayerImage.Name = "PlayerImage"
					PlayerImage.Parent = PlayerFrame
					PlayerImage.AnchorPoint = Vector2.new(0.5, 0.5)
					PlayerImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					PlayerImage.BackgroundTransparency = 1.000
					PlayerImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
					PlayerImage.BorderSizePixel = 0
					PlayerImage.Position = UDim2.new(0.115000002, 0, 0.5, 0)
					PlayerImage.Size = UDim2.new(0, 40, 0, 40)
					PlayerImage.Image = Icon

					UICorner_2.Parent = PlayerImage

					PlayerNameLabel.Name = "PlayerNameLabel"
					PlayerNameLabel.Parent = PlayerFrame
					PlayerNameLabel.AnchorPoint = Vector2.new(0, 0.5)
					PlayerNameLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					PlayerNameLabel.BackgroundTransparency = 1.000
					PlayerNameLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
					PlayerNameLabel.BorderSizePixel = 0
					PlayerNameLabel.Position = UDim2.new(0.230999976, 0, 0.500000238, 0)
					PlayerNameLabel.Size = UDim2.new(0, 166, 0, 40)
					PlayerNameLabel.FontFace = defaultFont
					PlayerNameLabel.Text = Name
					PlayerNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
					PlayerNameLabel.TextSize = 20.000
					PlayerNameLabel.TextXAlignment = Enum.TextXAlignment.Left

					SelectionBox.Name = "SelectionBox"
					SelectionBox.Parent = PlayerFrame
					SelectionBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					SelectionBox.BackgroundTransparency = 1.000
					SelectionBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
					SelectionBox.BorderSizePixel = 0
					SelectionBox.Size = UDim2.new(1, 0, 1, 0)
					assignClickAnimation(SelectionBox)
					addConnection(SelectionBox.MouseButton1Click,function()
						if isPlayerSelected == false then
							isPlayerSelected = true
							local outroTween = game:GetService("TweenService"):Create(PlayerDropdownMenu,TweenInfo.new(.5,Enum.EasingStyle.Cubic,Enum.EasingDirection.In),{Position = UDim2.new(-1.1, 0, -0.0032258064, 0)})
							outroTween:Play()
							TextLabel.Text = Name
							ImageLabel.Image = Icon
							args.Callback(game:GetService("Players"):FindFirstChild(Name))
							outroTween.Completed:Wait()
							PlayerDropdownMenu:Destroy()
						end
					end)
				end

			end
			addConnection(ImageButton.MouseButton1Click,function()
				popupMenu()
			end)
		end
		function thisTab:CreateDropdown(args)
			args.Text = args.Text or "Dropdown"
			args.Options = args.Options or {"Option 1", "Option 2", "Option 3"}
			args.Default = args.Default or "Option 1"
			args.Callback = args.Callback or function() end

			local Dropdown = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local SliderText = Instance.new("TextLabel")
			local ImageButton = Instance.new("ImageButton")
			local selectionFrame = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local TextLabel = Instance.new("TextLabel")

			--Properties:

			Dropdown.Name = tabName.."_Dropdown"
			Dropdown.Parent = TabContentsFrame
			Dropdown.BackgroundColor3 = Color3.fromRGB(22, 23, 27)
			Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Dropdown.BorderSizePixel = 0
			Dropdown.Position = UDim2.new(0, 0, 0.591397822, 0)
			Dropdown.Size = UDim2.new(0, 423, 0, 42)
			Dropdown.Visible = false

			UICorner.CornerRadius = UDim.new(0, 6)
			UICorner.Parent = Dropdown

			SliderText.Name = "SliderText"
			SliderText.Parent = Dropdown
			SliderText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SliderText.BackgroundTransparency = 1.000
			SliderText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SliderText.BorderSizePixel = 0
			SliderText.Position = UDim2.new(0.0283687934, 0, 0, 0)
			SliderText.Size = UDim2.new(0.482269496, 0, 1, 0)
			SliderText.FontFace = defaultFont
			SliderText.Text = args.Text
			SliderText.TextColor3 = Color3.fromRGB(193, 193, 193)
			SliderText.TextSize = 21.000
			SliderText.TextWrapped = true
			SliderText.TextXAlignment = Enum.TextXAlignment.Left

			ImageButton.Parent = Dropdown
			ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ImageButton.BackgroundTransparency = 1.000
			ImageButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ImageButton.BorderSizePixel = 0
			ImageButton.Size = UDim2.new(1, 0, 1, 0)

			selectionFrame.Name = "selectionFrame"
			selectionFrame.Parent = Dropdown
			selectionFrame.BackgroundColor3 = Color3.fromRGB(33, 34, 40)
			selectionFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			selectionFrame.BorderSizePixel = 0
			selectionFrame.Position = UDim2.new(0.543735206, 0, 0.095238097, 0)
			selectionFrame.Size = UDim2.new(-0.0330969281, 200, 0.809523821, 0)
			selectionFrame.ZIndex = 0

			UICorner_2.Parent = selectionFrame

			TextLabel.Parent = selectionFrame
			TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.BackgroundTransparency = 1.000
			TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel.BorderSizePixel = 0
			TextLabel.Position = UDim2.new(-0.00537634408, 0, 0, 0)
			TextLabel.Size = UDim2.new(1, 0, 1, 0)
			TextLabel.FontFace = defaultFont
			TextLabel.Text = args.Default
			TextLabel.TextColor3 = Color3.fromRGB(252, 252, 252)
			TextLabel.TextSize = 20.000
			TextLabel.TextWrapped = true

			assignClickAnimation(ImageButton)

			local function popupMenu()
				local PlayerDropdownMenu = Instance.new("Frame")
				local ScrollingFrame = Instance.new("ScrollingFrame")
				local UIPadding = Instance.new("UIPadding")
				local UIListLayout = Instance.new("UIListLayout")
				local TitleText = Instance.new("TextLabel")

				PlayerDropdownMenu.Name = "PlayerDropdownMenu"
				PlayerDropdownMenu.Parent = SideBar
				PlayerDropdownMenu.BackgroundColor3 = Color3.fromRGB(14, 15, 17)
				PlayerDropdownMenu.BorderColor3 = Color3.fromRGB(0, 0, 0)
				PlayerDropdownMenu.BorderSizePixel = 0
				PlayerDropdownMenu.Position = UDim2.new(-1.1, 0, -0.0032258064, 0)
				PlayerDropdownMenu.Size = UDim2.new(0, 237, 0, 271)

				ScrollingFrame.Parent = PlayerDropdownMenu
				ScrollingFrame.Active = true
				ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ScrollingFrame.BackgroundTransparency = 1.000
				ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ScrollingFrame.BorderSizePixel = 0
				ScrollingFrame.Position = UDim2.new(0, 0, 0.110701106, 0)
				ScrollingFrame.Size = UDim2.new(0, 236, 0, 213)
				ScrollingFrame.ScrollBarThickness = 4

				TitleText.Name = "TitleText"
				TitleText.Parent = PlayerDropdownMenu
				TitleText.AnchorPoint = Vector2.new(0, 0.5)
				TitleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TitleText.BackgroundTransparency = 1.000
				TitleText.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TitleText.BorderSizePixel = 0
				TitleText.Position = UDim2.new(0.0421940945, 0, 0.0585791096, 0)
				TitleText.Size = UDim2.new(0, 226, 0, 28)
				TitleText.FontFace = defaultFont
				TitleText.Text = args.Text
				TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
				TitleText.TextSize = 20.000
				TitleText.TextXAlignment = Enum.TextXAlignment.Left

				UIPadding.Parent = ScrollingFrame
				UIPadding.PaddingLeft = UDim.new(0, 10)
				UIPadding.PaddingRight = UDim.new(0, 10)

				UIListLayout.Parent = ScrollingFrame
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.Padding = UDim.new(0, 7)

				SideBar.ClipsDescendants = true
				local introTween = game:GetService("TweenService"):Create(PlayerDropdownMenu, TweenInfo.new(.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, -0.0032258064, 0)})
				introTween:Play()

				local isItemSelected = false
				for i, v in ipairs(args.Options) do
					local Selection = Instance.new("Frame")
					local UICorner = Instance.new("UICorner")
					local Label1 = Instance.new("TextLabel")
					local SelectionBox = Instance.new("ImageButton")

					Selection.Name = "Selection"
					Selection.Parent = ScrollingFrame
					Selection.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
					Selection.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Selection.BorderSizePixel = 0
					Selection.Position = UDim2.new(0, 0, 0.371950239, 0)
					Selection.Size = UDim2.new(1, 0, 0, 40)

					UICorner.Parent = Selection

					Label1.Name = "Label1"
					Label1.Parent = Selection
					Label1.AnchorPoint = Vector2.new(0, 0.5)
					Label1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Label1.BackgroundTransparency = 1.000
					Label1.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Label1.BorderSizePixel = 0
					Label1.Position = UDim2.new(0.0455553979, 0, 0.5, 0)
					Label1.Size = UDim2.new(0.953963101, 0, 1, 0)
					Label1.FontFace = defaultFont
					Label1.Text = v
					Label1.TextColor3 = Color3.fromRGB(255, 255, 255)
					Label1.TextSize = 20.000
					Label1.TextXAlignment = Enum.TextXAlignment.Left

					SelectionBox.Name = "SelectionBox"
					SelectionBox.Parent = Selection
					SelectionBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					SelectionBox.BackgroundTransparency = 1.000
					SelectionBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
					SelectionBox.BorderSizePixel = 0
					SelectionBox.Size = UDim2.new(1, 0, 1, 0)

					assignClickAnimation(SelectionBox)
					addConnection(SelectionBox.MouseButton1Click, function()
						if not isItemSelected then
							isItemSelected = true
							local outroTween = game:GetService("TweenService"):Create(PlayerDropdownMenu, TweenInfo.new(.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {Position = UDim2.new(-1.1, 0, -0.0032258064, 0)})
							outroTween:Play()
							args.Callback(v)
							TextLabel.Text = v
							outroTween.Completed:Wait()
							PlayerDropdownMenu:Destroy()
						end
					end)
				end
			end

			addConnection(ImageButton.MouseButton1Click, function()
				popupMenu()
			end)
		end
		function thisTab:CreateColorPicker(args)
			args.Text = args.Text or "Color Picker"
			args.Default = args.Default or Color3.new(1, 1, 1)
			args.Callback = args.Callback or function() end

			local Dropdown = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local SliderText = Instance.new("TextLabel")
			local ImageButton = Instance.new("ImageButton")
			local selectionFrame = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")

			--Properties:

			Dropdown.Name = tabName.."ColorPicker"
			Dropdown.Parent = TabContentsFrame
			Dropdown.BackgroundColor3 = Color3.fromRGB(22, 23, 27)
			Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Dropdown.BorderSizePixel = 0
			Dropdown.Position = UDim2.new(0, 0, 0.591397822, 0)
			Dropdown.Size = UDim2.new(0, 423, 0, 42)
			Dropdown.Visible = false

			UICorner.CornerRadius = UDim.new(0, 6)
			UICorner.Parent = Dropdown

			SliderText.Name = "SliderText"
			SliderText.Parent = Dropdown
			SliderText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SliderText.BackgroundTransparency = 1.000
			SliderText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SliderText.BorderSizePixel = 0
			SliderText.Position = UDim2.new(0.0283687934, 0, 0, 0)
			SliderText.Size = UDim2.new(0.482269496, 0, 1, 0)
			SliderText.FontFace = defaultFont
			SliderText.Text = args.Text
			SliderText.TextColor3 = Color3.fromRGB(193, 193, 193)
			SliderText.TextSize = 21.000
			SliderText.TextWrapped = true
			SliderText.TextXAlignment = Enum.TextXAlignment.Left

			ImageButton.Parent = Dropdown
			ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ImageButton.BackgroundTransparency = 1.000
			ImageButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ImageButton.BorderSizePixel = 0
			ImageButton.Size = UDim2.new(1, 0, 1, 0)

			selectionFrame.Name = "selectionFrame"
			selectionFrame.Parent = Dropdown
			selectionFrame.BackgroundColor3 = args.Default
			selectionFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			selectionFrame.BorderSizePixel = 0
			selectionFrame.AnchorPoint = Vector2.new(.5,.5)
			selectionFrame.Position = UDim2.new(0.943, 0,0.5, 0)
			selectionFrame.Size = UDim2.new(0.08, 0,0.81, 0)
			selectionFrame.ZIndex = 0

			UICorner_2.Parent = selectionFrame

			assignClickAnimation(ImageButton)

			local function popupMenu()
				local PlayerDropdownMenu = Instance.new("Frame")
				local TitleText = Instance.new("TextLabel")
				local Frame = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local Frame_2 = Instance.new("Frame")
				local ValueButton = Instance.new("ImageButton")
				local UIGradient = Instance.new("UIGradient")
				local ImageLabel = Instance.new("ImageLabel")
				local HSIButton = Instance.new("ImageButton")
				local RGB_Box = Instance.new("TextLabel")
				local RandomLabel1 = Instance.new("TextLabel")
				local RandomLabel2 = Instance.new("TextLabel")
				local HSV_Box = Instance.new("TextLabel")

				--Properties:

				local dH,dS,dV = args.Default:ToHSV()
				local DefaultRGB = Color3ToRGB(args.Default)


				Frame.Parent = PlayerDropdownMenu
				Frame.BackgroundColor3 = Color3.fromRGB(20, 21, 24)
				Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Frame.BorderSizePixel = 0
				Frame.Position = UDim2.new(0.0421940945, 0, 0.107011072, 0)
				Frame.Size = UDim2.new(0.915611804, 0, 0.833948314, 0)

				UICorner.Parent = Frame

				Frame_2.Parent = Frame
				Frame_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Frame_2.BorderSizePixel = 0
				Frame_2.Position = UDim2.new(0.838709652, 0, 0.0442477874, 0)
				Frame_2.Size = UDim2.new(0.110599078, 0, 0.681415915, 0)

				ValueButton.Name = "ValueButton"
				ValueButton.Parent = Frame_2
				ValueButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ValueButton.BackgroundTransparency = 1.000
				ValueButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ValueButton.BorderSizePixel = 0
				ValueButton.Size = UDim2.new(1, 0, 1, 0)

				UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0))}
				UIGradient.Rotation = 90
				UIGradient.Parent = Frame_2

				ImageLabel.Parent = Frame
				ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ImageLabel.BorderSizePixel = 0
				ImageLabel.Position = UDim2.new(0.059907835, 0, 0.0442477874, 0)
				ImageLabel.Size = UDim2.new(0.709677398, 0, 0.681415915, 0)
				ImageLabel.Image = "http://www.roblox.com/asset/?id=13037988771"

				HSIButton.Name = "HSIButton"
				HSIButton.Parent = ImageLabel
				HSIButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				HSIButton.BackgroundTransparency = 1.000
				HSIButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
				HSIButton.BorderSizePixel = 0
				HSIButton.Size = UDim2.new(1, 0, 1, 0)

				RGB_Box.Name = "RGB_Box"
				RGB_Box.Parent = Frame
				RGB_Box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				RGB_Box.BackgroundTransparency = 1.000
				RGB_Box.BorderColor3 = Color3.fromRGB(0, 0, 0)
				RGB_Box.BorderSizePixel = 0
				RGB_Box.Position = UDim2.new(0.221198156, 0, 0.761061966, 0)
				RGB_Box.Size = UDim2.new(0.54838711, 0, 0.0707964599, 0)
				RGB_Box.FontFace = defaultFont
				RGB_Box.Text = `{DefaultRGB.R},`..` {DefaultRGB.G},`..` {DefaultRGB.B}`
				RGB_Box.TextColor3 = Color3.fromRGB(255, 255, 255)
				RGB_Box.TextSize = 14.000
				RGB_Box.TextXAlignment = Enum.TextXAlignment.Left

				RandomLabel1.Name = "RandomLabel1"
				RandomLabel1.Parent = Frame
				RandomLabel1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				RandomLabel1.BackgroundTransparency = 1.000
				RandomLabel1.BorderColor3 = Color3.fromRGB(0, 0, 0)
				RandomLabel1.BorderSizePixel = 0
				RandomLabel1.Position = UDim2.new(0.059907835, 0, 0.761061966, 0)
				RandomLabel1.Size = UDim2.new(0.161290318, 0, 0.0619469024, 0)
				RandomLabel1.FontFace = defaultFont
				RandomLabel1.Text = "RGB:"
				RandomLabel1.TextColor3 = Color3.fromRGB(255, 255, 255)
				RandomLabel1.TextSize = 18.000
				RandomLabel1.TextXAlignment = Enum.TextXAlignment.Left

				RandomLabel2.Name = "RandomLabel2"
				RandomLabel2.Parent = Frame
				RandomLabel2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				RandomLabel2.BackgroundTransparency = 1.000
				RandomLabel2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				RandomLabel2.BorderSizePixel = 0
				RandomLabel2.Position = UDim2.new(0.059907835, 0, 0.840707958, 0)
				RandomLabel2.Size = UDim2.new(0.161290318, 0, 0.0619469024, 0)
				RandomLabel2.FontFace = defaultFont
				RandomLabel2.Text = "HSV:"
				RandomLabel2.TextColor3 = Color3.fromRGB(255, 255, 255)
				RandomLabel2.TextSize = 18.000
				RandomLabel2.TextXAlignment = Enum.TextXAlignment.Left

				HSV_Box.Name = "HSV_Box"
				HSV_Box.Parent = Frame
				HSV_Box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				HSV_Box.BackgroundTransparency = 1.000
				HSV_Box.BorderColor3 = Color3.fromRGB(0, 0, 0)
				HSV_Box.BorderSizePixel = 0
				HSV_Box.Position = UDim2.new(0.221198156, 0, 0.840707958, 0)
				HSV_Box.Size = UDim2.new(0.54838711, 0, 0.0707964599, 0)
				HSV_Box.FontFace = defaultFont
				HSV_Box.Text = `{DPRound(dH,3)},`..` {DPRound(dS,3)},`..` {DPRound(dV,3)}`
				HSV_Box.TextColor3 = Color3.fromRGB(255, 255, 255)
				HSV_Box.TextSize = 14.000
				HSV_Box.TextXAlignment = Enum.TextXAlignment.Left

				PlayerDropdownMenu.Name = "PlayerDropdownMenu"
				PlayerDropdownMenu.Parent = SideBar
				PlayerDropdownMenu.BackgroundColor3 = Color3.fromRGB(14, 15, 17)
				PlayerDropdownMenu.BorderColor3 = Color3.fromRGB(0, 0, 0)
				PlayerDropdownMenu.BorderSizePixel = 0
				PlayerDropdownMenu.Position = UDim2.new(-1.1, 0, -0.0032258064, 0)
				PlayerDropdownMenu.Size = UDim2.new(0, 237, 0, 271)

				TitleText.Name = "TitleText"
				TitleText.Parent = PlayerDropdownMenu
				TitleText.AnchorPoint = Vector2.new(0, 0.5)
				TitleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TitleText.BackgroundTransparency = 1.000
				TitleText.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TitleText.BorderSizePixel = 0
				TitleText.Position = UDim2.new(0.0421940945, 0, 0.0585791096, 0)
				TitleText.Size = UDim2.new(0, 226, 0, 28)
				TitleText.FontFace = defaultFont
				TitleText.Text = args.Text
				TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
				TitleText.TextSize = 20.000
				TitleText.TextXAlignment = Enum.TextXAlignment.Left

				local Continue = Instance.new("ImageButton")
				Continue.Name = "Continue"
				Continue.Parent = Frame
				Continue.BackgroundTransparency = 1.000
				Continue.LayoutOrder = 10
				Continue.Position = UDim2.new(0.801369965, 0, 0.757837057, 0)
				Continue.Size = UDim2.new(0, 32, 0, 32)
				Continue.ZIndex = 2
				Continue.Image = "rbxassetid://3926307971"
				Continue.ImageRectOffset = Vector2.new(764, 244)
				Continue.ImageRectSize = Vector2.new(36, 36)
				SideBar.ClipsDescendants = true

				assignClickAnimation(Continue,false)


				local introTween = game:GetService("TweenService"):Create(PlayerDropdownMenu, TweenInfo.new(.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, -0.0032258064, 0)})
				introTween:Play()

				local isColorSelected = false

				local pickingColor = false
				local pickingValue = false
				addConnection(HSIButton.MouseButton1Down,function() 
					pickingColor = true
				end)
				addConnection(HSIButton.MouseButton1Up,function() 
					pickingColor = false
				end)
				addConnection(ValueButton.MouseButton1Down,function() 
					pickingValue = true
				end)
				addConnection(ValueButton.MouseButton1Up,function() 
					pickingValue = false
				end)
				local currentHue = 0
				local currentSaturation = 1
				local currentValue = 1

				addConnection(game:GetService("RunService").RenderStepped, function(deltaTime)
					if pickingColor or pickingValue then
						-- this absolutely sucked to make so be grateful
						local mouse = game.Players.LocalPlayer:GetMouse()
						local mouseX = mouse.X
						local mouseY = mouse.Y

						if pickingColor then
							local popX = math.clamp(mouseX - ImageLabel.AbsolutePosition.X, 0, ImageLabel.AbsoluteSize.X)
							local popY = math.clamp(mouseY - ImageLabel.AbsolutePosition.Y, 0, ImageLabel.AbsoluteSize.Y)

							currentHue = 1 - popX / ImageLabel.AbsoluteSize.X
							currentSaturation = 1 - (popY / ImageLabel.AbsoluteSize.Y)
						end

						if pickingValue then
							local valY = math.clamp(mouseY - ValueButton.AbsolutePosition.Y, 0, ValueButton.AbsoluteSize.Y)
							currentValue = 1 - (valY / ValueButton.AbsoluteSize.Y)
						end

						local finalColorHSV = Color3.fromHSV(currentHue, currentSaturation, currentValue)
						local finalColorRGB = Color3.fromRGB(
							math.floor((finalColorHSV.R * 255) + 0.5),
							math.floor((finalColorHSV.G * 255) + 0.5),
							math.floor((finalColorHSV.B * 255) + 0.5)
						)

						selectionFrame.BackgroundColor3 = finalColorRGB
						UIGradient.Color = ColorSequence.new{
							ColorSequenceKeypoint.new(0.00, Color3.fromHSV(currentHue, currentSaturation, 1)),
							ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0))
						}

						RGB_Box.Text = string.format("%d, %d, %d", finalColorRGB.R * 255, finalColorRGB.G * 255, finalColorRGB.B * 255)
						HSV_Box.Text = string.format("%.3f, %.3f, %.3f", currentHue, currentSaturation, currentValue)

						args.Callback(finalColorRGB)
					end
				end)




				addConnection(Continue.MouseButton1Click,function() 
					local outroTween = game:GetService("TweenService"):Create(PlayerDropdownMenu, TweenInfo.new(.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {Position = UDim2.new(-1.1, 0, -0.0032258064, 0)})
					outroTween:Play()
					outroTween.Completed:Wait()
					PlayerDropdownMenu:Destroy()
				end)
			end

			addConnection(ImageButton.MouseButton1Click, function()
				popupMenu()
			end)
		end
		function thisTab:CreateBind(args)
			args.Text = args.Text or "Keybind"
			args.Default = args.Default or Enum.KeyCode.F
			args.Hold = args.Hold or false
			args.CallBack = args.CallBack or function() end

			local Dropdown = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local Text = Instance.new("TextLabel")
			local ImageButton = Instance.new("ImageButton")
			local KeybindText = Instance.new("TextLabel")
			local UICorner_2 = Instance.new("UICorner")

			--Properties:

			Dropdown.Name = tabName.."_Dropdown"
			Dropdown.Parent = TabContentsFrame
			Dropdown.BackgroundColor3 = Color3.fromRGB(22, 23, 27)
			Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Dropdown.BorderSizePixel = 0
			Dropdown.Position = UDim2.new(0, 0, 0.383512557, 0)
			Dropdown.Size = UDim2.new(0, 423, 0, 31)
			Dropdown.Visible = false

			UICorner.CornerRadius = UDim.new(0, 6)
			UICorner.Parent = Dropdown

			Text.Name = "Text"
			Text.Parent = Dropdown
			Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Text.BackgroundTransparency = 1.000
			Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Text.BorderSizePixel = 0
			Text.Position = UDim2.new(0.0283687934, 0, 0, 0)
			Text.Size = UDim2.new(0.482269496, 0, 1, 0)
			Text.FontFace = defaultFont
			Text.Text = args.Text
			Text.TextColor3 = Color3.fromRGB(193, 193, 193)
			Text.TextSize = 21.000
			Text.TextWrapped = true
			Text.TextXAlignment = Enum.TextXAlignment.Left

			ImageButton.Parent = Dropdown
			ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ImageButton.BackgroundTransparency = 1.000
			ImageButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ImageButton.BorderSizePixel = 0
			ImageButton.Size = UDim2.new(1, 0, 1, 0)

			KeybindText.Name = "KeybindText"
			KeybindText.Parent = Dropdown
			KeybindText.AnchorPoint = Vector2.new(0.5, 0.5)
			KeybindText.BackgroundColor3 = Color3.fromRGB(29, 30, 35)
			KeybindText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			KeybindText.BorderSizePixel = 0
			KeybindText.Position = UDim2.new(0.741725743, 0, 0.5, 0)
			KeybindText.Size = UDim2.new(0.471631169, 0, 0.774193525, 0)
			KeybindText.FontFace = defaultFont
			KeybindText.Text = game:GetService("UserInputService"):GetStringForKeyCode(args.Default)
			KeybindText.TextColor3 = Color3.fromRGB(193, 193, 193)
			KeybindText.TextSize = 21.000
			KeybindText.TextWrapped = true
			KeybindText.ZIndex = 0
			UICorner_2.Parent = KeybindText

			assignClickAnimation(ImageButton)
			local awaitingInput = false
			local inputKey = args.Default
			addConnection(ImageButton.MouseButton1Click,function() 
				KeybindText.Text = "Awaiting Input.."
				awaitingInput = true
			end)
			addConnection(game:GetService("UserInputService").InputBegan,function(input: InputObject) 
				if awaitingInput then
					inputKey = input.KeyCode
					awaitingInput = false	
					local bindName = game:GetService("UserInputService"):GetStringForKeyCode(input.KeyCode)
					KeybindText.Text = bindName
					if bindName == '' then
						local thingy = tostring(input.UserInputType)
						local finalThingy = string.sub(tostring(input.UserInputType), string.find(thingy, "%.", string.find(thingy, "%.") + 1) + 1)
						if finalThingy == '' then
							finalThingy = "[ Cannot display ]"
						end
						KeybindText.Text = finalThingy
					end
				else
					if input.KeyCode == inputKey then
						if args.Hold == true then
							args.CallBack(true)
						else
							args.CallBack()
						end
					end
				end

			end)
			addConnection(game:GetService("UserInputService").InputEnded,function(input: InputObject) 
				if args.Hold and input.KeyCode == inputKey then
					args.CallBack(false)
				end
			end)
		end
		return thisTab
	end

	local settingsOpen = false

	local function loadSettings(load)
		for i,v in pairs(ScrollingFrame555:GetChildren()) do
			if v:IsA("Frame") then
				wait(.1)
				v.Visible = load
				print(v.Name)	
			end
		end
	end

	local function createSetting(text,default,callback)
		local Frame = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local TextLabel = Instance.new("TextLabel")
		local animframe = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local ImageButton = Instance.new("ImageButton")
		local UIPadding = Instance.new("UIPadding")
		SettingsPanel.ClipsDescendants = true

		Frame.Parent = ScrollingFrame555 
		Frame.BackgroundColor3 = Color3.fromRGB(14, 15, 17)
		Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame.BorderSizePixel = 0
		Frame.Size = UDim2.new(1, -10, 0.065,0)
		Frame.Visible = false

		UICorner.Parent = Frame

		TextLabel.Parent = Frame
		TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel.BorderSizePixel = 0
		TextLabel.Position = UDim2.new(0.0689678416, 0, 0.158339262, 0)
		TextLabel.Size = UDim2.new(0, 185, 0, 25)
		TextLabel.FontFace = defaultFont
		TextLabel.Text = text
		TextLabel.TextColor3 = Color3.fromRGB(253, 253, 253)
		TextLabel.TextSize = 23.000
		TextLabel.TextXAlignment = Enum.TextXAlignment.Left

		animframe.Name = "animframe"
		animframe.Parent = Frame
		animframe.BackgroundColor3 = Color3.fromRGB(255, 82, 82)
		animframe.BorderColor3 = Color3.fromRGB(255, 0, 0)
		animframe.BorderSizePixel = 0
		animframe.Position = UDim2.new(0.845360816, 0, 0.298668027, 0)
		animframe.Size = UDim2.new(0, 14, 0, 14)

		UICorner_2.Parent = animframe

		ImageButton.Parent = Frame
		ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ImageButton.BackgroundTransparency = 1.000
		ImageButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ImageButton.BorderSizePixel = 0
		ImageButton.Size = UDim2.new(1, 0, 1, 0)
		assignClickAnimation(ImageButton)

		local IO = default
		if default then
			animframe.BackgroundColor3 = Color3.fromRGB(119, 255, 119)
		end
		addConnection(ImageButton.MouseButton1Click,function() 
			IO = not IO
			if IO then
				animframe.BackgroundColor3 = Color3.fromRGB(119,255,119)
			else
				animframe.BackgroundColor3 = Color3.fromRGB(255, 82, 82)
			end
			callback(IO)	
		end)
	end


	createSetting("Minimizing Anim",true,function(IO)
		minimizeAnim = IO
	end)
	createSetting("Sneaky Close",false,function(IO)
		instantClose = IO
	end)
	
	SideBar.ClipsDescendants = true
	addConnection(settingsBTN.MouseButton1Click,function() 
		if settingsOpen then
			settingsOpen = false
			game:GetService("TweenService"):Create(SettingsPanel,TweenInfo.new(1,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut),{Position = UDim2.new(0, 0, 0.870967746, 0),Size = UDim2.new(1,0,40)}):Play()
			game:GetService("TweenService"):Create(settingsBTN,TweenInfo.new(2,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut),{Rotation = 0}):Play()
			wait(1)
			loadSettings(false)
		else
			game:GetService("TweenService"):Create(SettingsPanel,TweenInfo.new(1,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut),{Position = UDim2.new(0,0,0,0),Size = UDim2.new(1,0,1,0)}):Play()
			game:GetService("TweenService"):Create(settingsBTN,TweenInfo.new(2,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut),{Rotation = 360}):Play()
			wait(.7)
			loadSettings(true)
			settingsOpen = true
		end

	end)

	window:CreateNotification({Title = "Summit Library Example",Description = "Interface Successfully loaded.", Duration = 3})
	return window
end

return summitLib
