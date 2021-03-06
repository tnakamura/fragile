# Fragile [![Build Status](https://secure.travis-ci.org/tnakamura/fragile.png)](http://travis-ci.org/tnakamura/fragile) [![Code Climate](https://codeclimate.com/github/tnakamura/fragile.png)](https://codeclimate.com/github/tnakamura/fragile) [![Dependency Status](https://gemnasium.com/tnakamura/fragile.png)](https://gemnasium.com/tnakamura/fragile) [![Coverage Status](https://coveralls.io/repos/tnakamura/fragile/badge.png?branch=master)](https://coveralls.io/r/tnakamura/fragile)

Ruby Pipeline Framework

## Description

This is a pipeline framework which can extend the functionality by plug-ins.

## Get Started

Installation.

    $ gem install fragile

Specify any recipe which -f option.

    $ fragile -f <recipe> <target>

Example.

    $ fragile -f recipe/example.rb console_sample

## What is Recipe?

The "Recipe" is ruby script.

```ruby
  require "fragile/plugin/rss_input"
  require "fragile/plugin/select_filter"
  require "fragile/plugin/console_output"
  
  pipeline "console_sample" do
    use "rss_input", :url => "http://d.hatena.ne.jp/griefworker/rss"
    use "select_filter", :proc => lambda{|x| x[:title].include?("[Ruby]")}
    use "console_output"
  end
```

## Environment

After ruby 1.8.

## Author

**tnakamura**

* [Blog](http://tnakamura.hatenablog.com/)
* [GitHub](https://github.com/tnakamura)

## License

Licensed under the MIT LICENSE

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

