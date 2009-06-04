#!/usr/bin/env ruby

require 'rubygems'
require 'pp'
require 'lib/resources'

class RhegExp < ResourcesGlade
  
  def initialize(path_or_data, root = nil, domain = nil, localedir = nil, flag = GladeXML::FILE)
    super(path_or_data, root, domain, localedir, flag)
    @glade['treeview_matches'].model = Gtk::TreeStore.new(String)
    @glade['treeview_matches'].append_column(Gtk::TreeViewColumn.new("Matches", Gtk::CellRendererText.new, :text => 0))    
    @glade['textview_text'].buffer.signal_connect('changed') { |widget| on_textview_text_changed(widget) }
  end
  
  def exit
    Gtk.main_quit
  end
  
  def update_matches
    mods = 0
    mods += Regexp::IGNORECASE if @glade['checkbutton_ignore_case'].active?
    @glade['treeview_matches'].model.clear
    begin
      re = Regexp.new('('+@glade['entry_regular_expression'].text+')', mods)
      @glade['textview_text'].buffer.text.each_line do |line|
        matches = line.scan(re)
        top = @glade['treeview_matches'].model.append(nil)
        top[0] = line.chomp
        if matches.length >= 1
          matches.each do |submatches|
            if submatches
              submatches.each do |submatch|
                son = @glade['treeview_matches'].model.append(top)
                son[0] = submatch
              end
            else
              son = @glade['treeview_matches'].model.append(top)
              son[0] = 'No Submatches'
            end
          end
        else
          son = @glade['treeview_matches'].model.append(top)
          son[0] = 'No Matches'
        end
      end
    rescue Exception => e
      top = @glade['treeview_matches'].model.append(nil)
      top[0] = 'ERROR'
      son = @glade['treeview_matches'].model.append(top)
      son[0] = e.message
    end
    @glade['treeview_matches'].expand_all
  end
  
  def on_window_main_destroy(widget)
    exit
  end

  def on_button_exit_clicked(widget)
    exit
  end

  def on_checkbutton_ignore_case_toggled(widget)
    update_matches
  end

  def on_entry_regular_expression_changed(widget)
    update_matches
  end

  def on_textview_text_changed(widget)
    update_matches
  end

end

res = RhegExp.new('lib/resources.glade', nil, 'Resources')
win = res.glade.get_widget('window_main')
win.show

Gtk.main
