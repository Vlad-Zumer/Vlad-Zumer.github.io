+++
title = 'Uniform Sampling of Points Inside Circle and Sphere'
date = 2025-04-05T14:30:00+01:00
# lastmod =
draft = false

areas = ['maths']
tags = ['probability', 'geometry', 'rng']

seo-tags = ['math','sphere','circle', 'randomness', 'sampling', 'uniform']

summary = 'When generating random points within a circle or sphere, a naive approach can lead to uneven distributions, with points clustering around the center. To achieve a uniform distribution, a more sophisticated method is needed. In this article, we will derive, motivate, and explain the necessary equations to generate points uniformly within circles and spheres.'
+++

<!-- 
# TODO:
- [ ] introduce and explain `PDF` earlier
- [ ] introduce and explain `CDF` earlier 
-->

This is a late reply to this [video](https://www.youtube.com/watch?v=kH-hqG34ylA) about implementing `K-means` clustering. Around `00:31:00` the question about how to generate clusters of points centered at some location with a given maximum radius arises. The requirement is the sampling has to be uniform (any point has an equal chance of being picked). This article aims to provide the solution and a step-by-step guide to obtaining it.

<!-- {{< expander id="video" title="Video" >}}
{{< youtube id="kH-hqG34ylA" >}}
{{< /expander >}} -->

{{% expander id="solutions" title="Solutions" %}}
- Let $Rand(min, max)$ be a result of sampling a uniform distribution on the interval $[min, max]$.

### Circle:
- Let the circle be centered at $(0, 0)$ with radius $R=1$.

$$
\begin{aligned}
R_{point} &= R * \sqrt{Rand(0, 1)} \\
\theta &= 2\pi * Rand(0, 1) \\
X &= R_{point} * \cos(\theta) \\
Y &= R_{point} * \sin(\theta) \\
Point &= (X, Y) \\
\end{aligned}
$$

### Sphere:
- Let the sphere be centered at $(0, 0, 0)$ with radius $R=1$.

$$
\begin{aligned}
R_{point} &= R * \sqrt[3]{Rand(0, 1)} \\
\theta &= 2\pi * Rand(0, 1) \\
\phi &= \arcsin(2 * Rand(0, 1) - 1) \\
X &= R_{point} * \cos(\phi) * \cos(\theta) \\
Y &= R_{point} *\cos(\phi) * \sin(\theta) \\
Z &= R_{point} * \sin(\phi) \\
Point &= (X, Y, Z) \\
\end{aligned}
$$

{{% /expander %}}


{{% expander id="toc" title="Table of Contents" %}}

- [Introduction](#introduction)
- [Naive Solution](#naive-solution)
- [Clusterfix](#clusterfix1)
  - [Probability, Functions and Black Magic](#probability-functions-and-black-magic)
  - [Sufficiently Advanced Technology](#sufficiently-advanced-technology2)
- [2Done](#2done)
- [Going Even Further Beyond (3D)](#going-even-further-beyond-3d3)
  - [Surface Level](#surface-level)
  - [Going Deeper](#going-deeper)
- [Conclusion?](#conclusion)

{{% /expander %}}

## Introduction

To keep things simple we will be keeping the radius $R=1$ and generating points around the origin, $(0, 0) or (0, 0, 0)$. Also we will consider $Rand(min, max)$ to be the result of sampling a uniform distribution on the interval $[min, max]$.

To start we will focus on $2D$ and then generalize for $3D$ space. In this case we will look at sampling points uniformly from a circle.

## Naive Solution

The naive approach would be to generate a random direction and magnitude ($R$) for the points. This is the same as generating random points on a circle with random radius.
$$
\begin{aligned}
R &= Rand(0,1)\\
Dir &= 2\pi*Rand(0,1)\\
X &= R * \cos(Dir)\\
Y &= R * \sin(Dir)\\
Point &= (X, Y)\\
\end{aligned}
$$

This is quite easy to implement but the results don't look quite right.

<!-- image of distribution -->
{{< figure
  src="circle_sphere_sampling/naive_circ_dist.png"
  alt="Image showing many green dots inside a blue circle. The dots seem to disperse more the farther they are from the center of the circle."
  caption="Figure 1: Naive Solution for Uniform distribution of points inside a circle"
  class="center-x"
  img-class="image-full-content"
  id="fig:1"
>}}

As can be seen, the points tend to cluster around the origin. But why is that the case? We have an equal chance of picking any radius when generating a point, so shouldn't it distribute uniformly on all radii?

## Clusterfix[^1]

Let us simplify the ask and generate equally spaced points on circles of different radii first. As can be seen the smaller the radius the closer the points get. That is because points on the same circle can be at most $2R$ away from each other.

<!-- image of circles -->
{{< figure
  src="circle_sphere_sampling/eqd_circle_points.png"
  alt="The image displays 4 circles of smaller and smaller sizes, each having 12 equally spaced points on them. For the smallest circle the points touch each other, while for the rest there is more and more space between them."
  caption="Figure 2: Equally Spaced Points on Circles of Different Radii"
  class="center-x"
  img-class="image-full-content"
  id="fig:2"
>}}

This means that the way we generate the random radii has to change. Currently we use an uniform distribution for it, meaning that any radius is just as likely as any other. But, as we have seen, this leads to clustering in the lower part of the distribution, so we need to choose a larger radius more times than a smaller one.

Therefore, the next question we need to answer is "how do we get this new distribution?". We know that the larger the radius is the bigger the probability that it will be picked should be; because there is more "area", in this case perimeter, that can be filled such that there is some minimum distance $d$ between all of them (see [Figure 2](#fig:2) - difference between the smallest and biggest circle). We will start with the simplest form of modeling this, using direct proportionality ($y=ax\Rightarrow{}y is directly proportional to x$). 

$$
\def\nl{\ \ \ \ \ \\ }
\begin{alignat}{1}
& PDF              =       \, f(x)                             \nl
& \int_{0}^{1} PDF =       \, \int_{0}^{1} f(x) \ _{dx} = \, 1 \nl
& PDF              \propto \, 2\pi R                           \nl
& f(x)             \propto \, 2\pi R                           \nl
& f(x)             =       \, ax                               \nl
\end{alignat}{ } % do not remove the { }, it keeps the env from needing overflow
$$

Equations $(1)$ to $(4)$ model what we know already: that there is a function $f(x) : [0,1] \rightarrow [0,1]$ that models the distribution we want, that the sum of all (**infinitely many**) probabilities is $100\% = 1$, and that $f(x)$ is directly proportional to the circumference of the circle. Equation $(5)$ codifies this in rigorous terms, here $x$ stands for the $2\pi{}R$, and $a$ is the multiplier for the direct proportionality. Also notice that $f(x)$ is defined only on the $[0,1]$ interval, because of the choices made in the [introduction](#introduction).

$$
\def\nl{\ \ \ \ \ \\ }
\begin{alignat}{1}
& \int_{0}^{1} ax \ \ _{dx} = \ a \int_{0}^{1} x \ _{dx} = a\left[\frac{x^2}{2}\right\rvert_{0}^{1} = \ \frac{a}{2} = \ 1\ \Rightarrow a = 2 \Rightarrow f(x) = 2x\nl
\end{alignat}{ } % do not remove the { }, it keeps the env from needing overflow
$$

From equations $(2)$ and $(5)$ we can derive equation $(6)$, which we solve to find the value of $a$ and get the formula for the [probability density function](https://en.wikipedia.org/wiki/Probability_density_function) (`PDF`). 

### Probability, Functions and Black Magic

Great, now that we have the `PDF` how do we sample it? Ideally there would be a way to just plug in the `PDF` into a black box and then use it to generate samples based on the `PDF`. Well, it just so happens that [inverse transform sampling](https://en.wikipedia.org/wiki/Inverse_transform_sampling) is such a black box. To use it, we must first calculate the [cumulative distribution function](https://en.wikipedia.org/wiki/Cumulative_distribution_function) (`CDF`) which tells us the probability that a sample from the `PDF` is smaller than the given value (see eq. $(7)$). For a real-valued `PDF`, the `CDF` can be computed as the "sum" of the values of the `PDF` less than the given value, in this case, since the `PDF` is also continuous, the integral. The final step of the inverse transform sampling is to calculate the inverse of the `CDF` (`ICDF`), this will give us the black box function that, given a uniform distribution from `0` to `1` will convert it to the initial `PDF`.

$$
\def\nl{\ \ \ \ \ \\ }
\begin{alignat}{1}
CDF(x)      &= \ P(PDF < x) \nl
CDF(x)      &= \ \int_{0}^{x} PDF = \ \int_{0}^{x} 2Y \ _{dY} =\ \left.2\frac{Y^2}{2}\right\rvert_{0}^{x} =\ x^2 \nl
CDF(x)^{-1} &= \sqrt{x} \nl
\end{alignat}{ } % do not remove the { }, it keeps the env from needing overflow
$$

### Sufficiently Advanced Technology[^2]

"Why and how does this work?", I hear you ask. Well, the `CDF` produces a probability given a sample, and the `ICDF` produces a sample given a probability. The `CDF` calculates the probability that a new sample from the original `PDF` will be lower than a given number, and the `ICDF` calculates the number such that a new sample from the `PDF` has a given probability to be lower than it. In other words `ICDF` calculates the `PDF` sample whose `CDF` is the given probability. And since we use a uniform distribution to select that probability, meaning that all "probabilities" have an equal chance to be picked, it is almost like sampling the original `PDF`.

[Figure 3](#fig:3) can be used to visualize why this is true. Using the `ICDF` is analogous to drawing horizontal lines and reflecting them down when it intersects the graph of the `CDF`. As can be seen from the figure, even though we sampled equally spaced points on the `Y-axis`, the result of the `ICDF` is that the points on the `X-Axis` cluster together the father away from `0` they get. This is consistent with the $PDF=2x$, which tells us that the larger the `x` is the more samples we should see around it.

<!-- Image of CDF -->
{{< figure 
  src="circle_sphere_sampling/inv-transform-sampling.png"
  alt="Graph showing the the CDF=x^2, and equally sampled horizontal lines on the Y-axis that reflect to become vertical (on the X-axis) when they intersect the CDF graph. Showing how the ICDF can be used to sample the original PDF."
  caption="Figure 3: Plot of CDF"
  class="center-x"
  img-class="image-full-content"
  id="fig:3"
>}}

## 2Done

Now that we know how to sample the radius correctly it's time to put it all together:

$$
\begin{aligned}
R_{point} &= R * \sqrt{Rand(0, 1)}    \\
\theta    &= 2\pi * Rand(0, 1)        \\
X         &= R_{point} * \cos(\theta) \\
Y         &= R_{point} * \sin(\theta) \\
Point     &= (X, Y)                   \\
\end{aligned}
$$

As can be seen in [Figure 4](#fig:4) no obvious clustering is happening.

<!-- Image of the fixed 2D -->
{{< figure 
  src="circle_sphere_sampling/fixed_circ_dist.png"
  alt="Image showing many green dots inside a blue circle. The dots are uniformly distributed inside the circle, no obvious clustering is seen."
  caption="Figure 4: Proper Solution for Uniform distribution of points inside a circle"
  class="center-x"
  img-class="image-full-content"
  id="fig:4"
>}}

## Going Even Further Beyond (3D)[^3]

Now that we know how to sample points inside a circle, I won't go over the naive approach for 3D (see [Figure 5](#fig:5)).

<!-- Image of the naive 3D -->
{{< figure 
  src="circle_sphere_sampling/naive_sphere_dist.png"
  alt="Image showing many green dots inside a pink sphere. The dots are clustered around the origin and the Z=0 axis."
  caption="Figure 5: Naive Solution for Uniform distribution of points inside a sphere"
  class="center-x"
  img-class="image-full-content"
  id="fig:5"
>}}

Also we now have at least 2 methods of generating the points:
1. "Split" the sphere into planes and generate points inside circles on those planes. (number of points needs to be scaled according to the radius of the circle)
2. Generate points on the sphere and then scale the radius. (number of points needs to be scaled according to the radius of the sphere)

We will use #2 because I have already done the calculations for it, #1 is left as an exercise to the reader.

Next we need to choose a spherical coordinate system, for (in)convenience we will use:
- $R\in[0;1]$ = The radius of the sphere.
- $\theta\in[0;2\pi]$ = angle around the `Z` axis measured form the `X` axis.
- $\phi\in[-\pi/2;\pi/2]$ = angle between the vector from the origin to the point, and the plane `XY` (see [Figure 6](#fig:6), the $\phi$ angle is represented by the cyan circle arc between the magenta line and the `XY` yellow plane).

<!-- Image of the phi angle -->
{{< figure 
  src="circle_sphere_sampling/sphere_angle_phi.png"
  alt="Visual representation of the phi angle inside the sphere"
  caption="Figure 6: $\phi$ angle visualization"
  class="center-x"
  img-class="image-full-content"
  id="fig:6"
>}}

### Surface Level

To generate points on the sphere it is enough to know how to generate points on a circle (`XY` plane) and then vary the radius of the circle and the perpendicular axis (`Z` axis) component as well (in the range $[-R;R]$). Using [Figure 6](#fig:6) as reference, imagine moving the blue plane up and down; the magenta circle is the intersection between the blue plane and the sphere, notice that it's radius is dependent on the height of the blue plane. Also notice that the height of the blue plane is dependent on the angle $\phi$ and the radius of the sphere. Using a bit of trigonometry we get equation $(10)$ that gives us a relationship between the radius of the sphere and the radius of the circle.

Next we will calculate a `PDF` for the probability of a point being on such a circle, depending on its radius. Equations $(11)$ through $(16)$ define this `PDF`. Start by assuming that the `PDF` is directly proportional to the circle perimeter, but since for this case $2\pi*R_{sphere}$ is constant, the `PDF` is actually proportional only to $\cos(\phi)$, the only variable part.

$$
\def\nl{\ \ \ \ \ \\ }
\begin{alignat}{1}
R_{circle}                &= R_{sphere} * \cos(\phi) \nl
PDF                       &\propto 2\pi R_{circle} \nl
PDF                       &\propto 2\pi R_{sphere} * \cos(\phi) \nl
PDF                       &\propto \cos(\phi) \nl
PDF                       &= f(x) \nl
f(\phi)                   &\propto \cos(\phi) \nl
f(\phi)                   &: [-\frac{\pi}{2};\frac{\pi}{2}] \rightarrow [0;1] \notag \nl
f(\phi)                   &= a\cos(\phi) \nl
\end{alignat}{ } % do not remove the { }, it keeps the env from needing overflow
$$

Next we use equations $(17)$ through $(21)$ to find $a$ (the proportionality factor) and the full definition of the `PDF`.

$$
\def\nl{\ \ \ \ \ \\ }
\def\ntnl{\ \ \ \ \ \notag \\ }
\begin{alignat}{1}
\int_{}{} PDF                                            &= 1 \nl
\int_{-\frac{\pi}{2}}^{\frac{\pi}{2}} f(x) \ _{dx}       &= 1 \nl
\int_{-\frac{\pi}{2}}^{\frac{\pi}{2}} a\cos(x) \ _{dx}   &= a \int_{-\frac{\pi}{2}}^{\frac{\pi}{2}} \cos(x) \ _{dx} \ntnl
  &= a\left[\sin(x)\right\rvert_{-\frac{\pi}{2}}^{\frac{\pi}{2}} \ntnl
  &= a(1-(-1)) \ntnl 
  &= 2a \ntnl
  &= 1 \nl
a    &= \frac{1}{2} \nl
f(x) &= \frac{\cos(x)}{2}\nl
\end{alignat}{ } % do not remove the { }, it keeps the env from needing overflow
$$

Next we calculate the `CDF` and `ICDF` (equations $(22)$ through $(29)$) so we can sample the distribution. The `PDF` depends on $\phi$ which is defined in the range $[-\pi/2;\pi/2]$, therefore so does the `CDF`.

$$
\def\nl{\ \ \ \ \ \\ }
\def\ntnl{\ \ \ \ \ \notag \\ }
\begin{alignat}{1}
PDF(x)         &: [-\frac{\pi}{2};\frac{\pi}{2}] \rightarrow [0;1] \nl
CDF(x)         &: [-\frac{\pi}{2};\frac{\pi}{2}] \rightarrow [0;1] \nl
CDF^{-1}(y)    &: [0;1] \rightarrow [-\frac{\pi}{2};\frac{\pi}{2}] \nl
x              &\in [-\frac{\pi}{2};\frac{\pi}{2}] \nl
y              &\in [0;1] \nl
CDF(x)         &= \int PDF \ntnl
  &= \int_{-\frac{\pi}{2}}^{x} \frac{\cos(t)}{2} \ _{dt} \ntnl
  &= \left.\frac{\sin(t)}{2}\right\rvert_{-\frac{\pi}{2}}^{x} \ntnl
  &= \frac{\sin(x) - \sin(-\frac{\pi}{2})}{2} \ntnl
  &= \frac{\sin(x) + 1 }{2} \nl
y &= CDF(x) \ntnl
  &= \frac{\sin(x) + 1 }{2} \nl
CDF(y)^{-1} &= \arcsin(2y-1) \nl
\end{alignat}{ } % do not remove the { }, it keeps the env from needing overflow
$$

Now putting all together we get the following formulas for generating points on a sphere of radius $R$.

$$
\begin{aligned}
\theta &= 2\pi * Rand(0, 1) \\
\phi &= \arcsin(2 * Rand(0, 1) - 1) \\
X &= R * \cos(\phi) * \cos(\theta) \\
Y &= R *\cos(\phi) * \sin(\theta) \\
Z &= R * \sin(\phi) \\
Point &= (X, Y, Z) \\
\end{aligned}
$$

<!-- Image of the points on sphere -->
{{< figure 
  src="circle_sphere_sampling/on_sphere_dist.png"
  alt="Image showing many green dots on the surface of a pink sphere. The dots are uniformly distributed on the sphere, no obvious clustering is seen."
  caption="Figure 7: Uniform distribution of points on the surface of a sphere"
  class="center-x"
  img-class="image-full-content"
  id="fig:7"
>}}

### Going Deeper

Now that we know how to generate points on a sphere all we have to do is vary the radius of the sphere we generate points on. But as we have already seen plenty of times, we need to be careful with the distribution of these radii (see [Figure 2](#fig:2)). So one last time with feeling: find the `PDF` ($(30)$ to $(40)$), compute the `CDF` ($(41)$), compute `ICDF` ($(42)$).

$$
\def\nl{\ \ \ \ \ \\ }
\def\ntnl{\ \ \ \ \ \notag \\ }
\begin{alignat}{1}
PDF                         &\propto V_{sphere} \nl
PDF                         &\propto 4\pi R^{2} \nl
PDF                         &\propto R^{2} \nl
PDF                         &= f(x) \nl
f(x)                        &\propto R^{2} \nl
f(x)                        &: [0;1] -> [0;1] \ntnl
f(x)                        &= ax^{2} \nl
\int PDF                    &= 1 \nl
\int_{0}^{1} f(x) \ _{dx}   &= 1\nl
\int_{0}^{1} f(x) \ _{dx}   &= \int_{0}^{1} ax^{2} \ _{dx} \ntnl
  &= a \int_{0}^{1} x^{2} \ _{dx} \ntnl
  &= a\left[\frac{x^3}{3}\right\rvert_{0}^{1} \ntnl
  &= a\frac{x^3}{3} = 1\nl
\Rightarrow a               &= 3 \nl
\Rightarrow f(x)            &= 3x^{2} \nl
CDF(x)                      &= \int PDF \ntnl
  &= \int_{0}^{x} f(t) \ _{dt} \ntnl
  &= \int_{0}^{x} 3t^{2} \ _{dt} \ntnl
  &= 3\left.\frac{t^{3}}{3}\right\rvert_{0}^{x} \ntnl
  &= x^{3} \nl
CDF(y)^{-1}                 &= \sqrt[3]{y} \nl
\end{alignat}{ } % do not remove the { }, it keeps the env from needing overflow
$$

Using these we get the equations necessary to generate uniformly distributed points inside a sphere as such:

$$
\begin{aligned}
R_{point} &= R * \sqrt[3]{Rand(0, 1)} \\
\theta &= 2\pi * Rand(0, 1) \\
\phi &= \arcsin(2 * Rand(0, 1) - 1) \\
X &= R_{point} * \cos(\phi) * \cos(\theta) \\
Y &= R_{point} *\cos(\phi) * \sin(\theta) \\
Z &= R_{point} * \sin(\phi) \\
Point &= (X, Y, Z) \\
\end{aligned}
$$

<!-- Image of the fixed 3D -->
{{< figure 
  src="circle_sphere_sampling/fixed_sphere_dist.png"
  alt="Image showing many green dots inside a pink sphere. The dots are uniformly distributed inside the sphere, no obvious clustering is seen."
  caption="Figure 8: Proper Solution for Uniform distribution of points inside a sphere"
  class="center-x"
  img-class="image-full-content"
  id="fig:8"
>}}

## Conclusion?
???

[^1]: Opposite of [clusterfuck](https://dictionary.cambridge.org/dictionary/english/clusterfuck). In this context it is used because of actively trying to solve a clustering issue.
[^2]: Reference to [Arthur C. Clarke](https://en.wikipedia.org/wiki/Arthur_C._Clarke)'s [3rd law](https://en.wikipedia.org/wiki/Clarke%27s_three_laws): "Any sufficiently advanced technology is indistinguishable from magic."
[^3]: [Stereo Sayan 3D](https://www.youtube.com/watch?v=hyNu5i_6lKA)
