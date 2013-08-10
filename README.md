# Robvst

A clean and modern Markdown blogging platform for Rails 4. 

Robvst is actually a fork of [obtvse2](https://github.com/natew/obtvse2), which I'd also like to contribute to. GitHub won't let me have more than one fork of another repo, though.

My goal is to modernize Obtvse a bit so that it supports Rails 4 and a few other nifty features that took the blogging platform away from its stated purpose of being "simple".

### Installation

```
git clone git://github.com/chrisb/robvst.git
cd obtvse2
bundle install
rake db:migrate
```

Edit `config/info.yml` to fill in your personal and site information.

Start the local server:

`bundle exec rails s`