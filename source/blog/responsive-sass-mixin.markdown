---
title: Responsive mixins for Sass
blog_title: Responsive mixins for Sass
date: 2014-01-01
---

# Responsive mixins for Sass

I'm a big fan of responsive websites, but it's only relatively recently that we've developed the tools and techniques to make effective responsive templates. It can still be quite a complex affair to build usable and maintainable CSS for these sites, but we can use some of the advanced features of [Sass](http://sass-lang.com) to make the job a bit easier.

I used to work at [tictoc](http://www.tictocfamily.com), and it was around mid-2012 when we started seeing requests for responsive designs from clients.  At tictoc, we typically built quite complex content-driven sites, and the key to a good responsive UX with these was making sure that content would not only be accessible on a variety of devices, but that content management was kept simple and the presentation remained good.

Our frontend developer [@simon_tsang](https://www.twitter.com/simon_tsang) looked into various approaches that could work for us, and eventually settled on the "fluid grid" approach to implementing responsive sites with good UX – there are now a few examples of this approach kicking around the Web.

I' m sold on this approach as being generally effective for building effective responsive sites, because it offers the benefits of responsiveness while maintaining a usable grid, which makes design a fair bit easier.

## Sass mixins

Sass is a great tool for simplifying the generation of CSS, and it makes for a much easier job generating the sometimes complex rules required for responsive grid layouts.

There are a couple of key variables I use to establish the constraints of the grid; here's an example taken from this blog:

~~~ sass
$col-width:    76px  // The width of a single grid column
$gutter-width: 20px  // The width of the gutter between columns
$min-cols:     3     // The minimum number of columns to show
$max-cols:     14    // The maximum number of columns to show
$col-unit:     2     // The number of column units to snap to
~~~~

We can then generate a Sass function that will calculate the required width of an element based on the column and gutter size:

~~~~ sass
@function col-width($n)
  @return ($col-width * $n) + ($gutter-width * ($n - 1))
~~~~

So, for any grid-aligned element on the page, we use this function to take the desired width in coluns and translate it into a pixel width. Good start. Using this, we can create a Sass mixin which can translate a number of columns into a media query.

~~~ sass
=breakpoint($cols)
  @media only screen and ( min-width: col-width($cols) + $gutter-width*2 )
    @content
    
=until-breakpoint($cols)
  @media only screen and ( max-width: col-width($cols) + $gutter-width*2 - 1px )
    @content
~~~

So, what's the practical upshot of all this? Basically, we can now use these mixins to create scoped styles that will be applied when the user agent's size is either above or below a specified number of columns.

## Using the mixins

We can immediately start using this code to constrain the width of our content to an integer number of columns. Have a play with this page - you'll notice that when it's resized, the content will snap to fit as many columns as possible into view, keeping the grid units equal in size.

We can use the following Sass snippet:

~~~ sass
.content
  margin: 0 auto
  width: 100%
  @for $i from $min-cols through $max-cols/$col-unit
    +breakpoint($i*$col-unit)
      width: col-width($i*$col-unit)
~~~

Which will generate this CSS:

~~~ css
@media only screen and (min-width: 561px) {
  .content {
    width: 531px;
  }
}
@media only screen and (min-width: 743px) {
  .content {
    width: 713px;
  }
}
@media only screen and (min-width: 925px) {
  .content {
    width: 895px;
  }
}
@media only screen and (min-width: 1107px) {
  .content {
    width: 1077px;
  }
}
@media only screen and (min-width: 1289px) {
  .content {
    width: 1259px;
  }
}
~~~~

Awesome. the `.content` class will now automatically snap to contain as many columns as possible, leaving a gutter to either side.

The `$col-unit` variable in there limits the number of different steps which are generated - while we might have small columns, we may still want to have e.g. an even number of columns, and that's covered by setting that variable.

You'll notice that when we drop below the minimum column count, we revert to using a liquid layout. Because mobile devices generally have limited screen size, we want to make as much use of it as possible - so we make sure that we don't waste space by sticking to a grid at that level. That's optional, of course.

Now that we've got a fixed, even grid, we can tie other elements together using the same queries. The blog post listing on my [homepage](/), for example, collapses from three columns, to two columns, to one column, as the page reduces in width:

~~~~ sass
li
  float: left
  padding-left: $gutter-width
  +until-breakpoint(8)
    width: 100%
    padding-left: 0
  +breakpoint(8)
    width: 50%
    &:nth-child(2n+1)
      padding-left: 0
      clear: left
  +breakpoint(12)
    width: 33.3%
    &:nth-child(2n+1)
      padding-left: $gutter-width
      clear: none
    &:nth-child(3n+1)
      padding-left: 0
      clear: left
~~~~

It's not too hard to see what's going on here:

- By default, the list items are floaded to the left with a little bit of padding
- When the screen width is ≤ 8 columns, we force them to full width and remove the padding
- When we've between 8 and 12 columns, we display the list items at half width in two columns
- When we've more than 12 columns, we display three items per row

## Further development

You might notice that there's an obvious problem in the code above - applying styles with the `+breakpoint(n)` mixin applies them when the screen is showing **n or more columns**, and using `+until-breakpoint(n)` when it's showing **n or fewer**. That's not going to be maintainable in the long run, though sometimes it will be desirable.

I've got a further development to this approach that allows for the definition of size classes (imagine a mixin `+breakpoint-between(8, 12)` and you'll probably see what I mean), and generates the required media queries to limit applied styles to apply only in specific size ranges. I'll write that up soon!

