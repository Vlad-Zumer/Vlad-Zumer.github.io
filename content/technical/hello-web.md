+++
title = 'Hello Web!'
date = 2024-09-14T23:06:16+01:00
lastmod = 2024-09-14T23:06:16+01:00
draft = true

# Taxonomies
areas = ['programming']
tags = ['web-dev', 'hugo', 'blog', 'meta']

seo-tags = ['partials','themes']

summary = '''"Hello web!", I feel that this is the appropriate first post/thing to write. (`...`)<br>Now that the preamble is out of the way, time to talk about <u>*why*</u> and <u>*how*</u> I made this blog. I have often searched for a specific bit of information, forget it at some later point, and then spend some time to recall it. At the same time I'm thinking some other poor sod might be in their *searching* period right now, so might as well try and help them as well.
'''
+++

`Hello web!`, I feel that this is the appropriate first post/thing to write. At this moment I have yet to host this blog anywhere other than locally, and many other things about it are sure to change before I publish it, but still no place like the present to start.

Now that the preamble is out of the way, time to talk about <u>*why*</u> and <u>*how*</u> I made this blog. The <u>*why*</u> is quite simple, I have often searched for a specific bit of information, spent many, many, many hours to find it and understand it, only to forget about it at some later point. This wouldn't be a problem if I never again needed that knowledge, but, as it happens, I often do need to recall it. At the same time I'm thinking some other poor sod might be in their *searching* period, so might as well try and help them as well.

Now for the <u>*how*</u>. This is a bit more complex, but I'll do my best to keep it nice, short, and to the point. I had 4 main requirements for functionality: 

1. I wanted to be able to write my posts in as simple syntax as possible, while still retaining the power of raw `html`, and due to my already existing experience with `markdown`, that's what I went for. Now I needed to find something to translate my `.md` files into `.html` ones.

2. I also wanted to ship as little `JS` and `CSS` as possible while still having a reasonably good `UX` for the site. One non-negotiable was that I wanted the blog to have a light and dark mode, as well as properly react to the user's preferences on this matter (this is a pet peeve of mine).

3. I wanted to be able to write maths in $\LaTeX$ notation and have it rendered in an appropriate way.

4. I wanted to have as fewer dependencies as possible. If feasible I wanted to develop this myself so I could be certain that I will have access to it in the next 5, 10, maybe even 40 years.

After looking around I went with [hugo](https://gohugo.io/). It checked almost all the boxes, except for the dependency one, but the power to template your pages and in the end still ship a static site, was the deciding factor. Another bonus was the community and resources behind it, [Luke Smith](https://lukesmith.xyz/) has some good intro videos on this topic, which I took ample advantage of.

After making the aforementioned choice, I got [nerd sniped](https://xkcd.com/356/). Hugo requires that you have a theme selected, without it, it will not display anything. So naturally, now I had to choose a theme for this blog. Luckily they have a [page]() dedicated to this. Here are some themes that I considered and used as inspiration: [m10c](https://themes.gohugo.io/themes/hugo-theme-m10c/), [Hugo - Classic](https://themes.gohugo.io/themes/hugo-classic/), [Terminal](https://themes.gohugo.io/themes/hugo-theme-terminal/), [xterm](https://themes.gohugo.io/themes/hugo-xterm/). The majority of them shipped too much `JS` and `CSS` for my liking. So I "just had" to make my own. This kickstarted another project that would take about 2 months (I forgot when I started working on this) or more of on-again, off-again work. [PostZ FS](https://github.com/Vlad-Zumer/PostZ-FS) is the result of this, a minimal theme that I keep updating whenever I encounter a new issue with my posts. At the moment this theme ships about <u>120</u> lines of `JS`, and around <u>625</u> lines of `CSS` in total, not counting the imports that make `katex` work. The `JS` code could be simplified by moving away from `OOP`.

One neat thing about this theme is that it can use only one `$` to denote an inline math block (e.g. `$\LaTeX$` => $\LaTeX$). The trick to do this is to change the delimiters that `katex` uses to determine if it's an inline block or block, and also do some pre-processing on the page to be rendered.

- `hugo.toml` : This is the configuration file for hugo
```toml{linenos=inline}
[markup.goldmark.extensions.passthrough]
# allow passthrough step needed for latex maths rendering
# allows the use of "layouts/_default/_markup/render-passthrough.html" to pre-process
enable = true

[markup.goldmark.extensions.passthrough.delimiters]
# delimiters for the passthrough
# tells the pre-process step what kind of block it deals with
block = [['$$', '$$']]
inline = [['$', '$']]
```

- `partials/head/katex.html` : Partial that gets added to pages to render inline maths
```html{linenos=inline}
<!-- Call "katex" to render math -->
<script>
  document.addEventListener("DOMContentLoaded", function() {
    renderMathInElement(document.body, {
      delimiters: [
        {left: '$$block-maths', right: '$$', display: true},     // block
        {left: '$$inline-maths', right: '$$', display: false},  // inline
      ],
      throwOnError : false,
      output: "html",
    });
  });
</script>
```

- `layouts/_default/_markup/render-passthrough.html` : Hugo template for callback from `goldmark` for passthrough
```html{linenos=inline}
<!-- This is where pre-process happens and allows for the use of  -->
<!-- just one "$" symbol for inline maths  -->
{{ if eq .Type "block" }}
<!-- If block process as block -->
<div class="block-maths-container">
  $$block-maths{{.Inner}}$$
</div>
{{- else -}}
<!-- If inline keep spaces in the math code -->
<span class="inline-maths-container">
  {{- range $index, $element := (split .Inner " ") -}}
    {{- if gt $index 0 -}}
      &#32;
    {{- end -}}
    $$inline-maths{{ $element }}$$
  {{- end -}}
</span>
{{- end -}}
```
