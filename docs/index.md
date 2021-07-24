---
tags: dontlink
sitemap: true
---

Vũ Hoàng Thái (武黃泰). 

I care about lots of stuff, and write software for a living. 

Favourite authors: Camus, Mishima and Chomsky, among others.

## Latest posts

{% for post in site.posts %}
  <div class='blogpost'>
    <div id='date'>
      <div id='day'>{{ post.date | date: "%-d" }}</div>
      <div id='month'>{{ post.date | date: "%B %Y" }}</div>
    </div>
    <div id='overview'>
      <div id='title'><a href="{{ post.url }}">{{ post.title }}</a></div>
      <div id='excerpt'>{{ post.excerpt | strip_html }}</div>
    </div>
  </div>
{% endfor %}

## Contacts
thai dot vh at live dot com

