# Summit UI Library Documentation
### Version: 1.2


## Refrencing the Library
```lua
local summitLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Dialga156b/Summit_UI-Library/main/source.lua')))()
```



## Creating a Window
```lua
local window = summitLib:CreateWindow({
  Name = "Summit UI Library Example", -- UI Title <string>
  AccentColor3 = Color3.new(1, 0.235294, 0.337255) -- UI accent color <color3>
})
```



## Creating a Tab
```lua
local Tab1 = window:CreateTab({
  Name = "Labels", --  Tab Name <string>
  Icon = 'rbxassetid://7733765307' -- Tab Icon <assetid/string>
})
```

## Creating a Label
```lua
Tab1:CreateLabel("Hello! This is a default Label.")
-- Label text <string>
```

## Creating a Paragraph
```lua
Tab1:CreateParagraph("This is a default Paragraph Element. the text isn't bolded, slightly smaller, and you could use this for when you want to introduce your users to a selection of items, menus, or variables.")
-- Paragraph text <string>
```

## Creating a Slider
```lua
Tab1:CreateSlider({
  Default = 250, -- Default Value for the slider when created <number>
  Minimum = 16, -- Minimum Value <number>
  Maximum = 500, -- Maximum Value <number>
  Callback = function(Value)
  	print(Value) -- Value: <number>
  end
})
```

## Creating a Button
```lua
Tab1:CreateButton({
  Text = "This is a Button!", -- Button Text <string>
  Callback = function()
  	print("Button Clicked!")
  end
})
```

## Creating a Toggle
```lua
Tab1:CreateToggle({
  Text = "This is a Toggle!", -- Toggle Text <string>
  Default = false, -- Default Toggle Value <boolean>
  Callback = function(Value)
  	print(Value) -- Value: Whether the toggle is toggled or not. <boolean>
  end
})
```

## Creating a Player Selector
```lua
Tab1:CreatePlayerSelector({
  Text = "This is a player selector!", -- selector text <string>
  Callback = function(Player) -- fires when a player is selected
  	print(Player.Name) -- Player: player that was selected <player>
  end
})
```

## Creating a Dropdown
```lua
Tab3:CreateDropdown({
  Text = "Dropdown", -- Dropdown Text <string>
  Options = {"Option 1", "Option 2", "Option 3"}, -- Options to choose from <table>
  Callback = function(Option) -- fires when an option is chosen
  	print(Option) -- Option: Returns the option selected <any>
  end
})
```

## Creating a Color Picker
```lua
Tab4:CreateColorPicker({
  Text = "Color Picker", -- Color picker Text <string>
  Default = Color3.new(0.866667, 0.203922, 1), -- Default color selected on creation <color3>
  Callback = function(Color) -- Fires when color is selected
  	print(Color) -- Color: Selected color <color3>
  end
})
```

## Creating a Keybind
```lua
-- Single press Keybind
Tab4:CreateBind({
  Text = "Press Keybind", -- Keybind text <string>
  Hold = false, -- Whether you need to hold the key or not <boolean>
  Default = Enum.KeyCode.F, -- Default keybind selected on creation <Enum.KeyCode>
  CallBack = function()
  	print('Keybind Fired!') -- Fires when the keybind is pressed.
  end
})

-- Hold-only Keybind
Tab4:CreateBind({
  Text = "Press Keybind", -- Keybind text <string>
  Hold = true, -- Whether you need to hold the key or not <boolean>
  Default = Enum.KeyCode.F, -- Default keybind selected on creation <Enum.KeyCode>
  CallBack = function(isHolding) -- isHolding: whether the key is being held or not <boolean>
  	print('Holding: ',isHolding) -- Fires when the keybind is held and unheld
  end
})
```

## FULL Working Example Code
```lua
local summitLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Dialga156b/Summit_UI-Library/main/source.lua')))()

local window = summitLib:CreateWindow({Name = "Summit UI Library Example",AccentColor3 = Color3.new(1, 0.235294, 0.337255)})
local Tab1 = window:CreateTab({Name = "Labels", Icon = 'rbxassetid://7733765307'})
local Tab2 = window:CreateTab({Name = "Interactables", Icon = 'rbxassetid://7743875962'})
local Tab3 = window:CreateTab({Name = "Dropdowns", Icon = 'rbxassetid://7743876142'})
local Tab4 = window:CreateTab({Name = "Miscecellaneous", Icon = 'rbxassetid://7733920644'})
Tab1:CreateLabel("Hello! This is a default Label.")
Tab1:CreateParagraph("This is a default Paragraph Element. the text isn't bolded, slightly smaller, and you could use this for when you want to introduce your users to a selection of items, menus, or variables.")

local SliderValue = 16

Tab2:CreateSlider({Default = 250, Minimum = 16, Maximum = 500, Callback = function(Value)
	print(Value) -- returns a whole number
	SliderValue = Value
end})

Tab2:CreateButton({Text = "This is a Button! Click me to send a notification!",Callback = function()
	print("Button Clicked!")
	window:CreateNotification({Description = "Descriptions can contain variables, like the one on the slider! ["..SliderValue.."]",Title = "Notification",Duration = 5})
end})

Tab2:CreateToggle({Text = "This is a Toggle!",Default = false,Callback = function(Value)
	print(Value) --  returns a boolean
end})

Tab3:CreatePlayerSelector({Text = "This is a player selector!",Callback = function(Player)
	print(Player.Name)--returns a player
end})

Tab3:CreateDropdown({Text = "Dropdown",Options = {"Option 1", "Option 2", "Option 3"},Callback = function(Option)
	print(Option)
end})

Tab4:CreateColorPicker({Text = "Color Picker",Default = Color3.new(0.866667, 0.203922, 1),Callback = function(Color)
	print(Color)
end})

Tab4:CreateBind({Text = "Press Keybind",Hold = false,Default = Enum.KeyCode.F,CallBack = function()
	print('Keybind Fired!') -- fires when the keybind is pressed.
end})

Tab4:CreateBind({Text = "Hold Keybind",Hold = true,Default = Enum.KeyCode.E,CallBack = function(isHolding)
	print('Holding: ',isHolding) -- fires when the keybind is press and unpressed, with isHolding being what state it's in.
end})

return sum
```

## More coming soon!
### Have a suggestion? Either create an issue and let me know what, or ping me on Discord at Eaqualoti!
