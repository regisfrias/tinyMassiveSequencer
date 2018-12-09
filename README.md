# Massive Instrument
My submission for https://tinymassive.io

Please use [Syphoner](http://www.sigmasix.ch/syphoner/) and [TMSyphonVisualiser](https://tinymassive.io/kit/TMApps.zip) to view this sketch as similar to the actual output as possible. The applet looks distorted and with too high resolution.

![](img/1.png)
![](img/2.png)
![](img/3.png)

## Compiling

### Dependencies

- [Processing](https://processing.org/)
- [Processing Sound library](https://processing.org/reference/libraries/sound)

`screenScaleX` and `screenScaleY` are a visualising convenience. Set both to `1` for exact output resolution (77x13px). Set them to `10` and `15` to get a feel of the building proportions (not for production!).

## How it works

Massive Instrument expects input from two joysticks which have been mapped to keyboard keys.

### Joystick 1

This is a sound file player and controls the visuals from the left side of the building.

Keyboard mapping:

```
'W': up
'A': left
'S': down
'D': right
'Q': button 1
'E': button 2
```

The joystick up/down/left/right triggers sounds from a preloaded library. Button 2 changes the sound collection (there are two collections, 8 samples in total). Button 1 changes the width of the visual elements.

Sixty-four beats (`AUTOMATIC_MODE_1` in the code) without activity triggers the automatic mode, which randomly triggers the sounds and images.

### Joystick 2

This is a step sequencer (drum machine) and controls the right side of the building.

Keyboard mapping:

```
'I': up
'J': left
'K': down
'L': right
'U': button 1
'O': button 2
```

The user always starts with a preset pattern, like the following:

```
- - X X - - X X - - X X - - X -
- - - - - - - - - - - - - - - -
- - - - - - - - - - - - - X - -
X - - - X - - - X - - - X - - -
```

The joystick works as you would expect: it moves a cursor (white rectangle) across the right screen. Button 1 sets the current grid cell on/off (red/black).

![](img/4.png)

Button 2 clears the screen so the user can start from scratch.

One hundred and twenty-eight beats (`AUTOMATIC_MODE_2`) without activity triggers the automatic mode, which randomly choses a preset. The playhead never stops.
