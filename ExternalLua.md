## Get Data Model
```lua
sealz.DataModel() > address
```

## Find First Child
```lua
sealz.FindFirstChild(Address , Name) > address
```

## Find First Child Of Class
```lua
sealz.FindFirstChildOfClass(Address , Class) > address
```

## Get Children
```lua
sealz.GetChildren(Address) > {addresses}
```

## Local Player
```lua
sealz.ReadString(Address) > address
```

## Get Position (X,Y,Z)
```lua
sealz.GetPosition(Address) > {x = number,y = number,z = number}
```

## Get Gui Posiiton (X,Y)
```lua
sealz.GetGuiPosiiton(Address) > {x = number,y = number}
```

## Get Gui Size (X,Y)
```lua
sealz.GetGuiSize(Address) > {x = number,y = number}
```

## Gui Visible
```lua
sealz.IsGuiVisible(Address) > boolean
```

## Gui Name
```lua
sealz.GetName(Address) > string
```

## Gui User Id
```lua
sealz.GetUserId(Address) > number
```

## Gui Character
```lua
sealz.GetCharacter(Address) > address
```

## Gui World To Viewport
```lua
sealz.WorldToViewport(Position , SCREEN_SIZE_X , SCREEN_SIZE_Y) > {x,y}
```

## Mouse rel
```lua
sealz.mouse_rel(x,y)
```

## Mouse m1
```lua
sealz.mouse_m1_press()
sealz.mouse_m1_release()
```

## Mouse m2
```lua
sealz.mouse_m2_press()
sealz.mouse_m2_release()
```

## Keyboard
```lua
sealz.keypress(name)
sealz.keyrelease(name)
```

## Read usize
```lua
sealz.read_usize(address) > num
```

## Read i64
```lua
sealz.read_i64(address) > num
```

## Read f32
```lua
sealz.read_f32(address) > num
```

## Read String
```lua
sealz.ReadString(Address) > string
```

# Drawing
```lua
sealz.DrawString(
  {x=0,y=0}, -- position
  "hello", -- text
  14, -- size
  {r=255,g=255,b=255} -- color
)

sealz.DrawCircle(
  {x=0,y=0}, -- position
  14, -- radius
  false, -- filled
  {r=255,g=255,b=255} -- color
)
```

# Variables
```lua
SCREEN_SIZE_X
SCREEN_SIZE_Y
```
Color
```lua
COLOR.WHITE
COLOR.GREEN
COLOR.BLUE
COLOR.RED
```
