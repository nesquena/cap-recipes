= cap_recipes

== DESCRIPTION:

This is a collection of capistrano recipes which will grow to encompass many useful recipes. Currently included:

 * Phusion Passenger (Setup and Deployment)
 * Apache Server 
 * Juggernaut Process
 * Backgroundrb Processes
 

== SYNOPSIS:

To include any of these into your deploy.rb configuration file for Capistrano:
  
  require 'cap_recipes/tasks/passenger'
  require 'cap_recipes/tasks/apache'
  require 'cap_recipes/tasks/backgroundrb'
  require 'cap_recipes/tasks/juggernaut'
  
== USAGE

Passenger

  deploy
    :stop
    :start
    :restart
    :with_migrations
    :copy_config
    :tail
    :install
  sweep
    :cache
    :log
    
Apache
  variables: apache_init_path
  tasks:
    apache
      :stop
      :start
      :restart
      :install
  
Backgroundrb
  variables: backgroundrb_log
  tasks:
    backgroundrb
      :stop
      :start
      :restart
      :copy_config
      :tail

Juggernaut
  
  variables: juggernaut_config, juggernaut_pid, juggernaut_log
  tasks:
    juggernaut
      :start
      :stop
      :restart
      :copy_config
      :tail

== INSTALL:

 * gem sources -a http://gems.github.com/
 * sudo gem install xgamerx-cap-recipes

== LICENSE:

(The MIT License)

Copyright (c) 2008 Nathan Esquenazi

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.