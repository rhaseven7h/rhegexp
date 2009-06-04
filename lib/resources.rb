#!/usr/bin/env ruby
#
# This file is gererated by ruby-glade-create-template 1.1.4.
#
require 'libglade2'

class ResourcesGlade
  include GetText

  attr :glade
  
  def initialize(path_or_data, root = nil, domain = nil, localedir = nil, flag = GladeXML::FILE)
    bindtextdomain(domain, localedir, nil, "UTF-8")
    @glade = GladeXML.new(path_or_data, root, domain, localedir, flag) {|handler| method(handler)}
    
  end
  
  def on_window_main_destroy(widget)
    puts "on_window_main_destroy() is not implemented yet."
  end
  def on_checkbutton_ignore_case_toggled(widget)
    puts "on_checkbutton_ignore_case_toggled() is not implemented yet."
  end
  def on_button_exit_clicked(widget)
    puts "on_button_exit_clicked() is not implemented yet."
  end
  def on_entry_regular_expression_changed(widget)
    puts "on_entry_regular_expression_changed() is not implemented yet."
  end
end

# Main program
if __FILE__ == $0
  # Set values as your own application. 
  PROG_PATH = "lib/resources.glade"
  PROG_NAME = "YOUR_APPLICATION_NAME"
  ResourcesGlade.new(PROG_PATH, nil, PROG_NAME)
  Gtk.main
end
