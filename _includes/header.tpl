<header>
        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
        <link rel="Bookmark" href="favicon.ico">
	<h1>{% if page.title %}<a href="/" class="minor">{{ site.name }}</a> / {{ page.title }}{% else %}{{ site.name }}{% endif %}</h1>
	{% if page.title == null %}<p class="additional">{{ site.meta.author.selfdesc }}</p>{% endif %}
</header>
