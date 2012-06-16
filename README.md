#Fragile

**Ruby Pipeline Framework**

##Description

This is a pipeline framework which can extend the functionality by plug-ins.

##Get Started

Installation.

```html
gem install fragile
```

Specify any recipe which -f option.

```html
fragile -f <recipe>
```

Example.

```html
$ fragile -f recipe/example.rb
```

##What is Recipe?

```ruby
pipeline "foobar" do
  use "feed_input", :url => "http://d.hatena.ne.jp/griefworker/rss"
  use "unduplicate_filter"
  use "mail_output", :to => "foobar@example.com"
end
```

##Environment

After ruby 1.8.

##Author

**tnakamura**

+ http://d.hatena.ne.jp/griefworker
+ https://github.com/tnakamura

##License

Licensed under the MIT LICENSE


