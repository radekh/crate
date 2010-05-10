#--
# Copyright (c) 2008 Jeremy Hinegardner
# All rights reserved.  See LICENSE and/or COPYING for details.
#++

require 'rubygems'
require 'logging'
require 'date'

# Configure Crate to log to STDOUT at the 'info' level
Logging::Logger['Crate'].level = :info
Logging::Logger['Crate'].add_appenders( Logging::Appenders.stdout )
Logging::Appenders.stdout.layout = Logging::Layouts::Pattern.new( 
    :pattern      => "[%d] %5l: %m\n",   # [date] LEVEL: message
    :date_pattern => "%H:%M:%S"          # date == HH::MM::SS
)

module Crate
  class Error < ::StandardError; end

  # The root directory of the project is considered to be the parent directory
  # of the 'lib' directory.
  #   
  # returns:: [String] The full expanded path of the parent directory of 'lib'
  #           going up the path from the current file.  Trailing
  #           File::SEPARATOR is guaranteed.
  #   
  def self.root_dir
    unless @root_dir
      path_parts = ::File.expand_path(__FILE__).split(::File::SEPARATOR)
      lib_index  = path_parts.rindex("lib")
      @root_dir = path_parts[0...lib_index].join(::File::SEPARATOR) + ::File::SEPARATOR
    end 
    return @root_dir
  end 

  # returns:: [String] The full expanded path of the +config+ directory
  #           below _root_dir_.  All parameters passed in are joined onto the
  #           result.  Trailing File::SEPARATOR is guaranteed if _args_ are
  #           *not* present.
  #   
  def self.config_path(*args)
    self.sub_path("config", *args)
  end 

  # returns:: [String] The full expanded path of the +data+ directory below
  #           _root_dir_.  All parameters passed in are joined onto the 
  #           result. Trailing File::SEPARATOR is guaranteed if 
  #           _*args_ are *not* present.
  #   
  def self.data_path(*args)
    self.sub_path("data", *args)
  end 

  # returns:: [String] The full expanded path of the +lib+ directory below
  #           _root_dir_.  All parameters passed in are joined onto the 
  #           result. Trailing File::SEPARATOR is guaranteed if 
  #           _*args_ are *not* present.
  #   
  def self.lib_path(*args)
    self.sub_path("lib", *args)
  end 

  def self.sub_path(sub,*args)
    sp = ::File.join(root_dir, sub) + File::SEPARATOR
    sp = ::File.join(sp, *args) if args
  end

  def self.project
    @project
  end
  
  def self.project=( p )
    @project = p
  end

  def self.ruby
    @ruby
  end
  def self.ruby=( r )
    @ruby = r
  end

end
%w[ version packing_list utils dependency gem_integration ruby project ].each { |r| require "crate/#{r}" }

