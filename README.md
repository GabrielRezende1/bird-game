# :bird: Flying Bird 

A flappy bird rip-off game developed from scratch using [Lua](https://www.lua.org/about.html) with [Löve2D Framework](https://www.love2d.org/wiki/Main_Page).  

For those unfamiliar, it is a simple game where you fly a bird through gaps between pairs of pipes and score points for doing so. The objective of the game is to score as many points as you can.

All 16x16 sprite assets were made by me in [Paint.NET](https://www.paint.net/). All sound assets were rightfully given by [Kenney](https://opengameart.org/users/kenney).

## :computer: A CS50x Final Project  

This project is a culmination of all my efforts to finish Harvard's Computer Science Introduction Course (2026). It was a great experience in general, and I sharpened my skills throughout the problem sets, finally opting for developing a game as my final project. And as per requested by them, there is also a [video showing the game]().

# :scroll: Project Structure  

I wasn't sure how to structure the folders in my project, so I tried using the template from [kasshust](https://deepwiki.com/kasshust/kass-love2d-template/1.1-project-structure) for Löve2D projects, although not all the structure was used.  

```
root/
├─ conf.lua         # Config file
├─ main.lua         # Main file
├─ make_all.toml
├─ assets/          # Sounds and Sprites
│ ├─ sprites/
│ └─ sounds/
├─ scene/           # Maps and Objects
│ ├─ objects/
│ └─ rooms/
├─ game/            # Game logic
├─ library/         # External libraries
│ └─ external/
```  

## :office: External Libraries  

[Lume](https://github.com/rxi/lume) - For serialization and deserialization of game save data