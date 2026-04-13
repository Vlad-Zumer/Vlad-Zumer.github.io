+++
title = 'Basic DC Electronics Concepts'
date = 2026-04-11T16:29:34+01:00
lastmod = 2026-04-13T14:14:33+01:00
draft = false

# Taxonomies
areas = ['electronics']
tags = ['basics', 'electricity', 'circuits']

seo-tags = ['DC Components', 'DC Current', 'DC circuits']

summary = 'I recently got back into electronics after quite a long time. It turns out I remember a fair bit and had forgotten a similar amount. This article aims to fast-track the recollection of that lost knowledge.'
+++

{{% expander id="toc" title="Table of Contents" %}}
  
- [Introduction](#introduction)
- [Back to everyday basics](#back-to-everyday-basics)
  - [Current](#current1)
  - [Voltage](#voltage2)
  - [Ground](#ground3)
  - [Power](#power4)
  - [Resistance](#resistance6)
- [Ohm's law](#ohms-law)
- [Components](#components)
  - [Wires](#wires)
  - [Constant current sources](#constant-current-sources)
  - [Constant voltage sources](#constant-voltage-sources)
    - [Batteries](#batteries)
  - [Resistors](#resistors)
    - [Equivalent resistance](#equivalent-resistance)
  - [Switches/Buttons](#switchesbuttons)
  - [Fuses](#fuses)
  - [Traditional Light bulbs](#traditional-light-bulbs)
  - [Diodes](#diodes)
    - [LEDs](#leds)
  - [Capacitors](#capacitors)
  - [Inductors](#inductors)
  - [Transistors](#transistors)
    - [BJTs](#bjts)
    - [FETs](#fets)
  - [Relay](#relay)

{{% /expander %}}

## Introduction

I recently got back into electronics after quite a long time, due to getting interested in custom split keyboards, and buying some microcontrollers and components. 
It turns out I remember a fair bit and had forgotten a similar amount. 
So, in an effort so reduce the time it takes to get back the familiarity and intuitiveness I once had, I'm writing it (almost) all down here.
I hope at some point I will have a similar article on AC as well.

## Back to everyday basics
In this section I aim to provide a quick refresher of the most common and basic concepts when it comes to DC electric circuits.

### Current[^1]
First question to answer is "What is electric current?" since that's the most common concept you will have heard of. In the simplest terms electric current ($I$) is the movement of charge ($Q$) through a medium such as a copper wire, and it is measured in $amperes$ ($A$). You can think of this as the flow rate of water through a pipe, the higher the amps, the more water flows through in the same amount of time.


### Voltage[^2]
The next most common concept you will have heard of is "voltage" or "volts", so lets try to answer what that is. $Volts$ ($V$) are a unit of measurement of the electric potential differential between 2 points. $Voltage$ ($V$ or $U$) refers to that potential difference. You can think about it as the pressure difference of 2 points in a pipe. The higher the voltage, the more pressure there is at one point compared to the other.


### Ground[^3]
A closely related concept to this is the "ground" or "earth". This is usually a reference point from which to measure voltages in the system, $V_{ground}=0$ always, but it may also be an electrical connection to a neutral node that has a lot of available charges. In the water-pipes analogy we have been using think of it as the sea/ocean.

{{< figure
  src="basic-dc-concepts/component-schematic/ground.png"
  alt="A filled in circle with a line going down vertically from it center intersecting another segment in the middle, perpendicularly, and 2 progressively smaller segments parallel the latter positioned below."
  caption="Figure 1: Electrical symbol for ground"
  class="center-x"
  img-class="image-full-content"
  id="fig:1"
>}}

### Power[^4]
Another common concept you will have heard of is "power" or "wattage" ($P$). This is the rate of transfer of electrical energy, it is equal to the current multiplied by the potential differential ($P=I\cdot{}V$), and it is measured in $watts$ ($W$). Using the water-pipes analogy again, this measures how much "work" could be done with a given water pressure and flow rate, akin to hydraulic systems.[^5]


### Resistance[^6]
Lastly, the not-so-common concept I will introduce here is the "resistance" ($R$) which is measured in $ohms$ ($\Omega$). As the names suggests this is the resistance that a charge encounters when trying to move.


## Ohm's law

This is probably the most important thing in this article, and if you ever remember anything from it, let it be this:

$$
\begin{aligned}
V &= IR \\
&or \\
I &= \frac{V}{R} \\
\end{aligned}
$$

What this is saying, using the water and pipes analogy from above, is that the difference in pressure between 2 points is equal to the flow rate times the resistance to the water moving, which I hope it makes intuitive sense now, since the harder it is to push the water (high resistance) the more pressure you will need to maintain the same flow rate.

## Components
This is probably going to be the longest part of the article as I will try and go though common components and describe them in an intuitive way.
This list is not exhaustive.

### Wires
Possibly the simplest component, an ideal wire has no resistance and is used to connect other components together. In reality every wire has some resistance dependent on the material and area, but for most applications this resistance can be ignored.

{{< multi-figure
  id="fig:2"
  class="center-x"
  caption="Figure 2: Wires"
  rows=1
  cols=2
  sub-figures=`
  [
    {
      "src": "basic-dc-concepts/component-irl-image/wire.jpg",
      "alt": "Copper strands insulated by a plastic outer coating.",
      "caption": "Fig 2.a:<br>Electrical wires"
    },
    {
      "src": "basic-dc-concepts/component-schematic/wire.png",
      "alt": "Just a line",
      "caption": "Fig 2.b:<br>Electric symbol for wire"
    }
  ]
  `
>}}

### Constant current sources
As the name suggests these sources provide a constant current to the circuit regardless of load (resistance). Thus the voltage at the terminals can vary depending on the resistance.

{{< multi-figure
  id="fig:3"
  class="center-x"
  caption="Figure 3: Constant current source"
  rows=1
  cols=2
  sub-figures=`
  [
    {
      "src": "basic-dc-concepts/component-irl-image/power-supply.jpg",
      "alt": "TODO",
      "caption": "Fig 3.a:<br>Bench top power supply. (C.C symbol on the left is for constant current)"
    },
    {
      "src": "basic-dc-concepts/component-schematic/constant-current-source.png",
      "alt": "TODO",
      "caption": "Fig 3.b:<br>Electric symbol for constant current source"
    }
  ]
  `
>}}

### Constant voltage sources
As the name suggests these sources provide a voltage current to the circuit regardless of load (resistance). Thus the current inside the circuit can vary depending on the resistance.

{{< multi-figure
  id="fig:4"
  class="center-x"
  caption="Figure 4: Constant voltage source"
  rows=1
  cols=2
  sub-figures=`
  [
    {
      "src": "basic-dc-concepts/component-irl-image/power-supply.jpg",
      "alt": "TODO",
      "caption": "Fig 4.a:<br>Bench top power supply. (C.V symbol on the right is for constant voltage)"
    },
    {
      "src": "basic-dc-concepts/component-schematic/constant-voltage-source.png",
      "alt": "TODO",
      "caption": "Fig 4.b:<br>Electric symbol for constant voltage source"
    }
  ]
  `
>}}

#### Batteries
For the most part batteries can be thought of as constant voltage sources. In reality the voltage of a battery depends on its charge level and decreases as the battery is being used. Thus even a relatively charged battery may not produce it's printed voltage value.

{{< figure
  src="basic-dc-concepts/component-irl-image/batteries.jpg"
  alt="TODO"
  caption="Figure 5: Batteries"
  class="center-x"
  img-class="image-full-content"
  id="fig:5"
>}}

### Resistors
These are the next simplest passive component in a circuit, their role is usually to reduce the current flowing through the circuit in order to protect more delicate components. They do this by resisting the flow of current. They consume some energy that is converted to heat.

{{< multi-figure
  id="fig:6"
  class="center-x"
  caption="Figure 6: Resistors"
  rows=2
  cols=2
  sub-figures=`
  [
    {
      "src": "basic-dc-concepts/component-irl-image/resistors-1.png",
      "alt": "TODO",
      "caption": "Fig 6a:<br>Image of axial-lead resistors of varying resistance.",
      "row-span": 2
    },
    {
      "src": "basic-dc-concepts/component-schematic/fixed-resistor.png",
      "alt": "TODO",
      "caption": "Fig 6.b:<br>Electric symbol for fixed resistor"
    },
    {
      "src": "basic-dc-concepts/component-schematic/variable-resistor.png",
      "alt": "TODO",
      "caption": "Fig 6.c:<br>Electric symbol for variable resistor"
    }
  ]
  `
>}}

#### Equivalent resistance
- When 2+ resistors are on the same wire, connected one after the other, their equivalent resistance is the sum of their individual resistances. (Series)
- When 2+ resistors are connected to the same **2** points then their inverse resistance is equal to the sum of the inverse of each individual resistance. (Parallel)

$$
\begin{aligned}
  R_{series} & = \sum_{i=0}^{n}R_{i} \\
  \frac{1}{R_{parallel}} & = \sum_{i=0}^{n} \frac{1}{R_{i}}
\end{aligned}
$$

{{< multi-figure
  id="fig:7"
  class="center-x"
  caption="Figure 7: Series and parallel resistors"
  rows=1
  cols=2
  sub-figures=`
  [
    {
      "src": "basic-dc-concepts/component-schematic/resistor-series.png",
      "alt": "TODO",
      "caption": "Fig 7a:<br>Image of fixed resistors connected in series."
    },
    {
      "src": "basic-dc-concepts/component-schematic/resistor-parallel.png",
      "alt": "TODO",
      "caption": "Fig 7.b:<br>Image of fixed resistors connected in parallel."
    }
  ]
  `
>}}

### Switches/Buttons
The role of these components is to switch the path that current flows through. They can also be used to fully disconnect part of the system.

Buttons are a special kind of switches that are normally "off" which means that by default no current flows through them.

<!-- $$ !!\ TODO: image!! $$ -->

### Fuses
An ideal fuse behaves like an ideal wire ($R=0$) until it reaches its limit at which point it should act as a perfect insulator ($R=\infty$). They are useful for protecting circuits from current surges that would damage expensive components or cause injuries (e.g. fires).

Most common ones I have encountered are a made from a piece of conductive material, encased in either glass or ceramic, with a specific resistance such that it will fail (melt/burn) when the current exceeds the safe value.

<!-- $$ !!\ TODO: image!! $$ -->

### Traditional Light bulbs
Traditional light bulbs are very close in construction to the latter fuses I described. They work by passing current through a wire that heats up enough to generate light. This filament is then encased in a glass bulb and put under vacuum or filled with some other inert gas to prevent the filament from catching fire/oxidizing due to the high temperatures.

<!-- $$ !!\ TODO: image!! $$ -->

### Diodes
These components are used to keep the flow of current in only one direction. An ideal diode behaves like an ideal wire when current passes in the forward direction ($R_{forward}=0$), and as a perfect insulator when current tries to pass in the opposite direction ($R_{backward}=\infty$). In reality there is some internal resistance for the forward direction, and there is a current at which the diode will start to allow current in the opposite direction.

<!-- $$ !!\ TODO: image!! $$ -->

#### LEDs
Probably the most common type of light recently, name "LED" stands for "light emitting diode". As the name suggests these are diodes that also emit light, as such, unlike the traditional light bulbs, they have a concept of "forward direction" for the current and will not work otherwise. Another difference is that they do not emit light due to black-body radiation[^7] (heat). 

<!-- $$ !!\ TODO: image!! $$ -->

### Capacitors
A capacitor is a device that stores electrical energy by accumulating electric charges. This is usually done by having 2 electric conductor surfaces, that store the charges, close together separated by an insulator. A capacitor is characterized by a constant $capacitance$[^8] ($C$) measured in $farads$ ($F$), defined as the ratio of charge ($Q$) on each conductor surface to the voltage ($V$) between them. The accumulation of these charges is a direct consequence of the voltage.

$$
C = \frac{Q}{V}
$$

When a capacitor is disconnected from a live circuit the charge stored in it will persist, that is why it is advised to discharge capacitors manually before working on circuits.

<ins>**_Be careful when connecting a capacitor to a closed circuit!_**</ins> Because the charge accumulated by the capacitor is only there due to the previous voltage, when connected to a closed circuit the capacitor will have am equal voltage between its leads, which can lead to current spikes though the circuit.

<!-- $$ !!\ TODO: image!! $$ -->

### Inductors
An inductor is a component that stores energy in a magnetic field when an electric current flows through it. An inductor typically consists of an insulated wire wound into a coil. An inductor is characterized by its $inductance$[^9] ($L$), which I don't understand well enough to explain it here yet.

The most important thing to remember though is that <ins>**_inductors oppose any changes in current through them_**</ins>. Which means we should be careful when disconnecting them because that can lead to spiking voltages and electric arcs.

<!-- $$ !!\ TODO: image!! $$ -->

### Transistors
Transistors can be thought of as switches that are controlled by current or voltage. They usually have 3 leads/wires coming out of them: base/gate, source/collector, drain/emitter. The gate as the name suggests controls the current that flows between the collector and emitter. Usually small changes in the gate's input result in bigger changes to the current between the collector and emitter, so they can be used for amplification as well.

#### BJTs
BJT stands for "bipolar junction transistor" and it uses a small current between the base and emitter terminals to control a higher current between the collector and emitter terminals.

<!-- $$ !!\ TODO: image!! $$ -->

#### FETs
FET stans for "field-effect transistor" and it uses a voltage between the gate and source to control the current between the source and drain. The advantage of FETs is that no current has to go through the gate for it to be controlled. MOSFETs are special type of FET with the further advantage that the circuit behind the gate can be isolated from the high current between the source and drain.

<!-- $$ !!\ TODO: image!! $$ -->

### Relay
A relay is an electrically operated mechanical switch, usually used for high current applications where full isolation of the control circuit is required. They are usually comprised of an electromagnet that closes or opens the controlled circuit.

<!-- $$ !!\ TODO: image!! $$ -->

[^1]: [Electric current (wikipedia)](https://en.wikipedia.org/wiki/Electric_current)
[^2]: [Voltage (wikipedia)](https://en.wikipedia.org/wiki/Voltage)
[^3]: [Electrical engineering ground (wikipedia)](https://en.wikipedia.org/wiki/Ground_(electricity))
[^4]: [Electric power (wikipedia)](https://en.wikipedia.org/wiki/Electric_power)
[^5]: [Hydraulic systems (wikipedia)](https://en.wikipedia.org/wiki/Hydraulic_machinery) 
[^6]: [Electrical Resistance (wikipedia)](https://en.wikipedia.org/wiki/Electrical_resistance_and_conductance)
[^7]: [Black-body radiation (wikipedia)](https://en.wikipedia.org/wiki/Black-body_radiation)
[^8]: [Capacitance (wikipedia)](https://en.wikipedia.org/wiki/Capacitance)
[^9]: [Inductance (wikipedia)](https://en.wikipedia.org/wiki/Inductance)