---
author: Chris Pilkington
date: "2023-10-03T20:26:27Z"
id: 546
tags:
- dev
- web
title: Migrating from WordPress to Hugo
---

For the last few years I've been intrigued by the idea of switching from WordPress to a statically generated blog such as Hugo mainly to reduce the attack surface of my web server (I've always been a bit paranoid of WordPress).

There are a number of benefits:
- No PHP or javascript
- No WordPress and associated vulnerabilities
- Reduced attack surface
- Quicker page requests (Not really an issue for my hobbyist blog)
- Potentially slightly more resilient to high traffic from slashdot/reddit or a DDOS attack (Again not really an issue for this blog)
- Version controlled in git
- Could be built and deployed with [Continous Integration](https://en.wikipedia.org/wiki/Continuous_integration) (I'm not doing this yet)
- Reproducable, if the server is lost or I move hosts I should be able to get up and running again in an hour
- Themes (Not as many themese, and not as easy to switch themes as WordPress, but not bad)

The main downsides are:
- No user input such as comments, surveys, etc.
- No search box, you can only really drill down by date, tags, or categories
- No statistics (Have to look at the apache logs instead)
- No online editor (For a team to collaborate they would need to use github/gitlab or similar, which do provide web based editors)
- No dynamic content apart from what the hugo plugins provide such as allowing embedding of youtube/twitter/instagram/etc. and you can embed raw html/javascript in your posts

Quirks:
- Content is written in markdown (If you are a programmer this is great, if you've never used markdown before this may be a bit of a learning curve, although there are editors available)
- As I discovered, Hugo doesn't really like having the blog in a sub directory
- When you add a new blog entry to an existing blog the diff is quite large because it adds the page, and updates the pages of tags,categories, and sitemaps. This is unavoidable though for a statically generated site with tags and categories as indexes. It might be better to not store the output in git, just generate and upload it only, having CI do this step and either rsyncing or just deleting and uploading the whole site each time would allow you to mostly ignore what happens behind the scenes

I have a few requirements:
- Nothing dynamic, no javascript (Apart from embedding youtube videos)
- Simple theme preferably dark mode
- Similar folder layout at least for the blog entries so that they don't 404 from google
- sitemap.xml
- RSS/Atom feed
- Potential for generating/deploying via CI

I looked at Jekyll and Hugo. Neither is perfect, but I got up and running with Hugo a lot quicker, it generated nice output, had quiet a few themes, so I went with it. Both have very similar features including themes, sitemaps, feeds, and the option to run a local server to get a live preview of your site before deploying to the real server.

## Themes

Switching themes is straightforward, just git clone a new theme, change your config.toml to point to the new theme and rebuild. Unfortunately not all themes are created equally, some support some features, some don't. The first dark mode them I found didn't support some layout or partial so I had to find another.

## RSS/Atom

The RSS feed seems to be stable although my guids were different to what WordPress was generating so I spammed any subscribers the first time I uploaded the new Hugo generated feed, sorry! I hope that was the last time :(

## Output

The output wasn't quite what I wanted so I had to run a script to fix it up a bit:
- I struggled a bit with putting my blog in a blog/ sub directory on the server, Hugo says it can support this, but it doesn't really seem to like it, or I am doing it wrong. I ended up not telling Hugo about the sub directory and then adding the sub directory and adjusting the paths before deploying it. Some of the links are still broken, I have to review it. This is a bit of a hack which I'd like to get rid of.
- RSS/Atom feeds used relative paths which is not legal, so they had to be rewritten. I also had to remove the About page from it.
- An RSS feed was generated per tag/category as well (WordPress does this too), I'd rather people just subscribed to a single feed, so I delete all the feeds except the main one.
- It provides a 404 page which I get rid of in favour of the server 404 page.

## Conclusion

I love it. It is harder to use than WordPress, but you get a lot more control over the output. I sleep safer at night knowing that most of the content is static and I'm not running WordPress and plugins.
