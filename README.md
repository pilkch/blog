## About

Hugo blog generated from markdown.  
It generates a blog/ folder which is intended to be used as a sub directory on an existing web server.  
I wanted to keep the blog/ structure. I don't think hugo is really made for it, or I am doing it wrong, as there are a lot of edge cases that then need to be fixed up with fix-directory-structure.sh.

## Requirements

1. Clone a theme in a directory under themes/. I use [m10c](https://github.com/vaga/hugo-theme-m10c.git):
```bash
(cd themes && git clone git@github.com:vaga/hugo-theme-m10c.git)
```
2. Hack: Add a modified youtube shortcode file if you have cross site security headers enabled, and embed youtube videos in any of your blog entries:
themes/m10c/layouts/shortcodes/youtube.html
```html
<!-- HACK: This is copied from the standard hugo youtube shortcode https://github.com/gohugoio/hugo/blob/master/tpl/tplimpl/embedded/templates/shortcodes/youtube.html
     The only modification is adding "crossorigin" to the iframe so that security headers can be enabled on the server -->
{{- $pc := .Page.Site.Config.Privacy.YouTube -}}
{{- if not $pc.Disable -}}
{{- $ytHost := cond $pc.PrivacyEnhanced  "www.youtube-nocookie.com" "www.youtube.com" -}}
{{- $id := .Get "id" | default (.Get 0) -}}
{{- $class := .Get "class" | default (.Get 1) -}}
{{- $title := .Get "title" | default "YouTube Video" }}
<div {{ with $class }}class="{{ . }}"{{ else }}style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden;"{{ end }}>
  <iframe src="https://{{ $ytHost }}/embed/{{ $id }}{{ with .Get "autoplay" }}{{ if eq . "true" }}?autoplay=1{{ end }}{{ end }}" {{ if not $class }}style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; border:0;" {{ end }}allowfullscreen title="{{ $title }}" crossorigin></iframe>
</div>
{{ end -}}
```

## Building

1. Build the blog folder and start the server for testing:
```bash
rm -rf public/ && hugo server --bind=192.168.0.49 --disableLiveReload --renderToDisk
```
2. In a background tab fix the directory structure:
```bash
./fix-directory-structure.sh
```
3. Go to http://192.168.0.49:1313/ in your browser and check the layout and pages

## Prepare and deploy the blog folder

1. Build the blog folder with the production profile, and start the server for testing:
```bash
rm -rf public/ && hugo --environment production --gc
```
2. Fix the directory structure:
```bash
./fix-directory-structure.sh
```
3. Add the blog folder to the checked out website repo:
```bash
./add-blog-to-website.sh ../mywebsite/
```
4. Commit the changes to ../mywebsite and push to git
5. Wait for continuous integration to find the changes and push them to your web server


## One liners

Development:
```bash
rm -rf public/ && hugo server --bind=192.168.0.49 --disableLiveReload --renderToDisk
```
and in another tab:
```bash
./fix-directory-structure.sh
```

Production:
```bash
rm -rf public/ && hugo --environment production --gc && ./fix-directory-structure.sh && ./add-blog-to-website.sh ../chris.iluo.net/
```
