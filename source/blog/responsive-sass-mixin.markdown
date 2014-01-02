---
title: Responsive mixins for Sass
blog_title: Responsive mixins for Sass
date: 2013-05-29
---

# Responsive mixins for Sass

I'm a big fan of Sass, and a big fan of responsive sites.

I've been doing a lot of work recently with responsive sites, and I've needed some Sass mixins to make the job a lot easier.

I used to work at [tictoc](http://www.tictocfamily.com), and our outstanding frontend developer [@simon_tsang](https://www.twitter.com/simon_tsang) prefered the liquid grid approach to implementing responsive sites ith good UX. I've developed the techniques we used there a little bit futrher.

~~~ sass

=breakpoint($cols)
  @media only screen and ( min-width: col-width($cols) + $gutter-width*2 )
    @content
    
=until-breakpoint($cols)
  @media only screen and ( max-width: col-width($cols) + $gutter-width*2 - 1px )
    @content
~~~
