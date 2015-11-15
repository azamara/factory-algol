# This imports all the layers for "Algol" into algolLayers1
artboardAlgol = Framer.Importer.load "imported/Algol"

# Container
container = new Layer
  width: 750
  height: 1334
  backgroundColor: "transparent"

# ScrollView  
scrollView = new ScrollComponent
	width: container.width
	height: container.height
	scrollHorizontal: false
	
# UI
{BarHeader} = artboardAlgol
{Content} = artboardAlgol
BarHeader.superLayer = scrollView.content
Content.superLayer = scrollView.content

# BarHeader Animation
BarHeader.opacity =  0
BarHeader.y = BarHeader.y + 20
BarHeader.states.add
	stateA:
		opacity: 1
		y: BarHeader.y - 20
BarHeader.states.next()

# Temperature Animation
{Temperature} = artboardAlgol
Temperature.scale = 0
Temperature.states.add
	stateA:
		scale: 1
Temperature.states.animationOptions = 
	curve: "spring(100, 10, 0)"
Temperature.states.next()

# Humidity Animation
{Humidity} = artboardAlgol
Humidity.scale = 0
Humidity.opacity = 0
originHumidityX = Humidity.x
Humidity.centerX()
Humidity.states.add
	stateA:
		x: originHumidityX
		scale: 1
		opacity: 1
Humidity.states.animationOptions = 
	curve: "spring(100, 10, 0)"
Humidity.states.next()

# Dust Animation
{Dust} = artboardAlgol
Dust.scale = 0
Dust.opacity = 0
originDustX = Dust.x
Dust.centerX()
Dust.states.add
	stateA:
		x: originDustX
		scale: 1
		opacity: 1
Dust.states.animationOptions = 
	curve: "spring(100, 10, 0)"
Dust.states.next()

