# Scafld

A simple token replacement template engine. (Yes a fancy way of writing a regexp wrapper).

## Installation

Add this line to your application's Gemfile:

    gem 'scafld'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install scafld

## Usage

Take her for a quick spin: `rake console`!

Scafld exposes two metods:

    Scafld.from_s("some string with {{tokens}}")
    Scafld.from_file("some-file.txt")
    
An example of using scafld:

    template = Scafld.from_s(
        "Hi {{name}}, nice of you to join {{what}}. 
        We here at {{what}} are happy for your support. 
        Thanks {{name}}!")
    template.replace("name", "Markus")
        .replace_once("what", "BigInc")
        .replace_once("what", "marketing")
    template.build
    #=> "Hi Markus, nice of you to join BigInc. \n We here at marketing are happy for your support. \n Thanks Markus!"

### Chaining methods

The following chaining methods exists:

- `replace(token,content)` replaces all occurances of the supplied token, with content.
- `replace_once(token,content)` replaces the first occurance of the supplied token with content.
- `tokens(:on|:off)` swithces between {{token}} replacement and normal text replacement. Default is :on
- `cleanup(:on|:off) turns token cleanup on/off. That is should scafld remove all "dangling" tokens when calling `build`

### Other methods

- `build` build the string, cleanup if necessary.
- `save_file(filename)` saves the output from build to a file.
- `tokens_left?`check if there are any tokens left that has not been replaced.

## FAQ

<dl>
<dt>You spelt the name wrong</dt>
<dd>Yeah the name should probably have been scaffld, but scafld was shorter, and not in use :)</dd>
</dl>

## Contributing

1. Fork it ( http://github.com/mkrogh/scafld/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
