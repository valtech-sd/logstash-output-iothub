# How-To Install JRuby

Though there are many ways to installing JRuby, here is an alternative.

## Windows

TODO: Include instructions for JRuby under Windows.

## macOS 

If you use other versions of Ruby, you might already have rvm and 
should skip to the `rvm install` step below.

- Install ruby version manager (rvm) (for details see: https://rvm.io/rvm/install)

  ```bash
  $ curl -sSL https://get.rvm.io | bash -s stable --ruby=jruby
  ```

- After the installation finishes, you need to run:

  ```bash
  $ source /Users/[your-username]/.rvm/scripts/rvm
  ```

- Watch for any messages, then install JRuby using **rvm**:

  ```bash
  $ rvm install "jruby-9.1.6.0"
  ```