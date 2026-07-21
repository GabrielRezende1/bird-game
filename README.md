# :bird: Flying Bird 

A flappy bird rip-off game developed from scratch using [Lua](https://www.lua.org/about.html) with [Löve2D Framework](https://www.love2d.org/wiki/Main_Page).  

For those unfamiliar, it is a simple game where you fly a bird through gaps between pairs of pipes and score points for doing so. The objective of the game is to score as many points as you can.

All 16x16 sprite assets were made by me in [Paint.NET](https://www.paint.net/). All sound assets were rightfully given by [Kenney](https://opengameart.org/users/kenney).

## :computer: A CS50x Final Project  

This project is a culmination of all my efforts to finish Harvard's Computer Science Introduction Course (2026). It was a great experience in general, and I sharpened my skills throughout the problem sets, finally opting for developing a game as my final project. And as per requested by them, there is also a [video showing the game](https://youtu.be/AdRZmBpxJ8A).

## :seedling: Installation  

Just download the zip folder from the [latest released version](https://github.com/GabrielRezende1/bird-game/releases/download/v1.0/birdgame.zip) (available as an executable).

# :scroll: Project Structure  

I wasn't sure how to structure the folders in my project, so I tried using the template from [kasshust](https://deepwiki.com/kasshust/kass-love2d-template/1.1-project-structure) for Löve2D projects, although not all the structure was used.  

```
root/
├─ conf.lua
├─ main.lua
├─ assets/          # Sounds and Sprites
│ ├─ sprites/
│ └─ sounds/
├─ scene/           # Maps and Objects
│ ├─ objects/
│ └─ rooms/
├─ game/            # Game logic
├─ library/
│ ├─ base/          # Core system implementations
│ └─ external/      # External libraries
```  

- __conf.lua__: Program setup-related options
- __main.lua__: Where everything is loaded and Love starts its process
- __assets/sprites__: Images of the game's objects (.png)
- __assets/sounds__: Sounds of the game's interactions (.ogg)
- __scene/objects__: Objects of the game's interactables
    - __bird.lua__: Bird main character object
    - __pipe.lua__: Pipe obstacle object
- __scene/rooms__: Background objects of the game's background rooms
    - __cloud.lua__: Cloud background visuals
- __game__: Game-specific implementations and content
    - __collision.lua__: Handles collision between the bird and pipes
    - __menu.lua__: Handles menu state before game starts
    - __score.lua__: Handles score system
- __library/base__: Core system implementations
    - __sound.lua__: Sound implementation
    - __storage.lua__: Game save implementation
- __library/external__: External libraries
    - __lume.lua__: A collection of functions for Lua, geared towards game development.

## :office: External Libraries  

[Lume](https://github.com/rxi/lume) - A collection of functions for Lua, geared towards game development. In my project, it was only used for serialization and deserialization of game save data